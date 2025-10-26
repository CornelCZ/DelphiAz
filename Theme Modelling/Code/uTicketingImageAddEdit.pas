unit uTicketingImageAddEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtDlgs, Types;

type
  TTicketingImageAddEdit = class(TForm)
    edName: TEdit;
    Name: TLabel;
    lbDescription: TLabel;
    edFileName: TEdit;
    btOpenImage: TButton;
    pnImage: TPanel;
    CloakroomImage: TImage;
    btOk: TButton;
    btCancel: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    btConvertBW: TButton;
    btRotate: TButton;
    Label1: TLabel;
    Label2: TLabel;
    btInvert: TButton;
    procedure btOkClick(Sender: TObject);
    procedure btOpenImageClick(Sender: TObject);
    procedure btRotateClick(Sender: TObject);
    procedure btConvertBWClick(Sender: TObject);
    procedure btInvertClick(Sender: TObject);
  private
    { Private declarations }
    ExistingID: integer;
    ThemeId: integer;
    SavedWidth, SavedHeight: integer;
    function NameIsValid: boolean;
    procedure UpdateImageDims;
  public
    { Public declarations }
    function Add(ThemeId: integer): boolean;
    function Edit(ThemeId, ExistingId: integer): boolean;
  end;

implementation

uses useful, uDMThemeData;

{$R *.dfm}

{ TTicketingImageAddEdit }

function TTicketingImageAddEdit.Add(ThemeId: integer): boolean;
begin
  Caption := 'Add Ticket Image';
  Self.ThemeId := ThemeId;
  ExistingID := -1;
  UpdateImageDims;
  result := (ShowModal = mrOk);
end;

function TTicketingImageAddEdit.Edit(ThemeId, ExistingId: integer): boolean;
begin
  Caption := 'Edit Ticket Image';
  self.ThemeId := ThemeId;
  self.ExistingID := ExistingId;
  UpdateImageDims;
  result := (ShowModal = mrOk);
end;

procedure TTicketingImageAddEdit.btOkClick(Sender: TObject);
begin
  if not NameIsValid then
    MessageDlg('Please specify an unique name for this image.', mtError, [mbOk], 0)
  else
  if not CloakroomImage.Picture.Bitmap.HandleAllocated then
    MessageDlg('Please select an image first.', mtError, [mbOk], 0)
  else
  if CloakroomImage.Picture.Bitmap.PixelFormat <> pf1bit then
    MessageDlg('The selected image is not a 1 bit (black/white) image which is required for printer use.'+#13+
      'Use "To Mono" first.', mtError, [mbOk], 0)
  else
  begin
    if (CloakroomImage.Picture.Bitmap.Width > 576) or (CloakroomImage.Picture.Bitmap.Height > 576) then
      MessageDlg('The selected image is larger than currently supported for printing (max. 576 x 576 pixels).'+#13+
        'The image will take longer to download and will be cropped when printed.', mtWarning, [mbOk], 0)
    else if (CloakroomImage.Picture.Bitmap.Height > 504)  then
      MessageDlg('The selected image is wider across paper width than printer margins may support (504 pixels).'+#13+
        'To print it without cropping, BTPR580 margins would need set to 3mm left/5mm right and CBM printers would need set to 48 column mode.', mtWarning, [mbOk], 0);
    ModalResult := mrOk;
  end;
end;

procedure TTicketingImageAddEdit.btOpenImageClick(Sender: TObject);
begin
  OpenPictureDialog1.FileName := edFileName.Text;
  if OpenPictureDialog1.Execute then
  begin
    edFileName.Text := OpenPictureDialog1.FileName;
    CloakroomImage.Picture.LoadFromFile(edFileName.text);
    UpdateImageDims;
    if trim(edName.text) = '' then
      edName.Text := ExtractFileBaseName(ExtractFileName(edFileName.text));
  end;
end;

function TTicketingImageAddEdit.NameIsValid: boolean;
begin
  if Trim(edName.Text) = '' then
    result := false
  else
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format(
      'select * from ThemeCloakroomImage where ThemeID = %d and CloakroomImageId <> %d and Name = %s',
      [ThemeId, ExistingId, QuotedStr(edName.Text)]
    );
    Open;
    result := (RecordCount = 0);
    Close;
  end;
end;

procedure TTicketingImageAddEdit.btRotateClick(Sender: TObject);
var
  sourceBitmap, destBitmap: TBitmap;
  i,j: integer;
begin
  sourceBitmap := TBitmap.create;
  destBitmap := TBitmap.create;
  sourceBitmap.Assign(CloakroomImage.Picture.Bitmap);
  destBitmap.Assign(sourceBitmap);
  destBitmap.Width := sourceBitmap.Height;
  destBitmap.Height := sourceBitmap.Width;
  for i := 0 to pred(sourceBitmap.Width) do
    for j := 0 to pred(sourceBitmap.Height) do
      destBitmap.Canvas.Pixels[pred(sourceBitmap.Height)-j,i] := sourceBitmap.Canvas.Pixels[i,j];
  CloakroomImage.Picture.Bitmap.Assign(destBitmap);
  destBitmap.free;
  sourceBitmap.free;
end;

procedure TTicketingImageAddEdit.btConvertBWClick(Sender: TObject);
var
  sourceBitmap, destBitmap: TBitmap;
  i,j: integer;
  pix: TColor;
  thresholdlevel: integer;
  threshtmp: int64;
begin
  sourceBitmap := TBitmap.Create;
  destBitmap := TBitmap.Create;
  sourceBitmap.Assign(CloakroomImage.Picture.Bitmap);
  destBitmap.Width := sourceBitmap.Width;
  destBitmap.Height := sourceBitmap.Height;
  destBitmap.PixelFormat := pf1bit;

  threshtmp := 0;
  for i := 0 to pred(sourceBitmap.Height) do
    for j := 0 to pred(sourceBitmap.Width) do
    begin
      pix := sourceBitmap.Canvas.Pixels[j,i];
      threshtmp := threshtmp + (pix and $ff) + (pix and $ff00) shr 8 + (pix and $ff0000 shr 16);
    end;
  thresholdlevel := threshtmp div (sourceBitmap.Width * sourceBitmap.Height);

  for i := 0 to pred(sourceBitmap.Height) do
    for j := 0 to pred(sourceBitmap.Width) do
    begin
      pix := sourceBitmap.Canvas.Pixels[j,i];
      if (pix and $ff) + (pix and $ff00) shr 8 + (pix and $ff0000 shr 16) <= (thresholdlevel)  then
        destBitmap.Canvas.Pixels[j,i] := clBlack
      else
        destBitmap.Canvas.Pixels[j,i] := clWhite;

    end;
  CloakroomImage.Picture.Bitmap.Assign(destBitmap);
  sourceBitmap.Free;
  destBitmap.Free;
  //CloakroomImage.Picture.Bitmap.Monochrome := true;
  //CloakroomImage.Picture.Bitmap.PixelFormat := pf1bit;
  // Todo set palette to black and white
  // Todo manually threshold the image
end;

procedure TTicketingImageAddEdit.UpdateImageDims;
begin
  if (CloakroomImage.Picture.Bitmap.Width <> SavedWidth)
    or (CloakroomImage.Picture.Bitmap.Height <> SavedHeight) then
  begin
    SavedWidth := CloakroomImage.Picture.Bitmap.Width;
    SavedHeight := CloakroomImage.Picture.Bitmap.Height;
    label2.Caption := Format('Image size: %d x %d', [SavedWidth, SavedHeight]);
  end;
end;

procedure TTicketingImageAddEdit.btInvertClick(Sender: TObject);
var
  sourceBitmap: TBitmap;
  i,j: integer;
  tmpColour: TColor;
begin
  sourceBitmap := TBitmap.create;
  sourceBitmap.Assign(CloakroomImage.Picture.Bitmap);
  for i := 0 to pred(sourceBitmap.Width) do
    for j := 0 to pred(sourceBitmap.Height) do
    begin
      tmpColour := sourceBitmap.Canvas.Pixels[i,j];
      sourceBitmap.Canvas.Pixels[i,j] :=
        (($ff0000-(tmpColour and $ff0000)) and $ff0000) or
        (($ff00-(tmpColour and $ff00)) and $ff00) or
        (($ff-(tmpColour and $ff)) and $ff);
    end;
  CloakroomImage.Picture.Bitmap.Assign(sourceBitmap);
  sourceBitmap.free;
end;

end.
