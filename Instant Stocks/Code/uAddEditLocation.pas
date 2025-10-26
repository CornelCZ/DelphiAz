unit uAddEditLocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfAddEditLocation = class(TForm)
    lblName: TLabel;
    lblNameInfo: TLabel;
    editLocName: TEdit;
    lblNote: TLabel;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    lblNoteInfo: TLabel;
    memoPrintNote: TMemo;
    cbHasFixedStock: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    locationNames : TStrings;
    templateName : String;
  end;

var
  fAddEditLocation: TfAddEditLocation;

implementation

uses udata1;

{$R *.dfm}

procedure TfAddEditLocation.FormCreate(Sender: TObject);
begin
  locationNames := TStringList.Create;
  cbHasFixedStock.Caption := 'Has Fixed ' + data1.SSbig;
end;

procedure TfAddEditLocation.FormDestroy(Sender: TObject);
begin
  locationNames.Free;
end;

procedure TfAddEditLocation.BitBtnSaveClick(Sender: TObject);
begin
  if lblName.Caption = 'Template Name' then
  begin
    templateName := trimRight(editLocName.Text);  // remove trailing spaces.

    if (length(trim(templateName)) < 1) or (length(templateName) > editLocName.MaxLength) then
    begin
      showMessage(lblName.Caption + 's need a Minimum of 1 non-space and a Maximum of ' +
          inttostr(editLocName.MaxLength) + ' characters.');
      modalResult := mrNone;                                 // spaces only string not allowed but
      exit;                                                  // if spaces are counted towards maximum
    end;

    if locationNames.IndexOf(templateName) > -1 then
    begin
      showMessage(lblName.Caption + 's have to be unique.' + #13 + #13 +
        lblName.Caption + ' "' + templateName + '" is already in use.');
      modalResult := mrNone;
    end;
  end
  else
  begin
    if (length(editLocName.Text) < 1) or (length(editLocName.Text) > editLocName.MaxLength) then
    begin
      showMessage(lblName.Caption + 's need a Minimum of 1 and a Maximum of ' +
          inttostr(editLocName.MaxLength) + ' characters.');
      modalResult := mrNone;
      exit;
    end;

    if locationNames.IndexOf(editLocName.Text) > -1 then
    begin
      showMessage(lblName.Caption + 's have to be unique.' + #13 + #13 +
        lblName.Caption + ' "' + editLocName.Text + '" is already in use.');
      modalResult := mrNone;
    end;
  end;

end;

end.
