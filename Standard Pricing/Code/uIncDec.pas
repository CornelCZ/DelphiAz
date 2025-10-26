unit uIncDec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, Wwdbigrd, XLDBGrid;

type

  TCalcType = (ctNone, ctValue, ctPercentage);

  TfIncDec = class(TForm)
    pnlButtons: TPanel;
    bbtOK: TBitBtn;
    bbtCancel: TBitBtn;
    Panel1: TPanel;
    rgAdjustType: TRadioGroup;
    lblAmount: TLabel;
    edAmount: TEdit;
    lblPercent: TLabel;
    procedure edAmountKeyPress(Sender: TObject; var Key: Char);
    procedure bbtOKClick(Sender: TObject);
    procedure edAmountExit(Sender: TObject);
    procedure rgAdjustTypeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    CalculationValue: real;
    CalculationType: TCalcType;
    AllowZeroPrices: Boolean;
    AllowMaxPrices: Boolean;
    CancelAllChanges: Boolean;
    procedure PreCheck(Grid: TXLDBGrid; var PricesWillBeZero: Boolean; var PricesWillBeMax: Boolean);
    function ArithmeticRoundTo2dps(value: Currency): Currency;
  public
    { Public declarations }
    procedure IncDecPrices(var Grid: TXLDBGrid; MarkAsModified: Boolean);
    class procedure IncDecSelectedPrices(var Grid: TXLDBGrid; MarkAsModified: Boolean);
  end;

implementation

uses Math, uPricingLog;

const
  INCREASE_VALUE = 0;
  DECREASE_VALUE = 1;
  INCREASE_PERCENTAGE = 2;
  DECREASE_PERCENTAGE = 3;

{$R *.dfm}

class procedure TfIncDec.IncDecSelectedPrices(var Grid: TXLDBGrid; MarkAsModified: Boolean);
var
  frmIncDec: TfIncDec;
  PricesWillBeZero: Boolean;
  PricesWillBeMax: Boolean;

  procedure GetUserChoice(aMessage: String; var allowLimit: Boolean; var cancelChanges: Boolean);
  begin
    case MessageDlg(aMessage, mtWarning,[mbYes, mbNo, mbCancel],0) of
      mrYes :
        begin
          allowLimit := TRUE;
          CancelChanges := FALSE;
        end;
      mrNo :
        begin
          allowLimit := FALSE;
          CancelChanges := FALSE;
        end;
      mrCancel :
        begin
          CancelChanges := TRUE;
        end;
    else
      begin
        CancelChanges := TRUE;
      end;
    end;
  end;

begin
  frmIncDec := TfIncDec.Create(nil);
  try
    with frmIncDec do
    begin
      PricesWillBeZero := FALSE;
      PricesWillBeMax := FALSE;
      AllowZeroPrices := FALSE;
      AllowMaxPrices := FALSE;
      CancelAllChanges := FALSE;
      if ShowModal = mrOK then
      begin
        PreCheck(Grid, PricesWillBeZero, PricesWillBeMax);
        if PricesWillBeZero then
        begin
          GetUserChoice('This price change will cause one or more prices to be 0.00' + #13#10#10 +
                   'Select ' + #13#10 + '-  ''Yes'' to change all prices' + #13#10 +
                   '-  ''No'' to only change prices which will be greater than 0.00' + #13#10 +
                   '-  ''Cancel'' to cancel all price changes' + #13#10#10, AllowZeroPrices, CancelAllChanges);
        end;

        if not CancelAllChanges then
        begin
          if PricesWillBeMax then
          begin
            GetUserChoice('This price change will cause one or more prices to be 99,999.99' + #13#10 +
                     'which is the highest price allowed' + #13#10#10 +
                     'Select ' + #13#10 + '-  ''Yes'' to change all prices' + #13#10 +
                     '-  ''No'' to only change prices which will be less than 99,999.99' + #13#10 +
                     '-  ''Cancel'' to cancel all price changes' + #13#10#10, AllowMaxPrices, CancelAllChanges);
          end;
        end;

        if (CalculationValue <> 0.00) and not CancelAllChanges then
          IncDecPrices(Grid, MarkAsModified);
      end;
    end;
  finally
    frmIncDec.Free;
  end;
end;

procedure TfIncDec.PreCheck(Grid: TXLDBGrid; var PricesWillBeZero: Boolean; var PricesWillBeMax: Boolean);
var
  i, j: Integer;
  StartRecNo: integer;
  FirstFieldIndex, LastFieldIndex: Integer;
  theTop, theBottom, theLeft, theRight: integer;
  IndicatorOffset: Integer;
  AdjustValue: Currency;
  LogStr, ChangeStr: String;
begin
  AdjustValue := 0;
  if dgIndicator in Grid.Options then
    IndicatorOffset := 1
  else
    IndicatorOffset := 0;

  Screen.Cursor := crHourGlass;
  try
    with Grid do
    begin
      if XLSelected then
      begin
        theTop    := XLSelection.Top;
        theBottom := XLSelection.Bottom;
        theLeft   := XLSelection.Left;
        theRight  := XLSelection.Right;
      end
      else
      begin
        theTop    := DataSource.DataSet.RecNo;
        theBottom := DataSource.DataSet.RecNo;
        theLeft   := Grid.GetActiveCol;
        theRight  := Grid.GetActiveCol;
      end;

      StartRecNo := DataSource.DataSet.RecNo;
      DataSource.DataSet.DisableControls;
      FirstFieldIndex := theLeft - IndicatorOffset;
      LastFieldIndex := theRight - IndicatorOffset;

      DataSource.DataSet.RecNo := theTop;

      LogStr := '';
      if (CalculationValue < 0) then
        ChangeStr := ' decrease '
      else
        ChangeStr := ' increase ';

      case CalculationType of
        ctValue: LogStr := 'value' + ChangeStr + 'of ' + edAmount.Text;
        ctPercentage: LogStr := 'percentage' + ChangeStr + 'of ' + edAmount.Text + '%';
      end;

      Log.Event('Pre-checking adjustment of Selected Prices', ' Price ' + LogStr);

      for i := theTop to theBottom do
      begin
        for j := FirstFieldIndex to LastFieldIndex do
        begin
          if not Grid.Fields[j].IsNull then
          begin
            case CalculationType of
              ctValue : AdjustValue := CalculationValue;
              ctPercentage : AdjustValue := Grid.Fields[j].AsCurrency * (CalculationValue/100);
            end;

            if Grid.Fields[j].AsCurrency + AdjustValue < 0 then
            begin
              PricesWillBeZero := TRUE;
            end
            else if  Grid.Fields[j].AsCurrency + AdjustValue > 99999.99 then
              PricesWillBeMax := TRUE;
          end;

        end;
        DataSource.DataSet.Next;
      end;

      DataSource.DataSet.RecNo := StartRecNo;
      DataSource.DataSet.EnableControls;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfIncDec.edAmountKeyPress(Sender: TObject; var Key: Char);
begin
  //Only allow numbers, decimal point and backspace.
  if not (Key in ['0'..'9', '.', #8]) then
       Key := #0;

  if (Key = '.') and (Pos('.', TEdit(Sender).Text) > 0) then
    Key := #0; // only one full stop allowed
end;

procedure TfIncDec.bbtOKClick(Sender: TObject);

  function ValueOrAdjustTypeChanged: Boolean;
  begin
    Result := FALSE;
    case rgAdjustType.ItemIndex of
      INCREASE_VALUE, INCREASE_PERCENTAGE :
        begin
          if (CalculationValue <> StrToFloat(edAmount.Text)) then
            Result := TRUE;
        end;
      DECREASE_VALUE, DECREASE_PERCENTAGE :
        begin
          if (CalculationValue <> (StrToFloat(edAmount.Text) * -1)) then
            Result := TRUE;
        end;
    end;
  end;

  begin
  if (Trim(edAmount.Text) = '') or (Trim(edAmount.Text) = '.') then
  begin
    MessageDlg('No amount specified!', mtInformation, [mbOK], 0);
    ModalResult := mrNone;
    Exit;
  end
  else
  begin
    if (CalculationValue = 0) or ValueOrAdjustTypeChanged then
      edAmountExit(edAmount);
  end;
end;

procedure TfIncDec.edAmountExit(Sender: TObject);
begin
  CalculationValue := 0;

  try
    if TEdit(Sender).Text <> '' then
    begin
      if Length(TEdit(Sender).Text) > 18 then
        raise EConvertError.Create('The value cannot be more than 18 digits long');

      if (StrToFloat(TEdit(Sender).Text) > 99999.99) then
        raise EConvertError.Create('The value cannot be greater than 99,999.99');
      TEdit(Sender).Text := format('%.2f', [StrToFloat(TEdit(Sender).Text)]);
      CalculationValue := StrToFloat(TEdit(Sender).Text);

      if (rgAdjustType.ItemIndex in [DECREASE_VALUE, DECREASE_PERCENTAGE]) then
        CalculationValue := CalculationValue * -1;
    end;
  except
    on E: EConvertError do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      edAmount.Text := '';
      edAmount.SetFocus;
    end;
  end;
end;

procedure TfIncDec.rgAdjustTypeClick(Sender: TObject);
begin
  case rgAdjustType.ItemIndex of
    INCREASE_VALUE, DECREASE_VALUE :
      begin
        lblPercent.Visible := FALSE;
        CalculationType := ctValue;
        lblAmount.Caption := ' Value by:';
      end;
    INCREASE_PERCENTAGE, DECREASE_PERCENTAGE :
      begin
        lblPercent.Visible := TRUE;
        CalculationType := ctPercentage;
        lblAmount.Caption := ' Percentage by:';
      end;
  end;

  case rgAdjustType.ItemIndex of
    INCREASE_VALUE, INCREASE_PERCENTAGE : lblAmount.Caption := 'Increase' + lblAmount.Caption;
    DECREASE_VALUE, DECREASE_PERCENTAGE : lblAmount.Caption := 'Decrease' + lblAmount.Caption;
  end;

  edAmount.SetFocus;
end;

procedure TfIncDec.FormShow(Sender: TObject);
begin
  CalculationValue := 0;
  CalculationType := ctValue;
  edAmount.SetFocus;
end;

procedure TfIncDec.IncDecPrices(var Grid: TXLDBGrid; MarkAsModified: Boolean);
var
  i, j: Integer;
  StartRecNo: integer;
  FirstFieldIndex, LastFieldIndex: Integer;
  theTop, theBottom, theLeft, theRight: integer;
  IndicatorOffset: Integer;
  PriceChangeCount: Integer;
  AdjustValue: Currency;
  LogStr, ChangeStr: String;
begin
  AdjustValue := 0;
  if dgIndicator in Grid.Options then
    IndicatorOffset := 1
  else
    IndicatorOffset := 0;

  Screen.Cursor := crHourGlass;
  try
    with Grid do
    begin
      if XLSelected then
      begin
        theTop    := XLSelection.Top;
        theBottom := XLSelection.Bottom;
        theLeft   := XLSelection.Left;
        theRight  := XLSelection.Right;
      end
      else
      begin
        theTop    := DataSource.DataSet.RecNo;
        theBottom := DataSource.DataSet.RecNo;
        theLeft   := Grid.GetActiveCol;
        theRight  := Grid.GetActiveCol;
      end;

      StartRecNo := DataSource.DataSet.RecNo;
      DataSource.DataSet.DisableControls;
      FirstFieldIndex := theLeft - IndicatorOffset;
      LastFieldIndex := theRight - IndicatorOffset;

      DataSource.DataSet.RecNo := theTop;

      LogStr := '';
      PriceChangeCount := 0;
      if (CalculationValue < 0) then
        ChangeStr := ' decrease '
      else
        ChangeStr := ' increase ';

      case CalculationType of
        ctValue: LogStr := 'value' + ChangeStr + 'of ' + edAmount.Text;
        ctPercentage: LogStr := 'percentage' + ChangeStr + 'of ' + edAmount.Text + '%';
      end;

      Log.Event('Adjust Selected Prices', ' Price ' + LogStr);

      for i := theTop to theBottom do
      begin
        DataSource.DataSet.Edit;

        for j := FirstFieldIndex to LastFieldIndex do
        begin
          if not Grid.Fields[j].IsNull then
          begin
            PriceChangeCount := PriceChangeCount + 1;
            case CalculationType of
              ctValue : AdjustValue := CalculationValue;
              ctPercentage : AdjustValue := Grid.Fields[j].AsCurrency * (CalculationValue/100);
            end;

            if Grid.Fields[j].AsCurrency + AdjustValue < 0 then
            begin
              if AllowZeroPrices then
              begin
                Grid.fields[j].AsCurrency := 0;
                if MarkAsModified then
                  Grid.DataSource.DataSet.Fields[Grid.Fields[j].Index + 1].AsBoolean := True;
              end
            end
            else if Grid.Fields[j].AsCurrency + AdjustValue > 99999.99 then
            begin
              if AllowMaxPrices then
              begin
                Grid.fields[j].AsCurrency := Grid.Fields[j].AsCurrency + AdjustValue;
                if MarkAsModified then
                  Grid.DataSource.DataSet.Fields[Grid.Fields[j].Index + 1].AsBoolean := True;
              end;
            end
            else
            begin
              Grid.fields[j].AsCurrency := ArithmeticRoundTo2dps(Grid.Fields[j].AsCurrency + AdjustValue);
              if MarkAsModified then
                Grid.DataSource.DataSet.Fields[Grid.Fields[j].Index + 1].AsBoolean := True;
            end;
          end;

        end;

        DataSource.DataSet.Post;
        DataSource.DataSet.Next;
      end;

      if PriceChangeCount > 0 then
        Log.Event('Adjust Selected Prices', Format(' Modified %d prices', [PriceChangeCount]));

      DataSource.DataSet.RecNo := StartRecNo;
      DataSource.DataSet.EnableControls;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

//Round the given currency value such that if it lies exactly between two pennies, e.g. 1.625, it always
//takes the higher value, 1.63 in this example.  
function TfIncDec.ArithmeticRoundTo2dps(value: Currency): Currency;
begin
  Result := RoundTo(value + 0.0001, -2)
end;


end.
