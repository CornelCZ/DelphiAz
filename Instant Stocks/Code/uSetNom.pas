unit uSetNom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Wwdatsrc, StdCtrls, Buttons, ExtCtrls, Grids,
  Wwdbigrd, Wwdbgrid;

type
  TfSetNom = class(TForm)
    wwGrid1: TwwDBGrid;
    Panel1: TPanel;
    OKBitBtn: TBitBtn;
    BitBtn1: TBitBtn;
    wwsAuditCur: TwwDataSource;
    wwtAuditCur: TADOQuery;
    wwtAuditCurEntityCode: TFloatField;
    wwtAuditCurSubCat: TStringField;
    wwtAuditCurImpExRef: TStringField;
    wwtAuditCurName: TStringField;
    wwtAuditCurOpStk: TFloatField;
    wwtAuditCurPurchStk: TFloatField;
    wwtAuditCurThRedQty: TFloatField;
    wwtAuditCurThCloseStk: TFloatField;
    wwtAuditCurActCloseStk: TFloatField;
    wwtAuditCurPurchUnit: TStringField;
    wwtAuditCurPurchBaseU: TFloatField;
    wwtAuditCurACount: TStringField;
    wwtAuditCurWasteTill: TFloatField;
    wwtAuditCurWastePC: TFloatField;
    wwtAuditCurWasteTillA: TFloatField;
    wwtAuditCurWastePCA: TFloatField;
    wwtAuditCurWastage: TFloatField;
    Label1: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    lblNomPriceTariffRO: TLabel;
    lblNomPriceOldRO: TLabel;
    procedure FormShow(Sender: TObject);
    procedure wwGrid1Exit(Sender: TObject);
    procedure wwtAuditCurOpStkGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure wwGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwtAuditCurBeforePost(DataSet: TDataSet);
    procedure wwGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwtAuditCurBeforeEdit(DataSet: TDataSet);
    procedure wwtAuditCurAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    deletePrice : boolean;
  public
    { Public declarations }
  end;

var
  fSetNom: TfSetNom;

implementation

uses udata1;

{$R *.dfm}

procedure TfSetNom.FormShow(Sender: TObject);
begin
  wwtAuditCur.Open;

  with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
  begin
    DisableControls;
    Selected.Clear;

    if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
      Selected.Add('SubCat'#9'20'#9'Sub-Category'#9'F')
    else
      Selected.Add('SubCat'#9'20'#9'Category'#9'F');

    Selected.Add('Name'#9'40'#9'Name'#9#9);
    Selected.Add('PurchUnit'#9'10'#9'Unit'#9'F');
    Selected.Add('ThRedQty'#9'9'#9'Theo. Reduct.'#9'F');
    Selected.Add('PurchStk'#9'8'#9'Actual Reduct.'#9'F');
    Selected.Add('WastePC'#9'9'#9'Act. Red. Cost'#9'F');
    Selected.Add('OpStk'#9'8'#9'Closing ' + data1.SSsmall + ''#9'F');
    Selected.Add('WasteTill'#9'8'#9'Closing Cost'#9'F');
    Selected.Add('ActCloseStk'#9'12'#9'Nominal Price'#9'F');

    wwgrid1.ApplySelected;

    EnableControls;
  end;

  lblNomPriceTariffRO.Visible := data1.curNomPriceTariffRO;
  lblNomPriceOldRO.Visible := data1.curNomPriceOldRO;
end;

procedure TfSetNom.wwGrid1Exit(Sender: TObject);
begin
  if wwtAuditCur.State = dsEdit then
    wwtAuditCur.Post;
end;

procedure TfSetNom.wwtAuditCurOpStkGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if sender.asstring = '' then
  begin
    Text := '';
    exit;
  end;

  if (sender.FieldName = 'ThRedQty') then
  begin
    if Sender.Asinteger = -999999 then
    begin
      Text := ' Prep. Item ';
      exit;
    end;
  end;

  if (sender.FieldName = 'PurchStk') then
  begin
    if Sender.Asinteger = -888888 then
    begin
      Text := ' New Item ';
      exit;
    end;
  end;

  Text := data1.dozGallFloatToStr(wwtAuditCurPurchUnit.Value, sender.Asfloat);
end;

procedure TfSetNom.wwGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (Field.FieldName = 'ActCloseStk') then
  begin
    if wwtAuditCur.FieldByName('wastetilla').Asinteger = -999999 then // Tarrif Price used...
    begin
      aFont.Style := [];
      aFont.Color := clWhite;
      aBrush.Color := clGreen;
    end
    else if wwtAuditCur.FieldByName('wastetilla').Asinteger = -888888 then // old Price used...
    begin
      aFont.Style := [];
      aFont.Color := clBlue;
      aBrush.Color := clYellow;
    end
    else
    begin
      aFont.Color := clBlack;
      aBrush.Color := clWhite;
      aFont.Style := [];
    end;
  end
  else if (Field.FieldName = 'ThRedQty') then
  begin
    if Field.Asinteger = -999999 then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clYellow;
      aBrush.Color := clBlack;
    end
    else
    begin
      aFont.Style := [];
    end;
  end
  else if (Field.FieldName = 'PurchStk') then
  begin
    if Field.Asinteger = -888888 then
    begin
      aFont.Style := [fsBold];
      aFont.Color := clWhite;
      aBrush.Color := clBlue;
    end
    else
    begin
      aFont.Style := [];
    end;
  end;

end;

procedure TfSetNom.wwtAuditCurBeforePost(DataSet: TDataSet);
begin
  if wwtAuditCur.FieldByName('wastetilla').Asinteger = -999999 then // Tarrif Price used...
  begin
    wwtAuditCur.FieldByName('wastetilla').AsString := '';
  end
  else if wwtAuditCur.FieldByName('wastetilla').Asinteger = -888888 then // old Price used...
  begin
    wwtAuditCur.FieldByName('wastetilla').AsString := '';
  end;

  if deletePrice then
    wwtAuditCur.FieldByName('ActCloseStk').Asstring := '';
end;

procedure TfSetNom.wwGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_DELETE, VK_CLEAR, VK_BACK] then
    deletePrice := TRUE;
end;

procedure TfSetNom.wwtAuditCurBeforeEdit(DataSet: TDataSet);
begin
  deletePrice := FALSE;
end;

procedure TfSetNom.wwtAuditCurAfterScroll(DataSet: TDataSet);
begin
  if (data1.curNomPriceTariffRO and (wwtAuditCur.FieldByName('wastetilla').Asinteger = -999999))
    or  (data1.curNomPriceOldRO and (wwtAuditCur.FieldByName('wastetilla').Asinteger = -888888)) then
      wwtAuditCurActCloseStk.ReadOnly := TRUE
  else
    wwtAuditCurActCloseStk.ReadOnly := FALSE;
end;

end.
