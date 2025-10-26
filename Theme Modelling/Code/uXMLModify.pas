unit uXMLModify;

// functions to tweak XML via the DOM

interface

uses msxml, classes, sysutils;

procedure Open(AFilename: string);

procedure DeleteNode(ANodePath: string);
// delete an element, or an attribute value (if nodepath ends with an attribute name)
procedure UpdateNode(ANodePath, AValue:string);
// update an attribute value (attr is last part of nodepath)
// elements that dont exist along the path will be created
function NodesExist(XPathQuery:string): boolean;
// copy the value of one node attribute to another node attribute
// - used to ensure that dialog default panel is the same as the
//   touchscreen/panels/defaultpanel
procedure CopyNodeAttributeValue(FromPath, FromAttribute, ToPath, ToAttribute: String);


procedure Close;

implementation

uses uWidestringUtils;

var
  FileName: string;
  XMLDocument: IXMLDOMDocument;
  temp : WideString;

procedure Open(AFilename: string);
begin
  FileName := AFilename;
  temp := ReadWidestringFromFile(FileName);
  XMLDocument := CoDomDocument.create;
  if not XMLDocument.load(AFilename) then
    raise Exception.create( Format ('Error loading XML document.'#13 +
            'Error number: %d'#13 +
            'Reason: %s'#13 +
            'Line: %d'#13 +
            'Column: %d'#13, [XMLDocument.parseError.errorCode,
            XMLDocument.parseError.reason,
            XMLDocument.parseError.line,
            XMLDocument.parseError.linePos]));

  if XMLDocument.firstchild = nil then
    raise Exception.create('Could not load XML file - no root node found!');
end;

procedure Close;
begin
  uWideStringUtils.WriteWidestringToFile(XMLDocument.xml, FileName);
  XMLDocument := nil;
end;

procedure DeleteNode(ANodePath: string);
var
  FSearchNode: IXMLDOMNode;
  FTargetNode: string;
  Found: boolean;

  procedure GetNextTarget;
  begin
    if pos('!', ANodePath) = 0 then
    begin
      FTargetNode := ANodePath;
      ANodePath := '';
    end
    else
    begin
      FTargetNode := copy(ANodePath, 1, pred(pos('!', ANodePath)));
      delete(ANodePath, 1, pos('!', ANodePath));
    end;
  end;
var
  FLastNode: IXMLDOMNode;

begin
  if XMLDocument.firstChild.nodeName = 'xml' then
  begin
    FSearchNode := XMLDocument.firstChild.nextSibling;
  end
  else
    FSearchNode := XMLDocument.firstChild;

  Found := false;
  GetNextTarget;
  while not Found do
  begin
    if assigned(FSearchNode) and (lowercase(FSearchNode.NodeName) = lowercase(FTargetNode)) then
    begin
      if ANodePath = '' then
        Found := true
      else
      begin
        GetNextTarget;
        FLastNode := FSearchNode;
        FSearchNode := FSearchNode.FirstChild;
      end;
    end
    else
    begin
      if FSearchNode <> nil then
      begin
        FLastNode := FSearchNode;
        FSearchNode := FSearchNode.NextSibling;
      end;
      if FSearchNode = nil then
      begin
        FSearchNode := FLastNode;
        if assigned(FSearchNode.attributes.GetNamedItem(FTargetNode)) then
        begin
          FSearchNode.attributes.RemoveNamedItem(FTargetNode);
        end
        else
        if Assigned(FSearchNode.ParentNode.attributes) then
        if   assigned(FSearchNode.ParentNode.attributes.GetNamedItem(FTargetNode)) then
        begin
          FSearchNode.ParentNode.attributes.RemoveNamedItem(FTargetNode)
        end;
        break;
      end;

    end;
  end;
  if Found then FSearchNode.ParentNode.RemoveChild(FSearchNode);

end;

procedure UpdateNode(ANodePath, AValue:string);
var
  FSearchNode, FTempNode, FInsertParent: IXMLDOMNode;
  FTargetNode: string;
  FTargetAttFilter: string;
  FTargetAttFilterValue: string;
  Found: boolean;

  procedure GetNextTarget;
  begin
    FTargetAttFilter := '';
    if pos('!', ANodePath) = 0 then
    begin
      FTargetNode := ANodePath;
      ANodePath := '';
    end
    else
    begin
      FTargetNode := copy(ANodePath, 1, pred(pos('!', ANodePath)));
      if pos('[', FTargetNode) <> 0 then
      begin
        FTargetAttFilter := FTargetNode;
        FTargetNode := copy(FTargetNode, 1, pred(pos('[', FTargetNode)));
        FTargetAttFilter := copy(FTargetAttFilter, succ(pos('[', FTargetAttFilter)), Length(FTargetAttFilter));
        FTargetAttFilter := copy(FTargetAttFilter, 1, pred(pos(']', FTargetAttFilter)));
        FTargetAttFilterValue := copy(FTargetAttFilter, succ(pos('=', FTargetAttFilter)), length(FTargetAttfilter));
        FTargetAttFilter := copy(FTargetAttFilter, 1, pred(pos('=', FTargetAttFilter)));
      end;
      delete(ANodePath, 1, pos('!', ANodePath));
    end;
  end;

var
  MatchFound: boolean;
begin
  if XMLDocument.firstChild.NodeName = 'xml' then
  begin
    FSearchNode := XMLDocument.firstChild.nextSibling;
  end
  else
    FSearchNode := XMLDocument.firstChild;

  Found := FALSE;
  GetNextTarget;
  FInsertParent := nil;
  while not Found do
  begin
    MatchFound := assigned(FSearchNode) and ((lowercase(FSearchNode.NodeName) = lowercase(FTargetNode)));

    if MatchFound and (FTargetAttFilter <> '') then
    begin
      if not Assigned(FSearchNode.attributes) or not assigned(FSearchNode.attributes.getNamedItem(FTargetAttFilter))  then
      begin
        // still match on a node that does not contain the filtered attribute as we are adding that attribute
        if lowercase(FTargetAttFilter) <> lowercase(ANodePath) then
          MatchFound := false;
      end
      else
      begin
        // the search node has the attribute we are after so check it
        if lowercase(FSearchNode.attributes.getNamedItem(FTargetAttFilter).nodeValue) <> lowercase(FTargetAttFilterValue) then
          MatchFound := false;
      end;
    end;


    if MatchFound then
    begin
      if pos('!', ANodePath) = 0 then
      begin
        FTempNode := XMLDocument.createAttribute(ANodePath);
        FTempNode.NodeValue := AValue;
        FSearchNode.attributes.SetNamedItem(FTempNode);
        Found := true;
      end
      else
      begin
        FInsertParent:= FSearchNode;
        GetNextTarget;
        if Assigned(FSearchNode.firstChild) then
        begin
          FSearchNode := FSearchNode.firstChild;
        end;
      end;
    end
    else
    begin
      if Assigned(FSearchNode) and Assigned(FSearchNode.NextSibling) then
        FSearchNode := FSearchNode.nextSibling
      else
      begin
        // node not found.. add it
        FTempNode := XMLDocument.createElement(FTargetNode);
        FInsertParent.appendChild(FTempNode);
        FSearchNode := FTempNode;
        FInsertParent := FSearchNode;
      end;
    end;
  end;
end;

function NodesExist(XPathQuery:string): boolean;
var
  Nodes: IXMLDOMNodeList;
begin
  Nodes := XMLDocument.selectNodes(XPathQuery);
  Result := Nodes.length > 0;
end;

procedure CopyNodeAttributeValue(FromPath, FromAttribute, ToPath, ToAttribute: String);
var
  NodeList: IXMLDOMNodeList;
  FTempNode, FToNode, FFromNode: IXMLDOMNode;
begin
  NodeList := XMLDocument.selectNodes(ToPath);
  if NodeList.length > 0 then
  begin
    FFromNode := XMLDocument.selectSingleNode(FromPath);
    FToNode := XMLDocument.selectSingleNode(ToPath);
    FTempNode := XMLDocument.createAttribute(ToAttribute);
    FTempNode.nodeValue := FFromNode.attributes.getNamedItem(FromAttribute).nodeValue;
    FToNode.attributes.setNamedItem(FTempNode);
  end;
end;


end.
