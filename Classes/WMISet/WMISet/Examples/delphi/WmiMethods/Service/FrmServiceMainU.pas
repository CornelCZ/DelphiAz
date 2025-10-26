unit FrmServiceMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Db, WmiDataSet, WmiConnection, ComCtrls, ToolWin, Grids, DBGrids,
  WmiAbstract, WmiMethod, FrmNewHostU, FrmAboutU;

type
  TFrmServiceMain = class(TForm)
    DBGrid1: TDBGrid;
    ToolBar1: TToolBar;
    tlbStart: TToolButton;
    tlbPause: TToolButton;
    tlbResume: TToolButton;
    tlbStop: TToolButton;
    ToolButton1: TToolButton;
    tlbRefresh: TToolButton;
    WmiConnection1: TWmiConnection;
    WmiQuery1: TWmiQuery;
    DataSource1: TDataSource;
    ilToolBar: TImageList;
    WmiMethod1: TWmiMethod;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    tlbAbout: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure tlbStartClick(Sender: TObject);
    procedure tlbRefreshClick(Sender: TObject);
    procedure tlbStopClick(Sender: TObject);
    procedure tlbPauseClick(Sender: TObject);
    procedure tlbResumeClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure tlbAboutClick(Sender: TObject);
  private
    procedure SetButtonState;
    procedure Refresh;
    procedure ExecuteMethod(AMethodName: string);
    procedure SetFormCaption;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmServiceMain: TFrmServiceMain;

implementation

{$R *.DFM}

procedure TFrmServiceMain.FormCreate(Sender: TObject);
begin
  WmiMethod1.WmiObjectSource := WmiQuery1;
  SetFormCaption;
end;

procedure TFrmServiceMain.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  SetButtonState;
end;

procedure TFrmServicemain.SetButtonState;
begin
  tlbStart.Enabled := (WmiQuery1.FieldByName('State').AsString = 'Stopped');
  tlbStop.Enabled  := (WmiQuery1.FieldByName('State').AsString = 'Running')  and
                      (WmiQuery1.FieldByName('AcceptStop').AsBoolean);
  tlbPause.Enabled := (WmiQuery1.FieldByName('State').AsString = 'Running')  and
                      (WmiQuery1.FieldByName('AcceptPause').AsBoolean);
  tlbResume.Enabled := (WmiQuery1.FieldByName('State').AsString = 'Paused');
end;


procedure TFrmServiceMain.tlbStartClick(Sender: TObject);
begin
  ExecuteMethod('StartService');
end;


procedure TFrmServicemain.Refresh;
var
  s: string;
begin
  s := WmiQuery1.FieldByName('name').AsString;

  WmiQuery1.DisableControls();
  Screen.Cursor := crHourGlass;
  try 
    WmiQuery1.Close();
    WmiQuery1.Open();
    WmiQuery1.Locate('name', s, []);
  finally 
    WmiQuery1.EnableControls();
    Screen.Cursor := crDefault;
  end;
  SetButtonState();
end;


procedure TFrmServiceMain.tlbRefreshClick(Sender: TObject);
begin
  Refresh;        
end;

procedure TFrmServiceMain.tlbStopClick(Sender: TObject);
begin
  executeMethod('StopService');
end;

procedure TFrmServiceMain.tlbPauseClick(Sender: TObject);
begin
  ExecuteMethod('PauseService');
end;

procedure TFrmServiceMain.tlbResumeClick(Sender: TObject);
begin
  ExecuteMethod('ResumeService');
end;

procedure TFrmServicemain.ExecuteMethod(AMethodName: string);
var
 s: string;
begin
  WmiMethod1.WmiMethodName := AMethodName;
  if (WmiMethod1.Execute <> 0) then
  begin
     s := WmiMethod1.LastWmiErrorDescription;
     Application.MessageBox(PChar(s), 'Error', MB_ICONHAND + MB_OK);
  end else
  begin
    Refresh();
  end;
end;


procedure TFrmServiceMain.ToolButton2Click(Sender: TObject);
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

procedure TFrmServiceMain.SetFormCaption;
begin
  if WmiConnection1.MachineName = '' then
    Caption := 'Services on local host' else
    Caption := 'Services on '+ WmiConnection1.MachineName; 
end;

procedure TFrmServiceMain.tlbAboutClick(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
