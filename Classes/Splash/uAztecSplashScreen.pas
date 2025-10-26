unit uAztecSplashScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

{$R AztecSplashScreens.RES}

type
  TSplashScreenType = (sstEPOSManager, sstServiceWatchdog, sstEstateManagement, sstVSSBuildTool,
                       sstReleaseNotes, sstShelfEdgeLabels, sstXMLProductImport,
                       sstReleaseManager);

  TfrmAztecSplashForm = class(TForm)
    tmrDisplayTimer: TTimer;
    imgMainImage: TImage;
    AlphaBlendTimer: TTimer;
    procedure tmrDisplayTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AlphaBlendTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetSplashFormImage(ASplashScreenType: TSplashScreenType);
  end;

function DisplayAztecSplashScreen(SplashScreenType: TSplashScreenType; AShowModal: boolean = FALSE): boolean;

implementation

uses uSplashConstants;

var
  frmAztecSplashForm: TfrmAztecSplashForm;

{$R *.dfm}

function DisplayAztecSplashScreen(SplashScreenType: TSplashScreenType; AShowModal: boolean): boolean;
begin
  Result := TRUE;

  try
    frmAztecSplashForm := TfrmAztecSplashForm.Create(nil);
    frmAztecSplashForm.Caption := Application.Title;

    frmAztecSplashForm.SetSplashFormImage(SplashScreenType);

    if AShowModal then
      frmAztecSplashForm.ShowModal
    else
      frmAztecSplashForm.Show;
  except
    Result := FALSE;
  end;
end;

procedure TfrmAztecSplashForm.SetSplashFormImage(ASplashScreenType: TSplashScreenType);
begin
  case ASplashScreenType of
    sstEPOSManager :
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, EPOS_MANAGER_SPLASH_SCREEN);
    sstServiceWatchdog :
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, SERVICE_WATCHDOG_SPLASH_SCREEN);
    sstEstateManagement :
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, ESTATE_MANAGEMENT_SPLASH_SCREEN);
    sstVSSBuildTool:
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, VSS_BUILD_TOOL_SPLASH_SCREEN);
    sstReleaseNotes:
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, AZTEC_RELEASENOTES_SPLASH_SCREEN);
    sstShelfEdgeLabels:
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, SHELF_EDGE_LABELS_SPLASH_SCREEN);
    sstXMLProductImport:
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, XML_PRODUCT_IMPORT_SPLASH_SCREEN);
    sstReleaseManager:
      imgMainImage.Picture.Bitmap.LoadFromResourceName(hInstance, RELEASE_MANAGER_SPLASH_SCREEN);
  end;
end;

procedure TfrmAztecSplashForm.tmrDisplayTimerTimer(Sender: TObject);
begin
  tmrDisplayTimer.Enabled  := FALSE;
  AlphaBlendTimer.Tag := -5;
  AlphaBlendTimer.Enabled := TRUE;
end;

procedure TfrmAztecSplashForm.FormShow(Sender: TObject);
begin
  AlphaBlendTimer.Enabled := TRUE;
  tmrDisplayTimer.Enabled := TRUE;
  SetForegroundWindow(Handle);
end;

procedure TfrmAztecSplashForm.AlphaBlendTimerTimer(Sender: TObject);
begin
  AlphaBlendTimer.Enabled := FALSE;
  AlphaBlendValue := AlphaBlendValue + AlphaBlendTimer.Tag;

  if AlphaBlendTimer.Tag < 0 then
  begin
    AlphaBlendTimer.Enabled := AlphaBlendValue > 0;

    if AlphaBlendValue = 0 then
    begin
      ModalResult := mrOK;
      Close;
    end;
  end
  else
     AlphaBlendTimer.Enabled := AlphaBlendValue < 255;
end;

procedure TfrmAztecSplashForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
