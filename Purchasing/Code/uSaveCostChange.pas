unit uSaveCostChange;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TSaveCostChangeDlg = class(TForm)
    YesBtn: TBitBtn;
    NoBtn: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaveCostChangeDlg: TSaveCostChangeDlg;

implementation

{$R *.dfm}

procedure TSaveCostChangeDlg.FormShow(Sender: TObject);
begin
  NoBtn.SetFocus;
end;

end.
