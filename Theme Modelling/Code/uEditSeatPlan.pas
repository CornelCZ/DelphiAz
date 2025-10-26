unit uEditSeatPlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ToolWin, ImgList, DB, ADODB,
  ExtCtrls, DBCtrls, uSeatPlan;

type
  TfrmTableSetUp = class(TForm)
    ImageList1: TImageList;
    AztecConn: TADOConnection;
    qryTableData: TADOQuery;
    dsTableData: TDataSource;
    ToolBar1: TToolBar  ;
    DBNavigator1: TDBNavigator;
    qryTableDataSiteCode: TIntegerField;
    qryTableDataTableNumber: TIntegerField;
    qryTableDataBackdrop: TWordField;
    qryTableDataHasSeatPlan: TBooleanField;
    qryTableDataHorizSize: TFloatField;
    qryTableDataVertSize: TFloatField;
    qryTableDataNumSeats1: TWordField;
    qryTableDataNumSeats2: TWordField;
    qryTableDataNumSeats3: TWordField;
    qryTableDataNumSeats4: TWordField;
    qryTableDataSeatRotation: TWordField;
    qryTableDataClockwise: TBooleanField;
    qryTableDataCircleOffset: TWordField;
    ComboBox1: TComboBox;
    ToolButton3: TToolButton;
    Button1: TButton;
    Button2: TButton;
    ToolBar2: TToolBar;
    lblTblNo: TLabel;
    Panel1: TPanel;
    Button4: TButton;
    Button5: TButton;

    procedure cmTableShapeChange(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryTableDataBackdropSetText(Sender: TField;
      const Text: String);
    procedure qryTableDataBackdropGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function CheckSaveChanges : Boolean;
    procedure SetTempSeatTableName(TempTableName: String);
    { Private declarations }
  public
    FSiteCode : Integer;
    FPanelButtonID : Integer;
    FTableNumber : Integer;
    SeatPlan1 : TSeatPlan;
    lkUpRound : Integer;
    lkUpSquare : Integer;
    lkUpDiamond : Integer;
    property TempSeatTableName : string write SetTempSeatTableName;
    { Public declarations }
  end;

var
  frmTableSetUp: TfrmTableSetUp;

implementation

uses uThemeModellingMenu, uAztecLog, uAztecDatabaseUtils;

{$R *.dfm}

procedure TfrmTableSetUp.cmTableShapeChange(Sender: TObject);
begin
end;

//------------------------------------------------------------------------------
procedure TfrmTableSetUp.ToolButton2Click(Sender: TObject);
begin
end;

//------------------------------------------------------------------------------
procedure TfrmTableSetUp.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  SeatPlan1.InitBackDropIDs(lkUpRound, lkupSquare, lkupDiamond);
  qryTableData.Close;
  qryTableData.Parameters.ParamByName('SiteCode').Value := FSiteCode;
  qryTableData.Parameters.ParamByName('TableNumber').Value := FTableNumber;
  qryTableData.Open;
  if (qryTableData.BOF) and (qryTableData.EOF) then
    SeatPlan1.New(FSiteCode,FTableNumber);
  SeatPlan1.SiteCode := FSiteCode;
  SeatPlan1.TableNumber := FTableNumber;
  ComboBox1.ItemIndex := SeatPlan1.TableShape;
  lblTblNo.Caption := 'Table : '+ IntToStr(FTableNumber);
end;

//------------------------------------------------------------------------------
procedure TfrmTableSetUp.FormCreate(Sender: TObject);
begin
  SetUpAztecADOConnection(AztecConn);

  SeatPlan1 := TSeatPlan.Create(Self);
  SeatPlan1.Parent := Panel1;
  SeatPlan1.Width := 320;
  SeatPlan1.Height := 336;
  SeatPlan1.Left := 0;
  SeatPlan1.TableShape := 0;
  SeatPlan1.Datasource := dsTableData;
end;

procedure TfrmTableSetUp.SetTempSeatTableName(TempTableName: String);
begin
  SeatPlan1.AztecTableName := TempTableName;
end;

procedure TfrmTableSetUp.qryTableDataBackdropSetText(Sender: TField;
  const Text: String);
begin
  if Text = 'Square' then
    qryTableData.FieldByName('BackDrop').AsInteger := lkUpSquare
  else if Text = 'Diamond' then
    qryTableData.FieldByName('BackDrop').AsInteger := lkUpDiamond
  else //** default to round **//
    qryTableData.FieldByName('BackDrop').AsInteger := lkUpRound;
end;

procedure TfrmTableSetUp.qryTableDataBackdropGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if qryTableData.FieldByName('BackDrop').AsInteger = lkUpSquare then
    Text := 'Square'
  else if qryTableData.FieldByName('BackDrop').AsInteger = lkUpDiamond then
    Text := 'Diamond'
  else
    Text := 'Round';
end;

//------------------------------------------------------------------------------
procedure TfrmTableSetUp.ComboBox1Change(Sender: TObject);
begin
  SeatPlan1.TableShape := ComboBox1.ItemIndex;
end;

procedure TfrmTableSetUp.Button1Click(Sender: TObject);
begin
  Log('Rotate Clockwise Clicked');
  SeatPlan1.Rotate(True);
end;

procedure TfrmTableSetUp.Button2Click(Sender: TObject);
begin
  Log('Rotate Anti Clockwise Clicked');
  SeatPlan1.Rotate(False);
end;

procedure TfrmTableSetUp.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbCancel then
    ComboBox1.ItemIndex := SeatPlan1.TableShape;
end;

//------------------------------------------------------------------------------
procedure TfrmTableSetUp.Button5Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  try
    SeatPlan1.CancelChanges := TRUE;
    dsTableData.DataSet.Cancel;
  finally
    SeatPlan1.CancelChanges := FALSE;
  end;
end;

procedure TfrmTableSetUp.Button4Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  if dsTableData.DataSet.State in [dsInsert, dsEdit] then
    dsTableData.DataSet.Post;
end;


//------------------------------------------------------------------------------
function TfrmTableSetUp.CheckSaveChanges : Boolean;
begin
  result := true;
  if dsTableData.state in [dsEdit,dsInsert] then
    if MessageDlg('Cancel changes and close?', mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      dsTableData.DataSet.Cancel;
      Result := True;
    end
    else
      Result := False;
end;

//------------------------------------------------------------------------------
procedure TfrmTableSetUp.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  if not ThemeModellingMenu.ApplicationClosing then
    CanClose := CheckSaveChanges;
end;

//------------------------------------------------------------------------------
procedure TfrmTableSetUp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

end.
