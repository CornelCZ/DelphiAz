unit uSelectTerminal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDataTree, StdCtrls, ComCtrls, DB, ADODB, ActnList;

type
  TSelectTerminalForm = class(TForm)
    tvSelectTerminal: TTreeView;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    qFetchTreeData: TADOQuery;
    ActionList1: TActionList;
    Ok: TAction;
    Close: TAction;
    procedure OkExecute(Sender: TObject);
    procedure CloseExecute(Sender: TObject);
    procedure OkUpdate(Sender: TObject);
  private
    { Private declarations }
    SelectTerminalDataTree: TDataTree;

  public
    PanelDesignID: integer;
    SiteCode, SalesAreaCode, POSCode: integer;
    procedure Init;
    class procedure SelectExamplePOS(const APanelDesignID: integer; var ASiteCode, ASalesAreaCode, APOSCode: integer);
    { Public declarations }
  end;

var
  SelectTerminalNamesArray: TNamesArray;

implementation

uses uDMThemeData;

{$R *.dfm}

procedure TSelectTerminalForm.OkExecute(Sender: TObject);
var
  SelectedNode: TTreeNode;
begin
  SelectedNode := tvSelectTerminal.Selected;
  if not assigned(SelectedNode) or (SelectedNode.level <> 4) then abort;
  POSCode := Integer(SelectedNode.Data);
  SalesAreaCode := Integer(SelectedNode.Parent.Data);
  SiteCode := Integer(SelectedNode.Parent.Parent.Data);
  ModalResult := mrOk;
end;

procedure TSelectTerminalForm.CloseExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

class procedure TSelectTerminalForm.SelectExamplePOS(
  const APanelDesignID: integer; var ASiteCode, ASalesAreaCode, APOSCode: integer
);
begin
  with TSelectTerminalForm.Create(nil) do
  try
    PanelDesignID := APanelDesignID;
    Init;
    if ShowModal = mrOk then
    begin
      ASitecode := SiteCode;
      ASalesAreaCode := SalesAreaCode;
      APOSCode := POSCode;
    end
    else
    begin
      ASitecode := -1;
      ASalesAreaCode := -1;
      APOSCode := -1;
    end;
  finally
    free;
  end;
end;

procedure TSelectTerminalForm.Init;
begin
  qFetchTreeData.SQL[1] := Format('set @PanelDesignID = %d', [PanelDesignID]);
  qFetchTreeData.ExecSQL;

  with dmThemeData.ADOQRun do
  begin
    SQL.Text := 'select top 1 * from ##SelectTerminal_Data';
    Open;
    if Recordcount = 0 then
    begin
      Close;
      raise Exception.Create('No terminals are using this Panel Design.');
    end;
    SQL.Text := 'select * from ##SelectTerminal_Names';
    Open;
    SetLength(SelectTerminalNamesArray, Recordcount+1);
    while not EOF do
    begin
      SelectTerminalNamesArray[FieldByName('ID').AsInteger] := FieldByName('Name').AsString;
      Next;
    end;
    Close;
  end;

  SelectTerminalDataTree := TDataTree.Create(tvSelectTerminal, dmThemeData.AztecConn, '##SelectTerminal_Data', SelectTerminalNamesArray, True);
  SelectTerminalDataTree.AddLevel('Company', '');
  SelectTerminalDataTree.AddLevel('Area', '');
  SelectTerminalDataTree.AddLevel('Site', '');
  SelectTerminalDataTree.AddLevel('Sales Area', '');
  SelectTerminalDataTree.AddLevel('POS', '');
  SelectTerminalDataTree.Initialise;
end;

procedure TSelectTerminalForm.OkUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Assigned(tvSelectTerminal.Selected)
    and (tvSelectTerminal.Selected.Level = 4);
end;

end.
