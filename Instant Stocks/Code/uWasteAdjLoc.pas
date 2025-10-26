unit uWasteAdjLoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, wwdbedit, DB, ADODB, Wwdatsrc,
  Buttons, DBCtrls;

type
  TfWasteAdjLoc = class(TForm)
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    DBText4: TDBText;
    DBText5: TDBText;
    Label5: TLabel;
    DBText6: TDBText;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    WasteLab: TLabel;
    DBText7: TDBText;
    DBText8: TDBText;
    Shape1: TShape;
    Panel1: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwDBEdit1Change(Sender: TObject);
  private
    { Private declarations }
    changed, init : boolean;
    procedure SetMask;
    procedure SetWasteLab;
  public
    { Public declarations }
    totWaste, tillA, pcA : real;
  end;

var
  fWasteAdjLoc: TfWasteAdjLoc;

implementation

uses uAuditLocations, udata1;

{$R *.dfm}

{ TfWasteAdj }

procedure TfWasteAdjLoc.SetMask;
begin
  if (data1.isDozen(fAuditLocations.qryAuditLocUnit.Value)) then
  begin
    wwdbedit1.Picture.PictureMask := '{{{[-]#[#][#][#][#][#][' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7,' +
        '8,9}]},[-]0' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7,8,9,10,11}}}';
  end
  else if (data1.isGallon(fAuditLocations.qryAuditLocUnit.Value)) then
  begin
    wwdbedit1.Picture.PictureMask :=
     '{{{[-]#[#][#][#][#][#][' + data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7}]},[-]0' +
     data1.dozgalchar + '{0,1[{0,1}],2,3,4,5,6,7}}}';
  end
  else
  begin
    wwdbedit1.Picture.PictureMask := '{{{[-]#[#][#][#][#][#][.#[#]]},.#[#]}}';
  end;

  wwdbedit2.Picture.PictureMask := wwdbedit1.Picture.PictureMask;
end;

procedure TfWasteAdjLoc.FormShow(Sender: TObject);
begin
  init := true;
  wwdbedit1.Text := dbtext7.Caption;
  wwdbedit2.Text := dbtext8.Caption;
  init := false;

  SetMask;
  SetWasteLab;
  changed := False;
  panel1.Top := 45;
end;

procedure TfWasteAdjLoc.SetWasteLab;
begin
  // show/no show special labels....
  if fAuditLocations.qryAuditLoc.FieldByName('Purchstk').asfloat = -999999 then
  begin
    panel1.Visible := True;
    Label10.Caption := 'This is a Prepared Item' + #13 + 'Wastage cannot be adjusted for it';
    Label10.Color := clBlack;
  end
//  else if not fAuditLocations.qryAuditLoc.FieldByName('isPurchUnit').asboolean then
//  begin
//    panel1.Visible := True;
//    Label10.Caption := 'This Row has an alternative Unit' + #13 + 'Wastage can be adjusted only for Rows with Purchase Units';
//    Label10.Color := clMaroon;
//  end
  else
    panel1.Visible := False;

  if fAuditLocations.qryAuditLoc.FieldByName('opstk').asfloat = -888888 then
    label11.Visible := True
  else
    label11.Visible := False;

  wwdbedit1.Visible := not label11.Visible;

  // transform wwdbedit1,2 in floats and calculate tot waste

  tillA := data1.dozGallStrToFloat(fAuditLocations.qryAuditLocUnit.Value,wwdbedit1.text);

  pcA := data1.dozGallStrToFloat(fAuditLocations.qryAuditLocUnit.Value,wwdbedit2.text);

  totWaste := fAuditLocations.qryAuditLocWasteTill.asfloat + tillA +
    fAuditLocations.qryAuditLocWastePC.asfloat + pcA;

  // set label text
  wasteLab.Caption := data1.dozGallFloatToStr(fAuditLocations.qryAuditLocUnit.Value, totWaste);
end;

procedure TfWasteAdjLoc.BitBtn3Click(Sender: TObject);
begin
  if changed then
  begin
    if fAuditLocations.qryAuditLoc.state = dsBrowse then
      fAuditLocations.qryAuditLoc.Edit;

    fAuditLocations.qryAuditLoc.FieldByName('Wastage').asfloat := totWaste;
    fAuditLocations.qryAuditLoc.FieldByName('WasteTillA').asfloat := tillA;
    fAuditLocations.qryAuditLoc.FieldByName('WastePCA').asfloat := pcA;

    fAuditLocations.qryAuditLoc.post;
  end;


  if fAuditLocations.qryAuditLoc.RecNo > 1 then
    fAuditLocations.qryAuditLoc.RecNo := fAuditLocations.qryAuditLoc.RecNo - 1;

  init := true;
  wwdbedit1.Text := dbtext7.Caption;
  wwdbedit2.Text := dbtext8.Caption;
  init := false;

  SetMask;
  SetWasteLab;
  changed := False;
end;

procedure TfWasteAdjLoc.BitBtn4Click(Sender: TObject);
begin
  if changed then
  begin
    if fAuditLocations.qryAuditLoc.state = dsBrowse then
      fAuditLocations.qryAuditLoc.Edit;

    fAuditLocations.qryAuditLoc.FieldByName('Wastage').asfloat := totWaste;
    fAuditLocations.qryAuditLoc.FieldByName('WasteTillA').asfloat := tillA;
    fAuditLocations.qryAuditLoc.FieldByName('WastePCA').asfloat := pcA;

    fAuditLocations.qryAuditLoc.post;
  end;

  fAuditLocations.qryAuditLoc.RecNo := fAuditLocations.qryAuditLoc.RecNo + 1;

  init := true;
  wwdbedit1.Text := dbtext7.Caption;
  wwdbedit2.Text := dbtext8.Caption;
  init := false;

  SetMask;
  SetWasteLab;
  changed := False;
end;

procedure TfWasteAdjLoc.BitBtn1Click(Sender: TObject);
begin
  if not changed then
    exit;

  if fAuditLocations.qryAuditLoc.state = dsBrowse then
    fAuditLocations.qryAuditLoc.Edit;

  fAuditLocations.qryAuditLoc.FieldByName('Wastage').asfloat := totWaste;
  fAuditLocations.qryAuditLoc.FieldByName('WasteTillA').asfloat := tillA;
  fAuditLocations.qryAuditLoc.FieldByName('WastePCA').asfloat := pcA;

  fAuditLocations.qryAuditLoc.post;
end;

procedure TfWasteAdjLoc.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_PRIOR: BitBtn3Click(Sender);
    VK_NEXT: BitBtn4Click(Sender);
  else exit;
  end; // case..

  key := 0;

end;

procedure TfWasteAdjLoc.wwDBEdit1Change(Sender: TObject);
begin
  if init then exit;

  SetWasteLab;
  changed := True;
end;

end.
