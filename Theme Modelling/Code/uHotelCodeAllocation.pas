unit uHotelCodeAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, uADO, StdCtrls, wwdblook, Wwdatsrc, Grids, Wwdbigrd,
  Wwdbgrid, ImgList;

type
  TSortField = (sfDivision, sfTill, sfSession, sfAnalysis);
  TSortOrder = (soAscending, soDescending);

  THotelCodeAllocation = class(TForm)
    qryHotelCodeAllocation: TADOQuery;
    grdHotelCodesAllocation: TwwDBGrid;
    dsHotelCodeAllocation: TwwDataSource;
    cmbHotelCodes: TwwDBLookupCombo;
    qryHotelCodes: TADOQuery;
    qryHotelCodesID: TIntegerField;
    qryHotelCodesCode: TStringField;
    btnCancel: TButton;
    qryHotelCodeAllocationTerminal: TStringField;
    qryHotelCodeAllocationHotelDivision: TStringField;
    qryHotelCodeAllocationSession: TStringField;
    qryHotelCodeAllocationHotelCodeID: TIntegerField;
    qryHotelCodeAllocationHotelDivisionID: TIntegerField;
    qryHotelCodeAllocationSessionID: TIntegerField;
    qryHotelCodeAllocationEposDeviceID: TIntegerField;
    qryHotelCodeAllocationAnalysisCode: TStringField;
    qryHotelCodeAllocationChanged: TBooleanField;
    cmdRefreshAllocation: TADOCommand;
    btnOK: TButton;
    cmdSaveChanges: TADOCommand;
    lblSiteName: TLabel;
    edtSiteName: TEdit;
    qryHotelCodeAllocationHotelCode: TStringField;
    ImageList1: TImageList;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure qryHotelCodeAllocationBeforePost(DataSet: TDataSet);
    procedure btnCancelClick(Sender: TObject);
    procedure grdHotelCodesAllocationTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure grdHotelCodesAllocationCalcTitleImage(Sender: TObject;
      Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
  private
    { Private declarations }
    CurrentSortField: TSortField;
    CurrentSortFieldName: String;
    CurrentSortOrder: TSortOrder;
    function GetSortDetails(newSortField: TSortField; newSortFieldName: String): String;
  public
    { Public declarations }
    FSiteCode: Integer;
    FSiteName: String;
  end;

var
  HotelCodeAllocation: THotelCodeAllocation;

implementation

{$R *.dfm}

procedure THotelCodeAllocation.FormShow(Sender: TObject);
begin
  edtSiteName.Text := FSiteName;
  //Note: Can't use parameters because the temp table created doesn't exist after execution
  //      of the command
  cmdRefreshAllocation.CommandText :=
    StringReplace(cmdRefreshAllocation.CommandText, ':SiteID', IntToStr(FSiteCode), [rfIgnoreCase]);
  cmdRefreshAllocation.Execute;
  qryHotelCodeAllocation.Open;
  CurrentSortField := sfDivision;
  CurrentSortFieldName := 'HotelDivision';
  CurrentSortOrder := soAscending;
end;

procedure THotelCodeAllocation.btnOKClick(Sender: TObject);
begin
  if qryHotelCodeAllocation.State = dsEdit then
    qryHotelCodeAllocation.Post;

  cmdSaveChanges.Execute;
end;

procedure THotelCodeAllocation.qryHotelCodeAllocationBeforePost(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('Changed').AsBoolean := TRUE;
  DataSet.FieldByName('HotelCode').AsString := DataSet.FieldByName('AnalysisCode').AsString;
end;

procedure THotelCodeAllocation.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function THotelCodeAllocation.GetSortDetails(newSortField: TSortField; newSortFieldName: String): String;
var
  mainSortOrder: String;
begin
  Result := '';
  if (CurrentSortField <> newSortField) then
  begin
    CurrentSortField := newSortField;
    CurrentSortFieldName := newSortFieldName;
    CurrentSortOrder := soAscending;
  end
  else
  begin
    if (CurrentSortOrder = soAscending) then
    begin
      CurrentSortOrder := soDescending;
      mainSortOrder := 'DESC';
    end
    else
    begin
      CurrentSortOrder := soAscending;
      mainSortOrder := 'ASC';
    end;
  end;

  case CurrentSortField of
    sfDivision: Result := ' ORDER BY HotelDivision ' + mainSortOrder + ', Terminal ASC, StartTime ASC';
    sfSession:  Result := ' ORDER BY StartTime ' + mainSortOrder + ', HotelDivision ASC, Terminal ASC';
    sfTill:     Result := ' ORDER BY Terminal ' + mainSortOrder + ', HotelDivision ASC, StartTime ASC';
    sfAnalysis: Result := ' ORDER BY HotelCode ' + mainSortOrder + ', HotelDivision ASC, Terminal ASC, StartTime ASC';
  end;
end;

procedure THotelCodeAllocation.grdHotelCodesAllocationTitleButtonClick(
  Sender: TObject; AFieldName: String);
var
  OrderSQL: String;
begin
  if (AFieldName = 'Session') then
    OrderSQL := GetSortDetails(sfSession, AFieldName)
  else if (AFieldName = 'HotelDivision') then
    OrderSQL := GetSortDetails(sfDivision, AFieldName)
  else if (AFieldName = 'Terminal') then
    OrderSQL := GetSortDetails(sfTill, AFieldName)
  else if (AFieldName = 'AnalysisCode') then
    OrderSQL := GetSortDetails(sfAnalysis, AFieldName)
  else
    Exit;


  with qryHotelCodeAllocation do
  begin
    DisableControls;
    Close;
    SQL.Text := 'SELECT HotelDivision, Terminal, Session, ' +
                '       HotelCodeID, HotelDivisionID, SessionID, EposDeviceID, Changed, ' +
                '       HotelCode ' +
                'FROM #HotelCodesAllocation ' +
                'WHERE Deleted = 0 ' +
                OrderSQL;
    Open;
    EnableControls;
  end;
end;

procedure THotelCodeAllocation.grdHotelCodesAllocationCalcTitleImage(
  Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  TitleImageAttributes.ImageIndex := -1;
  if (Field.FieldName = CurrentSortFieldName) then
  begin
    if (CurrentSortOrder = soAscending) then
      TitleImageAttributes.ImageIndex := 0
    else if (CurrentSortOrder = soDescending) then
      TitleImageAttributes.ImageIndex := 1;
  end;
end;

end.
