unit FrmScheduledJobMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, WmiAbstract, WmiMethod, DB, WmiDataSet, WmiConnection,
  Grids, DBGrids, ComCtrls, ToolWin, FrmNewJobU, FrmNewHostU,
  FrmAboutU;

type
  TFrmScheduledJobMain = class(TForm)
    ToolBar1: TToolBar;
    tlbCreate: TToolButton;
    tlbDelete: TToolButton;
    tlbSeparator: TToolButton;
    tlbRefresh: TToolButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    WmiConnection1: TWmiConnection;
    WmiQuery1: TWmiQuery;
    WmiMethodCreate: TWmiMethod;
    WmiMethodDelete: TWmiMethod;
    ImageList1: TImageList;
    tlbConnect: TToolButton;
    ToolButton2: TToolButton;
    tlbAbout: TToolButton;
    ToolButton3: TToolButton;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure tlbDeleteClick(Sender: TObject);
    procedure tlbRefreshClick(Sender: TObject);
    procedure tlbCreateClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure tlbConnectClick(Sender: TObject);
    procedure tlbAboutClick(Sender: TObject);
  private
    { Private declarations }
    function DaysOfWeekToStr(Days: integer): string;
    function DaysOfMonthToStr(Days: integer): string;
    procedure SetButtonState;
    procedure Refresh;
    procedure SetFormCaption;
  public
    { Public declarations }
  end;

var
  FrmScheduledJobMain: TFrmScheduledJobMain;

implementation

{$R *.dfm}

{ TFrmScheduledJobMain }

procedure TFrmScheduledJobMain.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  SetButtonState;
end;

procedure TFrmScheduledJobMain.tlbDeleteClick(Sender: TObject);
var
  s: string;
begin
  if WmiMethodDelete.Execute <> 0 then
  begin
    s := WmiMethodDelete.LastWmiErrorDescription;
    Application.MessageBox(PChar(s), 'Error', MB_ICONHAND + MB_OK) ;
  end else
  begin
    Refresh;
  end;
end;

procedure TFrmScheduledJobMain.Refresh;
var
  vSelected: integer;
begin
  vSelected := -1;
  if WmiQuery1.RecordCount > 0 then
    vSelected := WmiQuery1.FieldByName('JobId').AsInteger;

  WmiQuery1.DisableControls;
  Screen.Cursor := crHourGlass;
  try
    WmiQuery1.Close;
    WmiQuery1.Open;
    if vSelected <> -1 then
      WmiQuery1.Locate('JobId', vSelected, []);
  finally
    WmiQuery1.EnableControls;
    Screen.Cursor := crDefault;
  end;
  SetButtonState;
end;

procedure TFrmScheduledJobMain.SetButtonState;
begin
  tlbDelete.Enabled := WmiQuery1.RecordCount > 0;
end;


procedure TFrmScheduledJobMain.tlbRefreshClick(Sender: TObject);
begin
  Refresh;
end;

procedure TFrmScheduledJobMain.tlbCreateClick(Sender: TObject);
var
  FrmNewJob: TFrmNewJob;
  s: string;
begin
  FrmNewJob := TFrmNewJob.Create(nil);
  try
    while (true)  do
    begin
      if FrmNewJob.ShowModal() = mrOk then
      begin
          WmiMethodCreate.FetchInParams;
          WmiMethodCreate.InParams.ParamByName('Command').AsString := FrmNewJob.edtCommand.Text;
          WmiMethodCreate.InParams.ParamByName('StartTime').AsTime := FrmNewJob.dtpStartTime.Time;
          WmiMethodCreate.InParams.ParamByName('InteractWithDesktop').AsBoolean := FrmNewJob.chbInteract.Checked;
          WmiMethodCreate.InParams.ParamByName('RunRepeatedly').AsBoolean := FrmNewJob.chbRunRepeatedly.Checked;
          if (FrmNewJob.chbRunRepeatedly.Checked) then
          begin
            WmiMethodCreate.InParams.ParamByName('DaysOfWeek').AsInteger := FrmNewJob.GetDaysOfWeek;
            WmiMethodCreate.InParams.ParamByName('DaysOfMonth').AsInteger := FrmNewJob.GetDaysOfMonth;
          end;


          if (WmiMethodCreate.Execute <> 0) then
          begin
            s := WmiMethodCreate.LastWmiErrorDescription;
            Application.MessageBox(PChar(s), 'Error', MB_ICONHAND + MB_OK) ;
          end else
          begin
            Refresh;
            Break;
          end
      end else
      begin
        Break;
      end;
    end;
  finally
     FrmNewJob.Free;
  end
end;

procedure TFrmScheduledJobMain.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  s: string;
begin
  if (Column.FieldName = 'DaysOfWeek') and (Column.Field <> nil) then
  begin
      s := DaysOfWeekToStr(Column.Field.AsInteger);
      DBGrid1.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, s);
  end;
  if (Column.FieldName = 'DaysOfMonth') and (Column.Field <> nil) then
  begin
      s := DaysOfMonthToStr(Column.Field.AsInteger);
      DBGrid1.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, s);
  end
end;

function TFrmScheduledJobMain.DaysOfWeekToStr(Days: integer): string;
var
  vMask, i, vDay: integer;
begin
  if (Days = 127) then
  begin
    Result :=  'All';
  end else
  begin
    Result := '';
    vMask := 1;
    for i := 0 to 6 do
    begin
      vDay := vMask and Days;
      if (vDay <> 0) then
      begin
        case vDay of
          1: Result := Result  + 'Mon ';
          2: Result := Result  + 'Tue ';
          4: Result := Result  + 'Wed ';
          8: Result := Result  + 'Thu ';
          16: Result := Result  + 'Fri ';
          32: Result := Result  + 'Sat ';
          64: Result := Result  + 'Sun ';
        end;
      end;
      vMask := vMask * 2;
    end
  end;
end;


function TFrmScheduledJobMain.DaysOfMonthToStr(Days: integer): string;
var
  vMask, vDay, i: integer;
begin
  if (Days = 2147483647) then
  begin
    Result := 'All';
  end else
  begin
    Result := '';
    vMask  := 1;
    for i := 0 to 31 do
    begin
        vDay := vMask and Days;
        if vDay <> 0 then Result := Result + IntToStr(i+1) + ',';
        vMask := vMask * 2;
    end;
  end;
end;

procedure TFrmScheduledJobMain.FormCreate(Sender: TObject);
begin
  WmiMethodCreate.WmiObjectSource := WmiConnection1;
  WmiMethodDelete.WmiObjectSource := WmiQuery1;
  SetFormCaption;
end;

procedure TFrmScheduledJobMain.tlbConnectClick(Sender: TObject);
var
  vUserName: string;
  vWasCursor: TCursor;

  vOldUserName, vOldPassword, vOldMachineName: widestring;
  vFrmNewHost: TFrmNewHost;
begin
  vFrmNewHost := TFrmNewHost.Create(nil);
  try
    while true do
    begin
      if vFrmNewHost.ShowModal = mrOk then
      begin
        // save current credentials to be able to restore
        // them if new credentials are invalid.
        vOldUserName := WmiConnection1.Credentials.UserName;
        vOldPassword := WmiConnection1.Credentials.Password;
        vOldMachineName := WmiConnection1.MachineName;

        WmiConnection1.Connected := false;
        vUserName := vFrmNewHost.edtUserName.Text;
        if vFrmNewHost.edtDomain.Text <> '' then
          vUserName := vFrmNewHost.edtDomain.Text + '\' + vUserName;

        WmiConnection1.Credentials.UserName := vUserName;
        WmiConnection1.Credentials.Password := vFrmNewHost.edtPassword.Text;
        WmiConnection1.MachineName := vFrmNewHost.edtHostName.Text;

        vWasCursor := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        try
          try
            WmiConnection1.Connected := true;
            WmiQuery1.Active := true;
            SetFormCaption;
            Refresh;
            Break;
          finally
            Screen.Cursor := vWasCursor;
          end;
        except
          on E: Exception do
            begin
              Application.MessageBox(PChar(E.Message), 'Error', MB_Ok + MB_ICONSTOP);
              // restore previous credentials.
              WmiConnection1.Credentials.UserName := vOldUserName;
              WmiConnection1.Credentials.Password := vOldPassword;
              WmiConnection1.MachineName          := vOldMachineName;
              WmiConnection1.Connected := true;
              WmiQuery1.Active := true;
            end;
        end;
      end else
      begin
        Break;
      end;
    end;
  finally
    vFrmNewHost.Free;
  end;
end;

procedure TFrmScheduledJobMain.SetFormCaption;
begin
  if WmiConnection1.MachineName = '' then
    Caption := 'Scheduled jobs on local host' else
    Caption := 'Scheduled jobs on '+ WmiConnection1.MachineName; 
end;

procedure TFrmScheduledJobMain.tlbAboutClick(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
