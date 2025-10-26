unit uConfigureQRCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, ExtCtrls, wwdbedit, Wwdotdot, Wwdbcomb;

const
  URLMaximumLengthMsg = 'Maximum length of 1000 characters reached. If the placeholder' +
                      ' values cause the url length to exceed 1000 they will be truncated';

type
  TConfigureFooterQRCode = class(TForm)
    pnlMain: TPanel;
    pnlQRCodeUrl: TPanel;
    grpBoxQRCodeUrl: TGroupBox;
    lblUrl: TLabel;
    lblDynamicFields: TLabel;
    DBEditQRCodeUrlForReceiprFooter: TDBEdit;
    btnInsert: TButton;
    btnEditQRCodeFooterText: TButton;
    btnClose: TButton;
    grpBocPrintQRCode: TGroupBox;
    dbChkBoxBillFooter: TDBCheckBox;
    dbCheckBoxReceiptFooter: TDBCheckBox;
    cbDynamicFields: TComboBox;
    grpSizeQR: TGroupBox;
    cmboxQRCodeSize: TwwDBComboBox;
    grpQRRefund: TGroupBox;
    dbCheckBoxAppendRefundData: TDBCheckBox;
    procedure btnEditQRCodeFooterTextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure DBEditQRCodeUrlForReceiprFooterChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbDynamicFieldsChange(Sender: TObject);
  private
    UrlMaximumSize: Integer;
    function IsValidQRCodeUrl(url: string): Boolean;
    function IsUrlMaximumLengthRiched: Boolean;
    procedure PopulateDynamicFields;
    procedure UpdateDynamicFieldUiStateForSiteVersion;
    procedure SetHintsForDynamicFields;
  public
    FSiteCode : Integer;
    class function ShowConfigureFooterQRCode(SiteCode: Integer): boolean;
  end;


implementation

uses uAztecLog, uADO, uEditQRCodeOnReceiptText, uGlobals, DB,
  uThemeModellingMenu, uDMThemeData;

{$R *.dfm}

class function TConfigureFooterQRCode.ShowConfigureFooterQRCode(SiteCode: Integer): boolean;
var
  ConfigureFooterQRCode: TConfigureFooterQRCode;
begin
  Log('Editing QR Code footer text button clicked');
  ConfigureFooterQRCode := TConfigureFooterQRCode.Create(Nil);
  with ConfigureFooterQRCode do
  begin
    FSiteCode := SiteCode;
    Result := ShowModal = mrOk;
    Free;
  end;
end;

procedure TConfigureFooterQRCode.btnEditQRCodeFooterTextClick(Sender: TObject);
begin
  Log('Edit QR Code footer text button clicked');

  try
    dmADO.qCreateQrCodeOnReceiptTempTables.ExecSQL;
    dmADO.qLoadQrCodeReceiptText.Parameters.ParamByName('SiteCode').Value := FSiteCode;
    dmADO.qLoadQrCodeReceiptText.ExecSQL;
    dmAdo.TmpQrCodeOnReceiptFooterText.Open;

    if TEditQrCodeOnReceiptText.ShowQrCodeOnReceiptTextFrm(FSiteCode) then
    begin
     dmADO.qSaveQrCodeOnReceiptText.Parameters.ParamByName('SiteCode').Value := FSiteCode;
     dmADO.qSaveQrCodeOnReceiptText.ExecSQL;
    end;

  finally
    dmADO.qSaveQrCodeOnReceiptText.Close;
    dmADO.qCreateQrCodeOnReceiptTempTables.Close;
    dmAdo.TmpQrCodeOnReceiptFooterText.Close;
  end;
end;

procedure TConfigureFooterQRCode.FormCreate(Sender: TObject);
begin
  UrlMaximumSize := dmADO.qOutletPrintConfigs.FieldByName('QrCodeUrlForReceipt').Size;
  lblUrl.Hint := URLMaximumLengthMsg;
  lblUrl.ShowHint := IsUrlMaximumLengthRiched;
  dbChkBoxBillFooter.Caption :=  GetLocalisedName(IsQRCodePrintOn);
  Caption :=  GetLocalisedName(IsQRCodeFormCaption);
  PopulateDynamicFields;
  cbDynamicFieldsChange(Sender);
  UpdateDynamicFieldUiStateForSiteVersion;
  SetHintsForDynamicFields;
end;

procedure TConfigureFooterQRCode.UpdateDynamicFieldUiStateForSiteVersion;
begin
  if dmThemeData.SiteVersionAtLeast('3.27.0.0') then
  begin
    btnInsert.Enabled := true;
    cbDynamicFields.Enabled := true;
  end
  else
  begin
    btnInsert.Enabled := false;
    cbDynamicFields.Enabled := false;
  end;
end;

procedure TConfigureFooterQRCode.SetHintsForDynamicFields;
begin
  if not dmThemeData.SiteVersionAtLeast('3.27.0.0') then
    grpBoxQRCodeUrl.Hint := 'Dynamic Fields are not available for this site version (minimum site version is 3.27.0)'
  else
  begin
    grpBoxQRCodeUrl.Hint := '';
  end;
end;

function TConfigureFooterQRCode.IsValidQRCodeUrl(url: string): Boolean;
begin
  // Only check that a url has been entered if one or both print QR Code checkboxes has been checked.
  // Users responsibilty the ensure the url is valid.
  Result := true;
  if (length( Trim(DBEditQRCodeUrlForReceiprFooter.Text)) = 0) and
     (not dbCheckBoxAppendRefundData.Checked) and
     (dbCheckBoxReceiptFooter.Checked or dbChkBoxBillFooter.Checked) then
  begin
    result := false;
  end;
end;

procedure TConfigureFooterQRCode.btnInsertClick(Sender: TObject);
var
  SearchedAztecPlaceHolderText: string;
begin
  Log('Edit QR Code footer text Insert button clicked');

  SearchedAztecPlaceHolderText := dmADO.qTerminalDynamicFields.Lookup('DisplayName', cbDynamicFields.Text, 'AztecPlaceHolderText');
  DBEditQRCodeUrlForReceiprFooter.DataSource.DataSet.Edit;

  if Copy(DBEditQRCodeUrlForReceiprFooter.Text, Length(DBEditQRCodeUrlForReceiprFooter.Text), 1) = '/' then
    DBEditQRCodeUrlForReceiprFooter.Field.Value := DBEditQRCodeUrlForReceiprFooter.Text + SearchedAztecPlaceHolderText
  else
    DBEditQRCodeUrlForReceiprFooter.Field.Value := DBEditQRCodeUrlForReceiprFooter.Text + '/' + SearchedAztecPlaceHolderText  + '/';

  DBEditQRCodeUrlForReceiprFooter.Hint := DBEditQRCodeUrlForReceiprFooter.Text;
end;

procedure TConfigureFooterQRCode.PopulateDynamicFields;
begin
  dmADO.qTerminalDynamicFields.Open;
  dmADO.qTerminalDynamicFields.First;

  while not dmADO.qTerminalDynamicFields.EOF do
  begin
    cbDynamicFields.Items.Add(dmADO.qTerminalDynamicFields.FieldByName('DisplayName').AsString);
    dmADO.qTerminalDynamicFields.Next;
  end;

  dmADO.qTerminalDynamicFields.First();
  cbDynamicFields.ItemIndex := 0;
end;

function TConfigureFooterQRCode.IsUrlMaximumLengthRiched: Boolean;
begin
  Result := Length(DBEditQRCodeUrlForReceiprFooter.Text) >= UrlMaximumSize;
end;

procedure TConfigureFooterQRCode.DBEditQRCodeUrlForReceiprFooterChange(
  Sender: TObject);
begin
  lblUrl.ShowHint := IsUrlMaximumLengthRiched;
  DBEditQRCodeUrlForReceiprFooter.Hint := DBEditQRCodeUrlForReceiprFooter.Text;
end;

procedure TConfigureFooterQRCode.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ThemeModellingMenu.ApplicationClosing then exit;

  if not IsValidQRCodeUrl(DBEditQRCodeUrlForReceiprFooter.Text) then
  begin
    CanClose := false;
    ShowMessage('Please enter a valid QR Code URL.');
    DBEditQRCodeUrlForReceiprFooter.SetFocus;
  end;

  dmADO.qTerminalDynamicFields.Cancel();
  dmADO.qTerminalDynamicFields.First();
end;

procedure TConfigureFooterQRCode.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (DBEditQRCodeUrlForReceiprFooter.DataSource.DataSet.State in [dsEdit, dsInsert]) then
    DBEditQRCodeUrlForReceiprFooter.DataSource.DataSet.Post();
end;

procedure TConfigureFooterQRCode.cbDynamicFieldsChange(Sender: TObject);
begin
  SetHintsForDynamicFields;
end;

end.
