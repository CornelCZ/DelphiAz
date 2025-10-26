unit uFooterPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, DB, ADODB, StdCtrls, ComCtrls,
  ExtCtrls, DBGrids, ImgList, Contnrs, DateUtils, uDMThemeData, StrUtils;

const
  DYNAMIC_VOUCHER_CODE_PLACEHOLDER = '<-Voucher Code->';


type
  TFooterAlignment = (faLeft, faCentre, faRight);

  TSurveyCodeSupplier = (scsNone, scsMindShare, scsMarketForce, scsCLM, scsClarabridge, scsFeeditback);

  TLocalPaintBox = class(TPaintBox)
  public
    Text: String;
    Bold: Boolean;
    DoubleWidth: Boolean;
    DoubleHeight: Boolean;
    AppendSurveyCode: Boolean;
    AppendVoucherCode: Boolean;
    LocalAlignment: TFooterAlignment;
    IsTop: Boolean;
    IsBottom: Boolean;
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Anchors;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint;
    property OnStartDock;
    property OnStartDrag;
  end;

  TFooterPreview = class(TForm)
    ScrollBox: TScrollBox;
    pnlBottom: TPanel;
    btnClose: TButton;
    procedure LocalPaintBoxPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    LocalPaintBoxTop: TLocalPaintBox;
    LocalPaintBoxBottom: TLocalPaintBox;
    FIsShowing: Boolean;
    FSurveyCode: String;
    FSurveyCodeSupplier : TSurveyCodeSupplier;
    FShowSurveyCode: Boolean;
    FPaintBoxList: TObjectList;
    FLineCount: Integer;
    FTextAlignment: TFooterAlignment;

    procedure CreatePaintBoxes;
    procedure LocalPaintBoxTextOut(paintBox: TLocalPaintBox);
    //procedure DrawTopZigZagLine(paintBox: TLocalPaintBox);
    //procedure DrawBottomZigZagLine(paintBox: TLocalPaintBox);
    procedure DrawTopPlainLine(paintBox: TLocalPaintBox);
    procedure DrawBottomPlainLine(paintBox: TLocalPaintBox);
    procedure DrawDataPaintBox(paintBox: TLocalPaintBox);
    procedure GetSurveySupplierFromDB;
    function GenerateMindShareNumber(DateTime: TDateTime; LocationNumber, TicketNumber: Integer): String;
    function GenerateMarketForceNumber(DateTime : TDateTime; LocationNumber, AccountNumber : Integer): String;
    function GetPaintBox(Index: Integer): TLocalPaintBox;
    function GenerateClarabridgeNumber(SiteReference, DeviceID,
      AccountID: Integer): String;
    function PadLeft(StartString: String; DesiredLength: integer;
      PaddingCharacter: char): String;
    function GenerateFeeditbackNumber(SiteID, AccountID: Integer;
      Time: TDateTime): String;
    function GetAlphanumericFeeditbackCode(input : String) : string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create(AOwner: TComponent; LineCount: Integer; TextAlignment: TFooterAlignment = faCentre; ShowSurveyCode: Boolean = FALSE); reintroduce; overload;
    procedure ConfigurePaintBox(LineNo, TopPosition: Integer; FooterText: String; isBold, isDoubleSize: Boolean; _AppendSurveyCode: Boolean = False; _AppendVoucherCode: Boolean = False); overload;
    procedure ConfigurePaintBox(LineNo, TopPosition: Integer; FooterText: String; TextAlignment: SmallInt; isBold, isDoubleWidth, isDoubleHeight: Boolean; _AppendSurveyCode: Boolean = False; _AppendVoucherCode: Boolean = False); overload;
    procedure CreateTopAndBottomPaintBoxes;
    property IsShowing: Boolean read FIsShowing write FIsShowing;
    property PaintBox[Index: Integer]: TLocalPaintBox read GetPaintBox;
  end;


implementation

{$R *.dfm}

constructor TLocalPaintBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TForm(AOwner);
  Text := '';
  Bold := FALSE;
  AppendSurveyCode := False;
  AppendVoucherCode := False;
  Left := 34;
  Width := 412;
  Height := 18;
  IsTop := FALSE;
  IsBottom := FALSE;
end;

(*
procedure TFooterPreview.DrawTopZigZagLine(paintBox: TLocalPaintBox);
var
  x,y: Integer;
begin
    paintBox.Canvas.Brush.Color := clWhite;
    paintBox.Canvas.FillRect(paintBox.ClientRect);
    paintBox.Canvas.MoveTo(paintBox.ClientRect.Left,paintBox.ClientRect.Bottom);
    paintBox.Canvas.LineTo(paintBox.ClientRect.Left,paintBox.ClientRect.Top);
    paintBox.Canvas.MoveTo(paintBox.ClientRect.Right,paintbox.ClientRect.Top);
    paintBox.Canvas.LineTo(paintBox.ClientRect.Right,paintBox.ClientRect.Bottom);
    paintBox.Canvas.MoveTo(paintBox.ClientRect.Left,paintBox.ClientRect.Top+1);
    x := paintBox.ClientRect.Left;
    y := paintBox.ClientRect.Top+3;
    paintBox.Canvas.Brush.Color := clBtnFace;
    paintBox.Canvas.Pen.Width := 1;
    while (x <= paintBox.ClientRect.Left + paintBox.ClientWidth) do
    begin
      paintBox.Canvas.LineTo(x+5,y+5);
      paintBox.Canvas.LineTo(x+10,y);
      x := x+10;
    end;
    paintBox.Canvas.MoveTo(paintBox.ClientRect.Left+3,paintBox.ClientRect.Top+1);
    paintBox.Canvas.Brush.Color := clBtnFace;
    paintBox.Canvas.FloodFill(paintBox.ClientRect.Left+3,paintBox.ClientRect.Top+1, clBlack, fsBorder);
end;


procedure TFooterPreview.DrawBottomZigZagLine(paintBox: TLocalPaintBox);
var
  x,y: Integer;
begin
  paintBox.Canvas.Brush.Color := clWhite;
  paintBox.Canvas.FillRect(paintBox.ClientRect);
  paintBox.Canvas.MoveTo(paintBox.ClientRect.Left,paintBox.ClientRect.Top);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Left,paintBox.ClientRect.Bottom);
  paintBox.Canvas.MoveTo(paintBox.ClientRect.Right,paintBox.ClientRect.Bottom);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Right,paintBox.ClientRect.Top);

  paintBox.Canvas.MoveTo(paintBox.ClientRect.Left,paintBox.ClientRect.Bottom-2);
  x := paintBox.ClientRect.Left;
  y := paintBox.ClientRect.Bottom-2;
  paintBox.Canvas.Pen.Width := 1;
  while (x <= paintBox.ClientRect.Left + paintBox.ClientWidth) do
  begin
    paintBox.Canvas.LineTo(x+5,y-5);
    paintBox.Canvas.LineTo(x+10,y);
    x := x+10;
  end;

  // add shadow below line
  paintBox.Canvas.MoveTo(paintBox.ClientRect.Left+3,paintBox.ClientRect.Bottom-1);
  paintBox.Canvas.Brush.Color := clBtnFace;
  paintBox.Canvas.FloodFill(paintBox.ClientRect.Left+3,paintBox.ClientRect.Bottom-1, clBlack, fsBorder);

  paintBox.Canvas.MoveTo(paintBox.ClientRect.Left+1,paintBox.ClientRect.Bottom-2);
  x := paintBox.ClientRect.Left+1;
  y := paintBox.ClientRect.Bottom-2;
  while (x <= paintBox.ClientRect.Left + paintBox.ClientWidth - 3) do
  begin
    paintBox.Canvas.Pen.Color := clBlack;
    paintBox.Canvas.Lineto(x+5,y-5);
    paintBox.Canvas.MoveTo(x+4,y-3);
    paintBox.Canvas.LineTo(x+6,y-3);
    paintBox.Canvas.MoveTo(x+3,y-2);
    paintBox.Canvas.LineTo(x+4,y-2);
    paintBox.Canvas.MoveTo(x+6,y-2);
    paintBox.Canvas.LineTo(x+7,y-2);
    paintBox.Canvas.Pen.Color := clBtnShadow;
    paintBox.Canvas.MoveTo(x+4,y-2);
    paintBox.Canvas.LineTo(x+6,y-2);
    paintBox.Canvas.MoveTo(x+2,y-1);
    paintBox.Canvas.LineTo(x+5,y-1);
    paintBox.Canvas.MoveTo(x+6,y-1);
    paintBox.Canvas.LineTo(x+8,y-1);
    paintBox.Canvas.MoveTo(x+1,y);
    paintBox.Canvas.LineTo(x+3,y);
    paintBox.Canvas.MoveTo(x+10,y);
    x := x+10;
  end;
end;
*)

procedure TFooterPreview.DrawTopPlainLine(paintBox: TLocalPaintBox);
begin
  paintBox.Canvas.Brush.Color := clWhite;
  paintBox.Canvas.FillRect(paintBox.ClientRect);
  paintBox.Canvas.MoveTo(paintBox.ClientRect.Left,paintBox.ClientRect.Bottom);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Left,paintBox.ClientRect.Top);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Right,paintbox.ClientRect.Top);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Right,paintBox.ClientRect.Bottom);
end;

procedure TFooterPreview.DrawDataPaintBox(paintBox: TLocalPaintBox);
begin
  paintBox.Canvas.Brush.Color := clWhite;
  paintBox.Canvas.FillRect(paintBox.ClientRect);
  paintBox.Canvas.MoveTo(paintBox.ClientRect.Left,paintBox.ClientRect.Top);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Left,paintBox.ClientRect.Bottom);
  paintBox.Canvas.MoveTo(paintBox.ClientRect.Right,paintBox.ClientRect.Top);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Right,paintBox.ClientRect.Bottom);
end;

procedure TFooterPreview.DrawBottomPlainLine(paintBox: TLocalPaintBox);
begin
  paintBox.Canvas.Brush.Color := clWhite;
  paintBox.Canvas.FillRect(paintBox.ClientRect);
  paintBox.Canvas.MoveTo(paintBox.ClientRect.Left,paintBox.ClientRect.Top);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Left,paintBox.ClientRect.Bottom);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Right,paintbox.ClientRect.Bottom);
  paintBox.Canvas.LineTo(paintBox.ClientRect.Right,paintBox.ClientRect.Top);
end;


procedure TFooterPreview.LocalPaintBoxTextOut(paintBox: TLocalPaintBox);
var
  lf: TLogFont;
  ActualTextLength: Integer;
  OutputText: String;
  bigHeight: Integer;
  Points: array of TPoint;
  Left: Integer;
  Right: Integer;
  Top: Integer;
  Bottom: Integer;
  OldFont: HFONT;
  NewFont: HFONT;
begin
  if PaintBox.AppendSurveyCode then
    OutputText := PaintBox.Text + FSurveyCode
  else if PaintBox.AppendVoucherCode then
    Outputtext := DYNAMIC_VOUCHER_CODE_PLACEHOLDER
  else
    OutputText := PaintBox.Text;
  bigHeight := 20;

  paintBox.Canvas.Pen.Color := clBlack;
  paintBox.Canvas.Pen.Width := 2;
  if paintBox.IsTop then
    DrawTopPlainLine(paintBox)
  else if paintBox.IsBottom then
    DrawBottomPlainLine(paintBox)
  else
    DrawDataPaintBox(paintBox);

  if paintBox.IsTop or paintBox.IsBottom then
    Exit;

  strpcopy(lf.lfFaceName, 'Courier New');
  if paintBox.DoubleWidth then
  begin
    lf.lfWidth := 20;
    ActualTextLength := Length(OutputText) * 20;
    if paintBox.Bold then
      lf.lfWeight := FW_BOLD
    else
      lf.lfWeight := FW_DONTCARE;
  end
  else
  begin
    ActualTextLength := Length(OutputText)*10;
    if paintBox.Bold then
    begin
      lf.lfWidth := 9;
      lf.lfWeight := FW_SEMIBOLD;
    end
    else
    begin
      lf.lfWidth := 10;
      lf.lfWeight := FW_DONTCARE;
    end;
  end;

  if paintBox.DoubleHeight then
    lf.lfHeight := bigHeight
  else
    lf.lfHeight := -15;

  lf.lfItalic := 0;
  lf.lfUnderline := 0;
  lf.lfStrikeOut := 0;
  lf.lfOutPrecision := OUT_OUTLINE_PRECIS;
  lf.lfClipPrecision := CLIP_DEFAULT_PRECIS;
  lf.lfQuality := PROOF_QUALITY;
  lf.lfPitchAndFamily := FF_DONTCARE;
  lf.lfCharSet := paintbox.Canvas.Font.Charset;
  lf.lfEscapement := 0;
  lf.lfOrientation := 0;
  //lf.lfHeight := -15;

  NewFont := CreateFontIndirect(lf);
  OldFont := SelectObject(PaintBox.Canvas.Handle,NewFont);

  Top := Paintbox.ClientRect.Top;
  Bottom := Paintbox.ClientRect.Bottom;
  case PaintBox.LocalAlignment of
    faCentre: Left := paintbox.ClientRect.Left + ((paintbox.ClientRect.right-paintbox.ClientRect.Left) - ActualTextLength) div 2;
    faLeft: Left := paintbox.ClientRect.Left + 4
  else
    Left := paintbox.ClientRect.Right - ActualTextLength - 4;
  end;
  Right := Left + ActualTextLength;

  if PaintBox.AppendVoucherCode then
  begin
    SetLength(Points, 5);
    Points[0] := Point(Left - 2,Top + 2);
    Points[1] := Point(Right + 2, Top + 2);
    Points[2] := Point(Right + 2, Bottom - 2);
    Points[3] := Point(Left - 2, Bottom - 2);
    Points[4] := Points[0];

    PaintBox.Canvas.Brush.Style := bsSolid;
    PaintBox.Canvas.Brush.Color := clInfoBk;
    SetBkColor(Paintbox.Canvas.Handle,ColorToRGB(clWindow));
    SetBKMode(PaintBox.Canvas.Handle,Transparent);
    PaintBox.Canvas.FillRect(Rect(Points[0], Points[2]));
 end;

  paintBox.Canvas.TextOut(Left, Top, OutputText);

  if PaintBox.AppendVoucherCode then
  begin
    PaintBox.Canvas.Pen.Style := psDot;
    PaintBox.Canvas.Pen.Color := clBlack;
    PaintBox.Canvas.Pen.Width := 1;
    PaintBox.Canvas.PolyLine(Points);
  end;

  SelectObject(PaintBox.Canvas.Handle, OldFont);
  DeleteObject(NewFont);
end;

procedure TFooterPreview.LocalPaintBoxPaint(Sender: TObject);
begin

  if (TLocalPaintBox(Sender).Tag > FLineCount) then
    Exit;

  LocalPaintBoxTextOut(TLocalPaintBox(Sender));
end;

procedure TFooterPreview.CreatePaintBoxes;
var
  i: Integer;
begin
  FPaintBoxList := TObjectList.Create(True);
  for i := 1 to FLineCount do
    FPaintBoxList.Add(TLocalPaintBox.Create(ScrollBox));
end;

procedure TFooterPreview.CreateTopAndBottomPaintBoxes;
begin
  LocalPaintBoxTop := TLocalPaintBox.Create(ScrollBox);
  with LocalPaintBoxTop do
  begin
    Top := 32;
    IsTop := TRUE;
    OnPaint := LocalPaintBoxPaint;
  end;

  LocalPaintBoxBottom := TLocalPaintBox.Create(ScrollBox);
  with LocalPaintBoxBottom do
  begin
    Top := TLocalPaintBox(FPaintBoxList[FPaintBoxList.Count-1]).Top + TLocalPaintBox(FPaintBoxList[FPaintBoxList.Count-1]).Height;
    IsBottom := TRUE;
    OnPaint := LocalPaintBoxPaint;
  end;
end;

procedure TFooterPreview.ConfigurePaintBox(LineNo, TopPosition: Integer; FooterText: String; isBold, isDoubleSize, _AppendSurveyCode, _AppendVoucherCode: Boolean);
var
  TextAlignment: Integer;
  isDoubleHeight: Boolean;
begin
  TextAlignment := 1; //Centre
  isDoubleHeight := False;
  ConfigurePaintBox(LineNo, TopPosition, FooterText, TextAlignment, isBold, isDoubleSize, isDoubleHeight, _AppendSurveyCode, _AppendVoucherCode);
end;

// Set up paint box with extra attributes including Double Width, Double Height and Local Text Alignment (as opposed to all lines having the same alignment)
// This is currently used by Bill Footer set up
procedure TFooterPreview.ConfigurePaintBox(LineNo, TopPosition: Integer; FooterText: String; TextAlignment: SmallInt; isBold, isDoubleWidth, isDoubleHeight, _AppendSurveyCode, _AppendVoucherCode: Boolean);
begin
  with TLocalPaintBox(FPaintBoxList[LineNo-1]) do
  begin
    Tag := LineNo;
    Top := TopPosition;
    Text := FooterText;
    Bold := isBold;
    DoubleWidth := isDoubleWidth;
    DoubleHeight := isDoubleHeight;
    AppendSurveyCode := _AppendSurveyCode;
    AppendVoucherCode := _AppendVoucherCode;
    case TextAlignment of
      0 : LocalAlignment := faLeft;
      1 : LocalAlignment := faCentre;
      2 : LocalAlignment := faRight;
      else
        Raise Exception.Create('Error setting alignment for text line - invalid alignment value');
    end;
    OnPaint := LocalPaintBoxPaint;
  end;
end;

procedure TFooterPreview.FormDestroy(Sender: TObject);
begin
  FPaintBoxList.Free;
end;

procedure TFooterPreview.FormCreate(Sender: TObject);
begin
  Randomize; //For fake MindShareNumber generation
  CreatePaintBoxes;
end;

procedure TFooterPreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FIsShowing := False;
  Action := caHide;
end;

function TFooterPreview.GenerateMindShareNumber(DateTime: TDateTime;
  LocationNumber, TicketNumber: Integer): String;
var
  LocationPart, DatePart, TicketPart, Whole: String;
  DigitArray: array[0..11] of Integer;
  i: Integer;
  RunTotal: Integer;
begin
  if (LocationNumber <= 9999) and (TicketNumber <= 9999) then
  begin
    LocationPart := IntToStr(LocationNumber);
    LocationPart := StringOfChar('0',4 - Length(LocationPart)) + LocationPart;
    TicketPart := IntToStr(TicketNumber);
    TicketPart := StringOfChar('0',4 - Length(TicketPart)) + TicketPart;
    DatePart := FormatDateTime('mmdd',DateTime);
    Whole := LocationPart + DatePart + TicketPart;

    for i := 0 to 11 do
      DigitArray[i] := StrToInt(Copy(Whole,i+1,1));

    RunTotal := 0;
    for i := 0 to 11 do
    begin
      if i mod 2 = 0 then
      begin
        DigitArray[i] := (DigitArray[i] * 2);
        if DigitArray[i] > 9 then DigitArray[i] := DigitArray[i] - 9;
      end;
      RunTotal := RunTotal + DigitArray[i];
    end;

    Result := Whole + IntToStr((9 * RunTotal) mod 10);
  end;
end;

function TFooterPreview.GenerateMarketForceNumber(DateTime: TDateTime;
  LocationNumber, AccountNumber: Integer): String;
const
  IntToCharZeroBased : Array[0..23] of Char = ('A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');
  IntToCharOneBased : Array[1..24] of Char = ('A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');
var
  Char1, Char5, Char6, Char9, Char10 : Char;
  Chars2to4, Chars7to8, Chars11to12, LocationNumberAsString, AccountNumberAsString : String;
  Year, Month, Day, Hour, Minute, Second, Millisecond : Word;
begin
  LocationNumberAsString := IntToStr(LocationNumber);
  AccountNumberAsString := IntToStr(AccountNumber);
  DecodeDateTime(DateTime, Year, Month, Day, Hour, Minute, Second, Millisecond);
  Char1 := IntToCharOneBased[Month];
  Chars2to4 := copy(LocationNumberAsString, 1, 3);
  Char5 := IntToCharZeroBased[ AccountNumber mod 10 ] ;
  Char6 := IntToCharZeroBased[Hour];
  Chars7to8 := copy(AccountNumberAsString, 1, 2);
  Char9 := IntToCharZeroBased[ StrToInt(Copy(AccountNumberAsString,3,1)) ];
  if Day <= 24 then
    Char10 := IntToCharOneBased[ Day ]
  else
    Char10 := IntToStr(Day - 24)[1];
  Chars11to12 := Copy(LocationNumberAsString,4,2);
  result := Char1 + Chars2to4 + Char5 + Char6 + Chars7to8 + Char9 + Char10 + Chars11to12;
end;

function TFooterPreview.GenerateClarabridgeNumber(SiteReference, DeviceID, AccountID : Integer) : String;
var
  SiteReferenceString, DeviceIDString, AccountIDString, CheckDigit : String;
begin
  SiteReferenceString := IntToStr(SiteReference);
  DeviceIDString := IntToStr(DeviceID);
  AccountIDString := IntToStr(AccountID);
  CheckDigit := IntToStr(trunc(Random(9)));
  SiteReferenceString := PadLeft(SiteReferenceString, 4, '0');
  DeviceIDString := PadLeft(DeviceIDString,2,'0');
  AccountIDString := PadLeft(AccountIDString, 6, '0');

  result := SiteReferenceString + DeviceIDString + AccountIDString + CheckDigit;
end;

function TFooterPreview.GenerateFeeditbackNumber(SiteID, AccountID : Integer; Time : TDateTime): String;
var
  SiteIDAsString, AccountIDAsString : String;
  DayOfAccount, HourOfAccount : String;
begin
  SiteIDAsString := PadLeft(IntToStr(SiteID),5,'0');
  AccountIDAsString := PadLeft(IntToStr(AccountID),4,'0');
  DayOfAccount := PadLeft(IntToStr(DayOf(Time)),2,'0');
  HourOfAccount := PadLeft(IntToStr(HourOf(Time)),2,'0');
  result := IntToStr((MinuteOf(Time) mod 5) + 1);
  result := result + Copy(AccountIDAsString,4,1);
  result := Result + Copy(AccountIDAsString,3,1);
  result := Result + Copy(AccountIDAsString,2,1);
  result := Result + Copy(DayOfAccount,2,1);
  result := Result + Copy(DayOfAccount,1,1);
  result := Result + Copy(SiteIDAsString,5,1);
  result := Result + Copy(SiteIDAsString,4,1);
  result := Result + Copy(SiteIDAsString,3,1);
  result := Result + Copy(SiteIDAsString,2,1);
  result := Result + Copy(HourOfAccount,2,1);
  result := Result + Copy(HourOfAccount,1,1);
  result := Result + Copy(AccountIDAsString,1,1);
  result := Result + Copy(SiteIDAsString,1,1);
  result := GetAlphanumericFeeditbackCode(result);
end;

function TFooterPreview.PadLeft(StartString : String; DesiredLength : integer; PaddingCharacter : char) : String;
begin
  Result := StringOfChar(PaddingCharacter, DesiredLength) + StartString;
  Result := RightStr(Result, DesiredLength);
end;

function TFooterPreview.GetAlphanumericFeeditbackCode(input : String) : String;
const
  OutputCharArray : Array[0..33] of char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
                'Q','R','S','T','U','V','W','X','Y','Z','2','3','4','5','6','7','8','9');
var
  WorkingNumber : int64;
begin
  if Length(input) <> 14 then
    Raise Exception.Create('Feeditback reference number should always be 14 digits long');
  WorkingNumber := StrToInt64(input);
  while (WorkingNumber > 0) do
  begin
    Result := Result + OutputCharArray[WorkingNumber mod 34];
    WorkingNumber := WorkingNumber div 34;
  end;
  result := copy(result,1,3) + '-' + copy(result,4,3) + '-' + copy(result,7,3);
end;

procedure TFooterPreview.FormShow(Sender: TObject);
begin
  if FShowSurveyCode then
  begin
    GetSurveySupplierFromDB;
    case FSurveyCodeSupplier of
      scsMindShare :
        FSurveyCode := GenerateMindshareNumber(now,Trunc(Random(9999)), Trunc(Random(9999)));
      scsMarketForce :
        FSurveyCode := GenerateMarketForceNumber(now, Trunc(Random(99999)), Trunc(Random(9999)));
      scsCLM:
        FSurveyCode := DYNAMIC_VOUCHER_CODE_PLACEHOLDER;
      scsClarabridge:
        FSurveyCode := GenerateClarabridgeNumber( Trunc(Random(9999)),Trunc(Random(99)),Trunc(Random(999999))) ;
      scsFeeditback:
        FSurveyCode := GenerateFeeditbackNumber( Trunc(Random(99999)), Trunc(Random(9999)), Now);
    end;
  end;
end;

constructor TFooterPreview.Create(AOwner: TComponent);
begin
  inherited;
  FLineCount := 50;//30;
  FTextAlignment := faCentre;
  FShowSurveyCode := TRUE;
end;

constructor TFooterPreview.Create(AOwner: TComponent; LineCount: Integer;
  TextAlignment: TFooterAlignment; ShowSurveyCode: Boolean);
begin
  Create(AOwner);
  FLineCount := LineCount;
  FTextAlignment := TextAlignment;
  FShowSurveyCode := ShowSurveyCode;
end;

procedure TFooterPreview.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox.Perform(WM_VSCROLL,1,0);
end;

procedure TFooterPreview.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ScrollBox.Perform(WM_VSCROLL,0,0);
end;

function TFooterPreview.GetPaintBox(Index: Integer): TLocalPaintBox;
begin
  if (Index < 0) or (Index > FPaintBoxList.Count) then
    Result := nil
  else
    Result := TLocalPaintBox(FPaintBoxList[Index]);
end;

procedure TFooterPreview.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFooterPreview.GetSurveySupplierFromDB;
begin
  with dmThemeData.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select top 1 oc.SurveyCodeSupplier as SurveySupplier');
    SQL.Add('from #PromotionalFooterSalesArea pfsa');
    SQL.Add('inner join ac_SalesArea sa');
    SQL.Add('on pfsa.SalesAreaId = sa.Id');
    SQL.Add('inner join ThemeOutletConfigs oc');
    SQL.Add('on sa.SiteId = oc.SiteCode');
    SQL.Add('where oc.SurveyCodeSupplier <> 0');
    Open;
    FSurveyCodeSupplier := TSurveyCodeSupplier(FieldByName('SurveySupplier').AsInteger);
  end;
end;

end.
