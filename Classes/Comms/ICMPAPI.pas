{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved}

unit ICMPAPI;

interface

uses
  Windows;

type
  TIPAddr=longint;

  PIPOptionInformation=^TIPOptionInformation;
  TIPOptionInformation=
  record
    TimeToLive:byte;
    TimeOfService:byte;
    Flags:byte;
    OptionsSize:byte;
    OptionsData:^byte;
  end;

  TICMPEchoReply=
  record
    Address:TIPAddr;
    Status:ULONG;
    RoundTripTime:ULONG;
    DataSize:ULONG;
    Reserved:ULONG;
    Data:pointer;
    Options:PIPOptionInformation;
  end;

const
  ICMPDLL='ICMP.DLL';

  IP_STATUS_BASE = 11000;

  IP_SUCCESS                  = 0;
  IP_BUF_TOO_SMALL            = (IP_STATUS_BASE + 1);
  IP_DEST_NET_UNREACHABLE     = (IP_STATUS_BASE + 2);
  IP_DEST_HOST_UNREACHABLE    = (IP_STATUS_BASE + 3);
  IP_DEST_PROT_UNREACHABLE    = (IP_STATUS_BASE + 4);
  IP_DEST_PORT_UNREACHABLE    = (IP_STATUS_BASE + 5);
  IP_NO_RESOURCES             = (IP_STATUS_BASE + 6);
  IP_BAD_OPTION               = (IP_STATUS_BASE + 7);
  IP_HW_ERROR                 = (IP_STATUS_BASE + 8);
  IP_PACKET_TOO_BIG           = (IP_STATUS_BASE + 9);
  IP_REQ_TIMED_OUT            = (IP_STATUS_BASE + 10);
  IP_BAD_REQ                  = (IP_STATUS_BASE + 11);
  IP_BAD_ROUTE                = (IP_STATUS_BASE + 12);
  IP_TTL_EXPIRED_TRANSIT      = (IP_STATUS_BASE + 13);
  IP_TTL_EXPIRED_REASSEM      = (IP_STATUS_BASE + 14);
  IP_PARAM_PROBLEM            = (IP_STATUS_BASE + 15);
  IP_SOURCE_QUENCH            = (IP_STATUS_BASE + 16);
  IP_OPTION_TOO_BIG           = (IP_STATUS_BASE + 17);
  IP_BAD_DESTINATION          = (IP_STATUS_BASE + 18);

  IP_ADDR_DELETED             = (IP_STATUS_BASE + 19);
  IP_SPEC_MTU_CHANGE          = (IP_STATUS_BASE + 20);
  IP_MTU_CHANGE               = (IP_STATUS_BASE + 21);
  IP_UNLOAD                   = (IP_STATUS_BASE + 22);
  IP_ADDR_ADDED               = (IP_STATUS_BASE + 23);

  IP_GENERAL_FAILURE          = (IP_STATUS_BASE + 50);
  MAX_IP_STATUS               = IP_GENERAL_FAILURE;
  IP_PENDING                  = (IP_STATUS_BASE + 255);

  IP_FLAG_DF      = $02;

  IP_OPT_EOL      = 0;
  IP_OPT_NOP      = 1;
  IP_OPT_SECURITY = $82;
  IP_OPT_LSRR     = $83;
  IP_OPT_SSRR     = $89;
  IP_OPT_RR       = $07;
  IP_OPT_TS       = $44;
  IP_OPT_SID      = $88;

  MAX_OPT_SIZE    = 40;

function ICMPCreateFile:THandle;stdcall;
function ICMPCloseHandle(ICMPHandle:THandle):boolean;stdcall;
function ICMPSendEcho(ICMPHandle:THandle;DestinationAddress:TIPAddr;RequestData:pointer;
             RequestSize:word;RequestOptions:PIPOptionInformation;ReplyBuffer:pointer;
             ReplySize:DWORD;Timeout:DWORD):DWORD;stdcall;

implementation

function ICMPCreateFile;external ICMPDLL Name 'IcmpCreateFile';
function ICMPCloseHandle;external ICMPDLL Name 'IcmpCloseHandle';
function ICMPSendEcho;external ICMPDLL Name 'IcmpSendEcho';

end.


