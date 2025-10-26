unit uEditThemeTablePlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uEditGenericDetails, StdCtrls, uEPOSTextHelper, uGlobals;

type
  TEditThemeTablePlan = class(TEditGenericDetails)
    mmEposName: TMemo;
    Label1: TLabel;
    cbSplitTableMode: TCheckBox;
    procedure btOKClick(Sender: TObject);
    procedure cbSplitTableModeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    EPOSTextHelper: TEposTextHelper;
  public
    { Public declarations }
    TablePlanID, ThemeID: integer;
  end;

var
  EditThemeTablePlan: TEditThemeTablePlan;

implementation

uses
  uAztecLog, uDMThemeData;

{$R *.dfm}

procedure TEditThemeTablePlan.btOKClick(Sender: TObject);
begin
  buttonClicked(sender);
  // inherited method from TEditGenericDetails removed
  if trim(edName.Text) = '' then
    raise Exception.create('Please specify a name');
  with dmThemeData do
  begin
    adoQRun.SQL.Text := Format(
      'if exists(select * from ThemeTablePlan where Name = %s and TablePlanID <> %d and ThemeID = %d) select 1 else select 0',
      [QuotedStr(edName.Text), TablePlanID, ThemeID]
    );
    adoQRun.Open;
    if adoQRun.Fields[0].AsInteger = 1 then
    begin
      adoQRun.Close;
      raise Exception.Create(Format('The name %s is already in use by another Table Plan', [QuotedStr(edName.Text)]));
    end;
    adoQRun.Close;
  end;
  modalresult := mrOk;
end;

procedure TEditThemeTablePlan.cbSplitTableModeClick(Sender: TObject);
begin
  inherited;
  if cbSplitTableMode.Checked then
    log('Allow new split table mode checked')
  else
    log('Allow new split table mode unchecked')

end;

procedure TEditThemeTablePlan.btCancelClick(Sender: TObject);
begin
  inherited;
  buttonCLicked(sender);

end;

procedure TEditThemeTablePlan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Log('Form Close ' + Caption);
end;

procedure TEditThemeTablePlan.FormShow(Sender: TObject);
begin
  inherited;
  Log('Form Show ' + Caption);
end;

procedure TEditThemeTablePlan.FormCreate(Sender: TObject);
var epostext : String;
begin
  inherited;

  EPOSTextHelper := TEPOSTextHelper.Create(edName, mmEposName);

  if UKUSmode = 'US' then
     epostext := 'POS'
  else
     epostext := 'EPoS';

  Label1.Caption := epostext +' text:';
end;

end.
