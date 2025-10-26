unit uTillLabelEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask;

type
  TTillLabelEditor = class(TForm)
    edLabel: TEdit;
    btOk: TButton;
    btCancel: TButton;
    Label1: TLabel;
    FGColourDlg: TColorDialog;
    BGColourDlg: TColorDialog;
    edFGColour: TStaticText;
    edBGColour: TStaticText;
    Label2: TLabel;
    Label3: TLabel;
    cbLargeFont: TCheckBox;
    procedure edFGColourClick(Sender: TObject);
    procedure edBGColourClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TillLabelEditor: TTillLabelEditor;

implementation

uses uSimpleLocalise;

{$R *.dfm}

procedure TTillLabelEditor.edFGColourClick(Sender: TObject);
begin
  FGColourDlg.Color := TEdit(sender).Color;
  if FGColourDlg.Execute then
    TEdit(sender).color := FGColourDlg.Color;
end;

procedure TTillLabelEditor.edBGColourClick(Sender: TObject);
begin
  FGColourDlg.Color := TEdit(sender).Color;
  if BGColourDlg.Execute then
    TEdit(sender).color := BGColourDlg.Color;
end;

procedure TTillLabelEditor.FormCreate(Sender: TObject);
begin
  LocaliseForm(self);
end;

end.
