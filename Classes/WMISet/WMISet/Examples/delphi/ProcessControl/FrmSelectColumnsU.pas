unit FrmSelectColumnsU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmSelectColumns = class(TForm)
    chbImageName: TCheckBox;
    chbIOOther: TCheckBox;
    chbPID: TCheckBox;
    chbIOOtherBytes: TCheckBox;
    chbCpuUsage: TCheckBox;
    chbPagedPool: TCheckBox;
    chbCpuTime: TCheckBox;
    chbNonPagedPool: TCheckBox;
    chbMemoryUsage: TCheckBox;
    chbBasePriority: TCheckBox;
    chbPeakMemoryUsage: TCheckBox;
    chbHandleCount: TCheckBox;
    chbPageFaults: TCheckBox;
    chbThreadCount: TCheckBox;
    chbIOReads: TCheckBox;
    chbVirtualMemory: TCheckBox;
    chbIOReadBytes: TCheckBox;
    chbSessionId: TCheckBox;
    chbIOWrites: TCheckBox;
    chbStartedAt: TCheckBox;
    chbIOWriteBytes: TCheckBox;
    chbFullPath: TCheckBox;
    Bevel1: TBevel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSelectColumns: TFrmSelectColumns;

implementation

{$R *.dfm}

procedure TFrmSelectColumns.FormCreate(Sender: TObject);
begin
  ClientWidth := btnCancel.Left + btnCancel.Width + 7; 
  ClientHeight := btnCancel.Top + btnCancel.Height + 7; 
end;

end.
