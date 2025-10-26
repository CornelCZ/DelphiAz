unit uPCWasteHZChoose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, DB,
  ADODB;

type
  TfPCWasteHZChoose = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    wwDBGridHZs: TwwDBGrid;
    BitBtnCancel: TBitBtn;
    BitBtnNext: TBitBtn;
    dsHZs: TDataSource;
    adoqHZs: TADOQuery;
    adoqHZsSiteCode: TIntegerField;
    adoqHZshzID: TIntegerField;
    adoqHZshzName: TStringField;
    adoqHZsePur: TBooleanField;
    adoqHZseOut: TBooleanField;
    adoqHZseMoveIn: TBooleanField;
    adoqHZseMoveOut: TBooleanField;
    adoqHZseSales: TBooleanField;
    adoqHZseWaste: TBooleanField;
    adoqHZsActive: TBooleanField;
    adoqHZsLMDT: TDateTimeField;
    LabelHZChoose: TLabel;
    procedure adoqHZsBooleanGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure FormShow(Sender: TObject);
    procedure BitBtnNextClick(Sender: TObject);
    procedure wwDBGridHZsDblClick(Sender: TObject);
  private
    FHzID: Integer;
    FHzName: String;
    procedure SelectHZ;
    { Private declarations }
  public
    { Public declarations }
    property HzID: Integer read FHzID;
    property HzName: String read FHzName;
  end;

var
  fPCWasteHZChoose: TfPCWasteHZChoose;

implementation

uses
  uADO;

{$R *.dfm}

procedure TfPCWasteHZChoose.adoqHZsBooleanGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if (Sender as TField).AsBoolean = True then
    Text := 'Y'
  else
    Text := 'N';
end;

procedure TfPCWasteHZChoose.FormShow(Sender: TObject);
begin
  adoqHZs.Active := True;

  //Use the (unique) HZ set to accept purchases as the default option. 
  adoqHZs.Locate('ePur',1,[]);
end;

procedure TfPCWasteHZChoose.BitBtnNextClick(Sender: TObject);
begin
  SelectHZ;
end;

procedure TfPCWasteHZChoose.SelectHZ;
begin
  FHzID := adoqHZs.FieldByName('HzID').AsInteger;
  FHzName := adoqHZs.FieldByName('HzName').AsString;
  ModalResult := mrOK;
end;

procedure TfPCWasteHZChoose.wwDBGridHZsDblClick(Sender: TObject);
begin
  SelectHZ;
end;

end.
