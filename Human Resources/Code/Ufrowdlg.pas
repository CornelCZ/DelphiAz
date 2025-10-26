unit Ufrowdlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Mask, Dialogs;

type
  TFfrowdlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKBtnClick(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure MaskEdit2Exit(Sender: TObject);
    function Validtime(timestr: string): boolean;
  private
    { Private declarations }
  public
    instr, outstr: string;
    okflag: boolean;
    { Public declarations }
  end;

var
  Ffrowdlg: TFfrowdlg;

implementation

{$R *.DFM}

procedure TFfrowdlg.FormShow(Sender: TObject);
begin
  maskedit1.text := ' : ';
  maskedit2.text := ' : ';
  maskedit1.setfocus;

end;

procedure TFfrowdlg.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_return) then
    maskedit2.setfocus;
end;

procedure TFfrowdlg.MaskEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_return) then
    okbtnclick(sender);
end;

procedure TFfrowdlg.OKBtnClick(Sender: TObject);
begin
  if not okflag then
    exit
  else
  begin
    try
      strtotime(maskedit1.text);
      strtotime(maskedit2.text);
      instr := maskedit1.text;
      outstr := maskedit2.text;
      modalresult := mrOK;
    except
      on exception do
        exit;
    end;
  end;
end;

procedure TFfrowdlg.MaskEdit1Exit(Sender: TObject);
begin
  if not validtime(maskedit1.text) then
  begin
    maskedit1.text := ' : ';
  end
  else
    okflag := true;
end;

procedure TFfrowdlg.MaskEdit2Exit(Sender: TObject);
begin
  if not validtime(maskedit2.text) then
  begin
    maskedit2.text := ' : ';
  end
  else
    okflag := true;
end;

function tffrowdlg.Validtime(timestr: string): boolean;
var
  s1, s2: string;

begin
  okflag := false;
  validtime := false;
  if length(timestr) <> 5 then
    exit;
  s1 := copy(timestr, 1, 2);
  s2 := copy(timestr, 4, 2);
  if (s1 > inttostr(23)) or (s2 > inttostr(59)) then
    messagedlg(timestr + ' is not a valid time !', mterror, [mbok], 0)
  else
    validtime := true;
end;

end.
