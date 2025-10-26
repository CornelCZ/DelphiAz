unit uAddEditConquerorTerminal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAddEdit, DBCtrls, StdCtrls, Mask, ImgList, DB, ExtCtrls,
  wwdbedit, Wwdotdot, Wwdbcomb, wwdblook;

type
  TfrmAddEditConquerorTerminal = class(TfrmAddEdit)
    lblName: TLabel;
    DBEdtName: TDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeditEPoSDeviceID: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cmbbxHardwareType: TwwDBComboBox;
    editbxConquerorDeviceID: TMemo;
    dbcmbTerminalName: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure editbxConquerorDeviceIDKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function ValidZonalDeviceID: Boolean;
    function ValidConquerorDeviceID: Boolean;
  protected
    procedure SaveChanges; override;
    function ValidateFields: Boolean; override;
  end;

implementation

uses uADO, uDMThemeData, uEPosDevice;

{$R *.dfm}

procedure TfrmAddEditConquerorTerminal.FormCreate(Sender: TObject);
begin
  inherited;
  cmbbxHardwareType.Items.Clear;
  with dmAdo.adoqrun do
  begin
    close;
    sql.clear;
    sql.add ('SELECT [HardwareType], [HardwareName] FROM TerminalHardware');
    open;
    while not eof do
    begin
      cmbbxHardwareType.Items.Add(fieldbyname('HardwareName').AsString + #9 + fieldbyname('HardwareType').AsString);
      next;
    end;
  end;
end;

procedure TfrmAddEditConquerorTerminal.FormShow(Sender: TObject);
begin
  inherited;
  case FMode of
    EDIT_CONQUEROR_TERMINAL :
      begin
        with dmAdo.adoqrun do
        begin
          close;
          sql.clear;
          sql.add ('select ConquerorDeviceID from ConquerorEPoSDeviceDetails');
          sql.add ('where EPoSDeviceID = :EPoSDeviceID');
          parameters.parambyname('EPoSDeviceID').Value := dsEditRec.DataSet.fieldbyname('EPoSDeviceID').Value;
          open;
          editbxConquerorDeviceID.Text := fieldbyname('ConquerorDeviceID').AsString;
          editbxConquerorDeviceID.Enabled := false;
          dbEditEPoSDeviceID.Enabled := false;
        end;
        dsEditRec.DataSet.FieldByName('SiteCode').Value := FSiteCode;
        dsEditRec.DataSet.FieldByName('HardwareType').Value := ehtConqueror;
        HelpContext := 5023;
      end;
    ADD_CONQUEROR_TERMINAL :
      begin
        dsEditRec.DataSet.FieldByName('ServerID').Value := FParentDeviceID;
        dsEditRec.DataSet.FieldByName('SiteCode').Value := FSiteCode;
        dsEditRec.DataSet.FieldByName('HardwareType').Value := ehtConqueror;
        dsEditRec.DataSet.FieldByName('GatewayIP').Value := dmADO.GetGatewayIPForTerminal(FSiteCode);
        HelpContext := 5023;
      end;
  end;
  dmThemeData.qConfigSets.active := true;

  dmAdo.qGetPoses.Close;
  dmADO.qGetPoses.Parameters.ParamByName('current_pos').Value := dsEditRec.DataSet.fieldbyname('poscode').AsInteger;
  dmAdo.qGetPoses.Open;
end;

procedure TfrmAddEditConquerorTerminal.btnSaveClick(Sender: TObject);
begin
  inherited;
  // Add code that writes to ConquerorEPoSDeviceDetails here



end;

function TfrmAddEditConquerorTerminal.ValidateFields: Boolean;
begin
  result := true;
  if DBEdtName.Text = '' then
  begin
    result := false;
    DBEdtName.SetFocus;
    messagedlg('Name must be filled in.', mtInformation, [mbOK], 0);
  end else if (dbcmbTerminalName.text = '') or (dbcmbTerminalName.text = '(none)') then
  begin
    result := false;
    dbcmbTerminalName.SetFocus;
    messagedlg('Terminal name must be selected.', mtInformation, [mbOK], 0);
  end else if (((dbEditEPosDeviceID.Text  ='') or ( not ValidZonalDeviceID )) and (dseditRec.State = dsInsert)) then
  begin
    result := false;
    dbEditEPosDeviceID.SetFocus;
    messagedlg('Device ID must be filled in, and must be Unique.', mtInformation, [mbOK], 0);
  end else if (((editBxConquerorDeviceID.Text  ='') or ( not ValidConquerorDeviceID )) and (dseditRec.State = dsInsert)) then
  begin
    result := false;
    editBxConquerorDeviceID.SetFocus;
    messagedlg('Conqueror Device ID must be filled in, and must be Unique.', mtInformation, [mbOK], 0);
  end;
end;

function TfrmAddEditConquerorTerminal.ValidZonalDeviceID: Boolean;
begin
  with dmADO.qRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT [Name] FROM ThemeEposDevice');
    SQL.Add('WHERE EposDeviceID = ' + dbEditEposDeviceID.Text);
    Open;
    Result := (RecordCount = 0);
    Close;
  end;
end;

function TfrmAddEditConquerorTerminal.ValidConquerorDeviceID: Boolean;
begin
  with dmADO.qRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT [EPoSDeviceID] FROM ConquerorEPoSDeviceDetails');
    SQL.Add('WHERE ConquerorDeviceID = ' + editBxConquerorDeviceID.Text);
    Open;
    Result := (RecordCount = 0);
    Close;
  end;
end;


procedure TfrmAddEditConquerorTerminal.SaveChanges;
begin
  inherited;
    case FMode of
      EDIT_CONQUEROR_TERMINAL :
        begin
          with dmAdo.adoqrun do
          begin
            close;
            sql.clear;
            sql.add ('update ConquerorEPoSDeviceDetails set');
            sql.add ('ConquerorDeviceID = :ConquerorDeviceID');
            sql.add ('where EPoSDeviceID = :EPoSDeviceID');
            parameters.parambyname('EPoSDeviceID').Value := dsEditRec.DataSet.fieldbyname('EPoSDeviceID').Value;
            parameters.parambyname('ConquerorDeviceID').Value := editbxConquerorDeviceID.Text;
            execsql;
          end;
        end;
      ADD_CONQUEROR_TERMINAL :
        begin
          with dmAdo.adoqrun do
          begin
            close;
            sql.clear;
            sql.add ('Insert into ConquerorEPoSDeviceDetails (SiteCode, EPoSDeviceID, ConquerorDeviceID)');
            sql.add ('Values (:SiteCode, :EPoSDeviceID, :ConquerorDeviceID)');
            parameters.parambyname('SiteCode').Value := FSiteCode;
            parameters.parambyname('EPoSDeviceID').Value := dsEditRec.DataSet.fieldbyname('EPoSDeviceID').Value;
            parameters.parambyname('ConquerorDeviceID').Value := editbxConquerorDeviceID.Text;
            execsql;
          end;
        end;
    end;
end;

procedure TfrmAddEditConquerorTerminal.editbxConquerorDeviceIDKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0','1','2','3','4','5', '6','7','8','9', char(vk_back)]) then key := #0;

end;

procedure TfrmAddEditConquerorTerminal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dmADO.qGetPoses.Close;
end;

end.
