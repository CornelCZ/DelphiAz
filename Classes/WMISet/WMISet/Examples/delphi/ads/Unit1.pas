unit Unit1;
{$I DEFINE.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveDS, ActiveDSTLB, ComObj, StdCtrls, ActiveX, AdsErr,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  ComCtrls, ExtCtrls;


type
  TForm1 = class(TForm)
    tvNetwork: TTreeView;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    procedure tvNetworkExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvNetworkChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
  private
    function BuildPath(Node: TTreeNode): WideString;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.tvNetworkExpanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
var
  Res: HResult;
  DomainPath: WideString;
  vIADsContainer: IADsContainer;
  vUnk: IUnknown;
  vEnum: IEnumVARIANT;
  vObject: OleVariant;
  Count: cardinal;
  computersNode: TTreeNode;
  usersNode: TTreeNode;
  groupsNode: TTreeNode;
begin
  Screen.Cursor := crHourGlass;
  try
    if (Node.getFirstChild <> nil) and (Node.getFirstChild.Text = '') then
      begin
      Node.DeleteChildren;
      computersNode := tvNetwork.Items.AddChild(Node, 'Computers');
      usersNode  := tvNetwork.Items.AddChild(Node, 'Users');
      groupsNode := tvNetwork.Items.AddChild(Node, 'Groups');

      DomainPath := 'WinNT://'+ Node.Text;
      Res := ADsGetObject(PWideChar(DomainPath), IADsContainer, vIADsContainer);
      OleCheck(Res);

      AdsCheck(vIADsContainer.Get__NewEnum(vUnk));
      vEnum := vUnk as IEnumVARIANT;
      {$IFNDEF Delphi5}
      vEnum.Next(1, vObject, @Count);
      {$ELSE}
      vEnum.Next(1, vObject, Count);
      {$ENDIF}

      while (Count > 0) do
        begin
        if vObject.Class = 'Computer' then tvNetwork.Items.AddChild(computersNode, vObject.Name)
          else
        if vObject.Class = 'User' then tvNetwork.Items.AddChild(usersNode, vObject.Name)
          else
        if vObject.Class = 'Group' then tvNetwork.Items.AddChild(groupsNode, vObject.Name);
        
        {$IFNDEF Delphi5}
        vEnum.Next(1, vObject, @Count);
        {$ELSE}
        vEnum.Next(1, vObject, Count);
        {$ENDIF}
        end;
      end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.tvNetworkChange(Sender: TObject; Node: TTreeNode);
var
  vPath: WideString;
  Res: HResult;
  vIADsPropertyList: IADsPropertyList;
  vObject: OleVariant;
  vPropEntry: OleVariant;
  vPropValues: OleVariant;
  vPropValue: OleVariant;
  i, j, lowBound, highBound, vPropCount: integer;
  s: String;
begin
  ListBox1.Items.Clear;
  vPath := BuildPath(Node);
  Res := ADsGetObject(PWideChar(vPath), IADsPropertyList, vIADsPropertyList);
  OleCheck(Res);

  (vIADsPropertyList as IADs).GetInfo;
  AdsCheck(vIADsPropertyList.Get_PropertyCount(vPropCount));
  for i := 0 to vPropCount - 1 do
  begin
    AdsCheck(vIADsPropertyList.Next(vObject));
    AdsCheck(vIADsPropertyList.GetPropertyItem(vObject.Name, ADSTYPE_UNKNOWN, vPropEntry));
    vPropValues := vPropEntry.Values;
    s := '';
    lowBound  := VarArrayLowBound(vPropValues, 1);
    highBound := VarArrayHighBound(vPropValues, 1);
    for j := lowBound to highBound do
    begin
      vPropValue := vPropValues[j];
      case vPropValue.ADSType of
        ADSTYPE_INVALID:                s := 'invalid';
        ADSTYPE_DN_STRING:              s := vPropValue.DNString;
        ADSTYPE_CASE_EXACT_STRING:      s := vPropValue.CaseExactString;
        ADSTYPE_CASE_IGNORE_STRING:     s := vPropValue.CaseIgnoreString;
        ADSTYPE_PRINTABLE_STRING:       s := vPropValue.PrintableString;
        ADSTYPE_NUMERIC_STRING:         s := vPropValue.NumericString;
        ADSTYPE_BOOLEAN:                if vPropValue.Boolean then s := 'true'
                                           else s := 'false';
        ADSTYPE_INTEGER:                s := IntToStr(vPropValue.Integer);
        ADSTYPE_OCTET_STRING:           s := 'OCTET_STRING';           // to be implemented
        ADSTYPE_UTC_TIME:               s := DateTimeToStr(vPropValue.UTCTime);
        ADSTYPE_LARGE_INTEGER:          s := 'Large Integer';          // to be implemented
        ADSTYPE_PROV_SPECIFIC:          s := 'Provider specific data'; // to be implemented
        ADSTYPE_OBJECT_CLASS:           s := 'Object';                 // to be implemented
        ADSTYPE_CASEIGNORE_LIST:        s := 'Case Ignore List';  // to be implemented
        ADSTYPE_OCTET_LIST:             s := 'OctetList';         // to be implemented
        ADSTYPE_PATH:                   s := 'Path';              // to be implemented
        ADSTYPE_POSTALADDRESS:          s := 'IADsPostalAddress'; // to be implemented
        ADSTYPE_TIMESTAMP:              s := 'Time Stamp';        // to be implemented
        ADSTYPE_BACKLINK:               s := 'Blank link';        // to be implemented
        ADSTYPE_TYPEDNAME:              s := 'TypeDName';         // to be implemented
        ADSTYPE_HOLD:                   s := 'Hold';              // to be implemented
        ADSTYPE_NETADDRESS:             s := 'Net Address';       // to be implemented
        ADSTYPE_REPLICAPOINTER:         s := 'Replica Pointer';   // to be implemented
        ADSTYPE_FAXNUMBER:              s := 'Fax Number';        // to be implemented
        ADSTYPE_EMAIL:                  s := 'Email';             // to be implemented
        ADSTYPE_NT_SECURITY_DESCRIPTOR: s := 'Security desriptor';// to be implemented
        ADSTYPE_UNKNOWN:                s := 'Unknown';
      end;  
    end;
    ListBox1.Items.Add(vObject.Name + ': '+ s);
  end;

end;

function TForm1.BuildPath(Node: TTreeNode): WideString;
begin
  Result := '';
  while (Node <> nil) do
  begin
    case Node.Level of
    2: Result := '/'+ Node.Text;
    1:;
    0: Result := '//'+ Node.Text + Result;
    end;
    Node := Node.Parent;
  end;
  Result := 'WinNT:' + Result;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  Res: HResult;
  vUnk: IUnknown;
  vEnum: IEnumVARIANT;
  vDomain: OleVariant;
  vIADsContainer: IADsContainer;
  Node: TTreeNode;
  Count: cardinal; 
begin
  Screen.Cursor := crHourGlass;
  try
    Res := ADsGetObject('WinNT:', IADsContainer, vIADsContainer);
    OleCheck(Res);
    AdsCheck(vIADsContainer.Get__NewEnum(vUnk));
    vEnum := vUnk as IEnumVARIANT;
    {$IFNDEF Delphi5}
    vEnum.Next(1, vDomain, @Count);
    {$ELSE}
    vEnum.Next(1, vDomain, Count);
    {$ENDIF}
    while (Count > 0) do
      begin
      Node := tvNetwork.Items.AddChild(nil, vDomain.Name);
      tvNetwork.Items.AddChild(Node, '');
      {$IFNDEF Delphi5}
      vEnum.Next(1, vDomain, @Count);
      {$ELSE}
      vEnum.Next(1, vDomain, Count);
      {$ENDIF}
      end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.




 