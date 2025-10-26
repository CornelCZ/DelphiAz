unit uSelectServers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ActnList;

type
  TSelectServers = class(TForm)
    lvServers: TListView;
    btnContinue: TButton;
    btnCancel: TButton;
    alButtons: TActionList;
    actContinue: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actContinueUpdate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FSelectedServers: TStringList;
  end;


function CheckForMultipleServers(var SelectedServers: TStringList): Word;

implementation

uses uADO, ADODB, uAztecLog, uUpdateTerminals, DB;

{$R *.dfm}

function CheckForMultipleServers(var SelectedServers: TStringList): Word;
var
  SelectServersForm: TSelectServers;
  i: integer;
  ServerItem: TListItem;
begin
  with TADOQuery.Create(nil) do
  try
    Connection := dmADO.AztecConn;

    SQL.Text :=  'SELECT * from ThemeSites where SiteCode = dbo.fnGetSiteCode()';
    Open;
    if RecordCount = 0 then
    begin
      Close;
      Log('CheckForMultipleServers, no Theme configured, cannot send to POS.');
      if not (uUpdateTerminals.DoingThemeAutoSend or uUpdateTerminals.SendingThemeToEmptyPos) then
        MessageDlg('There is no Theme selected for this site.' + #13#10 +
                   'The Send to POS action cannot continue.',mtWarning,[mbOK],0);
      Result := mrCancel;
      exit;
    end;

    SQL.Text :=
      'select EposDeviceID, Name '+
      'from ( '+
      '  select EposDeviceID, Name from ThemeEposDevice '+
      '  where HardwareType in (select HardwareType from TerminalHardware where ClassName like ''%.AztecEPoSDevice'') '+
      '  and SiteCode = dbo.fnGetSiteCode() and IsServer = 1 '+
      ') ValidServers '+
      'join ( '+
      '  select distinct ServerID from ThemeEposDevice '+
      '  where HardwareType in (select HardwareType from TerminalHardware where ClassName like ''%.AztecEPoSDevice'') '+
      '  and SiteCode = dbo.fnGetSiteCode() and IsServer = 0 '+
      ') ValidDevices on EposDeviceID = ServerId '+
      'order by Name';
    Open;

    if (uUpdateTerminals.DoingThemeAutoSend or uUpdateTerminals.SendingThemeToEmptyPos) then
    begin
      if RecordCount = 0 then
      begin
        Log('CheckForMultipleServers, Auto SendToEpos disallowed because no servers exist in the Aztec database');
        Result := mrCancel;
      end
      else begin
        //Add all servers when doing an autmatic Send to EPoS
        while not EOF do
        begin
          SelectedServers.Add(IntToStr(FieldByName('EPoSDeviceID').AsInteger));
          Next;
        end;
        Result := mrOK;
      end;
    end
    else begin
      if RecordCount = 0 then
      begin
        Log('CheckForMultipleServers, SendToEpos disallowed because no servers exist in the Aztec database');
        MessageDlg('There are no servers in the Aztec Database.' + #13#10 +
                   'The Send to POS action cannot continue.',mtWarning,[mbOK],0);
        Result := mrCancel;
      end
      else if RecordCount = 1 then
      begin
        // only server so add this to UpdateTerminals list of servers
        Result := mrOK;
        SelectedServers.Add(IntToStr(FieldbyName('EPoSDeviceID').asInteger));
      end
      else
      begin
        // there are multiple servers so build the server device id checkbox list
        // and display the SelectServers form
        SelectServersForm := TSelectServers.Create(Application);
        try
          with SelectServersForm.lvServers do
          begin
            while not Eof do
            begin
              ServerItem := Items.Add;
              ServerItem.Caption := FieldByName('Name').AsString;
              SelectServersForm.FSelectedServers.Add(IntToStr(FieldByName('EPoSDeviceID').AsInteger));
              Next;
            end;
          end;
          Result := SelectServersForm.ShowModal;
          if Result = mrOK then
          begin
            for i := 0 to SelectServersForm.lvServers.Items.Count-1 do
            begin
              if SelectServersForm.lvServers.Items[i].Checked then
              begin
                SelectedServers.Add(SelectServersForm.FSelectedServers[i]);
              end;
            end;
          end;
        finally
          SelectServersForm.Free;
        end;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TSelectServers.FormCreate(Sender: TObject);
begin
  FSelectedServers := TStringList.Create;
end;

procedure TSelectServers.FormDestroy(Sender: TObject);
begin
  FSelectedServers.Free;
end;

procedure TSelectServers.actContinueUpdate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lvServers.Items.Count-1 do
  begin
    if lvServers.Items[i].Checked then
    begin
      actContinue.Enabled := TRUE;
      Exit;
    end;
  end;
  actContinue.Enabled := FALSE;
end;

end.
