//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FrmMainU.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "WmiAbstract"
#pragma link "WmiComponent"
#pragma link "WmiStorageInfo"
#pragma resource "*.dfm"


TForm1 *Form1;

//---------------------------------------------------------------------------
__fastcall TCredentials::TCredentials(WideString AUserName, WideString APassword)
{
        FUserName = AUserName;
        FPassword = APassword;
}

//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner): TForm(Owner) {
}

//---------------------------------------------------------------------------
WideString __fastcall TForm1::BoolToStr(bool AValue) {
  if (AValue) {
        return "yes";
  } else {
        return "no";
  }
}

//---------------------------------------------------------------------------
WideString __fastcall TForm1::GetAvailabilityDescription(WORD Availability) {
  switch (Availability) {
    case AVAIL_OTHER: return "Other";
    case AVAIL_RUNNING: return "Running";
    case AVAIL_WARNING: return "Warning";
    case AVAIL_IN_TEST: return "In test";
    case AVAIL_NOT_APPLICABLE: return "Not applicable";
    case AVAIL_POWER_OFF: return "Power off";
    case AVAIL_OFF_LINE: return "Off line";
    case AVAIL_OFF_DUTY: return "Off duty";
    case AVAIL_DEGRADED: return "Degraded";
    case AVAIL_NOT_INSTALLED: return "Not installed";
    case AVAIL_INSTALL_ERROR: return "Installation error";
    case AVAIL_POWER_SAVE_UNKNOWN: return "Power Save Unknown";
    case AVAIL_POWER_SAVE_LOW_POWER_MODE: return "Low power mode";
    case AVAIL_POWER_SAVE_STANDBY: return "Standby";
    case AVAIL_POWER_POWER_CYCLE: return "Power cycle";
    case AVAIL_POWER_SAVE_WARNING: return "Power save warning";
    case AVAIL_PAUSED: return "Paused";
    case AVAIL_NOT_READY: return "Not ready";
    case AVAIL_NOT_CONFIGURED: return "Not configured";
    case AVAIL_QUIESCED: return "Quiesced";
    default: return "Unknown";
  };
}

//---------------------------------------------------------------------------
WideString __fastcall TForm1::DriveTypeToStr(DWORD ADriveType) {
  switch (ADriveType) {
    case DT_NO_ROOT_DIRECTORY: return "No Root Directory";
    case DT_REMOVABLE_DISK:    return "Removable Disk";
    case DT_LOCAL_DISK:        return "Local Disk";
    case DT_NETWORK_DRIVE:     return "Network Drive";
    case DT_COMPACT_DISK:      return "Compact Disk";
    case DT_RAM_DISK:          return "Ram Drive";
    default: return "Unknown";
  };
}

//---------------------------------------------------------------------------
WideString __fastcall TForm1::MediaTypeToStr(DWORD AMediaType) {
  switch (AMediaType) {
    case MT_UNKNOWN: return "UNKNOWN";
    case MT_F5_1Pt2_512: return "F5_1Pt2_512";
    case MT_F3_1Pt44_512: return "F3_1Pt44_512";
    case MT_F3_2Pt88_512: return "F3_2Pt88_512";
    case MT_F3_20Pt8_512: return "F3_20Pt8_512";
    case MT_F3_720_512: return "F3_720_512";
    case MT_F5_360_512: return "F5_360_512";
    case MT_F5_320_512: return "F5_320_512";
    case MT_F5_320_1024: return "F5_320_1024";
    case MT_F5_180_512: return "F5_180_512";
    case MT_F5_160_512: return "F5_160_512";
    case MT_REMOVABLE: return "REMOVABLE";
    case MT_FIXED: return "FIXED";
    case MT_F3_120M_512: return "F3_120M_512";
    case MT_F3_640_512: return "F3_640_512";
    case MT_F5_640_512: return "F5_640_512";
    case MT_F5_720_512: return "F5_720_512";
    case MT_F3_1Pt2_512: return "F3_1Pt2_512";
    case MT_F3_1Pt23_1024: return "F3_1Pt23_1024";
    case MT_F5_1Pt23_1024: return "F5_1Pt23_1024";
    case MT_F3_128Mb_512: return "F3_128Mb_512";
    case MT_F3_230Mb_512: return "F3_230Mb_512";
    case MT_F8_256_128: return "F8_256_128";
    default: return "Unknown";
  };
};

//---------------------------------------------------------------------------
WideString __fastcall TForm1::FileSystemFlagsToStr(DWORD AFlags) {

  DWORD vMask = 1;
  WideString S;
  WideString  result = "";

  for (int i = 0; i < 32; i++) {
    if ((AFlags & vMask) != 0) {
      switch (vMask) {
        case FSF_CASE_SENSITIVE_SEARCH:   S = "Case sensitive search"; break;
        case FSF_CASE_PRESERVED_NAMES:    S = "Case preserved names"; break;
        case FSF_UNICODE_ON_DISK:         S = "Unicode on disk"; break;
        case FSF_PERSISTENT_ACLS:         S = "Persistent ACLs"; break;
        case FSF_FILE_COMPRESSION:        S = "File compression"; break;
        case FSF_VOLUME_QUOTAS:           S = "Volume quotas"; break;
        case FSF_SUPPORTS_SPARSE_FILES:   S = "Supports sparse files"; break;
        case FSF_SUPPORTS_REPARSE_POINTS: S = "Supports reparse points"; break;
        case FSF_SUPPORTS_REMOTE_STORAGE: S = "Supports remote storage"; break;
        case FSF_SUPPORTS_LONG_NAMES:     S = "Supports long names"; break;
        case FSF_VOLUME_IS_COMPRESSED:    S = "Volume is compressed"; break;
        case FSF_SUPPORTS_OBJECT_IDS:     S = "Supports object IDs"; break;
        case FSF_SUPPORTS_ENCRYPTION:     S = "Supports encryption"; break;
        case FSF_SUPPORTS_NAMED_STREAMS:  S = "Supports named streams"; break;
        default: S = "Unknown";
      };
      result = result + S + ", ";
    };
    vMask = vMask * 2;
  };
  return result;
};

//---------------------------------------------------------------------------
void __fastcall TForm1::SetWaitCursor() {
  FStoredCursor = Screen->Cursor;
  Screen->Cursor = crHourGlass;
};


//---------------------------------------------------------------------------
void __fastcall TForm1::FormResize(TObject *Sender)
{
  lvProperties->Columns->Items[1]->Width =
        lvProperties->ClientWidth - lvProperties->Columns->Items[0]->Width;

}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
  InitItems();
}

//---------------------------------------------------------------------------
void __fastcall TForm1::RestoreCursor() {
  Screen->Cursor = FStoredCursor;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::InitItems() {
  TTreeNode *vItem = tvBroswer->Items->Add(NULL, LOCAL_HOST);
  tvBroswer->Items->AddChild(vItem, NO_DATA);
  vItem = tvBroswer->Items->Add(NULL, NETWORK);
  tvBroswer->Items->AddChild(vItem, NO_DATA);
};

//---------------------------------------------------------------------------
void __fastcall TForm1::tvBroswerExpanding(TObject *Sender,
      TTreeNode *Node, bool &AllowExpansion) {
  AllowExpansion = ProcessNodeExpanding(Node);
}

//---------------------------------------------------------------------------
bool __fastcall TForm1::ProcessNodeExpanding(TTreeNode *ANode) {

  bool result = true;
  if ((ANode->Count == 1) && (ANode->getFirstChild()->Text == NO_DATA)) {
    result = false;
    if (ANode->Text == LOCAL_HOST) result = AddStorageDeviceNodes(ANode);
      else
    if (ANode->Text == NETWORK) result = LoadRemoteHosts(ANode);
      else
    if ((ANode->Parent != NULL) && (ANode->Parent->Text == NETWORK)) {
      if (DoConnect(ANode)) result = AddStorageDeviceNodes(ANode);
    } else
    if (ANode->Text == DISKS) result = LoadDiskDrives(ANode);
      else
    if (ANode->Text == TAPES) result = LoadTapes(ANode);
      else
    if (ANode->Text == FLOPPY_DRIVES) result = LoadFloppyDrives(ANode);
      else
    if (ANode->Text == LOGICAL_DISKS) result = LoadLogicalDisks(ANode);
      else
    if (ANode->Text == CDROM_DRIVES) result = LoadCDROMDrives(ANode);
      else
    if (ANode->Text == PARTITIONS) result = LoadPartitions(ANode);
  }

  return result;
}

//---------------------------------------------------------------------------
bool __fastcall TForm1::LoadPartitions(TTreeNode *ANode) {

  if (!DoConnect(ANode->Parent)) return false;

  ANode->DeleteChildren();
  SetWaitCursor();
  __try {
    for (int i = 0; i < WmiStorageInfo1->Partitions->Count; i++) {
       tvBroswer->Items->AddChild(ANode, WmiStorageInfo1->Partitions->Items[i]->Caption);
    }
  } __finally {
    RestoreCursor();
  };

  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::LoadTapes(TTreeNode *ANode) {

  if (!DoConnect(ANode->Parent)) return false;

  ANode->DeleteChildren();
  SetWaitCursor();
  __try {
    for (int i = 0; i < WmiStorageInfo1->TapeDrives->Count; i++) {
       tvBroswer->Items->AddChild(ANode, WmiStorageInfo1->TapeDrives->Items[i]->Caption);
    }
  } __finally {
    RestoreCursor();
  };
  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::LoadDiskDrives(TTreeNode *ANode) {

  if (!DoConnect(ANode->Parent)) return false;

  ANode->DeleteChildren();
  SetWaitCursor();
  __try {
      for (int i = 0; i < WmiStorageInfo1->DiskDrives->Count; i++) {
         tvBroswer->Items->AddChild(ANode, WmiStorageInfo1->DiskDrives->Items[i]->Caption);
      }
  } __finally {
    RestoreCursor();
  };

  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::LoadFloppyDrives(TTreeNode *ANode) {

  if (!DoConnect(ANode->Parent)) return false;

  ANode->DeleteChildren();
  SetWaitCursor();
  try {
    for (int i = 0; i <  WmiStorageInfo1->FloppyDrives->Count; i++) {
       tvBroswer->Items->AddChild(ANode, WmiStorageInfo1->FloppyDrives->Items[i]->Caption);
    }
  } __finally {
    RestoreCursor();
  };
  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::LoadLogicalDisks(TTreeNode *ANode) {

  if (!DoConnect(ANode->Parent)) return false;

  ANode->DeleteChildren();
  SetWaitCursor();
  __try {
    for (int i = 0; i < WmiStorageInfo1->LogicalDisks->Count; i++) {
       tvBroswer->Items->AddChild(ANode, WmiStorageInfo1->LogicalDisks->Items[i]->Caption);
    }   
  } __finally { 
    RestoreCursor();
  };
  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::LoadCDROMDrives(TTreeNode *ANode) {

  if (!DoConnect(ANode->Parent)) return false;

  ANode->DeleteChildren();
  SetWaitCursor();
  __try {
    for (int i = 0; i < WmiStorageInfo1->CDROMDrives->Count; i++) {
       tvBroswer->Items->AddChild(ANode, WmiStorageInfo1->CDROMDrives->Items[i]->Caption);
    }
  } __finally {
    RestoreCursor();
  };
  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::DoConnect(TTreeNode *ANode) {

  bool result = false;
  TCredentials *vCredentials;
  TFrmNewHost *vForm;

  // do not reconnect if already connected to desired host.
  if ((ANode->Text == WmiStorageInfo1->MachineName) && (WmiStorageInfo1->Active)) {
    return true;
  }

  // if the node represents the local host, clear credentials.
  // Otherwise try 1) to connect without credentiols. If it fails 2) ask user
  // for creadentials and try co connect again.
  // if connection is a sucess, remember sucessfull credentials, so
  // user does not have to enter them again.

  SetWaitCursor();
  try {
    WmiStorageInfo1->Active = false;
    if (ANode->Text == LOCAL_HOST) {
      // connect to local host;
      WmiStorageInfo1->Credentials->Clear();
      WmiStorageInfo1->MachineName = "";
      WmiStorageInfo1->Active = true;
      result = true;
    } else {
      if (ANode->Data == NULL) {
        // connect for the first time
        // try default credentials fisrt:
        try {
          WmiStorageInfo1->Credentials->Clear();
          WmiStorageInfo1->MachineName = ANode->Text;
          WmiStorageInfo1->Active = true;
          result = true;
        } catch (...)  {
          // expected exception: the credentials are not valid
        };

        // default credentials did not work.
        // try to connect with user's provided credentials
        if (!WmiStorageInfo1->Active) {
          vForm = new TFrmNewHost(NULL);
          vForm->MachineName = ANode->Text;
          __try {
            while (vForm->ShowModal() == mrOk) {
              try {
                WmiStorageInfo1->Active = false;
                WmiStorageInfo1->Credentials->Clear();
                WmiStorageInfo1->MachineName = ANode->Text;
                WmiStorageInfo1->Credentials->UserName = vForm->UserName;
                WmiStorageInfo1->Credentials->Password = vForm->edtPassword->Text;
                WmiStorageInfo1->Active = true;

                // connected successfully; remember credentials
                ANode->Data = new TCredentials(vForm->UserName, vForm->edtPassword->Text);
                AddStorageDeviceNodes(ANode);
                result = true;
                break;
              } catch (const Exception &e) {
                  Application->MessageBox(e.Message.c_str(), "Error", ID_OK);
              };
            }  
          } __finally {
            vForm->Free();
          };
        };
      } else {

        // reconnect with existing credentials
//        vCredentials = (dynamic_cast <TCredentials *>(ANode->Data));
        vCredentials = (TCredentials *) ANode->Data;

        WmiStorageInfo1->MachineName = ANode->Text;
        WmiStorageInfo1->Credentials->UserName = vCredentials->UserName;
        WmiStorageInfo1->Credentials->Password = vCredentials->Password;
        WmiStorageInfo1->Active = true;
        result = true;
      };
    };
  } __finally {
    RestoreCursor();
  };

  return result;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::LoadRemoteHosts(TTreeNode *ANode) {

  TStrings *AList = new TStringList();
  ANode->DeleteChildren();
  SetWaitCursor();
  __try {
    WmiStorageInfo1->ListServers(AList);
    for (int i = 0; i < AList->Count; i++) {
      TTreeNode *vNode = tvBroswer->Items->AddChild(ANode, AList->Strings[i]);
      AddStorageDeviceNodes(vNode);
    };
  } __finally {
    AList->Free();
    RestoreCursor();
  };
  return true;
};

//---------------------------------------------------------------------------
bool __fastcall TForm1::AddStorageDeviceNodes(TTreeNode *ANode) {

  ANode->DeleteChildren();

  TTreeNode *vItem = tvBroswer->Items->AddChild(ANode, CDROM_DRIVES);
  tvBroswer->Items->AddChild(vItem, NO_DATA);

  vItem = tvBroswer->Items->AddChild(ANode, DISKS);
  tvBroswer->Items->AddChild(vItem, NO_DATA);

  vItem = tvBroswer->Items->AddChild(ANode, FLOPPY_DRIVES);
  tvBroswer->Items->AddChild(vItem, NO_DATA);

  vItem = tvBroswer->Items->AddChild(ANode, LOGICAL_DISKS);
  tvBroswer->Items->AddChild(vItem, NO_DATA);

  vItem = tvBroswer->Items->AddChild(ANode, PARTITIONS);
  tvBroswer->Items->AddChild(vItem, NO_DATA);

  vItem = tvBroswer->Items->AddChild(ANode, TAPES);
  tvBroswer->Items->AddChild(vItem, NO_DATA);

  return true;
};

//---------------------------------------------------------------------------

void __fastcall TForm1::tvBroswerChanging(TObject *Sender, TTreeNode *Node,
      bool &AllowChange) {
  ProcessChangingNode(Node);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ProcessChangingNode(TTreeNode *ANode) {
  if (ANode->Parent != NULL) {
    if (ANode->Parent->Text == DISKS) LoadDiskProperties(ANode);
      else
    if (ANode->Parent->Text == TAPES) LoadTapeProperties(ANode);
      else
    if (ANode->Parent->Text == FLOPPY_DRIVES) LoadFloppyProperties(ANode);
      else
    if (ANode->Parent->Text == LOGICAL_DISKS) LoadLogicalDiskProperties(ANode);
      else
    if (ANode->Parent->Text == PARTITIONS) LoadPartitionProperties(ANode);
      else
    if (ANode->Parent->Text == CDROM_DRIVES) LoadCDROMProperties(ANode);
      else ClearPropertyViewView();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::AddPropertyItem(WideString ACaption, WideString AValue) {
  TListItem *vItem = lvProperties->Items->Add();
  vItem->Caption = ACaption;
  vItem->SubItems->Add(AValue);
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadDeviceProperties(TWmiDevice *ADrive) {
  AddPropertyItem("Caption", ADrive->Caption);
  AddPropertyItem("Description", ADrive->Description);
  AddPropertyItem("DeviceId", ADrive->DeviceId);
  AddPropertyItem("ErrorMethodology", ADrive->ErrorMethodology);
  if (((double) ADrive->InstallDate) > 0.0) {
     AddPropertyItem("InstallDate", DateToStr(ADrive->InstallDate));
  }
  AddPropertyItem("Plug&PlayDeviceID", ADrive->PNPDeviceID);
  AddPropertyItem("Status", ADrive->Status);
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadCommonDriveProperties(TWmiDriveBase *ADrive) {

  AnsiString s = "";
  for (int i = 0; i <  ADrive->Capabilities->Count; i++) {
    s = s + ADrive->Capabilities->Strings[i];
    if (i < ADrive->Capabilities->Count - 1) s = s + ", ";
  };
  AddPropertyItem("Capabilities", s);
  AddPropertyItem("Availability", GetAvailabilityDescription(ADrive->Availability));
  AddPropertyItem("Manufacturer", ADrive->Manufacturer);
  AddPropertyItem("Default Block Size", IntToStr(ADrive->DefaultBlockSize));
  AddPropertyItem("Compression Method", ADrive->CompressionMethod);
  AddPropertyItem("Max Block Size", IntToStr(ADrive->MaxBlockSize));
  AddPropertyItem("Min Block Size", IntToStr(ADrive->MinBlockSize));
  AddPropertyItem("Max Media Size", IntToStr(ADrive->MaxMediaSize));
  AddPropertyItem("Needs cleaning", BoolToStr(ADrive->NeedsCleaning));
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadDiskProperties(TTreeNode *ANode) {
  lvProperties->Items->BeginUpdate();
  try {
    ClearPropertyViewView();
    DoConnect(ANode->Parent->Parent); // The method needs a node that is a host.
    TWmiDiskDrive *vDiskDrive = WmiStorageInfo1->DiskDrives->Items[ANode->Index];
    LoadDeviceProperties(vDiskDrive);
    LoadCommonDriveProperties(vDiskDrive);
    AddPropertyItem("Bytes Per Sector", IntToStr(vDiskDrive->BytesPerSector));
    AddPropertyItem("Drive Index", IntToStr(vDiskDrive->DriveIndex));
    AddPropertyItem("Interface Type", vDiskDrive->InterfaceType);
    AddPropertyItem("Media Loaded", BoolToStr(vDiskDrive->MediaLoaded));
    AddPropertyItem("Model", vDiskDrive->Model);
    AddPropertyItem("Media Type", vDiskDrive->MediaType);
    AddPropertyItem("Partitions", IntToStr(vDiskDrive->Partitions));
    AddPropertyItem("SCSI Bus", IntToStr(vDiskDrive->SCSIBus));
    AddPropertyItem("SCSI Logical Unit", IntToStr(vDiskDrive->SCSILogicalUnit));
    AddPropertyItem("SCSI Target Id", IntToStr(vDiskDrive->SCSITargetId));
    AddPropertyItem("Sectors Per Track", IntToStr(vDiskDrive->SectorsPerTrack));
    AddPropertyItem("Signature", IntToStr(vDiskDrive->Signature));
    AddPropertyItem("Size", IntToStr(vDiskDrive->Size));
    AddPropertyItem("Total Cylinders", IntToStr(vDiskDrive->TotalCylinders));
    AddPropertyItem("Total Heads", IntToStr(vDiskDrive->TotalHeads));
    AddPropertyItem("Total Sectors", IntToStr(vDiskDrive->TotalSectors));
    AddPropertyItem("Total Tracks", IntToStr(vDiskDrive->TotalTracks));
    AddPropertyItem("Tracks Per Cylinder", IntToStr(vDiskDrive->TracksPerCylinder));

    lvProperties->SortType = (TSortType) 2;
  } __finally {
    lvProperties->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::AddAccessPropertyItem(DWORD AAccess) {

  const char *ACCESS = "Access";

  switch (AAccess) {
    case DISK_ACCESS_READABLE:   AddPropertyItem(ACCESS, "Readable");
    case DISK_ACCESS_WRITABLE:   AddPropertyItem(ACCESS, "Writable");
    case DISK_ACCESS_READ_WRITE: AddPropertyItem(ACCESS, "Read-write");
    case DISK_ACCESS_WRITE_ONCE: AddPropertyItem(ACCESS, "Wrice once");
    default: AddPropertyItem(ACCESS, "Unknown");
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadPartitionProperties(TTreeNode *ANode) {
  lvProperties->Items->BeginUpdate();
  __try {
    ClearPropertyViewView();
    DoConnect(ANode->Parent->Parent); // The method needs a node that is a host.
    TWmiPartition *vPartition = WmiStorageInfo1->Partitions->Items[ANode->Index];
    LoadDeviceProperties(vPartition);

    AddAccessPropertyItem(vPartition->Access);
    AddPropertyItem("Block Size", IntToStr(vPartition->BlockSize));
    AddPropertyItem("Bootable", BoolToStr(vPartition->Bootable));
    AddPropertyItem("Boot Partition", BoolToStr(vPartition->BootPartition));
    AddPropertyItem("Disk Index", IntToStr(vPartition->DiskIndex));
    AddPropertyItem("Partition Index", IntToStr(vPartition->PartitionIndex));
    AddPropertyItem("Number Of Blocks", IntToStr(vPartition->NumberOfBlocks));
    AddPropertyItem("Primary Partition", BoolToStr(vPartition->PrimaryPartition));
    AddPropertyItem("Purpose", vPartition->Purpose);
    AddPropertyItem("Rewrite Partition", BoolToStr(vPartition->RewritePartition));
    AddPropertyItem("Size", IntToStr(vPartition->Size));
    AddPropertyItem("Starting Offset", IntToStr(vPartition->StartingOffset));
    AddPropertyItem("System Type", vPartition->SystemType);

    lvProperties->SortType = (TSortType) 2;
  } __finally {
    lvProperties->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadTapeProperties(TTreeNode *ANode) {
  lvProperties->Items->BeginUpdate();
  __try {
    ClearPropertyViewView();
    DoConnect(ANode->Parent->Parent); // The method needs a node that is a host.
    TWmiTapeDrive *vTapeDrive = WmiStorageInfo1->TapeDrives->Items[ANode->Index];
    LoadDeviceProperties(vTapeDrive);
    LoadCommonDriveProperties(vTapeDrive);

    AddPropertyItem("Compression", BoolToStr(vTapeDrive->Compression));
    AddPropertyItem("ECC", BoolToStr(vTapeDrive->ECC));
    AddPropertyItem("EOT Warning Zone Size", IntToStr(vTapeDrive->EOTWarningZoneSize));
    AddPropertyItem("Tape Drive ID", vTapeDrive->TapeDriveID);
    AddPropertyItem("Max Partition Count", IntToStr(vTapeDrive->MaxPartitionCount));
    AddPropertyItem("Media Type", vTapeDrive->MediaType);
    AddPropertyItem("Padding", IntToStr(vTapeDrive->Padding));
    AddPropertyItem("Report Set Marks", BoolToStr(vTapeDrive->ReportSetMarks));

    lvProperties->SortType = (TSortType) 2;
  } __finally {
    lvProperties->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadFloppyProperties(TTreeNode *ANode) {
  lvProperties->Items->BeginUpdate();
  __try {
    ClearPropertyViewView();
    DoConnect(ANode->Parent->Parent); // The method needs a node that is a host.
    TWmiFloppyDrive *vFloppyDrive = WmiStorageInfo1->FloppyDrives->Items[ANode->Index];
    LoadDeviceProperties(vFloppyDrive);
    LoadCommonDriveProperties(vFloppyDrive);

    lvProperties->SortType = (TSortType) 2;
  } __finally {
    lvProperties->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadLogicalDiskProperties(TTreeNode *ANode) {
  lvProperties->Items->BeginUpdate();
  __try {
    ClearPropertyViewView();
    DoConnect(ANode->Parent->Parent); // The method needs a node that is a host.
    TWmiLogicalDisk *vDisk = WmiStorageInfo1->LogicalDisks->Items[ANode->Index];
    LoadDeviceProperties(vDisk);
    AddAccessPropertyItem(vDisk->Access);
    AddPropertyItem("Block Size", IntToStr(vDisk->BlockSize));
    AddPropertyItem("Compressed", BoolToStr(vDisk->Compressed));
    AddPropertyItem("Drive Type", DriveTypeToStr(vDisk->DriveType));
    AddPropertyItem("FileSystem", vDisk->FileSystem);
    AddPropertyItem("FreeSpace", IntToStr(vDisk->FreeSpace));
    AddPropertyItem("Maximum Component Length", IntToStr(vDisk->MaximumComponentLength));
    AddPropertyItem("Media Type", MediaTypeToStr(vDisk->MediaType));
    AddPropertyItem("Number Of Blocks", IntToStr(vDisk->NumberOfBlocks));
    AddPropertyItem("Provider Name", vDisk->ProviderName);
    AddPropertyItem("Purpose", vDisk->Purpose);
    AddPropertyItem("Quotas Disabled", BoolToStr(vDisk->QuotasDisabled));
    AddPropertyItem("Quotas Incomplete", BoolToStr(vDisk->QuotasIncomplete));
    AddPropertyItem("Quotas Rebuilding", BoolToStr(vDisk->QuotasRebuilding));
    AddPropertyItem("Size", IntToStr(vDisk->Size));
    AddPropertyItem("Supports Disk Quotas", BoolToStr(vDisk->SupportsDiskQuotas));
    AddPropertyItem("Supports File Based Compression", BoolToStr(vDisk->SupportsFileBasedCompression));
    AddPropertyItem("VolumeDirty", BoolToStr(vDisk->VolumeDirty));
    AddPropertyItem("VolumeName", vDisk->VolumeName);
    AddPropertyItem("VolumeSerialNumber", vDisk->VolumeSerialNumber);

    lvProperties->SortType = (TSortType) 2;
  } __finally {
    lvProperties->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::LoadCDROMProperties(TTreeNode *ANode) {
  lvProperties->Items->BeginUpdate();
  __try {
    ClearPropertyViewView();
    DoConnect(ANode->Parent->Parent); // The method needs a node that is a host.
    TWmiCDROMDrive *vCDROMDrive = WmiStorageInfo1->CDROMDrives->Items[ANode->Index];
    LoadDeviceProperties(vCDROMDrive);
    LoadCommonDriveProperties(vCDROMDrive);

    AddPropertyItem("Drive", vCDROMDrive->Drive);
    AddPropertyItem("Drive Integrity", BoolToStr(vCDROMDrive->DriveIntegrity));
    AddPropertyItem("FileSystemFlagsEx", FileSystemFlagsToStr(vCDROMDrive->FileSystemFlagsEx));
    AddPropertyItem("Drive Id", vCDROMDrive->DriveId);
    AddPropertyItem("Maximum Component Length", IntToStr(vCDROMDrive->MaximumComponentLength));
    AddPropertyItem("Media Loaded", BoolToStr(vCDROMDrive->MediaLoaded));
    AddPropertyItem("Media Type", vCDROMDrive->MediaType);
    AddPropertyItem("Manufacturer Assigned Revision Level", vCDROMDrive->MfrAssignedRevisionLevel);
    AddPropertyItem("Revision Level", vCDROMDrive->RevisionLevel);
    AddPropertyItem("SCSI Bus", IntToStr(vCDROMDrive->SCSIBus));
    AddPropertyItem("SCSI Logical Unit", IntToStr(vCDROMDrive->SCSILogicalUnit));
    AddPropertyItem("SCSI Port", IntToStr(vCDROMDrive->SCSIPort));
    AddPropertyItem("SCSI Target Id", IntToStr(vCDROMDrive->SCSITargetId));
    AddPropertyItem("Size", IntToStr(vCDROMDrive->Size));
    AddPropertyItem("TransferRate", FloatToStr(vCDROMDrive->TransferRate));
    AddPropertyItem("VolumeName", vCDROMDrive->VolumeName);
    AddPropertyItem("VolumeSerialNumber", vCDROMDrive->VolumeSerialNumber);

    lvProperties->SortType = (TSortType) 2;
  } __finally {
    lvProperties->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::ClearPropertyViewView() {
  lvProperties->Items->BeginUpdate();
  __try {
    lvProperties->Items->Clear();
  } __finally {
    lvProperties->Items->EndUpdate();
  };
};

//---------------------------------------------------------------------------
void __fastcall TForm1::CreateNewNetworkNode() {

  TFrmNewHost *vForm = new TFrmNewHost(NULL);
  __try {
    while (vForm->ShowModal() == mrOk) {
      try {
        WmiStorageInfo1->Active = false;
        WmiStorageInfo1->Credentials->Clear();
        WmiStorageInfo1->MachineName = vForm->edtHostName->Text;
        WmiStorageInfo1->Credentials->UserName = vForm->UserName;
        WmiStorageInfo1->Credentials->Password = vForm->edtPassword->Text;
        WmiStorageInfo1->Active = true;

        // connected successfully; add the new host to a list.
        TTreeNode *vNode = FindNeworkNode();
        if ((vNode->getFirstChild() != NULL) &&
           (vNode->getFirstChild()->Text == NO_DATA)) {
             vNode->DeleteChildren();
        }        

        vNode = tvBroswer->Items->AddChild(vNode, vForm->edtHostName->Text);
        vNode->Data = new TCredentials(vForm->UserName, vForm->edtPassword->Text);
        AddStorageDeviceNodes(vNode);
        tvBroswer->Selected = vNode;
        break;

      } catch (const Exception &e) {
          Application->MessageBox(e.Message.c_str(), "Error", ID_OK);
      };
    }  
  } __finally {
    vForm->Free();
  };
};

//---------------------------------------------------------------------------
TTreeNode* __fastcall TForm1::FindNeworkNode() {
  for (int i = 0; i < tvBroswer->Items->Count; i++) {
    if (tvBroswer->Items->Item[i]->Text == NETWORK) {
      return tvBroswer->Items->Item[i];
    }
  }

  return NULL;    
};

void __fastcall TForm1::ToolButton1Click(TObject *Sender)
{
  CreateNewNetworkNode();        
}
//---------------------------------------------------------------------------

