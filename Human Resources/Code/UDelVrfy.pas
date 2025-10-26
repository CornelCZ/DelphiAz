unit UDelVrfy;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, DB, DBTables, Wwtable, dialogs;

type
  TFDelVrfy = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
      name: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDelVrfy: TFDelVrfy;

implementation

uses uempmnu, UVerify;

{$R *.DFM}

procedure TFDelVrfy.FormShow(Sender: TObject);
begin
  with Vrfydlg.Vrfyschd do
  begin
    label4.caption := fieldbyname('fname').asstring + ' ' +
      fieldbyname('name').asstring;
    label5.caption := fieldbyname('Accin').asstring;
    label6.caption := fieldbyname('Accout').asstring;
    if fieldbyname('Confirmed').asstring = 'Y' then
      label7.visible := true
    else
      label7.visible := false;
  end;
end;

procedure TFDelVrfy.CancelBtnClick(Sender: TObject);
begin
  close;
end;

procedure TFDelVrfy.OKBtnClick(Sender: TObject);
begin
  screen.cursor := crhourglass;
  with vrfydlg.vrfyschd do
  begin
    edit;
    fieldbyname('visible').asstring := 'N';
    fieldbyname('shift').asinteger := 0;
    post;
    try
      disablecontrols;
      if vrfydlg.delflag then
      begin
        vrfydlg.delflag := false;
        modalresult := mrCancel;
        exit;
      end;
      if not vrfydlg.reviewFlag then
        Vrfydlg.SaveToSch;
      Vrfydlg.CopyWeek;
      if vrfydlg.copyquery.recordcount = 0 then
      begin
        Vrfydlg.bitbtn2.visible := false;
        Vrfydlg.btnDelete.visible := false;
      end;
      vrfydlg.copyquery.close;
    finally
      enablecontrols;
      screen.cursor := crdefault;
    end;
  end;
end;

end.
