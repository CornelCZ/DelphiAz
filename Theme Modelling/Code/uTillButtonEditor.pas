unit uTillButtonEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, uTillButton, ImgList;

type
  TTillButtonEditor = class(TForm)
    ilBackdropColours: TImageList;
    FunctionGrpBx: TGroupBox;
    lbBFunc: TLabel;
    ButtonTypeIDEdit: TEdit;
    edButtonTypeData: TEdit;
    lblFuncData: TLabel;
    lblFuncDesc: TLabel;
    edtButtonTypeDesc: TEdit;
    FormatGrpBx: TGroupBox;
    edFGColour: TStaticText;
    Label2: TLabel;
    Label3: TLabel;
    cbBackdropColours: TComboBoxEx;
    cbLargeFont: TCheckBox;
    pnlSecurity: TPanel;
    btEditSecurity: TButton;
    cbDefault: TCheckBox;
    TextGrpBx: TGroupBox;
    mmEposName: TMemo;
    FGColourDlg: TColorDialog;
    Label1: TLabel;
    pnlButtons: TPanel;
    btOk: TButton;
    btCancel: TButton;
    mmOriginalName: TMemo;
    Label6: TLabel;
    ProductGrpBx: TGroupBox;
    lblProdType: TLabel;
    edtProductType: TEdit;
    edtProductDescription: TEdit;
    lblProdDesc: TLabel;
    edButtonTypeID: TUpDown;
    procedure edFGColourClick(Sender: TObject);
    procedure btEditSecurityClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mmEposNameKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonTypeIDEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edButtonTypeDataKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FTillButton: TTillButton;
    procedure FillColourCombo;
    procedure SetMaximumButtonTypeID;
  public
    FButtonTypeID : int64;
    ButtonID: int64;
    ButtonSecurityId: integer;
    RequestWitness: boolean;
    NoTimedSecurity: boolean;
    { Public declarations }
    procedure LoadData(obj: TTillButton);
    procedure SaveData(obj: TTillButton);
    function GetFunctionDescription(FunctionID : String): String;
    function GetText(TableName, FieldName, KeyField, ButtonID : String) : String;
    function GetProductButtonText(ButtonID : String) : String;
    function GetFunctionButtonText(ButtonID : String) : String;
    procedure GetSelectedButtonText(ButtonData, ButtonData2 : String);
  end;

var
  TillButtonEditor: TTillButtonEditor;

implementation

uses uEditJobSecurity, uADO, uEditTimedJobSecurity, uSimpleLocalise, DB;

{$R *.dfm}

procedure TTillButtonEditor.edFGColourClick(Sender: TObject);
begin
  FGColourDlg.Color := TEdit(sender).Color;
  if FGColourDlg.Execute then
    TEdit(sender).color := FGColourDlg.Color;
end;

procedure TTillButtonEditor.btEditSecurityClick(Sender: TObject);
begin
  if NoTimedSecurity then
  begin
    with TEditJobSecurity.create(nil) do try
      buttonID := self.ButtonID;
      ButtonSecurityId := self.ButtonSecurityId;
      if showmodal = mrOk then
      begin
        Self.ButtonSecurityId := ButtonSecurityId;
        Self.RequestWitness := RequestWitness;
      end;
    finally
      free;
    end;
  end
  else
  with TEditTimedJobSecurity.create(nil) do try
    FButtonList.Add(FTillButton);
    ButtonSecurityId := self.ButtonSecurityId;
    FRequestWitness := uEditTimedJobSecurity.RequestWitnessStateFromBoolean(Self.RequestWitness);
    if showmodal = mrOk then
    begin
      Self.ButtonSecurityId := ButtonSecurityId;
      Self.RequestWitness := uEditTimedJobSecurity.BooleanFromRequestWitnessState(FRequestWitness, Self.RequestWitness);
    end;
  finally
    free;
  end;
end;

procedure TTillButtonEditor.FormCreate(Sender: TObject);
var
  i: integer;
begin
  LocaliseForm(self);
  if (lowercase(dmADO.Logon_Name) <> 'zonaldev') and
     (lowercase(dmADO.Logon_Name) <> 'zonalqa') and
     (lowercase(dmADO.Logon_Name) <> 'zonalhc') and
     (lowercase(dmADO.Logon_Name) <> 'zzcritical') then
  begin
    for i:= 0 to FunctionGrpBx.ControlCount -1 do
      if (FunctionGrpBx.controls[i].Tag = 1) and (FunctionGrpBx.Controls[i] is TEdit) then
        begin
          TEdit(FunctionGrpBx.controls[i]).Color := clBtnFace;
          TEdit(FunctionGrpBx.Controls[i]).ReadOnly := True;
        end
      else

      if (FunctionGrpBx.controls[i].Tag = 1) and (FunctionGrpBx.Controls[i] is TUpDown) then
          TUpDown(FunctionGrpBx.Controls[i]).Enabled := False;
    end;
  FillColourCombo;
end;

procedure TTillButtonEditor.mmEposNameKeyPress(Sender: TObject;
  var Key: Char);
var
  i, linecount: integer;
  tmpstr: string;
begin
  linecount := 0;
  tmpstr := TMemo(sender).lines.text;
  for i := 1 to length(tmpstr) do
    if (tmpstr[i] = #13) then inc(linecount);
  if (key = #13) and (linecount >= 2) then abort;
end;

procedure TTillButtonEditor.ButtonTypeIDEditChange(Sender: TObject);
begin
  with dmado.qRun do
  begin
    try
      sql.text := format('select Name from themebuttontypechoicelookup where id = %d', [strtoint(TEdit(sender).text)]);
      open;
      TEdit(sender).Hint := fieldbyname('name').asstring;
      TEdit(sender).ShowHint := true;

      FButtonTypeID := StrToInt(TEdit(sender).Text);

      GetSelectedButtonText(edButtonTypeData.text, '0');

      edtButtonTypeDesc.Text := GetFunctionDescription(TEdit(sender).Text);
    except
      close;
    end;
  end;
end;

procedure TTillButtonEditor.LoadData(obj: TTillButton);
var
  i: integer;
begin
  FTillButton := obj;

  if Assigned(obj.Owner) and (obj.Owner is TPanelManager) and (TPanelManager(obj.Owner).PanelType = ptDialog) then
    btEditSecurity.Enabled := false;

  ButtonID := obj.ButtonID;
  ButtonSecurityId := obj.ButtonSecurityId;
  RequestWitness := obj.RequestWitness;
  mmEposName.lines.Text :=
    obj.EposName1 + #13+
    obj.EposName2 + #13+
    obj.EposName3;
  edButtonTypeID.position := obj.ButtonTypeID;
  edButtonTypeData.Text := obj.ButtonTypeData;
  edFGColour.color := MakeColour(
    obj.FGColourRed,
    obj.FGColourGreen,
    obj.FGColourBlue
  );
  cbLargeFont.Checked := obj.FontID = 0;

  SetMaximumButtonTypeID;

  FButtonTypeID := obj.ButtonTypeID;

  if edtButtonTypeDesc.Visible then
     edtButtonTypeDesc.Text := GetFunctionDescription(IntToStr(obj.ButtonTypeID))
  else
     GetSelectedButtonText(obj.ButtonTypeData, obj.ButtonTypeData2);

  for i := 0 to pred(cbbackdropcolours.ItemsEx.Count) do
    if integer(cbbackdropcolours.itemsEx[i].data) = obj.backdropid then
    cbBackdropcolours.itemindex := i;
end;

procedure TTillButtonEditor.GetSelectedButtonText(ButtonData, ButtonData2 : String);
begin

  if (FButtonTypeID = 10) and (ButtonData <> '') then
     mmOriginalName.Lines.Text := GetText('ThemePanel', 'EPosName', 'PanelID',
                                                 ButtonData)
  else
  if (FButtonTypeID = 10) and (ButtonData = '') then
     mmOriginalName.Lines.Text := GetText('ThemeTablePlan', 'EPosName', 'TablePlanID',
                                                 ButtonData2)
  else
  if FButtonTypeID = 17 then
     mmOriginalName.Lines.Text := GetText('ac_PortionType', 'POSButtonTextLine',
                                                       'ID', ButtonData)
  else
  if FButtonTypeID = 67 then
     mmOriginalName.Lines.Text := GetText('Discount', 'EPosName',
                                                       'DiscountID', ButtonData)
  else
  if FButtonTypeID = 153 then
     mmOriginalName.Lines.Text := GetText('ac_orderdestination', 'PosButtonTextLine',
                                                       'ID', ButtonData)
  else
  if FButtonTypeID = 58 then
     mmOriginalName.Lines.Text := GetText('ThemeReport', 'EPosName',
                                                       'ReportID', ButtonData)
  else
  if (FButtonTypeID = 7) or (FButtonTypeID = 24) then
     mmOriginalName.Lines.Text := GetProductButtonText(ButtonData)
  else
  if FButtonTypeID = 6 then
     mmOriginalName.Lines.Text := GetText('ac_PaymentMethod', 'POSButtonTextLine',
                                                   'ID', ButtonData)
  else
  if FButtonTypeID = 13 then
     mmOriginalName.Lines.Text := GetText('theme_correctionmethod', 'EPosName',
                                                   'CorrectionMethodID', ButtonData)
  else
    if FButtonTypeID = 113 then
     mmOriginalName.Lines.Text := ButtonData
  else
  if FButtonTypeID = 175 then
     mmOriginalName.Lines.Text := GetText('ThemeEftRuleSoapOperation', 'EPosName',
                                                   'EFTRule', ButtonData)
  else
    begin
      ProductGrpBx.Visible := false;

      if (FButtonTypeID = 12) and (ButtonData = 'Park') then
         mmOriginalName.Lines.Text := ButtonData
    else
      if (FButtonTypeID = 12) and (ButtonData = 'ParkWithTicket') then
         mmOriginalName.Lines.Text := 'Park' + #13 + 'With' + #13 + 'Ticket'
    else
      if (FButtonTypeID = 12) and (ButtonData = 'MoveSeat') then
         mmOriginalName.Lines.Text := 'Move' + #13 + 'Seat'
    else
      if (FButtonTypeID = 12) and (ButtonData = 'MoveSeparateBill') then
         mmOriginalName.Lines.Text := 'Move' + #13 + 'Separate' + #13 + 'Bill'
    else
      if (FButtonTypeID = 96) and (ButtonData = 'CorrectAll') then
         mmOriginalName.Lines.Text := 'Correct' + #13 + 'All'
    else
      if (FButtonTypeID = 96) and (ButtonData = 'CorrectOne') then
         mmOriginalName.Lines.Text := 'Correct' + #13 + 'One'
    else
     mmOriginalName.Lines.Text := GetFunctionButtonText(IntToStr(FButtonTypeID));
    end;
end;

function TTillButtonEditor.GetText(TableName, FieldName, KeyField, ButtonID : String) : String;
begin
  ProductGrpBx.Visible := False;

  with dmADO.qRun do
    try
      SQL.Clear;
      SQL.Add('SELECT '+ FieldName +'1, '+ FieldName +'2, '+ FieldName +'3 ');
      SQL.Add('   FROM '+ TableName);
      SQL.Add('WHERE '+ KeyField + ' = '+ ButtonID);

      Open;
      result := Fields[0].AsString + #13 +
                Fields[1].AsString + #13 +
                Fields[2].AsString;
    except
      close;
    end;
end;

function TTillButtonEditor.GetProductButtonText(ButtonID : String) : String;
begin

  ProductGrpBx.Visible := True;
  with dmADO.qRun do
    try
      SQL.Clear;
      SQL.Add('SELECT AztecEPoSButton1, AztecEPoSButton2, AztecEPoSButton3, [Entity Type], [Extended RTL Name] + IsNull('' / ''+[Retail Description], '''') ');
      SQL.Add('   FROM Products  ');
      SQL.Add('WHERE EntityCode = '+ ButtonID);
      Open;

      edtProductType.Text := Fields[3].AsString;
      edtProductDescription.Text := Fields[4].AsString;

      result := Fields[0].AsString + #13 +
                Fields[1].AsString + #13 +
                Fields[2].AsString;
    except
      close;
    end;
end;

function TTillButtonEditor.GetFunctionButtonText(ButtonID : String) : String;
begin
  with dmADO.qRun do
    try
      SQL.Clear;
      SQL.Add('SELECT tf.Text FROM themefunctiontext tf ');
      SQL.Add('  JOIN ThemeButtonTypeChoiceLookup tbt ON tbt.Name = tf.ButtonFunction ');
      SQL.Add('WHERE ID = '+ ButtonID);
      Open;
      Result := Fields[0].AsString;
      ProductGrpBx.Visible := False;
    except
      close;
    end;
end;

function TTillButtonEditor.GetFunctionDescription(FunctionID : String) : String;
begin
  with dmADO.qRun do
    try
      SQL.Clear;
      SQL.Add('SELECT Name FROM ThemeButtonTypeChoiceLookup ');
      SQL.Add('    WHERE ID = '+ FunctionID);
      Open;

      result := FieldByName('Name').AsString
    except
      close;
    end;
end;

procedure TTillButtonEditor.SaveData(obj: TTillButton);
var
  t1, t2, t3: byte;
begin
  obj.ButtonSecurityId := ButtonSecurityId;
  obj.RequestWitness := RequestWitness;
  if mmEposName.Lines.count > 0 then
    obj.EposName1 := mmEposName.lines[0]
  else
    obj.EposName1 := '';
  if mmEposName.Lines.count > 1 then
    obj.EposName2 := mmEposName.lines[1]
  else
    obj.EposName2 := '';
  if mmEposName.Lines.count > 2 then
    obj.EposName3 := mmEposName.lines[2]
  else
    obj.EposName3 := '';
  obj.ButtonTypeID := StrToInt(ButtonTypeIDEdit.Text);
  obj.ButtonTypeData := edButtonTypeData.Text;
    splitcolour(edFGColour.color, t1, t2, t3);
  obj.FGColourRed := t1;
  obj.FGColourGreen := t2;
  obj.FGColourBlue := t3;
  if cbLargeFont.Checked then
    obj.FontID := 0
  else
    obj.FontID := 1;
  obj.backdropid := integer(cbbackdropcolours.itemsex[cbbackdropcolours.itemindex].data);
  obj.Invalidate;
end;

procedure TTillButtonEditor.FillColourCombo;
var
  currname: string;
  currcolour: Tcolor;
  i: integer;
  bmp: TBitmap;

  function CreateColourBitmap(bmpcolour: TColor): TBitmap;
  begin
    result := TBitmap.create;
    result.Width := 16;
    result.Height := 16;
    result.PixelFormat := pf24bit;
    result.Canvas.Pen.color := bmpcolour;
    result.Canvas.Brush.color := bmpcolour;
    result.Canvas.Rectangle(0, 0, 15, 15);
  end;

begin

  for i := Pred(cbBackdropColours.ItemsEx.Count) downto 0 do
  begin
    cbBackdropColours.ItemsEx[i].Data := nil;
    cbBackdropColours.ItemsEx.delete(i);
  end;

  for i := pred(ilBackdropColours.count) downto 0 do
  begin
    ilbackdropcolours.Delete(i);
  end;

  with dmADO.qRun do
  begin
    // default colour and button type (when no backdrop is assigned)
    sql.text := 'select Id, Value from ThemeBackdropLookup order by id';
    open;
    while not(Eof) do
    begin
      CurrName := fieldbyname('Value').asstring;
      if CurrName = 'DarkBlue' then CurrColour := 10027008
      else if CurrName = 'DarkRed' then CurrColour := 128
      else if CurrName = 'DarkGreen' then CurrColour := 32768
      else if CurrName = 'DarkPurple' then CurrColour := 8388736
      else if CurrName = 'LightBlue' then CurrColour := 16711680
      else if CurrName = 'LightRed' then CurrColour := 255
      else if CurrName = 'LightGreen' then CurrColour := 65280
      else if CurrName = 'LightPurple' then CurrColour := 16711884
      else if CurrName = 'Pink' then CurrColour := 10027263
      else if CurrName = 'Yellow' then CurrColour := 52428
      else if CurrName = 'Turquoise' then CurrColour := 10066176
      else if CurrName = 'Orange' then CurrColour := 26367
      else if CurrName = 'Close' then CurrColour := 0
      else CurrColour := -1;
      if CurrColour <> -1 then
      begin
        bmp := createcolourbitmap(CurrColour);
        ilBackDropColours.Add(bmp, nil);
        bmp.free;
        cbBackDropColours.ItemsEx.AddItem('', ilBackDropColours.Count-1,
          ilBackDropColours.Count-1, ilBackDropColours.Count-1, 0, pointer(fieldbyname('ID').asinteger));
      end;
      next;
     
    end;
    close;
  end;
end;

procedure TTillButtonEditor.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := Pred(cbBackdropColours.ItemsEx.Count) downto 0 do
  begin
    cbBackdropColours.ItemsEx[i].Data := nil;
    cbBackdropColours.ItemsEx.delete(i);
  end;

  for i := pred(ilBackdropColours.count) downto 0 do
  begin
    ilbackdropcolours.Delete(i);
  end;
end;

procedure TTillButtonEditor.edButtonTypeDataKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
      FButtonTypeID := StrToInt(ButtonTypeIDEdit.Text);

      GetSelectedButtonText(edButtonTypeData.text, '0');

      edtButtonTypeDesc.Text := GetFunctionDescription(ButtonTypeIDEdit.Text);
end;

procedure TTillButtonEditor.SetMaximumButtonTypeID;
begin
  with dmADO.qRun do
    begin
      Close;
      SQL.Text := ('SELECT COUNT(*) AS Count FROM ThemeButtonTypeChoiceLookup ');
      Open;

      edButtonTypeID.Max := FieldByName('Count').AsInteger;
    end;
end;

end.
