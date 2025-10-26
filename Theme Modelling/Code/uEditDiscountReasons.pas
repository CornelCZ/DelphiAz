unit uEditDiscountReasons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList, uSelectReasonsFrame;

type
  TEditDiscountReasons = class(TForm)
    SelectReasonsFrame: TSelectReasonsFrame;
    procedure FormCreate(Sender: TObject);
  private
    FDiscountID: Int64;
    FReasonsModified: Boolean;
    procedure SaveMappedReasons;
  public
    constructor Create(AOwner: TComponent; DiscountID: Int64); reintroduce;
    property ReasonsModfied: Boolean read FReasonsModified;
  end;

implementation

uses uADO, uAztecLog;

{$R *.dfm}

procedure TEditDiscountReasons.FormCreate(Sender: TObject);
begin
  FReasonsModified := False;

  SelectReasonsFrame.BehaveAsDialog := true;
  SelectReasonsFrame.PerformSave := SaveMappedReasons;
  SelectReasonsFrame.AllReasonsSQL :=
    'SELECT tr.ReasonID, Name, CAST(CASE WHEN tdrm.ReasonID IS NULL THEN 0 ELSE 1 END as BIT) as Used ' +
    'FROM ThemeReason tr ' +
    'LEFT JOIN #ThemeDiscountReasonMap tdrm ON tr.ReasonID = tdrm.ReasonID';

  SelectReasonsFrame.Initialise;
end;

procedure TEditDiscountReasons.SaveMappedReasons;
var
  ReasonID, Index : integer;
begin
  FReasonsModified := True;

  dmADO.qRun.SQL.Clear;
  //The where clause is not strictly necessary (the table only has reasons for
  //DiscountID = FDiscountID, but kept for form's sake)
  dmADO.qRun.SQL.Text := 'Delete from #ThemeDiscountReasonMap '+
                         'Where DiscountID = '+ IntToStr(FDiscountID);
  dmADO.qRun.ExecSQL;
  for Index := 0 to (SelectReasonsFrame.ChosenReasons.Count - 1) do
  begin
    ReasonID := Integer(SelectReasonsFrame.ChosenReasons.Objects[Index]);
    dmADO.qRun.SQL.Clear;
    dmADO.qRun.SQL.Text := 'Insert into #ThemeDiscountReasonMap '+
                           '(ReasonID, DiscountID) '+
                           'Values ('+ IntToStr(ReasonID)+','+ IntToStr(FDiscountID)+')';
    dmADO.qRun.ExecSQL;
  end;
end;

constructor TEditDiscountReasons.Create(AOwner: TComponent; DiscountID: Int64);
begin
  inherited Create(AOwner);

  FDiscountID := DiscountID;
end;


end.
