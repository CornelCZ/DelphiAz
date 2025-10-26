unit UCopyopt;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TCopyOptDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CopyOptDlg: TCopyOptDlg;

implementation

uses uSchedule;

{$R *.DFM}



procedure TCopyOptDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fSchedule.DBGrid.setfocus;
end;

end.

