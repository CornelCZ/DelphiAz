unit uAztecSplash;

(*
 * Unit provides the application splash screen on startup;
 *
 * Examines the windows version and other information as set
 * in Project | Options | Version Info
 *
 * NB this has not been localised; the project windows locale *must*
 * be English (United States) for the splash screen to be
 * correctly populated with version/build info.
 *
 * Author: Stuart Boutell, Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TSplashForm = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    ProductName: TLabel;
    LegalCopyright: TLabel;
    Bevel1: TBevel;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    canDismiss:boolean;
  public
    procedure Dismiss;
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.dfm}

procedure TSplashForm.Dismiss;
begin
  while NOT canDismiss do
    Application.HandleMessage;
  Hide;
end;

procedure TSplashForm.Timer1Timer(Sender: TObject);
begin
  canDismiss := true;
  Timer1.Enabled := false;
end;


procedure TSplashForm.FormCreate(Sender: TObject);
var
  S: string;
  n, Len: DWORD;
  Buf: PChar;
  Value: PChar;
  xcentre:Integer;
begin
  inherited;

  Image1.Picture.Bitmap.LoadFromResourceName(HInstance, 'AZTEC_LOGO');

  // Where is the centre of the form?
  xcentre := Left + (Width div 2);

  // Fill in labels on form based on version information embedded in the executable.
  ProductName.Caption := 'Aztec';
  LegalCopyright.Caption := 'Copyright (c) 2003-'+FormatDateTime('yyyy', date)+' Zonal Retail Data Systems';

  S := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);
  if n > 0 then
  begin
    Buf := AllocMem(n);
    GetFileVersionInfo(PChar(S), 0, n, Buf);
    if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\ModuleName'), Pointer(Value), Len) then
    begin
      ProductName.Caption := Trim(StringReplace(Value, 'Aztec', '', [rfIgnoreCase, rfReplaceAll]));
      //Cater for modules with a '&' in their name.  Just 'Time & Attendance' for now.
      ProductName.Caption := StringReplace(ProductName.Caption, '&', '&&', [rfIgnoreCase, rfReplaceAll])
    end;
    if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\ZonalCopyright'), Pointer(Value), Len) then
      LegalCopyright.Caption := Value;
    FreeMem(Buf, n);
  end;

  // Force Form to do autosize calculation
  AutoSize := false;
  AutoSize := true;

  // Adjust the form position so that the centre of the form has not moved.  This
  // keeps the splash screen in the centre of the screen, even if it has resized.
  Left := xcentre - (Width div 2);
  canDismiss := false;
end;

procedure TSplashForm.FormActivate(Sender: TObject);
begin
  Timer1.Enabled := true;
  Repaint;
end;

end.
