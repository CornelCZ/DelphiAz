unit FrmMainU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, WmiAbstract, WmiStorageInfo, WmiDevice, Menus, ComCtrls, ExtCtrls,
  Grids, ImgList,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  ToolWin, WmiComponent, FrmAboutU;

type
  TFrmMain = class(TForm)
    WmiStorageInfo1: TWmiStorageInfo;
    tvBroswer: TTreeView;
    pnlData: TPanel;
    lvProperties: TListView;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ilToolbar: TImageList;
    Splitter1: TSplitter;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvBroswerExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvBroswerChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    FStoredCursor: TCursor;

    procedure InitItems;
    function  ProcessNodeExpanding(ANode: TTreeNode): boolean;
    function  AddStorageDeviceNodes(ANode: TTreeNode): boolean;
    function  DoConnect(ANode: TTreeNode): boolean;
    function  LoadCDROMDrives(ANode: TTreeNode): boolean;
    function  LoadDiskDrives(ANode: TTreeNode): boolean;
    function  LoadFloppyDrives(ANode: TTreeNode): boolean;
    function  LoadLogicalDisks(ANode: TTreeNode): boolean;
    function  LoadRemoteHosts(ANode: TTreeNode): boolean;
    function  LoadTapes(ANode: TTreeNode): boolean;
    function  LoadPartitions(ANode: TTreeNode): boolean;
    procedure ProcessChangingNode(ANode: TTreeNode);
    procedure LoadCDROMProperties(ANode: TTreeNode);
    procedure LoadDiskProperties(ANode: TTreeNode);
    procedure LoadFloppyProperties(ANode: TTreeNode);
    procedure LoadLogicalDiskProperties(ANode: TTreeNode);
    procedure LoadTapeProperties(ANode: TTreeNode);
    procedure ClearPropertyViewView;
    procedure LoadDeviceProperties(ADrive: TWmiDevice);
    procedure LoadPartitionProperties(ANode: TTreeNode);
    procedure AddPropertyItem(ACaption, AValue: widestring);
    procedure LoadCommonDriveProperties(ADrive: TWmiDriveBase);
    procedure AddAccessPropertyItem(AAccess: word);
    procedure RestoreCursor;
    procedure SetWaitCursor;
    function  FindNeworkNode: TTreeNode;
    procedure CreateNewNetworkNode;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

Uses FrmNewHostU;

const
  LOCAL_HOST = 'Local Host';
  NETWORK = 'Network';
  NO_DATA = 'NO_DATA';
  DISKS = 'Disk Drives';
  TAPES = 'Tapes';
  FLOPPY_DRIVES = 'Floppy Drives';
  LOGICAL_DISKS = 'Logical Disks';
  CDROM_DRIVES = 'CDROM Drives';
  PARTITIONS = 'Partitions';

  LEVEL_REMOTE_HOST = 3;

type
  TCredentials = class
  private
    FUserName: widestring;
    FPassword: widestring;
  public
    constructor Create(AUserName, APassword: widestring);

    property UserName: widestring read FUserName;
    property Password: widestring read FPassword; 
  end;

function BoolToStr(AValue: boolean): widestring;
begin
  if AValue then Result := 'yes' else Result := 'no';
end;

function GetAvailabilityDescription(Availability: word): widestring;
begin
  case Availability of
    AVAIL_OTHER: Result := 'Other';
    AVAIL_RUNNING: Result := 'Running';
    AVAIL_WARNING: Result := 'Warning';
    AVAIL_IN_TEST: Result := 'In test';
    AVAIL_NOT_APPLICABLE: Result := 'Not applicable';
    AVAIL_POWER_OFF: Result := 'Power off';
    AVAIL_OFF_LINE: Result := 'Off line';
    AVAIL_OFF_DUTY: Result := 'Off duty';
    AVAIL_DEGRADED: Result := 'Degraded';
    AVAIL_NOT_INSTALLED: Result := 'Not installed';
    AVAIL_INSTALL_ERROR: Result := 'Installation error';
    AVAIL_POWER_SAVE_UNKNOWN: Result := 'Power Save Unknown';
    AVAIL_POWER_SAVE_LOW_POWER_MODE: Result := 'Low power mode';
    AVAIL_POWER_SAVE_STANDBY: Result := 'Standby';
    AVAIL_POWER_POWER_CYCLE: Result := 'Power cycle';
    AVAIL_POWER_SAVE_WARNING: Result := 'Power save warning';
    AVAIL_PAUSED: Result := 'Paused';
    AVAIL_NOT_READY: Result := 'Not ready';
    AVAIL_NOT_CONFIGURED: Result := 'Not configured';
    AVAIL_QUIESCED: Result := 'Quiesced';
    else  Result := 'Unknown';
  end;
end;

function DriveTypeToStr(ADriveType: DWORD): string;
begin
  case ADriveType of
    DT_NO_ROOT_DIRECTORY: Result := 'No Root Directory';
    DT_REMOVABLE_DISK:    Result := 'Removable Disk';
    DT_LOCAL_DISK:        Result := 'Local Disk';
    DT_NETWORK_DRIVE:     Result := 'Network Drive';
    DT_COMPACT_DISK:      Result := 'Compact Disk';
    DT_RAM_DISK:          Result := 'Ram Drive';
  end;
end;

function MediaTypeToStr(AMediaType: DWORD): string;
begin
  case AMediaType of
    MT_UNKNOWN: Result := 'UNKNOWN';
    MT_F5_1Pt2_512: Result := 'F5_1Pt2_512';
    MT_F3_1Pt44_512: Result := 'F3_1Pt44_512';
    MT_F3_2Pt88_512: Result := 'F3_2Pt88_512';
    MT_F3_20Pt8_512: Result := 'F3_20Pt8_512';
    MT_F3_720_512: Result := 'F3_720_512';
    MT_F5_360_512: Result := 'F5_360_512';
    MT_F5_320_512: Result := 'F5_320_512';
    MT_F5_320_1024: Result := 'F5_320_1024';
    MT_F5_180_512: Result := 'F5_180_512';
    MT_F5_160_512: Result := 'F5_160_512';
    MT_REMOVABLE: Result := 'REMOVABLE';
    MT_FIXED: Result := 'FIXED';
    MT_F3_120M_512: Result := 'F3_120M_512';
    MT_F3_640_512: Result := 'F3_640_512';
    MT_F5_640_512: Result := 'F5_640_512';
    MT_F5_720_512: Result := 'F5_720_512';
    MT_F3_1Pt2_512: Result := 'F3_1Pt2_512';
    MT_F3_1Pt23_1024: Result := 'F3_1Pt23_1024';
    MT_F5_1Pt23_1024: Result := 'F5_1Pt23_1024';
    MT_F3_128Mb_512: Result := 'F3_128Mb_512';
    MT_F3_230Mb_512: Result := 'F3_230Mb_512';
    MT_F8_256_128: Result := 'F8_256_128';
  end;
end;

function FileSystemFlagsToStr(AFlags: DWORD): widestring;
var
  vMask: DWORD;
  S: string;
  i: integer;
begin
  vMask := 1;
  Result := '';
  for i := 0 to 31 do
  begin
    if (AFlags and vMask) <> 0 then
    begin
      case vMask of
        FSF_CASE_SENSITIVE_SEARCH:   S := 'Case sensitive search';
        FSF_CASE_PRESERVED_NAMES:    S := 'Case preserved names';
        FSF_UNICODE_ON_DISK:         S := 'Unicode on disk';
        FSF_PERSISTENT_ACLS:         S := 'Persistent ACLs';
        FSF_FILE_COMPRESSION:        S := 'File compression';
        FSF_VOLUME_QUOTAS:           S := 'Volume quotas';
        FSF_SUPPORTS_SPARSE_FILES:   S := 'Supports sparse files';
        FSF_SUPPORTS_REPARSE_POINTS: S := 'Supports reparse points';
        FSF_SUPPORTS_REMOTE_STORAGE: S := 'Supports remote storage';
        FSF_SUPPORTS_LONG_NAMES:     S := 'Supports long names';
        FSF_VOLUME_IS_COMPRESSED:    S := 'Volume is compressed';
        FSF_SUPPORTS_OBJECT_IDS:     S := 'Supports object IDs';
        FSF_SUPPORTS_ENCRYPTION:     S := 'Supports encryption';
        FSF_SUPPORTS_NAMED_STREAMS:  S := 'Supports named streams';
      end;
      Result := Result + S + ', ';
    end;
    vMask := vMask * 2;
  end;
end;

procedure TFrmMain.FormResize(Sender: TObject);
begin
  with lvProperties do
    Columns[1].Width := ClientWidth - Columns[0].Width;
end;



procedure TFrmMain.FormCreate(Sender: TObject);
begin
  InitItems;
end;

procedure TFrmMain.SetWaitCursor;
begin
  FStoredCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

procedure TFrmMain.RestoreCursor;
begin
  Screen.Cursor := FStoredCursor;
end;


procedure TFrmMain.InitItems;
var
  vItem: TTreeNode;
begin
  vItem := tvBroswer.Items.Add(nil, LOCAL_HOST);
  tvBroswer.Items.AddChild(vItem, NO_DATA);
  vItem := tvBroswer.Items.Add(nil, NETWORK);
  tvBroswer.Items.AddChild(vItem, NO_DATA);
end;


procedure TFrmMain.tvBroswerExpanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  AllowExpansion := ProcessNodeExpanding(Node);
end;

function TFrmMain.ProcessNodeExpanding(ANode: TTreeNode): boolean;
begin
  Result := true;
  if (ANode.Count = 1) and (ANode.getFirstChild.Text = NO_DATA) then
  begin
    Result := false;
    if (ANode.Text = LOCAL_HOST) then Result := AddStorageDeviceNodes(ANode)
      else
    if (ANode.Text = NETWORK) then Result := LoadRemoteHosts(ANode)
      else
    if (ANode.Parent <> nil) and (ANode.Parent.Text = NETWORK) then
    begin
      if DoConnect(ANode) then Result := AddStorageDeviceNodes(ANode);
    end else
    if ANode.Text = DISKS then Result := LoadDiskDrives(ANode)
      else
    if ANode.Text = TAPES then Result := LoadTapes(ANode)
      else
    if ANode.Text = FLOPPY_DRIVES then Result := LoadFloppyDrives(ANode)
      else
    if ANode.Text = LOGICAL_DISKS then Result := LoadLogicalDisks(ANode)
      else
    if ANode.Text = CDROM_DRIVES then Result := LoadCDROMDrives(ANode)
      else
    if ANode.Text = PARTITIONS then Result := LoadPartitions(ANode);
  end
end;

function TFrmMain.LoadPartitions(ANode: TTreeNode): boolean;
var
  i: integer;
begin
  Result := false;
  if not DoConnect(ANode.Parent) then Exit;

  ANode.DeleteChildren;
  SetWaitCursor;
  try
    for i := 0 to WmiStorageInfo1.Partitions.Count - 1 do
       tvBroswer.Items.AddChild(ANode, WmiStorageInfo1.Partitions[i].Caption);
  finally
    RestoreCursor;
  end;
  Result := true;
end;


function TFrmMain.LoadDiskDrives(ANode: TTreeNode): boolean;
var
  i: integer;
begin
  Result := false;   
  if not DoConnect(ANode.Parent) then Exit;

  ANode.DeleteChildren;
  SetWaitCursor;
  try
    for i := 0 to WmiStorageInfo1.DiskDrives.Count - 1 do
       tvBroswer.Items.AddChild(ANode, WmiStorageInfo1.DiskDrives[i].Caption);
  finally
    RestoreCursor;
  end;     
  Result := true;   
end;

function TFrmMain.LoadTapes(ANode: TTreeNode): boolean;
var
  i: integer;
begin
  Result := false;
  if not DoConnect(ANode.Parent) then Exit;

  ANode.DeleteChildren;
  SetWaitCursor;
  try
    for i := 0 to WmiStorageInfo1.TapeDrives.Count - 1 do
       tvBroswer.Items.AddChild(ANode, WmiStorageInfo1.TapeDrives[i].Caption);
  finally
    RestoreCursor;
  end;
  Result := true;
end;

function TFrmMain.LoadFloppyDrives(ANode: TTreeNode): boolean;
var
  i: integer;
begin
  Result := false;
  if not DoConnect(ANode.Parent) then Exit;

  ANode.DeleteChildren;
  SetWaitCursor;
  try
    for i := 0 to WmiStorageInfo1.FloppyDrives.Count - 1 do
       tvBroswer.Items.AddChild(ANode, WmiStorageInfo1.FloppyDrives[i].Caption);
  finally
    RestoreCursor;
  end;
  Result := true;
end;

function TFrmMain.LoadLogicalDisks(ANode: TTreeNode): boolean;
var
  i: integer;
begin
  Result := false;
  if not DoConnect(ANode.Parent) then Exit;

  ANode.DeleteChildren;
  SetWaitCursor;
  try
    for i := 0 to WmiStorageInfo1.LogicalDisks.Count - 1 do
       tvBroswer.Items.AddChild(ANode, WmiStorageInfo1.LogicalDisks[i].Caption);
  finally
    RestoreCursor;
  end;     
  Result := true;
end;

function TFrmMain.LoadCDROMDrives(ANode: TTreeNode): boolean;
var
  i: integer;
begin
  Result := false;
  if not DoConnect(ANode.Parent) then Exit;

  ANode.DeleteChildren;
  SetWaitCursor;
  try
    for i := 0 to WmiStorageInfo1.CDROMDrives.Count - 1 do
       tvBroswer.Items.AddChild(ANode, WmiStorageInfo1.CDROMDrives[i].Caption);
  finally
    RestoreCursor;
  end;
  Result := true;
end;

function TFrmMain.DoConnect(ANode: TTreeNode): boolean;
var
  vCredentials: TCredentials;
  vForm: TFrmNewHost;
begin
  Result := false;

  // do not reconnect if already connected to desired host. 
  if (ANode.Text = WmiStorageInfo1.MachineName) and
     (WmiStorageInfo1.Active) then
  begin
    Result := true;
    Exit;
  end;

  // if the node represents the local host, clear credentials.
  // Otherwise try 1) to connect without credentiols. If it fails 2) ask user
  // for creadentials and try co connect again.
  // if connection is a sucess, remember sucessfull credentials, so
  // user does not have to enter them again.

  SetWaitCursor;
  try
    WmiStorageInfo1.Active := false;
    if ANode.Text = LOCAL_HOST then
    begin
      // connect to local host;
      WmiStorageInfo1.Credentials.Clear;
      WmiStorageInfo1.MachineName := '';
      WmiStorageInfo1.Active := true;
      Result := true;
    end else
    begin
      if (ANode.Data = nil) then
      begin
        // connect for the first time
        // try default credentials fisrt:
        try
          WmiStorageInfo1.Credentials.Clear;
          WmiStorageInfo1.MachineName := ANode.Text;
          WmiStorageInfo1.Active := true;
          Result := true;
        except
          // expected exception: the credentials are not valid
        end;

        // default credentials did not work.
        // try to connect with user's provided credentials
        if not WmiStorageInfo1.Active then
        begin
          vForm := TFrmNewHost.Create(nil);
          vForm.MachineName := ANode.Text;
          try
            while vForm.ShowModal = mrOk do
              try
                WmiStorageInfo1.Active := false;
                WmiStorageInfo1.Credentials.Clear;
                WmiStorageInfo1.MachineName := ANode.Text;
                WmiStorageInfo1.Credentials.UserName := vForm.UserName;
                WmiStorageInfo1.Credentials.Password := vForm.edtPassword.Text;
                WmiStorageInfo1.Active := true;

                // connected successfully; remember credentials
                ANode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
                AddStorageDeviceNodes(ANode);
                Result := true;
                Break;
              except
                on e: Exception do
                  Application.MessageBox(PChar(e.Message), 'Error', ID_OK);
              end;
          finally
            vForm.Free;
          end;
        end;
      end else
      begin

        // reconnect with existing credentials
        vCredentials := TCredentials (ANode.Data);
        WmiStorageInfo1.MachineName := ANode.Text;
        WmiStorageInfo1.Credentials.UserName := vCredentials.UserName;
        WmiStorageInfo1.Credentials.Password := vCredentials.Password;
        WmiStorageInfo1.Active := true;
        Result := true;
      end;
    end;
  finally
    RestoreCursor;
  end;
end;


function TFrmMain.LoadRemoteHosts(ANode: TTreeNode): boolean;
var
  AList: TStrings;
  i: integer;
  vNode: TTreeNode;
begin
  ANode.DeleteChildren;
  AList := TStringList.Create;
  SetWaitCursor;
  try
    WmiStorageInfo1.ListServers(AList);
    for i := 0 to AList.Count - 1 do
    begin
      vNode := tvBroswer.Items.AddChild(ANode, AList[i]);
      AddStorageDeviceNodes(vNode);
    end;
  finally
    AList.Free;
    RestoreCursor;
  end;
  Result := true;
end;

function TFrmMain.AddStorageDeviceNodes(ANode: TTreeNode): boolean;
var
  vItem: TTreeNode;
begin
  ANode.DeleteChildren;

  vItem := tvBroswer.Items.AddChild(ANode, CDROM_DRIVES);
  tvBroswer.Items.AddChild(vItem, NO_DATA);

  vItem := tvBroswer.Items.AddChild(ANode, DISKS);
  tvBroswer.Items.AddChild(vItem, NO_DATA);

  vItem := tvBroswer.Items.AddChild(ANode, FLOPPY_DRIVES);
  tvBroswer.Items.AddChild(vItem, NO_DATA);

  vItem := tvBroswer.Items.AddChild(ANode, LOGICAL_DISKS);
  tvBroswer.Items.AddChild(vItem, NO_DATA);

  vItem := tvBroswer.Items.AddChild(ANode, PARTITIONS);
  tvBroswer.Items.AddChild(vItem, NO_DATA);

  vItem := tvBroswer.Items.AddChild(ANode, TAPES);
  tvBroswer.Items.AddChild(vItem, NO_DATA);

  Result := true;
end;

procedure TFrmMain.tvBroswerChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  ProcessChangingNode(Node);
end;


procedure TFrmMain.ProcessChangingNode(ANode: TTreeNode);
begin
  if ANode.Parent <> nil then
  begin
    if ANode.Parent.Text = DISKS then LoadDiskProperties(ANode)
      else
    if ANode.Parent.Text = TAPES then LoadTapeProperties(ANode)
      else
    if ANode.Parent.Text = FLOPPY_DRIVES then LoadFloppyProperties(ANode)
      else
    if ANode.Parent.Text = LOGICAL_DISKS then LoadLogicalDiskProperties(ANode)
      else
    if ANode.Parent.Text = PARTITIONS then LoadPartitionProperties(ANode)
      else
    if ANode.Parent.Text = CDROM_DRIVES then LoadCDROMProperties(ANode)
      else ClearPropertyViewView;
  end;
end;

procedure TFrmMain.AddPropertyItem(ACaption, AValue: widestring);
var vItem: TListItem;
begin
  vItem := lvProperties.Items.Add;
  vItem.Caption := ACaption;
  vItem.SubItems.Add(AValue);
end;

procedure TFrmMain.LoadDeviceProperties(ADrive: TWmiDevice);
begin
  AddPropertyItem('Caption', ADrive.Caption);
  AddPropertyItem('Description', ADrive.Description);
  AddPropertyItem('DeviceId', ADrive.DeviceId);
  AddPropertyItem('ErrorMethodology', ADrive.ErrorMethodology);
  if ADrive.InstallDate <> 0 then
     AddPropertyItem('InstallDate', DateToStr(ADrive.InstallDate));
  AddPropertyItem('Plug&PlayDeviceID', ADrive.PNPDeviceID);
  AddPropertyItem('Status', ADrive.Status);
end;

procedure TFrmMain.LoadCommonDriveProperties(ADrive: TWmiDriveBase);
var
  i: integer;
  s: string;
begin
  s := '';
  for i := 0 to ADrive.Capabilities.Count - 1 do
  begin
    s := s + ADrive.Capabilities[i];
    if i < ADrive.Capabilities.Count - 1 then s := s + ', ';
  end;
  AddPropertyItem('Capabilities', s);
  AddPropertyItem('Availability', GetAvailabilityDescription(ADrive.Availability));
  AddPropertyItem('Manufacturer', ADrive.Manufacturer);
  AddPropertyItem('Default Block Size', IntToStr(ADrive.DefaultBlockSize));
  AddPropertyItem('Compression Method', ADrive.CompressionMethod);
  AddPropertyItem('Max Block Size', IntToStr(ADrive.MaxBlockSize));
  AddPropertyItem('Min Block Size', IntToStr(ADrive.MinBlockSize));
  AddPropertyItem('Max Media Size', IntToStr(ADrive.MaxMediaSize));
  AddPropertyItem('Needs cleaning', BoolToStr(ADrive.NeedsCleaning));
end;

procedure TFrmMain.LoadDiskProperties(ANode: TTreeNode);
var
  vDiskDrive: TWmiDiskDrive;
begin
  lvProperties.Items.BeginUpdate;
  try
    ClearPropertyViewView;
    DoConnect(ANode.Parent.Parent); // The method needs a node that is a host.
    vDiskDrive := WmiStorageInfo1.DiskDrives[ANode.Index];
    LoadDeviceProperties(vDiskDrive);
    LoadCommonDriveProperties(vDiskDrive);
    AddPropertyItem('Bytes Per Sector', IntToStr(vDiskDrive.BytesPerSector));
    AddPropertyItem('Drive Index', IntToStr(vDiskDrive.DriveIndex));
    AddPropertyItem('Interface Type', vDiskDrive.InterfaceType);
    AddPropertyItem('Media Loaded', BoolToStr(vDiskDrive.MediaLoaded));
    AddPropertyItem('Model', vDiskDrive.Model);
    AddPropertyItem('Media Type', vDiskDrive.MediaType);
    AddPropertyItem('Partitions', IntToStr(vDiskDrive.Partitions));
    AddPropertyItem('SCSI Bus', IntToStr(vDiskDrive.SCSIBus));
    AddPropertyItem('SCSI Logical Unit', IntToStr(vDiskDrive.SCSILogicalUnit));
    AddPropertyItem('SCSI Target Id', IntToStr(vDiskDrive.SCSITargetId));
    AddPropertyItem('Sectors Per Track', IntToStr(vDiskDrive.SectorsPerTrack));
    AddPropertyItem('Signature', IntToStr(vDiskDrive.Signature));
    AddPropertyItem('Size', IntToStr(vDiskDrive.Size));
    AddPropertyItem('Total Cylinders', IntToStr(vDiskDrive.TotalCylinders));
    AddPropertyItem('Total Heads', IntToStr(vDiskDrive.TotalHeads));
    AddPropertyItem('Total Sectors', IntToStr(vDiskDrive.TotalSectors));
    AddPropertyItem('Total Tracks', IntToStr(vDiskDrive.TotalTracks));
    AddPropertyItem('Tracks Per Cylinder', IntToStr(vDiskDrive.TracksPerCylinder));

    lvProperties.SortType := stText;
  finally
    lvProperties.Items.EndUpdate;
  end;
end;

procedure TFrmMain.AddAccessPropertyItem(AAccess: word);
const ACCESS = 'Access';
begin
  case AAccess of
    DISK_ACCESS_READABLE:   AddPropertyItem(ACCESS, 'Readable');
    DISK_ACCESS_WRITABLE:   AddPropertyItem(ACCESS, 'Writable');
    DISK_ACCESS_READ_WRITE: AddPropertyItem(ACCESS, 'Read-write');
    DISK_ACCESS_WRITE_ONCE: AddPropertyItem(ACCESS, 'Wrice once');
  end;
end;

procedure TFrmMain.LoadPartitionProperties(ANode: TTreeNode);
var
  vPartition: TWmiPartition;
begin
  lvProperties.Items.BeginUpdate;
  try
    ClearPropertyViewView;
    DoConnect(ANode.Parent.Parent); // The method needs a node that is a host.
    vPartition := WmiStorageInfo1.Partitions[ANode.Index];
    LoadDeviceProperties(vPartition);

    AddAccessPropertyItem(vPartition.Access);
    AddPropertyItem('Block Size', IntToStr(vPartition.BlockSize));
    AddPropertyItem('Bootable', BoolToStr(vPartition.Bootable));
    AddPropertyItem('Boot Partition', BoolToStr(vPartition.BootPartition));
    AddPropertyItem('Disk Index', IntToStr(vPartition.DiskIndex));
    AddPropertyItem('Partition Index', IntToStr(vPartition.PartitionIndex));
    AddPropertyItem('Number Of Blocks', IntToStr(vPartition.NumberOfBlocks));
    AddPropertyItem('Primary Partition', BoolToStr(vPartition.PrimaryPartition));
    AddPropertyItem('Purpose', vPartition.Purpose);
    AddPropertyItem('Rewrite Partition', BoolToStr(vPartition.RewritePartition));
    AddPropertyItem('Size', IntToStr(vPartition.Size));
    AddPropertyItem('Starting Offset', IntToStr(vPartition.StartingOffset));
    AddPropertyItem('System Type', vPartition.SystemType);

    lvProperties.SortType := stText;
  finally
    lvProperties.Items.EndUpdate;
  end;
end;

procedure TFrmMain.LoadTapeProperties(ANode: TTreeNode);
var
  vTapeDrive: TWmiTapeDrive;
begin
  lvProperties.Items.BeginUpdate;
  try
    ClearPropertyViewView;
    DoConnect(ANode.Parent.Parent); // The method needs a node that is a host.
    vTapeDrive := WmiStorageInfo1.TapeDrives[ANode.Index];
    LoadDeviceProperties(vTapeDrive);
    LoadCommonDriveProperties(vTapeDrive);

    AddPropertyItem('Compression', BoolToStr(vTapeDrive.Compression));
    AddPropertyItem('ECC', BoolToStr(vTapeDrive.ECC));
    AddPropertyItem('EOT Warning Zone Size', IntToStr(vTapeDrive.EOTWarningZoneSize));
    AddPropertyItem('Tape Drive ID', vTapeDrive.TapeDriveID);
    AddPropertyItem('Max Partition Count', IntToStr(vTapeDrive.MaxPartitionCount));
    AddPropertyItem('Media Type', vTapeDrive.MediaType);
    AddPropertyItem('Padding', IntToStr(vTapeDrive.Padding));
    AddPropertyItem('Report Set Marks', BoolToStr(vTapeDrive.ReportSetMarks));

    lvProperties.SortType := stText;
  finally
    lvProperties.Items.EndUpdate;
  end;
end;

procedure TFrmMain.LoadFloppyProperties(ANode: TTreeNode);
var
  vFloppyDrive: TWmiFloppyDrive;
begin
  lvProperties.Items.BeginUpdate;
  try
    ClearPropertyViewView;
    DoConnect(ANode.Parent.Parent); // The method needs a node that is a host.
    vFloppyDrive := WmiStorageInfo1.FloppyDrives[ANode.Index];
    LoadDeviceProperties(vFloppyDrive);
    LoadCommonDriveProperties(vFloppyDrive);
    lvProperties.SortType := stText;
  finally
    lvProperties.Items.EndUpdate;
  end;
end;

procedure TFrmMain.LoadLogicalDiskProperties(ANode: TTreeNode);
var
  vDisk: TWmiLogicalDisk;
begin
  lvProperties.Items.BeginUpdate;
  try
    ClearPropertyViewView;
    DoConnect(ANode.Parent.Parent); // The method needs a node that is a host.
    vDisk := WmiStorageInfo1.LogicalDisks[ANode.Index];
    LoadDeviceProperties(vDisk);
    AddAccessPropertyItem(vDisk.Access);
    AddPropertyItem('Block Size', IntToStr(vDisk.BlockSize));
    AddPropertyItem('Compressed', BoolToStr(vDisk.Compressed));
    AddPropertyItem('Drive Type', DriveTypeToStr(vDisk.DriveType));
    AddPropertyItem('FileSystem', vDisk.FileSystem);
    AddPropertyItem('FreeSpace', IntToStr(vDisk.FreeSpace));
    AddPropertyItem('Maximum Component Length', IntToStr(vDisk.MaximumComponentLength));
    AddPropertyItem('Media Type', MediaTypeToStr(vDisk.MediaType));
    AddPropertyItem('Number Of Blocks', IntToStr(vDisk.NumberOfBlocks));
    AddPropertyItem('Provider Name', vDisk.ProviderName);
    AddPropertyItem('Purpose', vDisk.Purpose);
    AddPropertyItem('Quotas Disabled', BoolToStr(vDisk.QuotasDisabled));
    AddPropertyItem('Quotas Incomplete', BoolToStr(vDisk.QuotasIncomplete));
    AddPropertyItem('Quotas Rebuilding', BoolToStr(vDisk.QuotasRebuilding));
    AddPropertyItem('Size', IntToStr(vDisk.Size));
    AddPropertyItem('Supports Disk Quotas', BoolToStr(vDisk.SupportsDiskQuotas));
    AddPropertyItem('Supports File Based Compression', BoolToStr(vDisk.SupportsFileBasedCompression));
    AddPropertyItem('VolumeDirty', BoolToStr(vDisk.VolumeDirty));
    AddPropertyItem('VolumeName', vDisk.VolumeName);
    AddPropertyItem('VolumeSerialNumber', vDisk.VolumeSerialNumber);

    lvProperties.SortType := stText;
  finally
    lvProperties.Items.EndUpdate;
  end;
end;

procedure TFrmMain.LoadCDROMProperties(ANode: TTreeNode);
var
  vCDROMDrive: TWmiCDROMDrive;
begin
  lvProperties.Items.BeginUpdate;
  try
    ClearPropertyViewView;
    DoConnect(ANode.Parent.Parent); // The method needs a node that is a host.
    vCDROMDrive := WmiStorageInfo1.CDROMDrives[ANode.Index];
    LoadDeviceProperties(vCDROMDrive);
    LoadCommonDriveProperties(vCDROMDrive);

    AddPropertyItem('Drive', vCDROMDrive.Drive);
    AddPropertyItem('Drive Integrity', BoolToStr(vCDROMDrive.DriveIntegrity));
    AddPropertyItem('FileSystemFlagsEx', FileSystemFlagsToStr(vCDROMDrive.FileSystemFlagsEx));
    AddPropertyItem('Drive Id', vCDROMDrive.DriveId);
    AddPropertyItem('Maximum Component Length', IntToStr(vCDROMDrive.MaximumComponentLength));
    AddPropertyItem('Media Loaded', BoolToStr(vCDROMDrive.MediaLoaded));
    AddPropertyItem('Media Type', vCDROMDrive.MediaType);
    AddPropertyItem('Manufacturer Assigned Revision Level', vCDROMDrive.MfrAssignedRevisionLevel);
    AddPropertyItem('Revision Level', vCDROMDrive.RevisionLevel);
    AddPropertyItem('SCSI Bus', IntToStr(vCDROMDrive.SCSIBus));
    AddPropertyItem('SCSI Logical Unit', IntToStr(vCDROMDrive.SCSILogicalUnit));
    AddPropertyItem('SCSI Port', IntToStr(vCDROMDrive.SCSIPort));
    AddPropertyItem('SCSI Target Id', IntToStr(vCDROMDrive.SCSITargetId));
    AddPropertyItem('Size', IntToStr(vCDROMDrive.Size));
    AddPropertyItem('TransferRate', FloatToStr(vCDROMDrive.TransferRate));
    AddPropertyItem('VolumeName', vCDROMDrive.VolumeName);
    AddPropertyItem('VolumeSerialNumber', vCDROMDrive.VolumeSerialNumber);

    lvProperties.SortType := stText;
  finally
    lvProperties.Items.EndUpdate;
  end;
end;

procedure TFrmMain.ClearPropertyViewView;
begin
  lvProperties.Items.BeginUpdate;
  try
    lvProperties.Items.Clear;
  finally
    lvProperties.Items.EndUpdate;
  end;  
end;

procedure TFrmMain.CreateNewNetworkNode;
var
  vForm: TFrmNewHost;
  vNode: TTreeNode;
begin
  vForm := TFrmNewHost.Create(nil);
  try
    while vForm.ShowModal = mrOk do
      try

        WmiStorageInfo1.Active := false;
        WmiStorageInfo1.Credentials.Clear;
        WmiStorageInfo1.MachineName := vForm.edtHostName.Text;
        WmiStorageInfo1.Credentials.UserName := vForm.UserName;
        WmiStorageInfo1.Credentials.Password := vForm.edtPassword.Text;
        WmiStorageInfo1.Active := true;

        // connected successfully; add the new host to a list.
        vNode := FindNeworkNode;
        if (vNode.getFirstChild <> nil) and
           (vNode.getFirstChild.Text = NO_DATA) then vNode.DeleteChildren;

        vNode := tvBroswer.Items.AddChild(vNode, vForm.edtHostName.Text);
        vNode.Data := TCredentials.Create(vForm.UserName, vForm.edtPassword.Text);
        AddStorageDeviceNodes(vNode);
        tvBroswer.Selected := vNode;
        Break;

      except
        on e: Exception do
          Application.MessageBox(PChar(e.Message), 'Error', ID_OK);
      end;
  finally
    vForm.Free;
  end;
end;

procedure TFrmMain.ToolButton1Click(Sender: TObject);
begin
  CreateNewNetworkNode;
end;

function TFrmMain.FindNeworkNode: TTreeNode;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to tvBroswer.Items.Count - 1 do
    if tvBroswer.Items[i].Text = NETWORK then
    begin
      Result := tvBroswer.Items[i];
      Exit;
    end;
end;

{ TCredentials }

constructor TCredentials.Create(AUserName, APassword: widestring);
begin
  inherited Create;
  FUserName := AUserName;
  FPassword := APassword;
end;

procedure TFrmMain.ToolButton3Click(Sender: TObject);
begin
  with TFrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
