unit uSplash;

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
 * Author: Stuart Boutell, Ice Cube/Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, INIFiles, StdCtrls, ExtCtrls;

type
  TSplashForm = class(TForm)
    ProductName: TStaticText;
    LegalCopyright: TStaticText;
    StaticText3: TStaticText;
    FileVersion: TStaticText;
    PrivateBuild: TStaticText;
    Timer1: TTimer;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashForm: TSplashForm;

implementation

uses uLog;

{$R *.dfm}

procedure TSplashForm.FormActivate(Sender: TObject);
var
  S: string;
  n, Len: DWORD;
  Buf: PChar;
  Value: PChar;
begin
  S := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);
  if n > 0 then
  begin
    Buf := AllocMem(n);
    GetFileVersionInfo(PChar(S), 0, n, Buf);
    if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\ProductName'), Pointer(Value), Len) then
      ProductName.Caption := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\FileVersion'), Pointer(Value), Len) then
      FileVersion.Caption := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\PrivateBuild'), Pointer(Value), Len) then
      PrivateBuild.Caption := Value;
    if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\LegalCopyright'), Pointer(Value), Len) then
      LegalCopyright.Caption := Value;
    FreeMem(Buf, n);
  end;
  Repaint;
end;

end.
