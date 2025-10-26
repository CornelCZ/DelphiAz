unit uXMLRectanglePatch;

interface

uses MSXML, windows;

// Due to some limits being exceeded in the SQL XML generation temp table "@xmldata", the BOH is
// currently generating XML to a refactored  DTD that compresses some EPOS "rectangle" data
// structures into a single element type.
// In all, about 70 elements are replaced by the new structure.
// This unit applies an inverse mapping from the Rectangle elements to their old counterparts and
// must be removed when the corresponding refactor is done in EPOS.

type
  TMoveMode = (mOldToNew, mNewToOld);

  TEposRect = class(TObject)
  public
    mode: TMoveMode;
    OldNode, NewNode: IXMLDOMNode;
    NodeName, NodePanel, XPathOld: string;
    Document: IXMLDOMDocument;
    procedure Process(Doc: IXMLDOMDocument; ButtonWidth, ButtonHeight, GridOffsetX: integer);
  private
    ButtonWidth, ButtonHeight, GridOffsetX: integer;
    PanelNode: IXMLDOMNode;
    NewRect, OldRect, OldHeader: TRect;
    procedure GetDims(Node: IXMLDOMNode; var Rect: TRect);
    procedure SetDims(Node: IXMLDOMNode; Rect: TRect);
    procedure InsertRectangle(ParentNode: IXMLDOMNode; RectName: string; Rect: TRect);
    procedure InsertLabel(ParentNode: IXMLDOMNode; Rect: TRect);
  end;

  TXMLRectanglePatch = class(TObject)
  public
    procedure Apply(Doc: IXMLDOMDocument; MoveMode: TMoveMode); overload;
    procedure Apply(var Model: widestring; MoveMode: TMoveMode); overload;
  private
    Rects: Array of TEposRect;
    ButtonWidth, ButtonHeight, GridOffsetX: integer;
  end;


implementation

uses sysutils, classes;

{ TEposRect }

procedure TEposRect.GetDims(Node: IXMLDOMNode; var Rect: TRect);
begin
  if Assigned(Node.attributes.getNamedItem('Top')) then
    Rect.Top := Node.attributes.getNamedItem('Top').nodeValue;
  if Assigned(Node.attributes.getNamedItem('Left')) then
    Rect.Left := Node.attributes.getNamedItem('Left').nodeValue;
  if Assigned(Node.attributes.getNamedItem('Width')) then
    Rect.Right := Node.attributes.getNamedItem('Width').nodeValue;
  if Assigned(Node.attributes.getNamedItem('Height')) then
    Rect.bottom := Node.attributes.getNamedItem('Height').nodeValue;
end;

procedure TEposRect.SetDims(Node: IXMLDOMNode; Rect: TRect);
var
  Attrs: Array[1..4] of IXMLDOMNode;
  i: integer;
begin
  Attrs[1] := Document.createAttribute('Top');
  Attrs[1].nodeValue := Rect.Top;
  Attrs[2] := Document.createAttribute('Left');
  Attrs[2].nodeValue := Rect.Left;
  Attrs[3] := Document.createAttribute('Height');
  Attrs[3].nodeValue := Rect.Bottom;
  Attrs[4] := Document.createAttribute('Width');
  Attrs[4].nodeValue := Rect.Right;
  for i := 1 to 4 do
    Node.attributes.setNamedItem(Attrs[i]);
end;


procedure TEposRect.InsertLabel(ParentNode: IXMLDOMNode; Rect: TRect);
var
  NewNode, NewSubNode: IXMLDOMNode;
  NewAttr: IXMLDOMNode;
  LabelsContainer: IXMLDOMNode;
begin
  LabelsContainer := ParentNode.selectSingleNode('Labels');
  if not Assigned(LabelsContainer) then
  begin
    NewNode := Document.createElement('Labels');
    ParentNode.appendChild(NewNode);
    LabelsContainer := NewNode;
  end;
  NewNode := Document.createElement('Label');
  SetDims(NewNode, Rect);

  NewAttr := Document.createAttribute('Text');
  NewAttr.nodeValue := '';
  NewNode.attributes.setNamedItem(NewAttr);

  NewAttr := Document.createAttribute('Font');

  if ButtonWidth <= 45 then
    NewAttr.nodeValue := 'Small'
  else
    NewAttr.nodeValue := 'Large';
  NewNode.attributes.setNamedItem(NewAttr);

  NewSubNode := Document.createElement('FGColour');
  NewAttr := Document.createAttribute('Red');
  NewAttr.nodeValue := '255';
  NewSubNode.attributes.setNamedItem(NewAttr);
  NewAttr := Document.createAttribute('Green');
  NewAttr.nodeValue := '255';
  NewSubNode.attributes.setNamedItem(NewAttr);
  NewAttr := Document.createAttribute('Blue');
  NewAttr.nodeValue := '255';
  NewSubNode.attributes.setNamedItem(NewAttr);

  NewNode.appendChild(NewSubNode);

  NewSubNode := Document.createElement('BGColour');
  NewAttr := Document.createAttribute('Red');
  NewAttr.nodeValue := '0';
  NewSubNode.attributes.setNamedItem(NewAttr);
  NewAttr := Document.createAttribute('Green');
  NewAttr.nodeValue := '0';
  NewSubNode.attributes.setNamedItem(NewAttr);
  NewAttr := Document.createAttribute('Blue');
  NewAttr.nodeValue := '0';
  NewSubNode.attributes.setNamedItem(NewAttr);

  NewNode.appendChild(NewSubNode);
  if LabelsContainer.hasChildNodes then
    LabelsContainer.insertBefore(NewNode, LabelsContainer.childNodes[0])
  else
    LabelsContainer.appendChild(NewNode);
end;

procedure TEposRect.InsertRectangle(ParentNode: IXMLDOMNode;
  RectName: string; Rect: TRect);
var
  NewNode: IXMLDOMNode;
  NewAttr: IXMLDOMNode;
  InsertionPoint: IXMLDOMNode;
  i: integer;
begin
  InsertionPoint := nil;
  for i := 0 to Pred(ParentNode.childNodes.length) do
    if ParentNode.childNodes[i].nodeName = 'EPoSName' then InsertionPoint := ParentNode.childNodes[i];
  NewNode := Document.createElement('Rectangle');
  NewAttr := Document.createAttribute('RectangleType');
  NewAttr.nodeValue := RectName;
  NewNode.attributes.setNamedItem(NewAttr);
  SetDims(NewNode, Rect);


  ParentNode.insertBefore(NewNode, InsertionPoint.nextSibling);
  //insertAfter(NewNode, InsertionPoint)

end;

function GetNodeParent(input: string):string;
begin
  repeat setlength(input, length(input)-1);
        until input[Length(input)] in ['/', '['];
        setlength(input, length(input)-1);
  result := input;
end;

procedure TEposRect.Process(Doc: IXMLDOMDocument; ButtonWidth, ButtonHeight, GridOffsetX: integer);
var
  i: integer;
  tmpNode, tmpAttr: IXMLDOMNode;
  oldNodePath: string;
  oldNodeParent: string;
begin
  self.ButtonWidth := ButtonWidth;
  self.ButtonHeight := ButtonHeight;
  self.GridOffsetX := GridOffsetX;
  Document := Doc;
  tmpNode := Doc.selectSingleNode(Format('EPoSModel/Touchscreen/Panels/@%s', [NodePanel]));
  if not Assigned(tmpNode) then exit;
  PanelNode := Doc.selectSingleNode(Format('EPoSModel/Touchscreen/Panels/Panel[@GUIDO=''%d'']', [integer(tmpNode.NodeValue)]));
  if not Assigned(PanelNode) then
    raise Exception.Create('panel wanel');

  if mode = mOldToNew then
  begin
    //form1.Memo1.lines.add('Process node: '+NodeName);

    if NodeName = 'Help' then
    begin
      OldRect.Right := ButtonWidth;
      Oldrect.Bottom := buttonHeight;
      OldRect.Top := 0;
      OldRect.Left := GridOffsetX;
      NewRect := OldRect;
      OldHeader := Rect(-1, -1, -1, -1);
    end
    else
    begin

      //form1.Memo1.Lines.add('Node path: '+Format(XPathOld, [NodeName]));
      OldNode := Doc.selectSingleNode(Format(XPathOld, [NodeName]));

      if not assigned(OldNode) and ((NodeName = 'PreviewDriveThruMiddleAccount') or (NodeName = 'PreviewDriveThruNewestAccount')) then
        exit;
      if not assigned(OldNode) then
        raise Exception.Create('Old Node not found!');

      if Assigned(OldNode.attributes.getNamedItem('Left')) then
      begin
        // Orderdisplay, rectangles
        GetDims(OldNode, OldRect);
        OldHeader := Rect(-1, -1, -1, -1);
        NewRect := OldRect;
      end
      else
      begin
        if OldNode.childNodes.length > 1 then
        begin
          for i := 0 to Pred(OldNode.childNodes.length) do
          begin
            if OldNode.childNodes[i].nodeName = 'List' then
              GetDims(OldNode.childNodes[i], OldRect)
            else
            if OldNode.childNodes[i].nodeName = 'Header' then
              GetDims(OldNode.childNodes[i], OldHeader)
          end;
        end;
        if OldRect.Right = 0 then
          OldRect.Right := ButtonWidth * 4;
        NewRect := OldRect;
        NewRect.top := OldHeader.top;
        NewRect.bottom := OldHeader.bottom + OldRect.bottom;
      end;

    end;

    //form1.Memo1.Lines.Add(Format('Header dims: (%d %d %d %d)', [OldHeader.Left, OldHeader.Top, OldHeader.right, OldHeader.bottom]));
    //form1.Memo1.Lines.Add(Format('Rect dims: (%d %d %d %d)', [OldRect.Left, OldRect.Top, Oldrect.right, OldRect.bottom]));

    InsertRectangle(PanelNode, NodeName, OldRect);
    if OldHeader.Left <> -1 then
      InsertLabel(PanelNode, OldHeader);

    if NodeName = 'Help' then
    begin
    end
    else if NodeName = 'OrderDisplay' then
    begin
      OldNode.attributes.removeNamedItem('Top');
      OldNode.attributes.removeNamedItem('Left');
      OldNode.attributes.removeNamedItem('Width');
      OldNode.attributes.removeNamedItem('Height');
    end
    else
    begin
      OldNode.parentNode.removeChild(OldNode);
    end;

  end
  else
  begin
    // inverse
    //form1.Memo1.lines.add('Process node: '+NodeName);
    newNode := PanelNode.selectSingleNode(Format('Rectangle[@RectangleType=''%s'']', [NodeName]));

    if not assigned(NewNode) and ((NodeName = 'PreviewDriveThruMiddleAccount') or (NodeName = 'PreviewDriveThruNewestAccount')) then
      exit;

    if not assigned(newNode) then
      raise Exception.Create('Error, cant find new node');
    oldNodePath := Format(XPathOld, [NodeName]);
    if oldNodePath <> '' then
    begin
      //form1.Memo1.lines.add(oldNodePath);
      oldNode := doc.selectSingleNode(oldNodePath);
      if not assigned(oldNode) then
      begin

        if pos('HeaderDisplay', XPathOld) <> 0 then
        begin
          // find parent of old node
          oldnodeparent := GetNodeParent(GetNodeParent(oldnodepath));
          //if not assigned(doc.selectSingleNode(oldnodeparent)) then
          begin
            oldnode := doc.selectSingleNode(oldnodeparent);
            tmpnode := doc.createElement('HeaderDisplay');
            tmpattr := doc.createAttribute('HeaderType');
            tmpattr.nodevalue := NodeName;
            tmpnode.attributes.setnameditem(tmpattr);
            oldnode.insertBefore(tmpnode, oldnode.selectSingleNode('Panels'));
            oldnode := tmpnode;
          end;
        end
        else
        begin
          oldnodeparent := GetNodeParent(oldnodepath);
          oldnode := doc.selectsinglenode(oldnodeparent);
          tmpNode := doc.createElement(nodename);
          oldNode.insertBefore(tmpnode, oldnode.selectSingleNode('Panel'));
          oldNode := tmpNode;
        end;
      end;
      // get attributes of new node
      NewRect.Left := newNode.attributes.getnameditem('Left').nodeValue;
      NewRect.Top := newNode.attributes.getnameditem('Top').nodeValue;
      NewRect.Right := newNode.attributes.getnameditem('Width').nodeValue;
      NewRect.Bottom := newNode.attributes.getnameditem('Height').nodeValue;

      if pos('HeaderDisplay', XPathOld) = 0 then
      begin
        SetDims(OldNode, NewRect);
      end
      else
      begin
        GetDims(PanelNode.selectSingleNode('Labels').childNodes[0], OldHeader);
        OldRect := NewRect;
        // create header and list
        tmpNode := doc.createElement('List');
        SetDims(tmpNode, OldRect);
        OldNode.appendChild(tmpNode);
        tmpNode := doc.createElement('Header');
        SetDims(tmpNode, OldHeader);
        OldNode.appendChild(tmpNode);

        // set header and list dims
      end;

    end;
    // remove new node
    newNode.parentNode.removeChild(newNode);
    if pos('HeaderDisplay', XPathOld) <> 0 then
    begin
      // remove the label
      PanelNode.selectSingleNode('Labels').removeChild(PanelNode.selectSingleNode('Labels').childNodes[0]);
    end;

  end;
end;

{ TXMLRectanglePatch }

procedure TXMLRectanglePatch.Apply(Doc: IXMLDOMDocument;
  MoveMode: TMoveMode);
var
  slNodeRules: TStrings;
  i: integer;
  TmpStr: string;
  NodeName, NodePanel, XPathOld: string;

begin
  exit; // this unit is no longer needed and pending deletion
  if not Assigned(Doc.firstChild) then
  begin
    raise Exception.create('Error with XML'+#13+doc.parseError.reason+#13+doc.parseError.srcText);
  end;
  if not Assigned(Doc.selectSingleNode('EPoSModel'))  then
    raise Exception.create('No EPoSModel node found');

  ButtonWidth := Doc.selectSingleNode('EPoSModel/Touchscreen/ButtonSize').attributes.getNamedItem('Width').nodeValue;
  ButtonHeight := Doc.selectSingleNode('EPoSModel/Touchscreen/ButtonSize').attributes.getNamedItem('Height').nodeValue;
  if ButtonWidth = 66 then
    GridOffsetX := 4
  else
    GridOffsetX := 0;

  slNodeRules := TStringList.Create;
  slNodeRules.Add('OrderDisplay;Root;EPoSModel/Touchscreen/%s');
  slNodeRules.Add('Help;Root;');

  (*
  // Till team now do this part of the refactor in 3.4.1
  slNodeRules.Add('DisplayChoiceContentsRectangle;ConversationalOrdering;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectPaymentToFinaliseRectangle;SelectPaymentToFinalise;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectOrderDestinationRectangle;OrderDestinationSearch;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectNewOwnerRectangle;SelectNewOwner;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectPINPadRectangle;SelectPINPad;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SeparateBillRectangle;SelectSeparateBill;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('MachineSearchRectangle;MachineSearch;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SafeSearchRectangle;SafeSearch;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('DrawerSearchRectangle;CashDrawerSearch;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('LedgerSearchRectangle;LedgerSearch;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('BookingSearchRectangle;BookingSearch;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('AlphanumericSearchRectangle;AlphanumericSearch;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectPrinterTestRectangle;SelectPrinterTest;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectEmployeeRectangle;SelectEmployee;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('ChangeJobRectangle;ChangeJob;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectFolioRectangle;SelectFolio;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('PrinterChoiceRectangle;PrinterChoice;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('SelectHeldPaymentsRectangle;SelectHeldPayments;EPoSModel/Touchscreen/Panels/%s');
  slNodeRules.Add('AccountNumberRectangle;SelectAccountNumber;EPoSModel/Touchscreen/Panels/%s');     *)

  slNodeRules.Add('CorrectAccountAccount;CorrectAccount;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('CorrectAccountCorrections;CorrectAccount;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('DrawerAssignmentUnassigned;DrawerAssignment;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('DrawerAssignmentAssigned;DrawerAssignment;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('PreviewDriveThruOldestAccount;PreviewDriveThruAccounts;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('PreviewDriveThruMiddleAccount;PreviewDriveThruAccounts;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('PreviewDriveThruNewestAccount;PreviewDriveThruAccounts;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('RecallAccountAccountSelection;RecallAccount;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('RecallAccountRecalledAccount;RecallAccount;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('ReorderRound;ReorderRound;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('SplitAccountCurrentAccount;SplitAccount;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('SplitAccountSplitAccount;SplitAccount;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('ReconcileAccountAccountSelection;StandaloneModeReconciliation;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');
  slNodeRules.Add('ReconcileAccountSelectedAccount;StandaloneModeReconciliation;EPoSModel/Touchscreen/HeaderDisplay[@HeaderType=''%s'']');


  SetLength(Rects, slNodeRules.Count);
  for i := 0 to Pred(slNodeRules.Count) do
  begin
    // reverse the rule order
    if MoveMode = mNewToOld then
      TmpStr := slNodeRules[Pred(slNodeRules.Count)-i]
    else
      TmpStr := slNodeRules[i];

    NodeName := Copy(TmpStr, 1, Pos(';', TmpStr)-1);
    Delete(TmpStr, 1, Length(NodeName)+1);
    NodePanel := Copy(TmpStr, 1, Pos(';', TmpStr)-1);
    Delete(TmpStr, 1, Length(NodePanel)+1);
    XPathOld := TmpStr;

    Rects[i] := TEposRect.Create;
    Rects[i].mode := MoveMode;
    Rects[i].NodeName := NodeName;
    Rects[i].NodePanel := NodePanel;
    Rects[i].XPathOld := XPathOld;
    Rects[i].Process(Doc, ButtonWidth, ButtonHeight, GridOffsetX);
  end;

  slNodeRules.Free;
end;


procedure TXMLRectanglePatch.Apply(var Model: widestring;
  MoveMode: TMoveMode);
var
  Dom: IXMLDOMDocument;
begin
  exit; // This unit is no longer needed and pending deletion
  Dom := CoDOMDocument.Create;
  Dom.loadXML(Model);
  // check for reservations URL browsing changes which coincide with the RR
  if not Assigned(Dom.selectSingleNode('EPoSModel/Touchscreen/Panels/@WebBrowser')) then
    exit;
  Apply(Dom, MoveMode);
  Model := Dom.xml;
end;

end.
