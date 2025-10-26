unit uSwipeCardExceptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, uADO_SwipeRange;

type
  TDisableControlsProc = procedure(ParentControl: TWinControl);

  TSwipeCardExceptions = class(TForm)
    gridSwipeExceptions: TwwDBGrid;
    btnClose: TButton;
    btnDelete: TButton;
    btnAdd: TButton;
    dtsSwipeExceptions: TDataSource;
    qSwipeExceptions: TADOQuery;
    qSwipeExceptionsExceptionID: TLargeintField;
    qSwipeExceptionsSwipeCardrangeID: TLargeintField;
    qSwipeExceptionsValue: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FStartValue, FEndValue : String;
    FSwipeCardRangeID : Integer;
    RecModified : Boolean;
    FIsPromotional: Boolean;
    FReadOnly: Boolean;
    FDisableControls: TDisableControlsProc;
    procedure generateExceptionRange;
    { Private declarations }
  public
    { Public declarations }
    ExceptionList : TStringList;
    property StartValue : String write FStartValue;
    property EndValue : String write FEndValue;
    property SwipeCardRangeID : Integer write FSwipeCardRangeID;
    property IsPromotional: Boolean read FIsPromotional write FIsPromotional;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property DisableControls: TDisableControlsProc read FDisableControls write FDisableControls;
  end;

var
  SwipeCardExceptions: TSwipeCardExceptions;

implementation

uses uSwipeCardExceptionValue,uGenerateThemeIDs, useful;

{$R *.dfm}

procedure TSwipeCardExceptions.FormShow(Sender: TObject);
begin
  if FIsPromotional then
    HelpContext := 7107
  else
    HelpContext := 5070;

  ExceptionList := TStringList.Create;

  RecModified := False;

  with qSwipeExceptions do
  begin
    Close;
    Parameters[0].Value := FSwipeCardRangeID;
    Open;

    first;
    while not EOF do
      begin
        ExceptionList.Add(FieldByName('Value').AsString);
        next;
      end;
  end;

  if FReadOnly and Assigned(FDisableControls) then
  begin
    FDisableCOntrols(Self);
    btnClose.Enabled := True;
  end;
end;

procedure TSwipeCardExceptions.btnAddClick(Sender: TObject);
var i : integer;
begin

  with TSwipeCardExceptionValue.Create(nil) do
  try
    IsPromotional := FIsPromotional;

    {TO DO: ?! Did we really just burn a pointer for no reason?
    I cannot clearly tell what ExceptionList is really used for.  This needs
    investigation as I cannot be confident of making changes here given my short timescale.}
    FExceptionList := TStringList.Create;
    FExceptionList := ExceptionList;

    ExStartValue := FStartValue;
    ExEndValue := FEndValue;

    if ShowModal = mrOK then
    begin
      {TO DO: For large newExceptionList this is glacially slow.  Most of the
      slowness is down to GetNewID, but I can't help but feel a lock type of ltBatchOptimistic
      might be in order for qSwipeExceptions.  As above I have no time to investigate.}
      qSwipeExceptions.DisableControls;
      try
        for i := 0 to Pred(newExceptionList.Count) do
          with qSwipeExceptions do
          begin
          Insert;
          FieldByName('ExceptionID').AsInteger := GetNewId(scThemeSwipeCardException);
          FieldByName('SwipeCardRangeID').AsInteger := FSwipeCardRangeID;
          FieldByName('Value').AsString := newExceptionList[i];
          RecModified := True;
          Post;
          ExceptionList.Add(newExceptionList[i]);
          end;
      finally
        qSwipeExceptions.EnableControls;
      end;
    end;

    qSwipeExceptions.Close;
    qSwipeExceptions.Open;
    newExceptionList.Free;
  finally
    free;
  end;
end;

procedure TSwipeCardExceptions.btnDeleteClick(Sender: TObject);

  procedure DeleteFromExceptionList(deleteValue : String);
  var i : integer;
  begin
    for i := 0 to Pred(ExceptionList.Count) do
    begin
      if ExceptionList[i] = deleteValue then
        begin
         ExceptionList.Delete(i);
         break;
        end;
    end;
  end;

begin
   if qSwipeExceptions.RecordCount = 0 then
      raise Exception.Create('There are no exceptions to delete.')
   else
   if MessageDlg(Format('Do you want to delete exception ''%s''?',[qSwipeExceptions.FieldByName('Value').AsString]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
       RecModified := True;
       DeleteFromExceptionList(qSwipeExceptions.FieldByName('Value').AsString);
       qSwipeExceptions.Delete;
     end;
end;

procedure TSwipeCardExceptions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if RecModified and not FReadOnly then
     generateExceptionRange;
end;

function CompareExceptions(List: TStringList; Index1, Index2: Integer): Integer;
  var
    d1, d2: String;
begin
    d1 := List[Index1];
    d2 := List[Index2];
    if d1 = d2 then
       Result := 0
    else
    if not StringGreaterThan(d1, d2) then
      Result := -1
    else
    if StringGreaterThan(d1, d2) then
       Result := 1
    else
       Result := 0;
end;

procedure TSwipeCardExceptions.generateExceptionRange;
var
  originalParam, newParam: String;
begin
  originalParam := ':SwipeCardRangeID -- IDParam';
  newParam := IntToStr(FSwipeCardRangeID) + ' -- IDParam';

  with dmADO_SwipeRange.qGenerateRanges do
  begin
    SQL.Text := StringReplace(SQL.Text, originalParam, newParam, [rfReplaceAll, rfIgnoreCase]);
    ExecSQL;
    SQL.Text := StringReplace(SQL.Text, newParam, originalParam, [rfReplaceAll, rfIgnoreCase]);
  end;
end;

end.
