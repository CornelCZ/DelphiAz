unit uPCWasteChoose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TfPCWasteChoose = class(TForm)
    BitBtnCancelAndExit: TBitBtn;
    BitBtnEnterPCWaste: TBitBtn;
    BitBtnViewPCWaste: TBitBtn;
    procedure BitBtnEnterPCWasteClick(Sender: TObject);
    procedure BitBtnViewPCWasteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FUseHZs: boolean;
    procedure SetupButtons;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPCWasteChoose: TfPCWasteChoose;

implementation

uses uPCWasteRep, uPCWaste, uPCWasteHZChoose, uADO, udata1;

{$R *.dfm}

procedure TfPCWasteChoose.BitBtnEnterPCWasteClick(Sender: TObject);
var
  fPCWaste: TfPCWaste;
  fPCWasteHZChoose: TfPCWasteHZChoose;
  UseHzID: Integer;
  UseHzName: String;
  DoPCWaste: Boolean;
begin
  //If there are any active holding zones then there has to be more than 1 by
  //definition.  If there isn't then we aren't using holding zones at all
  //and all waste should be recorded against the whole site - defined as
  //being holding zone 0.
  DoPCWaste := True;
  UseHzID := 0;
  UseHzName := '';

  if FUseHZs then
  begin
    fPCWasteHZChoose := TfPCWasteHZChoose.Create(self);
    try
      DoPCWaste := fPCWasteHZChoose.ShowModal = mrOK;
      UseHzID := fPCWasteHZChoose.HzID;
      UseHzName := fPCWasteHZChoose.HzName;
    finally
      fPCWasteHZChoose.Hide;
      fPCWasteHZChoose.Release;
      Refresh;
    end;
  end;

  if DoPCWaste then
  begin
    fPCWaste := TfPCWaste.Create(self);
    fPCWaste.HzID := UseHzID;
    fPCWaste.HzName := UseHzName;
    try
      fPCWaste.ShowModal;
    finally
      fPCWaste.Hide;
      fPCWaste.Release;
      Setupbuttons;
      Refresh;
    end;
  end;
end;

procedure TfPCWasteChoose.BitBtnViewPCWasteClick(Sender: TObject);
var
  fPCWasteRep: TfPCWasteRep;
begin
  fPCWasteRep := TfPCWasteRep.Create(self);
  try
    fPCWasteRep.ShowHZs := FUseHZs;
    fPCWasteRep.ShowModal;
  finally
    fPCWasteRep.Release;
  end;
end;

procedure TfPCWasteChoose.SetupButtons;
begin
  with data1.adoqRun do
  try
    close;
    sql.Clear;
    sql.Add('select count(*) as NumPCWaste from stkPCWaste');
    sql.Add('where (WasteFlag = ''M'')');
    sql.Add('and (deleted = 0)');
    open;

    if FieldByName('NumPCWaste').AsInteger > 0 then
    begin
      BitBtnViewPCWaste.Enabled := True;
      BitBtnViewPCWaste.Caption := '&View Waste';
    end
    else
    begin
      BitBtnViewPCWaste.Enabled := False;
      BitBtnViewPCWaste.Caption := 'No Waste to View';
    end;
  finally
    close;
  end;

  FUseHZs := data1.CheckSiteUsesHZs;

end;

procedure TfPCWasteChoose.FormShow(Sender: TObject);
begin
  SetupButtons;
end;

end.
