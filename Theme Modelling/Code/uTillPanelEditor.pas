unit uTillPanelEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, uEPOSTextHelper;

type
  TTillPanelEditor = class(TForm)
    btOk: TButton;
    btCancel: TButton;
    cbHideOrderDisplay: TCheckBox;
    lbName: TLabel;
    lbDescription: TLabel;
    edName: TEdit;
    mmDescription: TMemo;
    Label1: TLabel;
    mmEposName: TMemo;
    Label2: TLabel;
    seWidth: TSpinEdit;
    Label3: TLabel;
    seHeight: TSpinEdit;
    Label6: TLabel;
    seTop: TSpinEdit;
    seLeft: TSpinEdit;
    Label5: TLabel;
    cbModPanel: TCheckBox;
    procedure cbHideOrderDisplayClick(Sender: TObject);
    procedure cbModPanelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    EPOSTextHelper: TEposTextHelper;    
  public
    { Public declarations }
    PanelID: integer;
    PanelDesignID: integer;
  end;

var
  TillPanelEditor: TTillPanelEditor;

implementation

uses
  uAztecLog, uDMThemeData;

{$R *.dfm}

procedure TTillPanelEditor.cbHideOrderDisplayClick(Sender: TObject);
begin
  if cbHideOrderDisplay.Checked then
    Log('Panel Hides Order Display Checked')
  else
    Log('Panel Hides Order Display Unchecked');
end;

procedure TTillPanelEditor.cbModPanelClick(Sender: TObject);
begin
  if cbModPanel.Checked then
    Log('Auto AND Panel Checked')
  else
    Log('Auto AND Panel UnChecked')

end;

procedure TTillPanelEditor.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
end;

procedure TTillPanelEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

//------------------------------------------------------------------------------
procedure TTillPanelEditor.btOkClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if not dmThemeData.CheckPanelNameUnique(PanelID, edName.Text, False, PanelDesignID) then
    raise Exception.Create(Format('The name %s is already in use by another panel', [QuotedStr(edName.Text)]));
  ModalResult := mrOk;
end;

procedure TTillPanelEditor.btCancelClick(Sender: TObject);
begin
   ButtonClicked(Sender);
end;

procedure TTillPanelEditor.FormCreate(Sender: TObject);
begin
  EPOSTextHelper := TEPOSTextHelper.Create(edName, mmEposName);
end;

end.

