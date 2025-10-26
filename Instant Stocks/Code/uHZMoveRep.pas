unit uHZMoveRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, StdCtrls,
  DBCtrls, ppStrtch, ppMemo, ppBands, ppCtrls, ppVar, ppPrnabl, ppClass,
  ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, ActnList,
  Buttons, wwcheckbox, wwDataInspector;

type
  TfHZMoveRep = class(TForm)
    adotHZs: TADOTable;
    dsstkHZMoves: TDataSource;
    adotstkHZMoves: TADOTable;
    adotstkHZMovesMoveID: TAutoIncField;
    adotstkHZMoveshzIDSource: TIntegerField;
    adotstkHZMoveshzIDDest: TIntegerField;
    adotstkHZMovesMoveDT: TDateTimeField;
    adotstkHZMovesMoveBy: TStringField;
    adotstkHZMovesMoveNote: TStringField;
    adotstkHZMovesHZSourceName: TStringField;
    adotstkHZMovesHZDestName: TStringField;
    PanelMain: TPanel;
    PanelGrid: TPanel;
    wwDBGridHZMove: TwwDBGrid;
    ppDBPipelineHZMove: TppDBPipeline;
    ppReportHZMove: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppShape3: TppShape;
    pplTitle: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText12: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLine24: TppLine;
    pplMvDate: TppLabel;
    pplFromTo: TppLabel;
    pplMvBy: TppLabel;
    ppLine1: TppLine;
    ppLine10: TppLine;
    ppLine2: TppLine;
    ppLine11: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine17: TppLine;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel13: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppDBText1: TppDBText;
    ppLine16: TppLine;
    ppDBText3: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppLabel16: TppLabel;
    ppMemo1: TppMemo;
    adotHZMProds: TADOTable;
    adotHZMProdsSiteCode: TIntegerField;
    adotHZMProdsMoveID: TIntegerField;
    adotHZMProdsRecID: TIntegerField;
    adotHZMProdsEntityCode: TFloatField;
    adotHZMProdsBaseU: TFloatField;
    adotHZMProdsMoveU: TStringField;
    adotHZMProdsLMDT: TDateTimeField;
    dsstkHZMProds: TDataSource;
    ppLine12: TppLine;
    ppLine9: TppLine;
    ActionList: TActionList;
    ActionViewHZMove: TAction;
    PanelNote: TPanel;
    LabelTransferNote: TLabel;
    MemoTransferNote: TDBMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    adotProducts: TADOTable;
    adotHZMProdsName: TStringField;
    adotHZMProdsSub: TStringField;
    adotHZMProdsActualQty: TFloatField;
    adotHZMProdsQty: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure ppReportHZMovePreviewFormCreate(Sender: TObject);
    procedure ActionViewHZMoveExecute(Sender: TObject);
    procedure wwDBGridHZMoveDblClick(Sender: TObject);
    procedure adotHZMProdsCalcFields(DataSet: TDataSet);
    procedure ppDBText5GetText(Sender: TObject; var Text: String);
  private
    { Private declarations }
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure SetDozGallFormatting;
  public
    { Public declarations }
  end;

var
  fHZMoveRep: TfHZMoveRep;

implementation

uses
  udata1, uADO;

{$R *.dfm}

procedure TfHZMoveRep.FormShow(Sender: TObject);
begin
  adotstkHZMoves.DisableControls;
  adotHZMProds.DisableControls;
  try
    SetDozGallFormatting;
    adotstkHZMoves.Open;
    adotHZMProds.Open;
  finally
    adotstkHZMoves.EnableControls;
    adotHZMProds.EnableControls;
  end;
end;

procedure TfHZMoveRep.ppReportHZMovePreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfHZMoveRep.ActionViewHZMoveExecute(Sender: TObject);
var
  MoveDateTime: TDateTime;
  SourceName, DestName: String;
  User: String;
  MoveID: Integer;
  MoveNote: String;
begin
  MoveDateTime := adotstkHZMoves.FieldByName('MoveDT').AsDateTime;
  SourceName := adotstkHZMoves.FieldByName('HZSourceName').AsString;
  DestName := adotstkHZMoves.FieldByName('HZDestName').AsString;
  User := adotstkHZMoves.FieldByName('MoveBy').AsString;
  MoveID := adotstkHZMoves.FieldByName('MoveID').AsInteger;
  MoveNote := adotstkHZMoves.FieldByName('MoveNote').AsString;

  // print transfer list
  pplMvDate.Caption := 'Transfer Date/Time: ' + formatDateTime('ddddd hh:nn:ss', MoveDateTime);
  pplFromTo.Caption := 'From: ' + SourceName + '  --  To: ' + DestName;
  pplMvBy.Caption := 'Entered By: ' + User;
  pplTitle.Caption := 'Internal Transfer ' + inttostr(MoveID);
  ppSummaryBand1.Visible := True;

  if MoveNote = '' then
  begin
    ppmemo1.Visible := False;
    pplabel16.Visible := False;
  end
  else
  begin
    ppmemo1.Visible := true;
    pplabel16.Visible := true;
    ppmemo1.Text := MoveNote;
  end;

  ppReportHZMove.ShowPrintDialog := True;
  ppReportHZMove.DeviceType := 'Screen';
  ppReportHZMove.PrinterSetup.PaperName := data1.repPaperName;
  ppReportHZMove.Print;
end;

procedure TfHZMoveRep.wwDBGridHZMoveDblClick(Sender: TObject);
begin
  ActionViewHZMove.Execute;
end;

procedure TfHZMoveRep.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure TfHZMoveRep.adotHZMProdsCalcFields(DataSet: TDataSet);
begin
  adotHZMProds.FieldByName('ActualQuantity').Value := adotHZMProds.FieldbyName('Qty').Value/adotHZMprods.FieldByName('BaseU').Value;
end;

procedure TfHZMoveRep.ppDBText5GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppDBText4.Text,Text);
end;

procedure TfHZMoveRep.SetDozGallFormatting;
begin
  with dmado.adoqRun do
  try
    SQL.Clear;
    SQL.Add('SELECT SUM(CASE dozform  WHEN ''Y'' THEN 1 ELSE 0 END) AS dozs,');
    SQL.Add('       SUM(CASE gallform WHEN ''Y'' THEN 1 ELSE 0 END) AS galls');
    SQL.Add('FROM Threads');
    SQL.Add('WHERE Active = ''Y''');
    Open;

    if not (BOF and EOF) then
    begin
      data1.curGallForm := FieldByName('galls').AsInteger > 0;
      data1.curdozForm := FieldByName('dozs').AsInteger > 0;
    end;
  finally
    Close;
  end;
end;

end.
