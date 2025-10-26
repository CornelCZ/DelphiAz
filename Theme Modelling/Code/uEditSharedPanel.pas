unit uEditSharedPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uEditGenericDetails, StdCtrls, ComCtrls, DB, uEPOSTextHelper;

type
  TEditSharedPanel = class(TEditGenericDetails)
    Label1: TLabel;
    mmEposName: TMemo;
    cbHideOrderDisplay: TCheckBox;
    cbModPanel: TCheckBox;
    procedure cbHideOrderDisplayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbModPanelClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    EPOSTextHelper: TEposTextHelper;    
  public
    PanelID: integer;
    { Public declarations }
  end;

var
  EditSharedPanel: TEditSharedPanel;

implementation
uses
 udmTHemeData, uStdGrid, uAztecLog;

{$R *.dfm}

procedure TEditSharedPanel.cbHideOrderDisplayClick(Sender: TObject);
begin
  inherited;
  //** if we are marking this panel as a does not hide order display then we need
  //** to make sure it wont invalidate any panel Designs currently accessing the
  //** shared Panel.
  //** Need to make sure the s
  if cbHideOrderDisplay.Checked = False then
  begin
    with dmThemeData do
    begin
      Log('Panel Hides Order Display : False');
      sp_SharedPanelDimensionsOK.Parameters[1].Value := qSharedPanels.FieldByName('PanelID').AsInteger;
      sp_SharedPanelDimensionsOK.Open;
      if sp_SharedPanelDimensionsOK.RecordCount > 0 then
      begin
        cbHideOrderDisplay.Checked := True;
        with TfrmStdGrid.Create(nil) do try
          Memo1.Text := 'This shared panel overlaps the order display on the following design. "Hide order Display"  cannot be changed';
          dsGrid.DataSet := sp_SharedPanelDimensionsOK;
          ShowModal;
        finally
          Free;
        end;
      end;
      sp_SharedPanelDimensionsOK.Close;
    end;
  end
  else
    Log('Panel Hides Order Display : True');

end;

//------------------------------------------------------------------------------
procedure TEditSharedPanel.FormShow(Sender: TObject);
begin
  log('Form Show ' + Caption);
  cbHideOrderDisplay.OnClick := cbHideOrderDisplayClick;
end;

procedure TEditSharedPanel.btOkClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if trim(edName.Text) = '' then
    raise Exception.create('Please specify a name');

  if not dmThemeData.CheckPanelNameUnique(PanelID, edName.Text, False) then
    raise Exception.Create(Format('The name %s is already in use by another panel', [QuotedStr(edName.Text)]));

  modalresult := mrOk;
end;

procedure TEditSharedPanel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log('Form Close ' + Caption);
end;

procedure TEditSharedPanel.cbModPanelClick(Sender: TObject);
begin
  if cbModPanel.Checked then
    Log('Auto And Panel Checked : True')
  else
    Log('Auto And Panel Checked : False')

end;

procedure TEditSharedPanel.btCancelClick(Sender: TObject);
begin
  buttonClicked(Sender);
end;

procedure TEditSharedPanel.FormCreate(Sender: TObject);
begin
  inherited;
  EPOSTextHelper := TEPOSTextHelper.Create(edName, mmEposName);
end;

end.
