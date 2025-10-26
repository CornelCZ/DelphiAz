unit uEditGenericDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEditGenericDetails = class(TForm)
    lbName: TLabel;
    lbDescription: TLabel;
    edName: TEdit;
    mmDescription: TMemo;
    btOk: TButton;
    btCancel: TButton;
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uAztecLog;
{$R *.dfm}

procedure TEditGenericDetails.btOkClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if Trim(edName.Text) = '' then
    Raise Exception.create('Please specify a name');
  ModalResult := mrOk;
end;

procedure TEditGenericDetails.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
end;

procedure TEditGenericDetails.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  if not (mmDescription.Visible)  then
    Height := Height - 126;
end;

procedure TEditGenericDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

//------------------------------------------------------------------------------
end.
