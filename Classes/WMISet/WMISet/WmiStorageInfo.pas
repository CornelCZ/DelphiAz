unit WmiStorageInfo;

interface
{$I ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WmiAbstract, WbemScripting_TLB, ActiveX, ComObj, WmiErr, WmiUtil,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  WmiDevice, WmiComponent;

type
  TWmiDiskDrive = class;
  TWmiCDROMDrive = class;
  TWmiFloppyDrive = class;
  TWmiPartition = class;
  TWmiLogicalDisk = class;
  TWmiTapeDrive = class;

  TWmiCDROMDriveList = class;
  TWmiDiskDriveList = class;
  TWmiLogicalDiskList = class;
  TWmiPartitionList = class;
  TWmiFloppyDriveList = class;
  TWmiTapeDriveList = class;

  TWmiStorageInfo = class;

  TWmiDriveBase = class(TWmiDevice)
  private
    FNeedsCleaning: boolean;
    FNumberOfMediaSupported: DWORD;
    FDefaultBlockSize: int64;
    FMaxMediaSize: int64;
    FMinBlockSize: int64;
    FMaxBlockSize: int64;
    FManufacturer: widestring;
    FCompressionMethod: widestring;
    FCapabilities: TStrings;

    function  GetCapabilities: TStrings;
    procedure SetCapabilities(const Value: TStrings);
    procedure SetCompressionMethod(const Value: widestring);
    procedure SetManufacturer(const Value: widestring);
    procedure SetNeedsCleaning(const Value: boolean);
    procedure SetNumberOfMediaSupported(const Value: DWORD);
    procedure SetDefaultBlockSize(const Value: int64);
    procedure SetMaxBlockSize(const Value: int64);
    procedure SetMaxMediaSize(const Value: int64);
    procedure SetMinBlockSize(const Value: int64);
  protected
    procedure LoadProperties(ADrive: ISWbemObject); override;
  public
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList;
                       AInternallyCreated: boolean;
                       AClass: TWmiEntityListClass); reintroduce;
    destructor Destroy; override;                   
    {$WARNINGS ON} {$HINTS ON}
  published
    property    Capabilities: TStrings read GetCapabilities write SetCapabilities;
    property    Manufacturer: widestring read FManufacturer write SetManufacturer;
    property    DefaultBlockSize: int64 read FDefaultBlockSize write SetDefaultBlockSize;
    property    CompressionMethod: widestring read FCompressionMethod write SetCompressionMethod;
    property    MaxBlockSize: int64 read FMaxBlockSize write SetMaxBlockSize;
    property    MinBlockSize: int64 read FMinBlockSize write SetMinBlockSize;
    property    MaxMediaSize: int64 read FMaxMediaSize write SetMaxMediaSize;
    property    NeedsCleaning: boolean read FNeedsCleaning write SetNeedsCleaning;
    property    NumberOfMediaSupported: DWORD read FNumberOfMediaSupported write SetNumberOfMediaSupported;
  end;

  TWmiTapeDrive = class(TWmiDriveBase)
  private
    FECC: boolean;
    FCompression: boolean;
    FReportSetMarks: boolean;
    FEOTWarningZoneSize: DWORD;
    FFeaturesLow: DWORD;
    FMaxPartitionCount: DWORD;
    FFeaturesHigh: DWORD;
    FPadding: DWORD;
    FTapeDriveID: widestring;
    FMediaType: widestring;

    procedure SetCompression(const Value: boolean);
    procedure SetECC(const Value: boolean);
    procedure SetEOTWarningZoneSize(const Value: DWORD);
    procedure SetFeaturesHigh(const Value: DWORD);
    procedure SetFeaturesLow(const Value: DWORD);
    procedure SetMaxPartitionCount(const Value: DWORD);
    procedure SetMediaType(const Value: widestring);
    procedure SetPadding(const Value: DWORD);
    procedure SetReportSetMarks(const Value: boolean);
    procedure SetTapeDriveID(const Value: widestring);
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure   LoadProperties(ATapeDrive: ISWbemObject); override;
  public
    procedure   Refresh; override;
  published
    property    Compression: boolean read FCompression write SetCompression;
    property    ECC: boolean read FECC write SetECC;
    property    EOTWarningZoneSize: DWORD read FEOTWarningZoneSize write SetEOTWarningZoneSize;
    property    FeaturesHigh: DWORD read FFeaturesHigh write SetFeaturesHigh;
    property    FeaturesLow: DWORD read FFeaturesLow write SetFeaturesLow;
    property    TapeDriveID: widestring read FTapeDriveID write SetTapeDriveID;
    property    MaxPartitionCount: DWORD read FMaxPartitionCount write SetMaxPartitionCount;
    property    MediaType: widestring read FMediaType write SetMediaType;
    property    Padding: DWORD read FPadding write SetPadding;
    property    ReportSetMarks: boolean read FReportSetMarks write SetReportSetMarks;
  end;

  TWmiTapeDriveList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiTapeDrive;
    procedure SetItem(AIndex: integer; const Value: TWmiTapeDrive);
  protected
  public
    property Items[AIndex: integer]: TWmiTapeDrive read GetItem write SetItem; default; 
  end;

  TWmiFloppyDrive = class(TWmiDriveBase)
  private
  protected
  public
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure   Refresh; override;
  published
  end;

  TWmiFloppyDriveList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiFloppyDrive;
    procedure SetItem(AIndex: integer; const Value: TWmiFloppyDrive);
  protected
  public
    property Items[AIndex: integer]: TWmiFloppyDrive read GetItem write SetItem; default; 
  end;

  TWmiCDROMDrive = class(TWmiDriveBase)
  private
    FMediaLoaded: boolean;
    FDriveIntegrity: boolean;
    FSCSIBus: DWORD;
    FMaximumComponentLength: DWORD;
    FFileSystemFlagsEx: DWORD;
    FSize: int64;
    FTransferRate: double;
    FDrive: widestring;
    FMfrAssignedRevisionLevel: widestring;
    FVolumeSerialNumber: widestring;
    FMediaType: widestring;
    FDriveId: widestring;
    FVolumeName: widestring;
    FRevisionLevel: widestring;
    FSCSILogicalUnit: word;
    FSCSIPort: word;
    FSCSITargetId: word;

    procedure SetDrive(const Value: widestring);
    procedure SetDriveId(const Value: widestring);
    procedure SetDriveIntegrity(const Value: boolean);
    procedure SetFileSystemFlagsEx(const Value: DWORD);
    procedure SetMaximumComponentLength(const Value: DWORD);
    procedure SetMediaLoaded(const Value: boolean);
    procedure SetMediaType(const Value: widestring);
    procedure SetMfrAssignedRevisionLevel(const Value: widestring);
    procedure SetRevisionLevel(const Value: widestring);
    procedure SetSCSIBus(const Value: DWORD);
    procedure SetSCSILogicalUnit(const Value: word);
    procedure SetSCSIPort(const Value: word);
    procedure SetSCSITargetId(const Value: word);
    procedure SetSize(const Value: int64);
    procedure SetTransferRate(const Value: double);
    procedure SetVolumeName(const Value: widestring);
    procedure SetVolumeSerialNumber(const Value: widestring);
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure   LoadProperties(ADrive: ISWbemObject); override;
  public
    procedure   Refresh; override;
  published
    property    Drive: widestring read FDrive write SetDrive;
    property    DriveIntegrity: boolean read  FDriveIntegrity write SetDriveIntegrity;
    property    FileSystemFlagsEx: DWORD read FFileSystemFlagsEx write SetFileSystemFlagsEx;
    property    DriveId: widestring read FDriveId write SetDriveId;
    property    MaximumComponentLength: DWORD read FMaximumComponentLength write SetMaximumComponentLength;
    property    MediaLoaded: boolean read FMediaLoaded write SetMediaLoaded;
    property    MediaType: widestring read FMediaType write SetMediaType;
    property    MfrAssignedRevisionLevel: widestring read FMfrAssignedRevisionLevel write SetMfrAssignedRevisionLevel;
    property    RevisionLevel: widestring read FRevisionLevel write SetRevisionLevel;
    property    SCSIBus: DWORD read FSCSIBus write SetSCSIBus;
    property    SCSILogicalUnit: word read FSCSILogicalUnit write SetSCSILogicalUnit;
    property    SCSIPort: word read FSCSIPort write SetSCSIPort;
    property    SCSITargetId: word read FSCSITargetId write SetSCSITargetId;
    property    Size: int64 read FSize write SetSize;
    property    TransferRate: double read FTransferRate write SetTransferRate;
    property    VolumeName: widestring read FVolumeName write SetVolumeName;
    property    VolumeSerialNumber: widestring read FVolumeSerialNumber write SetVolumeSerialNumber;
  end;

  TWmiCDROMDriveList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiCDROMDrive;
    procedure SetItem(AIndex: integer; const Value: TWmiCDROMDrive);
  protected
  public
    property Items[AIndex: integer]: TWmiCDROMDrive read GetItem write SetItem; default; 
  end;

  TWmiDiskDrive = class(TWmiDriveBase)
  private
    FMediaLoaded: boolean;
    FSignature: DWORD;
    FTotalHeads: DWORD;
    FTracksPerCylinder: DWORD;
    FBytesPerSector: DWORD;
    FSCSIBus: DWORD;
    FPartitions: DWORD;
    FSectorsPerTrack: DWORD;
    FTotalCylinders: int64;
    FTotalTracks: int64;
    FTotalSectors: int64;
    FSize: int64;
    FDriveIndex: integer;
    FInterfaceType: widestring;
    FModel: widestring;
    FMediaType: widestring;
    FSCSITargetId: word;
    FSCSIPort: word;
    FSCSILogicalUnit: word;

    procedure SetBytesPerSector(const Value: DWORD);
    procedure SetDriveIndex(const Value: integer);
    procedure SetInterfaceType(const Value: widestring);
    procedure SetMediaLoaded(const Value: boolean);
    procedure SetMediaType(const Value: widestring);
    procedure SetModel(const Value: widestring);
    procedure SetPartitions(const Value: DWORD);
    procedure SetSCSIBus(const Value: DWORD);
    procedure SetSCSILogicalUnit(const Value: word);
    procedure SetSCSIPort(const Value: word);
    procedure SetSCSITargetId(const Value: word);
    procedure SetSectorsPerTrack(const Value: DWORD);
    procedure SetSignature(const Value: DWORD);
    procedure SetSize(const Value: int64);
    procedure SetTotalCylinders(const Value: int64);
    procedure SetTotalHeads(const Value: DWORD);
    procedure SetTotalSectors(const Value: int64);
    procedure SetTotalTracks(const Value: int64);
    procedure SetTracksPerCylinder(const Value: DWORD);
  protected
    procedure   LoadProperties(ADiskDrive: ISWbemObject); override;
  public
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure   Refresh; override;
    destructor  Destroy; override;
  published
    property    BytesPerSector: DWORD read FBytesPerSector write SetBytesPerSector;
    property    DriveIndex: integer read FDriveIndex write SetDriveIndex;
    property    InterfaceType: widestring read FInterfaceType write SetInterfaceType;
    property    MediaLoaded: boolean read FMediaLoaded write SetMediaLoaded;
    property    MediaType: widestring read FMediaType write SetMediaType;
    property    Model: widestring read FModel write SetModel;
    property    Partitions: DWORD read FPartitions write SetPartitions;
    property    SCSIBus: DWORD read FSCSIBus write SetSCSIBus;
    property    SCSILogicalUnit: word read FSCSILogicalUnit write SetSCSILogicalUnit;
    property    SCSIPort: word read FSCSIPort write SetSCSIPort;
    property    SCSITargetId: word read FSCSITargetId write SetSCSITargetId;
    property    SectorsPerTrack: DWORD read FSectorsPerTrack write SetSectorsPerTrack;
    property    Signature: DWORD read FSignature write SetSignature;
    property    Size: int64 read FSize write SetSize;
    property    TotalCylinders: int64 read FTotalCylinders write SetTotalCylinders;
    property    TotalHeads: DWORD read FTotalHeads write SetTotalHeads;
    property    TotalSectors: int64 read FTotalSectors write SetTotalSectors;
    property    TotalTracks: int64 read FTotalTracks write SetTotalTracks;
    property    TracksPerCylinder: DWORD read FTracksPerCylinder write SetTracksPerCylinder;      
  end;

  TWmiDiskDriveList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiDiskDrive;
    procedure SetItem(AIndex: integer; const Value: TWmiDiskDrive);
  protected
  public
    property Items[AIndex: integer]: TWmiDiskDrive read GetItem write SetItem; default; 
  end;

  TWmiLogicalDiskList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiLogicalDisk;
    procedure SetItem(AIndex: integer; const Value: TWmiLogicalDisk);
  protected
  public
    property Items[AIndex: integer]: TWmiLogicalDisk read GetItem write SetItem; default; 
  end;

  TWmiLogicalDisk = class(TWmiDevice)
  private
    FQuotasDisabled: boolean;
    FSupportsFileBasedCompression: boolean;
    FQuotasRebuilding: boolean;
    FQuotasIncomplete: boolean;
    FVolumeDirty: boolean;
    FSupportsDiskQuotas: boolean;
    FCompressed: boolean;
    FDriveType: DWORD;
    FMediaType: DWORD;
    FMaximumComponentLength: DWORD;
    FFreeSpace: int64;
    FBlockSize: int64;
    FSize: int64;
    FNumberOfBlocks: int64;
    FFileSystem: widestring;
    FVolumeSerialNumber: widestring;
    FPurpose: widestring;
    FVolumeName: widestring;
    FProviderName: widestring;
    FAccess: word;
    procedure SetAccess(const Value: word);
    procedure SetBlockSize(const Value: int64);
    procedure SetCompressed(const Value: boolean);
    procedure SetDriveType(const Value: DWORD);
    procedure SetFileSystem(const Value: widestring);
    procedure SetFreeSpace(const Value: int64);
    procedure SetMaximumComponentLength(const Value: DWORD);
    procedure SetMediaType(const Value: DWORD);
    procedure SetNumberOfBlocks(const Value: int64);
    procedure SetProviderName(const Value: widestring);
    procedure SetPurpose(const Value: widestring);
    procedure SetQuotasDisabled(const Value: boolean);
    procedure SetQuotasRebuilding(const Value: boolean);
    procedure SetSize(const Value: int64);
    procedure SetSupportsDiskQuotas(const Value: boolean);
    procedure SetSupportsFileBasedCompression(const Value: boolean);
    procedure SetVolumeDirty(const Value: boolean);
    procedure SetVolumeName(const Value: widestring);
    procedure SetVolumeSerialNumber(const Value: widestring);
    procedure SetQuotasIncomplete(const Value: boolean);
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure LoadProperties(ALogicalDisk: ISWbemObject); override;
  public
    procedure   Refresh; override;
    destructor  Destroy; override;
  published
    property    Access: word read FAccess write SetAccess;
    property    BlockSize: int64 read FBlockSize write SetBlockSize;
    property    Compressed: boolean read FCompressed write SetCompressed;
    property    DriveType: DWORD read FDriveType write SetDriveType;
    property    FileSystem: widestring read FFileSystem write SetFileSystem;
    property    FreeSpace: int64 read FFreeSpace write SetFreeSpace;
    property    MaximumComponentLength: DWORD read FMaximumComponentLength write SetMaximumComponentLength;
    property    MediaType: DWORD read FMediaType write SetMediaType;
    property    NumberOfBlocks: int64 read FNumberOfBlocks write SetNumberOfBlocks;
    property    ProviderName: widestring read FProviderName write SetProviderName;
    property    Purpose: widestring read FPurpose write SetPurpose;
    property    QuotasDisabled: boolean read FQuotasDisabled write SetQuotasDisabled;
    property    QuotasIncomplete: boolean read FQuotasIncomplete write SetQuotasIncomplete;
    property    QuotasRebuilding: boolean read FQuotasRebuilding write SetQuotasRebuilding;
    property    Size: int64 read FSize write SetSize;
    property    SupportsDiskQuotas: boolean read FSupportsDiskQuotas write SetSupportsDiskQuotas;
    property    SupportsFileBasedCompression: boolean read FSupportsFileBasedCompression write SetSupportsFileBasedCompression;
    property    VolumeDirty: boolean read FVolumeDirty write SetVolumeDirty;
    property    VolumeName: widestring read FVolumeName write SetVolumeName;
    property    VolumeSerialNumber: widestring read FVolumeSerialNumber write SetVolumeSerialNumber;
  end;

  TWmiPartitionList = class(TWmiEntityList)
  private
    function  GetItem(AIndex: integer): TWmiPartition;
    procedure SetItem(AIndex: integer; const Value: TWmiPartition);
  protected
  public
    function Add(): TWmiPartition; overload;
    property Items[AIndex: integer]: TWmiPartition read GetItem write SetItem; default; 
  end;

  TWmiPartition = class(TWmiDevice)
  private
    FRewritePartition: boolean;
    FBootPartition: boolean;
    FPrimaryPartition: boolean;
    FBootable: boolean;
    FDiskIndex: DWORD;
    FPartitionIndex: DWORD;
    FHiddenSectors: DWORD;
    FSize: int64;
    FNumberOfBlocks: int64;
    FStartingOffset: int64;
    FBlockSize: integer;
    FSystemType: widestring;
    FPurpose: widestring;
    FAccess: word;
    procedure SetAccess(const Value: word);
    procedure SetBlockSize(const Value: integer);
    procedure SetBootable(const Value: boolean);
    procedure SetBootPartition(const Value: boolean);
    procedure SetDiskIndex(const Value: DWORD);
    procedure SetHiddenSectors(const Value: DWORD);
    procedure SetNumberOfBlocks(const Value: int64);
    procedure SetPartitionIndex(const Value: DWORD);
    procedure SetPrimaryPartition(const Value: boolean);
    procedure SetPurpose(const Value: widestring);
    procedure SetRewritePartition(const Value: boolean);
    procedure SetSize(const Value: int64);
    procedure SetStartingOffset(const Value: int64);
    procedure SetSystemType(const Value: widestring);
  protected
    {$HINTS OFF} {$WARNINGS OFF}
    constructor Create(AOwner: TWmiEntityList); reintroduce;
    {$WARNINGS ON} {$HINTS ON}
    procedure LoadProperties(APartition: ISWbemObject); override;
  public
    destructor  Destroy; override;
    procedure   Refresh; override;
  published
    property    Access: word read FAccess write SetAccess;
    property    BlockSize: integer read FBlockSize write SetBlockSize;
    property    Bootable: boolean read FBootable write SetBootable;
    property    BootPartition: boolean read FBootPartition write SetBootPartition;
    property    DiskIndex: DWORD read FDiskIndex write SetDiskIndex;
    property    HiddenSectors: DWORD read FHiddenSectors write SetHiddenSectors;
    property    PartitionIndex: DWORD read FPartitionIndex write SetPartitionIndex;
    property    NumberOfBlocks: int64 read FNumberOfBlocks write SetNumberOfBlocks;
    property    PrimaryPartition: boolean read FPrimaryPartition write SetPrimaryPartition;
    property    Purpose: widestring read FPurpose write SetPurpose;
    property    RewritePartition: boolean read FRewritePartition write SetRewritePartition;
    property    Size: int64 read FSize write SetSize;
    property    StartingOffset: int64 read FStartingOffset write SetStartingOffset;
    property    SystemType: widestring read FSystemType write SetSystemType;
  end;

  TWmiStorageInfo = class(TWmiComponent)
  private
    { Private declarations }
    FPartitions:   TWmiPartitionList;
    FLogicalDisks: TWmiLogicalDiskList;
    FDiskDrives:   TWmiDiskDriveList;
    FCDROMDrives:  TWmiCDROMDriveList;
    FFloppyDrives: TWmiFloppyDriveList;
    FTapeDrives:   TWmiTapeDriveList;
    FOnFloppyDriveChanged: TWmiDeviceEvent;
    FOnLogicalDiskChanged: TWmiDeviceEvent;
    FOnDiskDriveChanged: TWmiDeviceEvent;
    FOnCDROMDriveChanged: TWmiDeviceEvent;
    FOnTapeDriveChanged: TWmiDeviceEvent;
    FOnPartitionChanged: TWmiDeviceEvent;

    function  GetPartitions: TWmiPartitionList;
    procedure SetPartitions(const Value: TWmiPartitionList);
    function  GetLogicalDisks: TWmiLogicalDiskList;
    procedure SetLogicalDisks(const Value: TWmiLogicalDiskList);
    function  GetDiskDrives: TWmiDiskDriveList;
    procedure SetDiskDrives(const Value: TWmiDiskDriveList);
    procedure SetCDROMDrives(const Value: TWmiCDROMDriveList);
    function  GetCDROMDrives: TWmiCDROMDriveList;
    function  GetFloppyDrives: TWmiFloppyDriveList;
    procedure SetFloppyDrives(const Value: TWmiFloppyDriveList);
    function  GetTapeDrives: TWmiTapeDriveList;
    procedure SetTapeDrives(const Value: TWmiTapeDriveList);

    procedure LoadTapeDrives;
    procedure LoadCDROMDisks;
    procedure LoadDiskDrives;
    procedure LoadLogicalDisks;
    procedure LoadPartitions;
    procedure LoadFloppyDrives;

    procedure DriveChanged(Sender: TObject; Event: OleVariant; AHandler: TWmiDeviceEvent);
    procedure FloppyDriveChanged(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure DiskDriveChanged(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure PartitionChanged(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure LogicalDiskChanged(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure CDROMDriveChanged(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
    procedure TapeDriveChanged(Sender: TObject; EventInfo: TEventInfoHolder; Event: OleVariant);
  protected
    // this method is called when user's credential's changed
    procedure CredentialsOrTargetChanged; override;
    procedure RegisterEvents; override;
    procedure SetActive(Value: boolean); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    { Published declarations }
    property    Active;
    property    Credentials;
    property    MachineName;
    property    SystemInfo;

    property    Partitions: TWmiPartitionList read GetPartitions write SetPartitions stored false;
    property    LogicalDisks: TWmiLogicalDiskList read GetLogicalDisks write SetLogicalDisks stored false;
    property    DiskDrives: TWmiDiskDriveList read GetDiskDrives write SetDiskDrives stored false;
    property    CDROMDrives: TWmiCDROMDriveList read GetCDROMDrives write SetCDROMDrives stored false;
    property    FloppyDrives: TWmiFloppyDriveList read GetFloppyDrives write SetFloppyDrives stored false;
    property    TapeDrives: TWmiTapeDriveList read GetTapeDrives write SetTapeDrives stored false;

    property    OnFloppyDriveChanged: TWmiDeviceEvent read FOnFloppyDriveChanged write FOnFloppyDriveChanged;
    property    OnDiskDriveChanged: TWmiDeviceEvent read FOnDiskDriveChanged write FOnDiskDriveChanged;
    property    OnPartitionChanged: TWmiDeviceEvent read FOnPartitionChanged write FOnPartitionChanged;
    property    OnLogicalDiskChanged: TWmiDeviceEvent read FOnLogicalDiskChanged write FOnLogicalDiskChanged;
    property    OnCDROMDriveChanged: TWmiDeviceEvent read FOnCDROMDriveChanged write FOnCDROMDriveChanged;
    property    OnTapeDriveChanged: TWmiDeviceEvent read FOnTapeDriveChanged write FOnTapeDriveChanged;
  end;

const

  // logical disk access
  DISK_ACCESS_UNKNOWN = 0;
  DISK_ACCESS_READABLE = 1;
  DISK_ACCESS_WRITABLE = 2;
  DISK_ACCESS_READ_WRITE = 3;
  DISK_ACCESS_WRITE_ONCE = 4;

  // Drive Type for logical disks
  DT_UNKNOWN = 0;       
  DT_NO_ROOT_DIRECTORY = 1;
  DT_REMOVABLE_DISK = 2;
  DT_LOCAL_DISK = 3;
  DT_NETWORK_DRIVE = 4;
  DT_COMPACT_DISK = 5;
  DT_RAM_DISK = 6;

  // Disk drive's capabilities
  DDC_UNKNOWN = 0;                     // Unknown
  DDC_OTHER = 1;                       // Other
  DDC_SEQUENTIAL_ACCESS = 2;           // Sequential Access
  DDC_RANDOM_ACCESS = 3;               // Random Access
  DDC_SUPPORTS_WRITING = 4;            // Supports Writing
  DDC_ENCRYPTION = 5;                  // Encryption
  DDC_COMPRESSION = 6;                 // Compression
  DDC_SUPPORTS_REMOVABLE_MEDIA = 7;    // Supports Removable Media
  DDC_MANUAL_CLEANING = 8;             // Manual Cleaning
  DDC_AUTOMATIC_CLEANING = 9;          // Automatic Cleaning
  DDC_SMART_NOTIFICATION = 10;         // SMART Notification
  DDC_SUPPORTS_DUAL_SIDED_MEDIA = 11;  // Supports Dual Sided Media
  DDC_PRIOR_EJECTION_NOT_REQUIRED = 12;//Ejection Prior to Drive Dismount Not Required


  // Logical's disk media type
  MT_UNKNOWN     = 0;  // Format is unknown
  MT_F5_1Pt2_512 = 1;  // 51/4-Inch Floppy Disk - 1.2Mb - 512 bytes/sector
  MT_F3_1Pt44_512 = 2; // 31/2-Inch Floppy Disk - 1.44Mb -512 bytes/sector
  MT_F3_2Pt88_512 = 3; // 31/2-Inch Floppy Disk - 2.88Mb - 512 bytes/sector
  MT_F3_20Pt8_512 = 4; // 31/2-Inch Floppy Disk - 20.8Mb - 512 bytes/sector
  MT_F3_720_512 = 5;   // 31/2-Inch Floppy Disk - 720Kb - 512 bytes/sector
  MT_F5_360_512 = 6;   // 51/4-Inch Floppy Disk - 360Kb - 512 bytes/sector
  MT_F5_320_512 = 7;   // 51/4-Inch Floppy Disk - 320Kb - 512 bytes/sector
  MT_F5_320_1024 = 8;  // 51/4-Inch Floppy Disk - 320Kb - 1024 bytes/sector
  MT_F5_180_512 = 9;   // 51/4-Inch Floppy Disk - 180Kb - 512 bytes/sector
  MT_F5_160_512 = 10;  // 51/4-Inch Floppy Disk - 160Kb - 512 bytes/sector
  MT_REMOVABLE = 11;   // Removable media other than floppy
  MT_FIXED = 12;       // hard disk media
  MT_F3_120M_512 = 13; //  31/2-Inch Floppy Disk - 120Mb - 512 bytes/sector
  MT_F3_640_512 = 14;  // 31/2-Inch Floppy Disk - 640Kb - 512 bytes/sector
  MT_F5_640_512 = 15;  // 51/4-Inch Floppy Disk - 640Kb - 512 bytes/sector
  MT_F5_720_512 = 16;  // 51/4-Inch Floppy Disk - 720Kb - 512 bytes/sector
  MT_F3_1Pt2_512 = 17; // 31/2-Inch Floppy Disk - 1.2Mb - 512 bytes/sector
  MT_F3_1Pt23_1024 = 18; // 31/2-Inch Floppy Disk - 1.23Mb - 1024 bytes/sector
  MT_F5_1Pt23_1024 = 19; // 51/4-Inch Floppy Disk - 1.23Mb - 1024 bytes/sector
  MT_F3_128Mb_512 = 20;  // 31/2-Inch Floppy Disk - 128Mb - 512 bytes/sector
  MT_F3_230Mb_512 = 21;  // 31/2-Inch Floppy Disk - 230Mb - 512 bytes/sector
  MT_F8_256_128 = 22;    // 8-Inch Floppy Disk - 256Kb - 128 bytes/sector

  // File System Flags Extended constants
  FSF_CASE_SENSITIVE_SEARCH =   $00001;
  FSF_CASE_PRESERVED_NAMES =    $00002;
  FSF_UNICODE_ON_DISK =         $00004;
  FSF_PERSISTENT_ACLS =         $00008;
  FSF_FILE_COMPRESSION =        $00010;
  FSF_VOLUME_QUOTAS =           $00020;
  FSF_SUPPORTS_SPARSE_FILES =   $00040;
  FSF_SUPPORTS_REPARSE_POINTS = $00080;
  FSF_SUPPORTS_REMOTE_STORAGE = $00100;
  FSF_SUPPORTS_LONG_NAMES =     $04000;
  FSF_VOLUME_IS_COMPRESSED =    $08000;
  FSF_SUPPORTS_OBJECT_IDS =     $10000;
  FSF_SUPPORTS_ENCRYPTION =     $20000;
  FSF_SUPPORTS_NAMED_STREAMS =  $40000;
  FSF_UNKNOWN                =  $80000;  // I saw this flag set.

  // tape drive features high
  {$EXTERNALSYM TAPE_DRIVE_LOAD_UNLOAD}
  TAPE_DRIVE_LOAD_UNLOAD      = $80000001;
  {$EXTERNALSYM TAPE_DRIVE_TENSION}
  TAPE_DRIVE_TENSION          = $80000002;
  {$EXTERNALSYM TAPE_DRIVE_LOCK_UNLOCK}
  TAPE_DRIVE_LOCK_UNLOCK      = $80000004;
  {$EXTERNALSYM TAPE_DRIVE_REWIND_IMMEDIATE}
  TAPE_DRIVE_REWIND_IMMEDIATE = $80000008;
  {$EXTERNALSYM TAPE_DRIVE_SET_BLOCK_SIZE}
  TAPE_DRIVE_SET_BLOCK_SIZE   = $80000010;
  {$EXTERNALSYM TAPE_DRIVE_LOAD_UNLD_IMMED}
  TAPE_DRIVE_LOAD_UNLD_IMMED  = $80000020;
  {$EXTERNALSYM TAPE_DRIVE_TENSION_IMMED}
  TAPE_DRIVE_TENSION_IMMED    = $80000040;
  {$EXTERNALSYM TAPE_DRIVE_LOCK_UNLK_IMMED}
  TAPE_DRIVE_LOCK_UNLK_IMMED  = $80000080;
  {$EXTERNALSYM TAPE_DRIVE_SET_ECC}
  TAPE_DRIVE_SET_ECC          = $80000100;
  {$EXTERNALSYM TAPE_DRIVE_SET_COMPRESSION}
  TAPE_DRIVE_SET_COMPRESSION  = $80000200;
  {$EXTERNALSYM TAPE_DRIVE_SET_PADDING}
  TAPE_DRIVE_SET_PADDING      = $80000400;
  {$EXTERNALSYM TAPE_DRIVE_SET_REPORT_SMKS}
  TAPE_DRIVE_SET_REPORT_SMKS  = $80000800;
  {$EXTERNALSYM TAPE_DRIVE_ABSOLUTE_BLK}
  TAPE_DRIVE_ABSOLUTE_BLK     = $80001000;
  {$EXTERNALSYM TAPE_DRIVE_ABS_BLK_IMMED}
  TAPE_DRIVE_ABS_BLK_IMMED    = $80002000;
  {$EXTERNALSYM TAPE_DRIVE_LOGICAL_BLK}
  TAPE_DRIVE_LOGICAL_BLK      = $80004000;
  {$EXTERNALSYM TAPE_DRIVE_LOG_BLK_IMMED}
  TAPE_DRIVE_LOG_BLK_IMMED    = $80008000;
  {$EXTERNALSYM TAPE_DRIVE_END_OF_DATA}
  TAPE_DRIVE_END_OF_DATA      = $80010000;
  {$EXTERNALSYM TAPE_DRIVE_RELATIVE_BLKS}
  TAPE_DRIVE_RELATIVE_BLKS    = $80020000;
  {$EXTERNALSYM TAPE_DRIVE_FILEMARKS}
  TAPE_DRIVE_FILEMARKS        = $80040000;
  {$EXTERNALSYM TAPE_DRIVE_SEQUENTIAL_FMKS}
  TAPE_DRIVE_SEQUENTIAL_FMKS  = $80080000;
  {$EXTERNALSYM TAPE_DRIVE_SETMARKS}
  TAPE_DRIVE_SETMARKS         = $80100000;
  {$EXTERNALSYM TAPE_DRIVE_SEQUENTIAL_SMKS}
  TAPE_DRIVE_SEQUENTIAL_SMKS  = $80200000;
  {$EXTERNALSYM TAPE_DRIVE_REVERSE_POSITION}
  TAPE_DRIVE_REVERSE_POSITION = $80400000;
  {$EXTERNALSYM TAPE_DRIVE_SPACE_IMMEDIATE}
  TAPE_DRIVE_SPACE_IMMEDIATE  = $80800000;
  {$EXTERNALSYM TAPE_DRIVE_WRITE_SETMARKS}
  TAPE_DRIVE_WRITE_SETMARKS   = $81000000;
  {$EXTERNALSYM TAPE_DRIVE_WRITE_FILEMARKS}
  TAPE_DRIVE_WRITE_FILEMARKS  = $82000000;
  {$EXTERNALSYM TAPE_DRIVE_WRITE_SHORT_FMKS}
  TAPE_DRIVE_WRITE_SHORT_FMKS = $84000000;
  {$EXTERNALSYM TAPE_DRIVE_WRITE_LONG_FMKS}
  TAPE_DRIVE_WRITE_LONG_FMKS  = $88000000;
  {$EXTERNALSYM TAPE_DRIVE_WRITE_MARK_IMMED}
  TAPE_DRIVE_WRITE_MARK_IMMED = $90000000;
  {$EXTERNALSYM TAPE_DRIVE_FORMAT}
  TAPE_DRIVE_FORMAT           = $A0000000;
  {$EXTERNALSYM TAPE_DRIVE_FORMAT_IMMEDIATE}
  TAPE_DRIVE_FORMAT_IMMEDIATE = $C0000000;

  // tape drive features low
  {$EXTERNALSYM TAPE_DRIVE_FIXED}
  TAPE_DRIVE_FIXED            = $00000001;
  {$EXTERNALSYM TAPE_DRIVE_SELECT}
  TAPE_DRIVE_SELECT           = $00000002;
  {$EXTERNALSYM TAPE_DRIVE_INITIATOR}
  TAPE_DRIVE_INITIATOR        = $00000004;
  {$EXTERNALSYM TAPE_DRIVE_ERASE_SHORT}
  TAPE_DRIVE_ERASE_SHORT      = $00000010;
  {$EXTERNALSYM TAPE_DRIVE_ERASE_LONG}
  TAPE_DRIVE_ERASE_LONG       = $00000020;
  {$EXTERNALSYM TAPE_DRIVE_ERASE_BOP_ONLY}
  TAPE_DRIVE_ERASE_BOP_ONLY   = $00000040;
  {$EXTERNALSYM TAPE_DRIVE_ERASE_IMMEDIATE}
  TAPE_DRIVE_ERASE_IMMEDIATE  = $00000080;
  {$EXTERNALSYM TAPE_DRIVE_TAPE_CAPACITY}
  TAPE_DRIVE_TAPE_CAPACITY    = $00000100;
  {$EXTERNALSYM TAPE_DRIVE_TAPE_REMAINING}
  TAPE_DRIVE_TAPE_REMAINING   = $00000200;
  {$EXTERNALSYM TAPE_DRIVE_FIXED_BLOCK}
  TAPE_DRIVE_FIXED_BLOCK      = $00000400;
  {$EXTERNALSYM TAPE_DRIVE_VARIABLE_BLOCK}
  TAPE_DRIVE_VARIABLE_BLOCK   = $00000800;
  {$EXTERNALSYM TAPE_DRIVE_WRITE_PROTECT}
  TAPE_DRIVE_WRITE_PROTECT    = $00001000;
  {$EXTERNALSYM TAPE_DRIVE_EOT_WZ_SIZE}
  TAPE_DRIVE_EOT_WZ_SIZE      = $00002000;
  {$EXTERNALSYM TAPE_DRIVE_ECC}
  TAPE_DRIVE_ECC              = $00010000;
  {$EXTERNALSYM TAPE_DRIVE_COMPRESSION}
  TAPE_DRIVE_COMPRESSION      = $00020000;
  {$EXTERNALSYM TAPE_DRIVE_PADDING}
  TAPE_DRIVE_PADDING          = $00040000;
  {$EXTERNALSYM TAPE_DRIVE_REPORT_SMKS}
  TAPE_DRIVE_REPORT_SMKS      = $00080000;
  {$EXTERNALSYM TAPE_DRIVE_GET_ABSOLUTE_BLK}
  TAPE_DRIVE_GET_ABSOLUTE_BLK = $00100000;
  {$EXTERNALSYM TAPE_DRIVE_GET_LOGICAL_BLK}
  TAPE_DRIVE_GET_LOGICAL_BLK  = $00200000;
  {$EXTERNALSYM TAPE_DRIVE_SET_EOT_WZ_SIZE}
  TAPE_DRIVE_SET_EOT_WZ_SIZE  = $00400000;
  {$EXTERNALSYM TAPE_DRIVE_EJECT_MEDIA}
  TAPE_DRIVE_EJECT_MEDIA      = $01000000;
  {$EXTERNALSYM TAPE_DRIVE_CLEAN_REQUESTS}
  TAPE_DRIVE_CLEAN_REQUESTS   = $02000000;
  {$EXTERNALSYM TAPE_DRIVE_SET_CMP_BOP_ONLY}
  TAPE_DRIVE_SET_CMP_BOP_ONLY = $04000000;


implementation

const
  QUERY_SELECT_PARTITIONS               = 'select * from Win32_DiskPartition';
  QUERY_FIND_PARTITION_BY_DEVICE_ID     = 'select * from Win32_DiskPartition where DeviceID="%s"';

  QUERY_SELECT_LOGICAL_DISKS            = 'select * from Win32_LogicalDisk';
  QUERY_FIND_LOGICAL_DISK_BY_DEVICE_ID  = 'select * from Win32_LogicalDisk where DeviceID="%s"';

  QUERY_SELECT_DISK_DRIVES              = 'select * from Win32_DiskDrive';
  QUERY_FIND_DISK_DRIVE_BY_DEVICE_ID    = 'select * from Win32_DiskDrive where DeviceID="%s"';

  QUERY_SELECT_CDROM_DRIVES             = 'select * from Win32_CDROMDrive';
  QUERY_FIND_CDROM_DRIVE_BY_DEVICE_ID   = 'select * from Win32_CDROMDrive where DeviceID="%s"';

  QUERY_SELECT_FLOPPY_DRIVES            = 'select * from Win32_FloppyDrive';
  QUERY_FIND_FLOPPY_DRIVE_BY_DEVICE_ID  = 'select * from Win32_FloppyDrive where DeviceID="%s"';

  QUERY_SELECT_TAPE_DRIVES              = 'select * from Win32_TapeDrive';
  QUERY_FIND_TAPE_DRIVE_BY_DEVICE_ID    = 'select * from Win32_TapeDrive where DeviceID="%s"';

  QUERY_EVENT_FLOPPY_DRIVE_CHANGE       = 'SELECT * FROM __InstanceOperationEvent '+
                                          'WITHIN %f '+
                                          'WHERE TargetInstance ISA "Win32_FloppyDrive"';

  QUERY_EVENT_DISK_DRIVE_CHANGE         = 'SELECT * FROM __InstanceOperationEvent '+
                                          'WITHIN %f '+
                                          'WHERE TargetInstance ISA "Win32_DiskDrive"';

  QUERY_EVENT_CDROM_DRIVE_CHANGE        = 'SELECT * FROM __InstanceOperationEvent '+
                                          'WITHIN %f '+
                                          'WHERE TargetInstance ISA "Win32_CDROMDrive"';

  QUERY_EVENT_LOGICAL_DISK_CHANGE       = 'SELECT * FROM __InstanceOperationEvent '+
                                          'WITHIN %f '+
                                          'WHERE TargetInstance ISA "Win32_LogicalDisk"';

  QUERY_EVENT_PARTITION_CHANGE          = 'SELECT * FROM __InstanceOperationEvent '+
                                          'WITHIN %f '+
                                          'WHERE TargetInstance ISA "Win32_DiskPartition"';

  QUERY_EVENT_TAPE_DRIVE_CHANGE          = 'SELECT * FROM __InstanceOperationEvent '+
                                          'WITHIN %f '+
                                          'WHERE TargetInstance ISA "Win32_TapeDrive"';


// this methid returns description of Disk Drive capability
function GetCapabilityDescription(ACapability: word): string;
begin
  case ACapability of 
    DDC_UNKNOWN:                      Result := 'Unknown';
    DDC_OTHER:                        Result := 'Other';
    DDC_SEQUENTIAL_ACCESS:            Result := 'Sequential Access';
    DDC_RANDOM_ACCESS:                Result := 'Random Access';
    DDC_SUPPORTS_WRITING:             Result := 'Supports Writing';
    DDC_ENCRYPTION:                   Result := 'Encryption';
    DDC_COMPRESSION:                  Result := 'Compression';
    DDC_SUPPORTS_REMOVABLE_MEDIA:     Result := 'Supports Removable Media';
    DDC_MANUAL_CLEANING:              Result := 'Manual Cleaning';
    DDC_AUTOMATIC_CLEANING:           Result := 'Automatic Cleaning';
    DDC_SMART_NOTIFICATION:           Result := 'SMART Notification';
    DDC_SUPPORTS_DUAL_SIDED_MEDIA:    Result := 'Supports Dual Sided Media';
    DDC_PRIOR_EJECTION_NOT_REQUIRED:  Result := 'Ejection Prior to Drive Dismount Not Required';
    else Result := 'Unknown';
  end
end;

{ TWmiPartitionList }
function TWmiPartitionList.Add: TWmiPartition;
begin
  if not Active then RaiseNotActiveException;
  raise Exception.Create('Not implemented');
end;

function TWmiPartitionList.GetItem(AIndex: integer): TWmiPartition;
begin
  Result := TWmiPartition(inherited GetItem(AIndex));
end;

procedure TWmiPartitionList.SetItem(AIndex: integer;
  const Value: TWmiPartition);
begin
  inherited SetItem(AIndex, Value);
end;

{ TWmiStorageInfo }

procedure TWmiStorageInfo.CredentialsOrTargetChanged;
begin
  inherited;
  FPartitions.ClearEntities;
  FFloppyDrives.ClearEntities;
  FCDROMDrives.ClearEntities;
  FDiskDrives.ClearEntities;
  FTapeDrives.ClearEntities;
  FLogicalDisks.ClearEntities;
end;

procedure TWmiStorageInfo.RegisterEvents;
const
  INSTANCE_EVENT = '__InstanceOperationEvent';
begin
  ClearEventList;
  if (not IsDesignTime) and Active then
  begin
    RegisterEvent(QUERY_EVENT_FLOPPY_DRIVE_CHANGE, FloppyDriveChanged, INSTANCE_EVENT);
    RegisterEvent(QUERY_EVENT_DISK_DRIVE_CHANGE,   DiskDriveChanged, INSTANCE_EVENT);
    RegisterEvent(QUERY_EVENT_CDROM_DRIVE_CHANGE,  CDROMDriveChanged, INSTANCE_EVENT);
    RegisterEvent(QUERY_EVENT_LOGICAL_DISK_CHANGE, LogicalDiskChanged, INSTANCE_EVENT);
    RegisterEvent(QUERY_EVENT_PARTITION_CHANGE,    PartitionChanged, INSTANCE_EVENT);
    RegisterEvent(QUERY_EVENT_TAPE_DRIVE_CHANGE,   TapeDriveChanged, INSTANCE_EVENT);
  end;
end;

constructor TWmiStorageInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PoolingInterval := 100;  // by default ten seconds pooling interval. 
  FPartitions   := TWmiPartitionList.Create(self, TWmiPartition, true);
  FLogicalDisks := TWmiLogicalDiskList.Create(self, TWmiLogicalDisk, true);
  FDiskDrives   := TWmiDiskDriveList.Create(self, TWmiDiskDrive, true);
  FCDROMDrives  := TWmiCDROMDriveList.Create(self, TWmiCDROMDrive, true);
  FFloppyDrives := TWmiFloppyDriveList.Create(self, TWmiFloppyDrive, true);
  FTapeDrives   := TWmiTapeDriveList.Create(self, TWmiTapeDrive, true);
end;

destructor TWmiStorageInfo.Destroy;
begin
 FPartitions.Free;
  FLogicalDisks.Free;
  FDiskDrives.Free;
  FCDROMDrives.Free;
  FFloppyDrives.Free;
  FTapeDrives.Free;
  inherited;
end;


procedure TWmiStorageInfo.LoadFloppyDrives;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vFloppyDrive: TWmiFloppyDrive;
begin
  FFloppyDrives.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(QUERY_SELECT_FLOPPY_DRIVES);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject   := IUnknown(vOleVar) as SWBemObject;
      vOleVar      := Unassigned;
      vFloppyDrive := TWmiFloppyDrive.Create(FFloppyDrives);
      vFloppyDrive.LoadProperties(vWmiObject);
    end;
  end;
end;

procedure TWmiStorageInfo.LoadCDROMDisks;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vCDROMDisk: TWmiCDROMDrive;
begin
  FCDROMDrives.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(QUERY_SELECT_CDROM_DRIVES);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject   := IUnknown(vOleVar) as SWBemObject;
      vCDROMDisk := TWmiCDROMDrive.Create(FCDROMDrives);
      vCDROMDisk.LoadProperties(vWmiObject);
    end;
  end;
end;

procedure TWmiStorageInfo.LoadLogicalDisks;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vLogicalDisk: TWmiLogicalDisk;
begin
  FLogicalDisks.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(QUERY_SELECT_LOGICAL_DISKS);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject   := IUnknown(vOleVar) as SWBemObject;
      vLogicalDisk := TWmiLogicalDisk.Create(FLogicalDisks);
      vLogicalDisk.LoadProperties(vWmiObject);
    end;
  end;
end;

procedure TWmiStorageInfo.LoadPartitions;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vPartition: TWmiPartition;
begin
  FPartitions.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(QUERY_SELECT_PARTITIONS);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject := IUnknown(vOleVar) as SWBemObject;
      vOleVar    := Unassigned;
      vPartition  := TWmiPartition.Create(FPartitions);
      vPartition.LoadProperties(vWmiObject);
    end;
  end;
end;

function TWmiStorageInfo.GetPartitions: TWmiPartitionList;
begin
  if Active then
  begin
    if FPartitions.Count = 0 then LoadPartitions;
  end else
  begin
    FPartitions.ClearEntities;
  end;
  Result := FPartitions;
end;

function TWmiStorageInfo.GetLogicalDisks: TWmiLogicalDiskList;
begin
  if Active then
  begin
    if FLogicalDisks.Count = 0 then LoadLogicalDisks;
  end else
  begin
    FLogicalDisks.ClearEntities;
  end;
  Result := FLogicalDisks;
end;

procedure TWmiStorageInfo.SetPartitions(const Value: TWmiPartitionList);begin end;
procedure TWmiStorageInfo.SetLogicalDisks(const Value: TWmiLogicalDiskList);begin end;
procedure TWmiStorageInfo.SetDiskDrives(const Value: TWmiDiskDriveList);begin end;
procedure TWmiStorageInfo.SetCDROMDrives(const Value: TWmiCDROMDriveList);begin end;
procedure TWmiStorageInfo.SetFloppyDrives(const Value: TWmiFloppyDriveList);begin end;
procedure TWmiStorageInfo.SetTapeDrives(const Value: TWmiTapeDriveList);begin end;

function TWmiStorageInfo.GetDiskDrives: TWmiDiskDriveList;
begin
  if Active then
  begin
    if FDiskDrives.Count = 0 then LoadDiskDrives;
  end else
  begin
    FDiskDrives.ClearEntities;
  end;
  Result := FDiskDrives;
end;

procedure TWmiStorageInfo.LoadDiskDrives;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vDiskDrive: TWmiDiskDrive;
begin
  FDiskDrives.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(QUERY_SELECT_DISK_DRIVES);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject   := IUnknown(vOleVar) as SWBemObject;
      vOleVar    := Unassigned;
      vDiskDrive := TWmiDiskDrive.Create(FDiskDrives);
      vDiskDrive.LoadProperties(vWmiObject);
    end;
  end;
end;


function TWmiStorageInfo.GetCDROMDrives: TWmiCDROMDriveList;
begin
  if Active then
  begin
    if FCDROMDrives.Count = 0 then LoadCDROMDisks;
  end else
  begin
    FCDROMDrives.ClearEntities;
  end;
  Result := FCDROMDrives;
end;

function TWmiStorageInfo.GetFloppyDrives: TWmiFloppyDriveList;
begin
  if Active then
  begin
    if FFloppyDrives.Count = 0 then LoadFloppyDrives;
  end else
  begin
    FFloppyDrives.ClearEntities;
  end;
  Result := FFloppyDrives;
end;

function TWmiStorageInfo.GetTapeDrives: TWmiTapeDriveList;
begin
  if Active then
  begin
    if FTapeDrives.Count = 0 then LoadTapeDrives;
  end else
  begin
    FTapeDrives.ClearEntities;
  end;
  Result := FTapeDrives;
end;

procedure TWmiStorageInfo.LoadTapeDrives;
var
  vEnum: IEnumVariant;
  vOleVar: OleVariant;
  vWmiObject: ISWbemObject;
  vFetchedCount: cardinal;
  vTapeDrive: TWmiTapeDrive;
begin
  FTapeDrives.ClearEntities;
  if Active then
  begin
    vEnum := ExecSelectQuery(QUERY_SELECT_TAPE_DRIVES);
    while (vEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vWmiObject := IUnknown(vOleVar) as SWBemObject;
      vOleVar    := Unassigned;
      vTapeDrive := TWmiTapeDrive.Create(FTapeDrives);
      vTapeDrive.LoadProperties(vWmiObject);
    end;
  end;
end;

procedure TWmiStorageInfo.SetActive(Value: boolean);
begin
  if (Value <> GetActive) and (Value = false) then
  begin
    FPartitions.ClearEntities;
    FLogicalDisks.ClearEntities;
    FDiskDrives.ClearEntities;
    FCDROMDrives.ClearEntities;
    FFloppyDrives.ClearEntities;
    FTapeDrives.ClearEntities;
  end;

  inherited;
end;

procedure TWmiStorageInfo.DriveChanged(Sender: TObject;
  Event: OleVariant; AHandler: TWmiDeviceEvent);
var
  vEvent:     ISWbemObject;
  vDevice:    ISWbemObject;
  vProperty:  ISWbemProperty;
  vPath:      ISWbemObjectPath;
  vClass, vDeviceId:  widestring;
  vAction:    TWmiDeviceAction;
begin
  if Assigned(AHandler) then
  begin
    vEvent     := IUnknown(Event) as ISWbemObject;
    vProperty  := WmiGetObjectProperty(vEvent, 'TargetInstance');
    vDevice   := IUnknown(WmiGetVariantPropertyValue(vProperty)) as ISWbemObject;

    vProperty  := WmiGetObjectProperty(vDevice, 'DeviceId');
    vDeviceId  := WmiGetStringPropertyValue(vProperty);

    WmiCheck(vEvent.Get_Path_(vPath));
    WmiCheck(vPath.Get_Class_(vClass));
    if vClass = '__InstanceCreationEvent' then vAction := daCreated
    else if vClass = '__InstanceModificationEvent' then vAction := daChanged
    else if vClass = '__InstanceDeletionEvent' then vAction := daDeleted
    else vAction := daOther;

    AHandler(self, vDeviceId, vAction);
  end;
end;


procedure TWmiStorageInfo.FloppyDriveChanged(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  DriveChanged(Sender, Event, FOnFloppyDriveChanged);
end;

procedure TWmiStorageInfo.CDROMDriveChanged(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  DriveChanged(Sender, Event, FOnCDROMDriveChanged);
end;

procedure TWmiStorageInfo.DiskDriveChanged(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  DriveChanged(Sender, Event, FOnDiskDriveChanged);
end;

procedure TWmiStorageInfo.LogicalDiskChanged(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  DriveChanged(Sender, Event, FOnLogicalDiskChanged);
end;

procedure TWmiStorageInfo.PartitionChanged(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  DriveChanged(Sender, Event, FOnPartitionChanged);
end;

procedure TWmiStorageInfo.TapeDriveChanged(Sender: TObject;
  EventInfo: TEventInfoHolder; Event: OleVariant);
begin
  DriveChanged(Sender, Event, FOnTapeDriveChanged);
end;

{ TWmiPartition }

constructor TWmiPartition.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiPartitionList);
end;


destructor TWmiPartition.Destroy;
begin
  inherited;
end;

procedure TWmiPartition.LoadProperties(APartition: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  WmiCheck(APartition.Get_Properties_(vProperties));
  FRewritePartition         := WmiGetBooleanPropertyValueByName(vProperties, 'RewritePartition');
  FBootPartition            := WmiGetBooleanPropertyValueByName(vProperties, 'BootPartition');
  FPrimaryPartition         := WmiGetBooleanPropertyValueByName(vProperties, 'PrimaryPartition');
  FBootable                 := WmiGetBooleanPropertyValueByName(vProperties, 'Bootable');
  FDiskIndex                := WmiGetIntegerPropertyValueByName(vProperties, 'DiskIndex');
  FPartitionIndex           := WmiGetIntegerPropertyValueByName(vProperties, 'Index');
  FHiddenSectors            := WmiGetIntegerPropertyValueByName(vProperties, 'HiddenSectors');
  FSize                     := WmiGetInt64PropertyValueByName(vProperties, 'Size');
  FNumberOfBlocks           := WmiGetInt64PropertyValueByName(vProperties, 'NumberOfBlocks');
  FStartingOffset           := WmiGetInt64PropertyValueByName(vProperties, 'StartingOffset');
  FBlockSize                := WmiGetIntegerPropertyValueByName(vProperties, 'BlockSize');
  FSystemType               := WmiGetStringPropertyValueByName(vProperties, 'Type');
  FPurpose                  := WmiGetStringPropertyValueByName(vProperties, 'Purpose');
  FAccess                   := WmiGetIntegerPropertyValueByName(vProperties, 'Access');
end;

procedure TWmiPartition.Refresh;
var
  vPartitionObj:      ISWbemObject;
  vQuery:             widestring;
begin
  vQuery      := Format(QUERY_FIND_PARTITION_BY_DEVICE_ID, [DeviceId]);
  vPartitionObj := WmiSelectSingleEntity(WmiServices, vQuery);
  LoadProperties(vPartitionObj);
end;

procedure TWmiPartition.SetAccess(const Value: word);begin end;
procedure TWmiPartition.SetBlockSize(const Value: integer);begin end;
procedure TWmiPartition.SetBootable(const Value: boolean);begin end;
procedure TWmiPartition.SetBootPartition(const Value: boolean);begin end;
procedure TWmiPartition.SetDiskIndex(const Value: DWORD);begin end;
procedure TWmiPartition.SetHiddenSectors(const Value: DWORD);begin end;
procedure TWmiPartition.SetNumberOfBlocks(const Value: int64);begin end;
procedure TWmiPartition.SetPartitionIndex(const Value: DWORD);begin end;
procedure TWmiPartition.SetPrimaryPartition(const Value: boolean);begin end;
procedure TWmiPartition.SetPurpose(const Value: widestring);begin end;
procedure TWmiPartition.SetRewritePartition(const Value: boolean);begin end;
procedure TWmiPartition.SetSize(const Value: int64);begin end;
procedure TWmiPartition.SetStartingOffset(const Value: int64);begin end;
procedure TWmiPartition.SetSystemType(const Value: widestring);begin end;


{ TWmiLogicalDisk }

constructor TWmiLogicalDisk.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiLogicalDiskList);
end;

destructor TWmiLogicalDisk.Destroy;
begin
  inherited;
end;

procedure TWmiLogicalDisk.LoadProperties(ALogicalDisk: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  WmiCheck(ALogicalDisk.Get_Properties_(vProperties));
  // the quota properties were added in Windows XP
  FSupportsDiskQuotas       := WmiGetBooleanPropertyValueByNameSafe(vProperties, 'SupportsDiskQuotas');
  FQuotasDisabled           := WmiGetBooleanPropertyValueByNameSafe(vProperties, 'QuotasDisabled');
  FQuotasRebuilding         := WmiGetBooleanPropertyValueByNameSafe(vProperties, 'QuotasRebuilding');
  FQuotasIncomplete         := WmiGetBooleanPropertyValueByNameSafe(vProperties, 'QuotasIncomplete');
  FSupportsFileBasedCompression := WmiGetBooleanPropertyValueByName(vProperties, 'SupportsFileBasedCompression');
  FVolumeDirty              := WmiGetBooleanPropertyValueByNameSafe(vProperties, 'VolumeDirty');
  FCompressed               := WmiGetBooleanPropertyValueByName(vProperties, 'Compressed');
  FDriveType                := WmiGetIntegerPropertyValueByName(vProperties, 'DriveType');
  FMediaType                := WmiGetIntegerPropertyValueByName(vProperties, 'MediaType');
  FMaximumComponentLength   := WmiGetIntegerPropertyValueByName(vProperties, 'MaximumComponentLength');
  FFreeSpace                := WmiGetInt64PropertyValueByName(vProperties, 'FreeSpace');
  FBlockSize                := WmiGetInt64PropertyValueByName(vProperties, 'BlockSize');
  FSize                     := WmiGetInt64PropertyValueByName(vProperties, 'Size');
  FNumberOfBlocks           := WmiGetInt64PropertyValueByName(vProperties, 'NumberOfBlocks');
  FFileSystem               := WmiGetStringPropertyValueByName(vProperties, 'FileSystem');
  FVolumeSerialNumber       := WmiGetStringPropertyValueByName(vProperties, 'VolumeSerialNumber');
  FPurpose                  := WmiGetStringPropertyValueByName(vProperties, 'Purpose');
  FVolumeName               := WmiGetStringPropertyValueByName(vProperties, 'VolumeName');
  FProviderName             := WmiGetStringPropertyValueByName(vProperties, 'ProviderName');
  FAccess                   := WmiGetIntegerPropertyValueByName(vProperties, 'Access');
end;

procedure TWmiLogicalDisk.Refresh;
var
  vDiskObj:      ISWbemObject;
  vQuery:        widestring;
begin
  vQuery      := Format(QUERY_FIND_LOGICAL_DISK_BY_DEVICE_ID, [DeviceId]);
  vDiskObj    := WmiSelectSingleEntity(WmiServices, vQuery);
  LoadProperties(vDiskObj);
end;

procedure TWmiLogicalDisk.SetAccess(const Value: word);begin end;
procedure TWmiLogicalDisk.SetBlockSize(const Value: int64);begin end;
procedure TWmiLogicalDisk.SetCompressed(const Value: boolean);begin end;
procedure TWmiLogicalDisk.SetDriveType(const Value: DWORD);begin end;
procedure TWmiLogicalDisk.SetFileSystem(const Value: widestring);begin end;
procedure TWmiLogicalDisk.SetFreeSpace(const Value: int64);begin end;
procedure TWmiLogicalDisk.SetMaximumComponentLength(const Value: DWORD);begin end;
procedure TWmiLogicalDisk.SetMediaType(const Value: DWORD);begin end;
procedure TWmiLogicalDisk.SetNumberOfBlocks(const Value: int64);begin end;
procedure TWmiLogicalDisk.SetProviderName(const Value: widestring);begin end;
procedure TWmiLogicalDisk.SetPurpose(const Value: widestring);begin end;
procedure TWmiLogicalDisk.SetQuotasDisabled(const Value: boolean);begin end;
procedure TWmiLogicalDisk.SetQuotasIncomplete(const Value: boolean);begin end;
procedure TWmiLogicalDisk.SetQuotasRebuilding(const Value: boolean);begin end;
procedure TWmiLogicalDisk.SetSize(const Value: int64);begin end;
procedure TWmiLogicalDisk.SetSupportsDiskQuotas(const Value: boolean);begin end;
procedure TWmiLogicalDisk.SetSupportsFileBasedCompression;begin end;
procedure TWmiLogicalDisk.SetVolumeDirty(const Value: boolean);begin end;
procedure TWmiLogicalDisk.SetVolumeName(const Value: widestring);begin end;
procedure TWmiLogicalDisk.SetVolumeSerialNumber(const Value: widestring);begin end;

{ TWmiLogicalDiskList }

function TWmiLogicalDiskList.GetItem(AIndex: integer): TWmiLogicalDisk;
begin
  Result := TWmiLogicalDisk(inherited GetItem(AIndex));
end;

procedure TWmiLogicalDiskList.SetItem(AIndex: integer;
  const Value: TWmiLogicalDisk);
begin
  inherited SetItem(AIndex, Value);
end;

{ TWmiDiskDrive }

constructor TWmiDiskDrive.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiDiskDriveList);
end;

procedure TWmiDiskDrive.LoadProperties(ADiskDrive: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  WmiCheck(ADiskDrive.Get_Properties_(vProperties));
  FMediaType                := WmiGetStringPropertyValueByName(vProperties, 'MediaType');
  FMediaLoaded              := WmiGetBooleanPropertyValueByName(vProperties, 'MediaLoaded');
  // this property was added in Windows XP
  FSignature                := WmiGetIntegerPropertyValueByNameSafe(vProperties, 'Signature');
  FTotalHeads               := WmiGetIntegerPropertyValueByName(vProperties, 'TotalHeads');
  FTracksPerCylinder        := WmiGetIntegerPropertyValueByName(vProperties, 'TracksPerCylinder');
  FBytesPerSector           := WmiGetIntegerPropertyValueByName(vProperties, 'BytesPerSector');
  FSCSIBus                  := WmiGetIntegerPropertyValueByName(vProperties, 'SCSIBus');
  FPartitions               := WmiGetIntegerPropertyValueByName(vProperties, 'Partitions');
  FSectorsPerTrack          := WmiGetIntegerPropertyValueByName(vProperties, 'SectorsPerTrack');
  FTotalCylinders           := WmiGetInt64PropertyValueByName(vProperties, 'TotalCylinders');
  FTotalTracks              := WmiGetInt64PropertyValueByName(vProperties, 'TotalTracks');
  FTotalSectors             := WmiGetInt64PropertyValueByName(vProperties, 'TotalSectors');
  FSize                     := WmiGetInt64PropertyValueByName(vProperties, 'Size');
  FDriveIndex               := WmiGetIntegerPropertyValueByName(vProperties, 'Index');
  FInterfaceType            := WmiGetStringPropertyValueByName(vProperties, 'InterfaceType');
  FModel                    := WmiGetStringPropertyValueByName(vProperties, 'Model');
  FMediaType                := WmiGetStringPropertyValueByName(vProperties, 'MediaType');
  FSCSITargetId             := WmiGetIntegerPropertyValueByName(vProperties, 'SCSITargetId');
  FSCSIPort                 := WmiGetIntegerPropertyValueByName(vProperties, 'SCSIPort');
  FSCSILogicalUnit          := WmiGetIntegerPropertyValueByName(vProperties, 'SCSILogicalUnit');
end;

procedure TWmiDiskDrive.Refresh;
var
  vDiskDriveObj:      ISWbemObject;
  vQuery:             widestring;  
begin
  vQuery      := Format(QUERY_FIND_DISK_DRIVE_BY_DEVICE_ID, [DeviceId]);
  vDiskDriveObj := WmiSelectSingleEntity(WmiServices, vQuery);
  LoadProperties(vDiskDriveObj);
end;

procedure TWmiDiskDrive.SetBytesPerSector(const Value: DWORD); begin end;
procedure TWmiDiskDrive.SetDriveIndex(const Value: integer); begin end;
procedure TWmiDiskDrive.SetInterfaceType(const Value: widestring); begin end;
procedure TWmiDiskDrive.SetMediaLoaded(const Value: boolean); begin end;
procedure TWmiDiskDrive.SetMediaType(const Value: widestring); begin end;
procedure TWmiDiskDrive.SetModel(const Value: widestring); begin end;
procedure TWmiDiskDrive.SetPartitions(const Value: DWORD); begin end;
procedure TWmiDiskDrive.SetSCSIBus(const Value: DWORD); begin end;
procedure TWmiDiskDrive.SetSCSILogicalUnit(const Value: word); begin end;
procedure TWmiDiskDrive.SetSCSIPort(const Value: word); begin end;
procedure TWmiDiskDrive.SetSCSITargetId(const Value: word); begin end;
procedure TWmiDiskDrive.SetSectorsPerTrack(const Value: DWORD); begin end;
procedure TWmiDiskDrive.SetSignature(const Value: DWORD); begin end;
procedure TWmiDiskDrive.SetSize(const Value: int64); begin end;
procedure TWmiDiskDrive.SetTotalCylinders(const Value: int64); begin end;
procedure TWmiDiskDrive.SetTotalHeads(const Value: DWORD); begin end;
procedure TWmiDiskDrive.SetTotalSectors(const Value: int64); begin end;
procedure TWmiDiskDrive.SetTotalTracks(const Value: int64); begin end;
procedure TWmiDiskDrive.SetTracksPerCylinder(const Value: DWORD); begin end;

destructor TWmiDiskDrive.Destroy;
begin
  inherited;
end;

{ TWmiDiskDriveList }

function TWmiDiskDriveList.GetItem(AIndex: integer): TWmiDiskDrive;
begin
  Result := TWmiDiskDrive(inherited GetItem(AIndex));
end;

procedure TWmiDiskDriveList.SetItem(AIndex: integer;
  const Value: TWmiDiskDrive);
begin
  inherited SetItem(AIndex, Value);
end;


{ TWmiCDROMDrive }

constructor TWmiCDROMDrive.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiCDROMDriveList);
end;

procedure TWmiCDROMDrive.LoadProperties(ADrive: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  WmiCheck(ADrive.Get_Properties_(vProperties));

  FMediaLoaded              := WmiGetBooleanPropertyValueByName(vProperties, 'MediaLoaded');
  FDriveIntegrity           := WmiGetBooleanPropertyValueByName(vProperties, 'DriveIntegrity');
  FMaximumComponentLength   := WmiGetIntegerPropertyValueByName(vProperties, 'MaximumComponentLength');
  FFileSystemFlagsEx        := WmiGetIntegerPropertyValueByName(vProperties, 'FileSystemFlagsEx');
  FSize                     := WmiGetInt64PropertyValueByName(vProperties, 'Size');
  FTransferRate             := WmiGetFloatPropertyValueByName(vProperties, 'TransferRate');
  FDrive                    := WmiGetStringPropertyValueByName(vProperties, 'Drive');
  FDriveId                  := WmiGetStringPropertyValueByName(vProperties, 'Id');
  FMediaType                := WmiGetStringPropertyValueByName(vProperties, 'MediaType');
  FMfrAssignedRevisionLevel := WmiGetStringPropertyValueByNameSafe(vProperties, 'MfrAssignedRevisionLevel');
  FVolumeSerialNumber       := WmiGetStringPropertyValueByName(vProperties, 'VolumeSerialNumber');
  FVolumeName               := WmiGetStringPropertyValueByName(vProperties, 'VolumeName');
  FRevisionLevel            := WmiGetStringPropertyValueByName(vProperties, 'RevisionLevel');

  FSCSIBus                  := WmiGetIntegerPropertyValueByName(vProperties, 'SCSIBus');
  FSCSITargetId             := WmiGetIntegerPropertyValueByName(vProperties, 'SCSITargetId');
  FSCSIPort                 := WmiGetIntegerPropertyValueByName(vProperties, 'SCSIPort');
  FSCSILogicalUnit          := WmiGetIntegerPropertyValueByName(vProperties, 'SCSILogicalUnit');
end;

procedure TWmiCDROMDrive.Refresh;
var
  vCDROMDriveObj:     ISWbemObject;
  vQuery:             widestring;  
begin
  vQuery         := Format(QUERY_FIND_CDROM_DRIVE_BY_DEVICE_ID, [DeviceId]);
  vCDROMDriveObj := WmiSelectSingleEntity(WmiServices, vQuery);
  LoadProperties(vCDROMDriveObj);
end;

procedure TWmiCDROMDrive.SetDrive(const Value: widestring); begin end;
procedure TWmiCDROMDrive.SetDriveId(const Value: widestring); begin end;
procedure TWmiCDROMDrive.SetDriveIntegrity(const Value: boolean); begin end;
procedure TWmiCDROMDrive.SetFileSystemFlagsEx(const Value: DWORD); begin end;
procedure TWmiCDROMDrive.SetMaximumComponentLength(const Value: DWORD); begin end;
procedure TWmiCDROMDrive.SetMediaLoaded(const Value: boolean); begin end;
procedure TWmiCDROMDrive.SetMediaType(const Value: widestring); begin end;
procedure TWmiCDROMDrive.SetMfrAssignedRevisionLevel(const Value: widestring); begin end;
procedure TWmiCDROMDrive.SetRevisionLevel(const Value: widestring); begin end;
procedure TWmiCDROMDrive.SetSCSIBus(const Value: DWORD); begin end;
procedure TWmiCDROMDrive.SetSCSILogicalUnit(const Value: word); begin end;
procedure TWmiCDROMDrive.SetSCSIPort(const Value: word); begin end;
procedure TWmiCDROMDrive.SetSCSITargetId(const Value: word); begin end;
procedure TWmiCDROMDrive.SetSize(const Value: int64); begin end;
procedure TWmiCDROMDrive.SetTransferRate(const Value: double); begin end;
procedure TWmiCDROMDrive.SetVolumeName(const Value: widestring); begin end;
procedure TWmiCDROMDrive.SetVolumeSerialNumber(const Value: widestring); begin end;

{ TWmiCDROMDriveList }

function TWmiCDROMDriveList.GetItem(AIndex: integer): TWmiCDROMDrive;
begin
  Result := TWmiCDROMDrive(inherited GetItem(AIndex));
end;

procedure TWmiCDROMDriveList.SetItem(AIndex: integer;
  const Value: TWmiCDROMDrive);
begin
  inherited SetItem(AIndex, Value);
end;

{ TWmiFloppyDrive }

constructor TWmiFloppyDrive.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiFloppyDriveList);
end;

procedure TWmiFloppyDrive.Refresh;
var
  vFloppyDriveObj:    ISWbemObject;
  vQuery:             widestring;  
begin
  vQuery          := Format(QUERY_FIND_FLOPPY_DRIVE_BY_DEVICE_ID, [DeviceId]);
  vFloppyDriveObj := WmiSelectSingleEntity(WmiServices, vQuery);
  LoadProperties(vFloppyDriveObj);
end;

{ TWmiFloppyDriveList }

function TWmiFloppyDriveList.GetItem(AIndex: integer): TWmiFloppyDrive;
begin
  Result := TWmiFloppyDrive (inherited GetItem(AIndex));
end;

procedure TWmiFloppyDriveList.SetItem(AIndex: integer;
  const Value: TWmiFloppyDrive);
begin
  inherited SetItem(AIndex, Value);
end;

{ TWmiTapeDrive }

constructor TWmiTapeDrive.Create(AOwner: TWmiEntityList);
begin
  inherited Create(AOwner, true, TWmiTapeDriveList);
end;

procedure TWmiTapeDrive.LoadProperties(ATapeDrive: ISWbemObject);
var
  vProperties: ISWbemPropertySet;
begin
  inherited;
  WmiCheck(ATapeDrive.Get_Properties_(vProperties));
  FCompression        := WmiGetIntegerPropertyValueByName(vProperties, 'Compression') <> 0;
  FReportSetMarks     := WmiGetIntegerPropertyValueByName(vProperties, 'ReportSetMarks') <> 0;
  FEOTWarningZoneSize := WmiGetIntegerPropertyValueByName(vProperties, 'EOTWarningZoneSize');
  FFeaturesLow        := WmiGetIntegerPropertyValueByName(vProperties, 'FeaturesLow');
  FFeaturesHigh       := WmiGetIntegerPropertyValueByName(vProperties, 'FeaturesHigh');
  FMaxPartitionCount  := WmiGetIntegerPropertyValueByName(vProperties, 'MaxPartitionCount');
  FPadding            := WmiGetIntegerPropertyValueByName(vProperties, 'Padding');
  FTapeDriveID        := WmiGetStringPropertyValueByName(vProperties, 'ID');
  FMediaType          := WmiGetStringPropertyValueByName(vProperties, 'MediaType');
end;

procedure TWmiTapeDrive.Refresh;
var
  vTapeDriveObj:      ISWbemObject;
  vQuery:             widestring;  
begin
  vQuery      := Format(QUERY_FIND_TAPE_DRIVE_BY_DEVICE_ID, [DeviceId]);
  vTapeDriveObj := WmiSelectSingleEntity(WmiServices, vQuery);
  LoadProperties(vTapeDriveObj);
end;

procedure TWmiTapeDrive.SetCompression(const Value: boolean); begin end;
procedure TWmiTapeDrive.SetECC(const Value: boolean); begin end;
procedure TWmiTapeDrive.SetEOTWarningZoneSize(const Value: DWORD); begin end;
procedure TWmiTapeDrive.SetFeaturesHigh(const Value: DWORD); begin end;
procedure TWmiTapeDrive.SetFeaturesLow(const Value: DWORD); begin end;
procedure TWmiTapeDrive.SetMaxPartitionCount(const Value: DWORD); begin end;
procedure TWmiTapeDrive.SetMediaType(const Value: widestring); begin end;
procedure TWmiTapeDrive.SetPadding(const Value: DWORD); begin end;
procedure TWmiTapeDrive.SetReportSetMarks(const Value: boolean); begin end;
procedure TWmiTapeDrive.SetTapeDriveID(const Value: widestring); begin end;

{ TWmiTapeDriveList }

function TWmiTapeDriveList.GetItem(AIndex: integer): TWmiTapeDrive;
begin
  Result := TWmiTapeDrive(inherited GetItem(AIndex));
end;

procedure TWmiTapeDriveList.SetItem(AIndex: integer;
  const Value: TWmiTapeDrive);
begin
  inherited SetItem(AIndex, Value);
end;

{ TWmiDriveBase }

constructor TWmiDriveBase.Create(AOwner: TWmiEntityList;
  AInternallyCreated: boolean; AClass: TWmiEntityListClass);
begin
  inherited Create(AOwner, AInternallyCreated, AClass);
end;

destructor TWmiDriveBase.Destroy;
begin
  if FCapabilities <> nil then FCapabilities.Free;
  inherited;
end;

function TWmiDriveBase.GetCapabilities: TStrings;
begin
  if FCapabilities = nil then FCapabilities := TStringList.Create;
  Result := FCapabilities;
end;

procedure TWmiDriveBase.LoadProperties(ADrive: ISWbemObject);
var
  vProperties: ISWbemPropertySet;

  vCapabilities: OleVariant;
  vCapabilityDescriptions: OleVariant;
  s: widestring;
  i: integer;
begin
  inherited;
  WmiCheck(ADrive.Get_Properties_(vProperties));
  FCompressionMethod        := WmiGetStringPropertyValueByName(vProperties, 'CompressionMethod');
  FManufacturer             := WmiGetStringPropertyValueByName(vProperties, 'Manufacturer');
  FNeedsCleaning            := WmiGetBooleanPropertyValueByName(vProperties, 'NeedsCleaning');
  FNumberOfMediaSupported   := WmiGetIntegerPropertyValueByName(vProperties, 'NumberOfMediaSupported');
  FMaxBlockSize             := WmiGetInt64PropertyValueByName(vProperties, 'MaxBlockSize');
  FDefaultBlockSize         := WmiGetInt64PropertyValueByName(vProperties, 'DefaultBlockSize');
  FMinBlockSize             := WmiGetInt64PropertyValueByName(vProperties, 'MinBlockSize');
  FMaxMediaSize             := WmiGetInt64PropertyValueByName(vProperties, 'MaxMediaSize');

  // load capabilities. Combine the code and descriioption
  // into one string.
  if FCapabilities = nil then FCapabilities := TStringList.Create;
  FCapabilities.Clear;
  vCapabilities := WmiGetPropertyValueByName(vProperties, 'Capabilities');
  vCapabilityDescriptions := WmiGetPropertyValueByName(vProperties, 'CapabilityDescriptions');
  if VarIsArray(vCapabilities) then
  begin
    for i := VarArrayLowBound(vCapabilities, 1) to VarArrayHighBound(vCapabilities, 1) do
    begin
       s := IntToStr(vCapabilities[i]) + ':';
       if VarIsArray(vCapabilityDescriptions) then
         s := s + vCapabilityDescriptions[i]
         else s := s + GetCapabilityDescription(vCapabilities[i]);
       FCapabilities.Add(s);
    end;   
  end;
end;

procedure TWmiDriveBase.SetCapabilities(const Value: TStrings);begin end;
procedure TWmiDriveBase.SetCompressionMethod(const Value: widestring);begin end;
procedure TWmiDriveBase.SetDefaultBlockSize(const Value: int64);begin end;
procedure TWmiDriveBase.SetManufacturer(const Value: widestring);begin end;
procedure TWmiDriveBase.SetMaxBlockSize(const Value: int64);begin end;
procedure TWmiDriveBase.SetMaxMediaSize(const Value: int64);begin end;
procedure TWmiDriveBase.SetMinBlockSize(const Value: int64);begin end;
procedure TWmiDriveBase.SetNeedsCleaning(const Value: boolean);begin end;
procedure TWmiDriveBase.SetNumberOfMediaSupported(const Value: DWORD);begin end;

end.


