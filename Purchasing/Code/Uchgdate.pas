unit uChgDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ComCtrls, DB, ADODB, Math;

type
  TfChgDate = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dtNewdate: TDateTimePicker;
    qryLastStockDate: TADOQuery;
    qryUnstockedDiv: TADOQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    LastStockDate: TDateTime;
    function DateValid: Boolean;
  public
    { Public declarations }
    newdate : Tdatetime;
  end;

var
  fchgdate: Tfchgdate;

implementation

uses
  uGlobals, uLog, uADO;

{$R *.DFM}

function Tfchgdate.DateValid: Boolean;
var
  UKUSDateFormat: string;
begin
  Result := True;

  if UKUSmode = 'UK' then
    UKUSDateFormat := 'dd/mm/yyyy'
  else
    UKUSDateFormat := 'mm/dd/yyyy';

  with qryLastStockDate do
  begin
    try
      Open;
      LastStockDate := FieldByName('LastStock').AsDateTime;
      Close;
    except
      on E: Exception do
      begin
        log.Event('fchgdate; ERROR - DateValid: getting last stocktake date. ' + E.Message + '; ' + qryLastStockDate.SQL.Text);
        raise;
      end;
    end;
  end;

  // Compare dates, but strip off time part.
  if floor(dtNewDate.DateTime) <= floor(LastStockDate) then
  begin
    try
      // if unstocked divisions exist then allow the new invoice to be created.
      qryUnstockedDiv.Open;
      if qryUnstockedDiv.RecordCount = 0 then
      begin
        ShowMessage('Date entered must be after last stocktake (' +
          FormatDateTime(UKUSDateFormat, LastStockDate) + ')');
        Result := false;
      end;
      qryUnstockedDiv.Close;
    except
      on E: Exception do
      begin
        log.Event('fchgdate; ERROR - DateValid: checking against last stocktake date. ' + E.Message + '; ' + qryUnstockedDiv.SQL.Text);
        raise;
      end;
    end;
  end;

  if floor(dtNewDate.DateTime) > floor(date) then
  begin
    ShowMessage('Date cannot be in the future.');
    result := false;
  end;
end;

procedure Tfchgdate.BitBtn1Click(Sender: TObject);
begin
  if DateValid then
  begin
    newdate := dtNewDate.Date;
    ModalResult := mrOK;
  end
  else
  begin
    ModalResult := mrNone;
  end;
end;

procedure TfChgDate.FormShow(Sender: TObject);
begin
  log.event('fchgdate; FormShow');
  fchgdate.Caption := 'Change ' + GetLocalisedName(lsInvoice) + ' Date'; // Job 16221
  dtNewDate.SetFocus;
end;

procedure Tfchgdate.FormCreate(Sender: TObject);
begin
  log.event('fchgdate; FormCreate');
end;

procedure Tfchgdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('fchgdate; FormClose');
end;

end.
