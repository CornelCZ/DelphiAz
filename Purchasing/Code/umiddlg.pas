unit umiddlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Wwlocate;

type
  Tfmiddlg = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    btnFirst: TBitBtn;
    btnClose: TBitBtn;
    btnNext: TBitBtn;
    lblSearchMode: TLabel;
    lblSearchModeValue: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmiddlg: Tfmiddlg;

implementation

{$R *.DFM}

uses uNewItemDlg;

procedure Tfmiddlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    modalresult := mrCancel
end;

procedure Tfmiddlg.FormShow(Sender: TObject);
begin
  fnewitemdlg.wwFind.MatchType := mtPartialMatchAny;
  lblSearchModeValue.Caption := fnewitemdlg.wwincsearch.SearchField;
  Edit1.Text := fnewitemdlg.wwincsearch.Text;
  edit1.SetFocus;
end;

procedure Tfmiddlg.btnFirstClick(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    fnewitemdlg.wwFind.FieldValue := Edit1.Text;
    fnewitemdlg.wwFind.FindFirst;
  end;
  Edit1.SetFocus;
end;

procedure Tfmiddlg.btnNextClick(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    fnewitemdlg.wwFind.FieldValue := Edit1.Text;
    fnewitemdlg.wwFind.FindNext;
  end;
  Edit1.SetFocus;
end;

end.
