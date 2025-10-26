unit uPriceIncDec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Wwdbigrd, Wwdbgrid, DB, ADODB, Grids,
  ActnList;

type TIncDecType = (tidValueIncrease, tidValueDecrease, tidPercentageIncrease, tidPercentageDecrease);

type TCrackedGrid = class(TwwCustomDBGrid);

type
  TfrmPriceIncDec = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    cbxCalculationType: TComboBox;
    lblCalculationType: TLabel;
    edtCalculationAmount: TEdit;
    lblValue: TLabel;
    lblPercent: TLabel;
    ActionList1: TActionList;
    actOK: TAction;
    procedure edtCalculationAmountKeyPress(Sender: TObject; var Key: Char);
    procedure cbxCalculationTypeChange(Sender: TObject);
    procedure actOKExecute(Sender: TObject);
    procedure actOKUpdate(Sender: TObject);
  private
    { Private declarations }
    FCalculationType: TIncDecType;
    FGrid: TwwDbGrid;
    FPriceColumn: String;
    procedure ModifyPrices;
  public
    { Public declarations }
    procedure IncDecPrices(grid: TwwDbGrid; PriceColumn: String);
  end;

var
  frmPriceIncDec: TfrmPriceIncDec;

implementation

uses
  udmPromotions, uAztecLog, Math;

{$R *.dfm}

procedure TfrmPriceIncDec.edtCalculationAmountKeyPress(Sender: TObject;
  var Key: Char);
var
  CurrText: String;
  Edit: TEdit;
  DecimalPos: Integer;
  SelPos: Integer;
  SelLength: Integer;
begin
  Edit := TEdit(Sender);

  CurrText := Edit.Text;
  DecimalPos := Pos('.',CurrText);
  SelPos := Edit.SelStart;
  SelLength := Edit.SelLength;

  udmPromotions.ValidatePriceKeyPress(Key, CurrText, SelPos, SelLength, DecimalPos, false);
end;

procedure TfrmPriceIncDec.cbxCalculationTypeChange(Sender: TObject);
begin
  lblPercent.Visible := TCombobox(sender).itemindex in [2, 3];

  case TCombobox(sender).itemindex of
    0: FCalculationType := tidValueIncrease;
    1: FCalculationType := tidValueDecrease;
    2: FCalculationType := tidPercentageIncrease;
    3: FCalculationType := tidPercentageDecrease;
  end;
end;

procedure TfrmPriceIncDec.ModifyPrices;
var
  i, j: Integer;
  PriceColumnIndex: Integer;
  Delta: real;
  StartRecNo: Integer;
  Amount: Currency;
  OldCursor: TCursor;
  VisibleRowCount: Integer;
  ActiveRow: Integer;

  function CalcTypeToStr(CalcType: TIncDecType; Amt: real): String;
  begin
    case calcType of
      tidValueIncrease: Result := 'value increase of ' + FloatToStr(Amt);
      tidValueDecrease: Result := 'value decrease of ' + FloatToStr(Amt);
      tidPercentageIncrease: Result := 'percentage increase of ' + FloatToStr(Amt) + '%';
      tidPercentageDecrease: Result := 'percentage decrease of ' + FloatToStr(Amt) + '%';
    end;
  end;

begin
  Amount := StrToCurr(edtCalculationAmount.Text);
  Log('  +/- Price Adjustment', 'Promotion price ' + CalcTypeToStr(FCalculationType,Amount));

  PriceColumnIndex := -1;
  for j := 0 to FGrid.FieldCount -1 do
  begin
    if FGrid.FieldName(j) = FPriceColumn then
    begin
      PriceColumnIndex := j;
      Break;
    end;
  end;

  OldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if PriceColumnIndex > -1 then
    begin
      ActiveRow := FGrid.GetActiveRow;
      StartRecno := fgrid.datasource.dataset.RecNo;
      VisibleRowCount := TCrackedGrid(FGrid).VisibleRowCount;

      FGrid.DataSource.DataSet.DisableControls;
      FGrid.DataSource.DataSet.RecNo := 1;

      Log('  +/- Price Adjustment', Format('Modifying %d prices', [FGrid.Selectedlist.Count]));
      for i := 0 to FGrid.SelectedList.Count - 1 do
      begin
        FGrid.DataSource.DataSet.GotoBookmark(FGrid.SelectedList.Items[i]);
        FGrid.DataSource.DataSet.Edit;
        Delta := 0;
        case FCalculationType of
          tidValueIncrease, tidValueDecrease:
            Delta := Amount;
          tidPercentageIncrease, tidPercentageDecrease:
            Delta := FGrid.Fields[PriceColumnIndex].AsCurrency * (Amount/100);
        end;

        if FCalculationType in [tidValueDecrease, tidPercentageDecrease] then
        begin
          if (FGrid.Fields[PriceColumnIndex].AsCurrency - Delta) < 0 then
            FGrid.Fields[PriceColumnIndex].AsCurrency := 0
          else
            FGrid.Fields[PriceColumnIndex].AsCurrency := FGrid.Fields[PriceColumnIndex].AsCurrency - Delta;
        end
        else
          FGrid.Fields[PriceColumnIndex].AsCurrency := FGrid.Fields[PriceColumnIndex].AsCurrency + Delta;

        FGrid.DataSource.DataSet.Next;
      end;
      //Restore the previous record "view" i.e. the user shoudl be looking at the
      //same set of records even after we've mucked around with book marks.
      FGrid.DataSource.DataSet.RecNo := Max(StartRecNo - ActiveRow + Ceil(VisibleRowCount/2) - 1,0);
      FGrid.DataSource.DataSet.EnableControls;
    end
    else begin
      Log('  +/- Price Adjustment', 'Failed to Inc/Dec promotion prices.  Price column "' + FPriceColumn +'" not found.');
      MessageDlg('Unable to modify promotion prices.',
                  mtError,
                  [mbOK],
                  0);
    end;
  finally
    Screen.Cursor := OldCursor;
  end;
end;

procedure TfrmPriceIncDec.IncDecPrices(grid: TwwDbGrid;
  PriceColumn: String);
begin
  FGrid := grid;
  FPriceColumn := PriceColumn;
  ShowModal;
end;

procedure TfrmPriceIncDec.actOKExecute(Sender: TObject);
var
  DoMod: Boolean;
  TmpValue: extended;
begin
  DoMod := True;

  case FCalculationType of
    tidValueIncrease,
    tidValueDecrease:
    begin
      TmpValue := StrToFloatDef(edtCalculationAmount.Text, LOW_PRICE_RANGE-1.0);
      if (TmpValue > HIGH_PRICE_RANGE) or (TmpValue < LOW_PRICE_RANGE) then
      begin
        MessageDlg(Format('Price values must be between %f and %f.', [LOW_PRICE_RANGE, HIGH_PRICE_RANGE]),
                   mtError,
                   [mbOK],
                   0);
        DoMod := False;
      end;
    end;
    tidPercentageIncrease:
    begin
      TmpValue := StrToFloatDef(edtCalculationAmount.Text, LOW_PERCENTAGE-1.0);
      if (TmpValue > VERY_HIGH_PERCENTAGE) or (TmpValue < LOW_PERCENTAGE) then
      begin
        MessageDlg(Format('Increase Percentage values must be between %f and %f.', [LOW_PERCENTAGE, VERY_HIGH_PERCENTAGE]),
                   mtError,
                   [mbOK],
                   0);
        DoMod := False;
      end;
    end;
    tidPercentageDecrease:
    begin
      TmpValue := StrToFloatDef(edtCalculationAmount.Text, LOW_PERCENTAGE-1.0);
      if (TmpValue > HIGH_PERCENTAGE) or (TmpValue < LOW_PERCENTAGE) then
      begin
        MessageDlg(Format('Decrease Percentage values must be between %f and %f.', [LOW_PERCENTAGE, HIGH_PERCENTAGE]),
                   mtError,
                   [mbOK],
                   0);
        DoMod := False;
      end;
    end;
  end;

  if DoMod then
    ModifyPrices;
end;

procedure TfrmPriceIncDec.actOKUpdate(Sender: TObject);
begin
  actOK.Enabled := (cbxCalculationType.ItemIndex > -1) and (edtCalculationAmount.Text <> '');
  btnOK.Default := actOK.Enabled;
  btnCancel.Default := not actOK.Enabled;
end;

end.
