unit uPortionCookTimes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, ExtCtrls,DB,
  wwdbdatetimepicker,ADODB;

type
  TProtectionHackGrid = class(TwwCustomDBGrid)
    public
      FCacheColInfo: TList;
      property ColCount;
  end;

type
  TPortionCookTimes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SaveButton: TButton;
    CancelButton: TButton;
    dbgCookTimes: TwwDBGrid;
    pnlCheckBoxHider: TPanel;
    wwDBDateTimePicker: TwwDBDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure dbgCookTimesFieldChanged(Sender: TObject; Field: TField);
    procedure dbgCookTimesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SaveButtonClick(Sender: TObject);
    procedure dbgCookTimesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CancelButtonClick(Sender: TObject);
    procedure dbgCookTimesDrawTitleCell(Sender: TObject; Canvas: TCanvas;
      Field: TField; Rect: TRect; var DefaultDrawing: Boolean);
  private
    { Private declarations }
    FSkipChangeEvent: Boolean;
    FDoSave: Boolean;
    FCanClose: Boolean;
    procedure SetupGrid;
    function IsStandardPortion: Boolean;
    procedure CooktimesBeforePost(DataSet: TDataSet);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AsOfDateCaption: String); reintroduce;
  end;

var
  PortionCookTimes: TPortionCookTimes;

implementation

uses
  uDatabaseADO;

{$R *.dfm}

procedure TPortionCookTimes.FormShow(Sender: TObject);
begin
  dbgCooktimes.BeginUpdate;
  try
    ProductsDB.qEditCookTimes.close;
    ProductsDB.qEditCookTimes.Open;

    SaveButton.Enabled := not ProductsDB.CurrentEntityControlledByRM;
    if ProductsDB.CurrentEntityControlledByRM then
      dbgCookTimes.ReadOnly := True;
  finally
    dbgCooktimes.EndUpdate;
  end;
  SetupGrid;
end;

procedure TPortionCookTimes.SetupGrid;
var
  i: Integer;
  CurrentField: string;
  DisplayName: String;
  DisplayWidth: Integer;
begin
  with dbgCookTimes do
  begin
    Options := Options - [Wwdbigrd.dgIndicator];
    BeginUpdate;

    Selected.Clear;

    for i := 0 to pred(datasource.dataset.fields.count) do
    begin
      //Fields that we *do* want to show the user..
      CurrentField := lowercase(Datasource.DataSet.Fields[i].FieldName);
      if ((CurrentField = 'portionname')
       or (CurrentField = 'cooktime')
       or (CurrentField = 'defaultcooktime')
       ) then
      begin
        if (CurrentField = 'portionname') then
        begin
          DisplayName := 'Portion';
          DisplayWidth := 15;
        end
        else if (CurrentField = 'cooktime') then
        begin
          //Note the last param of this call to SetControlType. In a
          //normal active grid double clicking the grid reveals a columns
          //editor which allows the assignment of an edit control to a particular
          //column field.  One of the useful options is 'Control Always Paints'
          //(datetime editor benefits from choosing this).  These grids cannot
          //be made active at designtime.  Adding the (undocumented) 'T' param
          //at the end of the control name turns on this option.
          if not ProductsDB.CurrentEntityControlledByRM then
            SetControlType(dbgCookTimes.datasource.dataset.fields[i].FieldName,fctCustom,'wwDBDateTimePicker;T');
          DisplayName := 'Cook Time';
          DisplayWidth := 15;
        end
        else if (CurrentField = 'defaultcooktime') then
        begin
          setControlType(dbgCookTimes.datasource.dataset.fields[i].FieldName,fctCheckBox,'True;False');
          DisplayName := 'Use Default Cook Time';
          DisplayWidth := 1;//Columnsautosize to show all the title
        end
        else
          DisplayWidth := 10;

        Selected.Add(dbgCookTimes.datasource.dataset.fields[i].FieldName
                     +#9
                     +InttoStr(DisplayWidth)
                     +#9
                     +DisplayName)
      end;
    end;
    ApplySelected;

    EndUpdate;

    Refresh;
  end;

   pnlCheckBoxHider.Width := dbgCookTimes.ColWidths[2] ;
   pnlCheckBoxHider.Top := dbgCookTimes.Top + 20 ;
   pnlCheckBoxHider.Left := dbgCookTimes.Left + dbgCookTimes.ColWidths[0] +dbgCookTimes.ColWidths[1] + 4 ;
end;

procedure TPortionCookTimes.dbgCookTimesFieldChanged(Sender: TObject;
  Field: TField);
var
  UseDefault: Boolean;
begin
  if FSkipChangeEvent then
  begin
    //FSkipChangeEvent := False;
    Exit;
  end;

  //This procedure is definitely not reentrant and we need the usually
  //kludgey Changing<blah> flags to stop infinite recursion.  Find a better
  //way than this if possible.
  if (Lowercase(Field.FieldName) = 'defaultcooktime') then
  begin
    dbgCookTimes.DataSource.DataSet.DisableControls;
    try
    FSkipChangeEvent := True;
    UseDefault := Field.AsBoolean;
    if UseDefault and not IsStandardPortion then
      dbgCookTimes.DataSource.DataSet.FieldByName('cooktime').value := null;
    FSkipChangeEvent := False;
    finally
      dbgCookTimes.DataSource.DataSet.EnableControls;
    end;
  end
  else if (Lowercase(Field.FieldName) = 'cooktime') then
  begin
    if not (VarIsNull(Field.Value) or IsStandardPortion)  then
    begin
      dbgCookTimes.DataSource.DataSet.DisableControls;
      try
        FSkipChangeEvent := True;

        if (Field.AsDateTime <> 0) then
        begin
          dbgCookTimes.DataSource.DataSet.FieldByName('defaultcooktime').Value := False;
        end
        else
        begin
          dbgCookTimes.DataSource.DataSet.FieldByName('defaultcooktime').Value := True;
        end;
        FSkipChangeEvent := False;
      finally
        dbgCookTimes.DataSource.DataSet.EnableControls;
      end;
    end;
  end;
end;

procedure TPortionCookTimes.dbgCookTimesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dbgCookTimes.Datasource.Dataset.Fields[2].ReadOnly := IsStandardPortion;
end;

function TPortionCookTimes.IsStandardPortion: Boolean;
begin
  IsStandardPortion := dbgCookTimes.DataSource.DataSet.FieldByName('portiontypeid').AsInteger = 1;
end;

procedure TPortionCookTimes.SaveButtonClick(Sender: TObject);
begin
  FDoSave := True;
  FCanClose := True;
end;

procedure TPortionCookTimes.dbgCookTimesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  dbgCookTimes.Datasource.Dataset.Fields[2].ReadOnly := IsStandardPortion;
end;

procedure TPortionCookTimes.FormCreate(Sender: TObject);
begin
  FCanClose := True;
  dbgCookTimes.Datasource.Dataset.BeforePost := CooktimesBeforePost;
end;

procedure TPortionCookTimes.CooktimesBeforePost(
  DataSet: TDataSet);
var
  TempDateTime: TDateTime;
begin
  TempDateTime := Dataset.FieldByName('cooktime').AsDateTime;
  if (not DataSet.FieldByName('cooktime').IsNull) then
  begin
    if Frac(TempDateTime) = 0.0 then
      Dataset.FieldByName('cooktime').Clear
    else
    begin
      if TempDateTime < 2.0 then
        TempDateTime := Frac(TempDateTime) + 2.0;
      if TempDateTime <> Dataset.FieldByName('cooktime').AsDateTime then
        Dataset.FieldByName('cooktime').AsDateTime := TempDateTime;
    end;
  end;
  if (FormatDateTime('hh:nn:ss', Frac(TempDateTime)) > '01:00:00') then
  begin
    if MessageDlg('This Cook Time is bigger than 1 hour!'+#13+#10+''+#13+#10+
                  'Click "OK" to keep it, "Abort" to undo the change. ',
                  mtWarning,
                 [mbOK,mbAbort],
                  0) = mrAbort then
    begin
      Dataset.Cancel;
      Abort;
      if FCanClose then
        FCanClose := False;
    end;
  end;
end;

procedure TPortionCookTimes.FormDestroy(Sender: TObject);
begin
  dbgCookTimes.Datasource.Dataset.BeforePost := nil;
end;

procedure TPortionCookTimes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := FCanClose;
  if CanClose and FDoSave then
  begin
    if ProductsDB.qEditCookTimes.Active then
    begin
      ProductsDB.qEditCookTimes.UpdateBatch;
    end;
  end;
  FCanClose := True;
end;

procedure TPortionCookTimes.CancelButtonClick(Sender: TObject);
begin
  FCanClose := True
end;

procedure TPortionCookTimes.dbgCookTimesDrawTitleCell(Sender: TObject;
  Canvas: TCanvas; Field: TField; Rect: TRect;
  var DefaultDrawing: Boolean);
begin
  //Canvas.Font.Style := [fsbold];
end;

constructor TPortionCookTimes.Create(AOwner: TComponent;
  AsOfDateCaption: String);
begin
  inherited Create(AOwner);
  Caption := 'Portion Cook Times as of: ' + AsOfDateCaption;
end;

end.
