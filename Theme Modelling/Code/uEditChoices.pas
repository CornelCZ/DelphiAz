unit uEditChoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uADO, DB, ADODB, Grids, DBGrids, StdCtrls, Wwdbigrd, Wwdbgrid,
  wwdblook, uGridSortHelper;

type
  TEditChoices = class(TForm)
    qPrepareEdit: TADOQuery;
    DataSource1: TDataSource;
    qEditChoices: TADOQuery;
    qChoicelist: TADOQuery;
    qActivePanels: TADOQuery;
    qActivePanelspanelid: TLargeintField;
    qActivePanelsname: TStringField;
    qChoicelistchoiceid: TLargeintField;
    qChoicelistname: TStringField;
    qEditChoicesPanelName: TStringField;
    Button1: TButton;
    Button2: TButton;
    qSaveChanges: TADOQuery;
    qEditChoiceschoiceid: TLargeintField;
    qEditChoicespanelid: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    dbgEditChoices: TwwDBGrid;
    wwDBLookupCombo1: TwwDBLookupCombo;
    qEditChoicesName: TStringField;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure qEditChoicesBeforeInsert(DataSet: TDataSet);
    procedure qEditChoicesBeforeDelete(DataSet: TDataSet);
    procedure qEditChoicesAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    EditChoicesSortHelper: TGridSortHelper;
    paneldesignid: integer;
    { Private declarations }
  public
    { Public declarations }
    class procedure EditChoices(panel_design_id: integer);
  end;

var
  EditChoices: TEditChoices;

implementation

uses
  uAztecLog, uFormNavigate;

{$R *.dfm}

{ TEditChoices }

class procedure TEditChoices.EditChoices(panel_design_id: integer);
var
  FEditChoices: TEditChoices;
begin
  FEditChoices :=  TEditChoices.create(nil);
  with FEditChoices do try
    paneldesignid := panel_design_id;
    Nav.MoveForward(FEditChoices, true);
  finally
  end;
end;

procedure TEditChoices.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  with dmAdo.AztecConn do
  begin
    execute('if object_id(''tempdb..#portionheader'') is not null drop table #portionheader');
    execute('if object_id(''tempdb..#portiondetail'') is not null drop table #portiondetail');
    execute('if object_id(''tempdb..#choicelist'') is not null drop table #choicelist');
    execute('if object_id(''tempdb..#activepanels'') is not null drop table #activepanels');
    execute('if object_id(''tempdb..#editchoices'') is not null drop table #editchoices');
    execute('if object_id(''tempdb..#panelset'') is not null drop table #panelset');
    //qPrepareEdit.Parameters.ParamByName('paneldesignid').value := paneldesignid;
    qPrepareEdit.SQL[2] := inttostr(paneldesignid);
    qPrepareEdit.execsql;
    qEditchoices.Open;
    EditChoicesSortHelper.Reset;
  end;
end;

procedure TEditChoices.Button2Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  if qEditChoices.State = dsEdit then qEditChoices.Post;
//  qSaveChanges.parameters.ParamByName('paneldesignid').value := paneldesignid;
  qSaveChanges.SQL[2] := inttostr(paneldesignid);
  qSaveChanges.execsql;
  modalresult := mrOk;
  Close;
end;

procedure TEditChoices.qEditChoicesBeforeInsert(DataSet: TDataSet);
begin
  abort;
end;

procedure TEditChoices.qEditChoicesBeforeDelete(DataSet: TDataSet);
begin
  abort;
end;

procedure TEditChoices.qEditChoicesAfterOpen(DataSet: TDataSet);
begin
  dataset.FieldByName('choiceid').readonly := true;
end;

procedure TEditChoices.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  Nav.MoveBack;
end;

procedure TEditChoices.Button1Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  Close;
end;

procedure TEditChoices.FormCreate(Sender: TObject);
begin
  EditChoicesSortHelper := TGridSortHelper.Create;
  EditChoicesSortHelper.Initialise(dbgEditChoices);
end;

procedure TEditChoices.FormDestroy(Sender: TObject);
begin
  EditChoicesSortHelper.Free;
end;

end.
