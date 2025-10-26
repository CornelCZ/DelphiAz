unit uEditVariationPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uEditGenericDetails, StdCtrls, ComCtrls, DB;

type
  TEditVariationPanel = class(TEditGenericDetails)
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    PanelID: integer;
    VariationGroup: integer;
    { Public declarations }
  end;

implementation
uses
 udmThemeData, uStdGrid, uAztecLog;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TEditVariationPanel.FormShow(Sender: TObject);
begin
  log('Form Show ' + Caption);
end;

procedure TEditVariationPanel.btOkClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if Trim(edName.Text) = '' then
    raise Exception.create('Please specify a name');

  if not dmThemeData.CheckPanelNameUnique(PanelID, edName.Text, True, VariationGroup) then
    raise Exception.Create(Format('The name %s is already in use by another variation in this group, or the Variation Group itself', [QuotedStr(edName.Text)]));

  modalresult := mrOk;
end;

procedure TEditVariationPanel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log('Form Close ' + Caption);
end;

procedure TEditVariationPanel.btCancelClick(Sender: TObject);
begin
  inherited;
  buttonClicked(Sender);
end;

end.
