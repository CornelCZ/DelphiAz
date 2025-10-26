unit uEditParkingSpace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, DBCtrls, DB, Mask, ADODB, strUtils;

const
  PAY_POINT = 1;
  PICKUP_POINT = 2;
  PAYPICKUP_POINT = 4;
type
  TEditParkingSpace = class(TForm)
    lblSequence: TLabel;
    btOk: TButton;
    btCancel: TButton;
    gbxType: TGroupBox;
    lblAssign: TLabel;
    cbTerminalName: TComboBox;
    cbxPayPoint: TCheckBox;
    cbxPickupPoint: TCheckBox;
    edtSeqNum: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure cbTerminalNameChange(Sender: TObject);
  private
    TerminalName : String;
  public
    TerminalList: TStringList;
    FTerminalID : integer;
    function GetTerminalList: TStrings;
    property TerminalID : integer read FTerminalID write FTerminalID;
  end;

implementation

uses
  uAztecLog, uTillButton,uEditOutletDriveThru, udmThemeData;

{$R *.dfm}

procedure TEditParkingSpace.FormShow(Sender: TObject);
begin

  TerminalList := TStringList.Create;
  cbTerminalName.Items.Assign(GetTerminalList);

  if TerminalID > 0 then
    cbTerminalName.ItemIndex := TerminalList.IndexOf(TerminalName)
  else
    cbTerminalName.ItemIndex := 0;

  Log('Form Show Edit Parking Space');
end;

procedure TEditParkingSpace.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close Edit Parking Space');
end;

procedure TEditParkingSpace.btOkClick(Sender: TObject);
begin
  //Pay Point Validation
  if (cbxPayPoint.Checked = true) and (cbxPickupPoint.Checked = false) then
     begin
       if (EditOutletDriveThru.PointTypeExists(PAY_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pay Point already exists.', mtError, [mbOK],0)
       else
       if (EditOutletDriveThru.notBeforeAfterPointType(False, PICKUP_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pay Point cannot be placed after a Pickup Point.', mtError,[mbOK],0)
       else
       if (EditOutletDriveThru.PointTypeExists(PAYPICKUP_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pay Point cannot be added to a Drive Thru plan that contains a Pay/Pickup Point', mtError, [mbOK],0)
       else
       if (cbTerminalName.ItemIndex = 0) then
          begin
            MessageDlg('Please assign a terminal to the Pay Point.',mtError,[mbok], 0);
            cbTerminalName.SetFocus;
          end
       else
         ModalResult := mrOk;
     end
  else
  // Pickup Point Validation
  if (cbxPayPoint.Checked = false) and (cbxPickupPoint.Checked = true) then
     begin
       if (EditOutletDriveThru.PointTypeExists(PICKUP_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pickup Point already exists.', mtError, [mbOK],0)
       else
       if (EditOutletDriveThru.notBeforeAfterPointType(True, PAY_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pickup Point cannot be placed before a Pay Point.', mtError,[mbOK],0)
       else
       if (EditOutletDriveThru.PointTypeExists(PAYPICKUP_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pickup Point cannot be added to a Drive Thru plan that contains a Pay/Pickup Point', mtError, [mbOK],0)
       else
       if (EditOutletDriveThru.notBeforeAfterPointType(True, EMPTY_SPACE, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pickup Point cannot be placed before an empty Drive Thru space.', mtError, [mbOK],0)
       else
       if (cbTerminalName.ItemIndex = 0) then
          begin
            MessageDlg('Please assign a terminal to the Pickup Point.',mtError,[mbok], 0);
            cbTerminalName.SetFocus;
          end
       else
         ModalResult := mrOk;
     end
    else
  // Pay/Pickup validation
  if (cbxPayPoint.Checked = true) and (cbxPickupPoint.Checked = true) then
     begin
       if (EditOutletDriveThru.PointTypeExists(PAYPICKUP_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pay/Pickup Point already exists.', mtError, [mbOK],0)
       else
       if (EditOutletDriveThru.PointTypeExists(PAY_POINT, StrToInt(edtSeqNum.Text))) or (EditOutletDriveThru.PointTypeExists(PICKUP_POINT, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pay/Pickup Point cannot be added to a Drive Thru plan that contains a Pay or Pickup Point', mtError, [mbOK],0)
       else
       if (EditOutletDriveThru.notBeforeAfterPointType(True, EMPTY_SPACE, StrToInt(edtSeqNum.Text))) then
          MessageDlg('A Pay/Pickup Point cannot be placed before an empty Drive Thru space.', mtError, [mbOK],0)
       else
       if (cbTerminalName.ItemIndex = 0) then
          begin
            MessageDlg('Please assign a terminal to the Pay/Pickup Point.',mtError,[mbok], 0);
            cbTerminalName.SetFocus;
          end
       else
         ModalResult := mrOk;
     end
  else
  if (cbxPayPoint.Checked = false) and (cbxPickupPoint.Checked = false) and
     (cbTerminalName.ItemIndex > 0) then
     begin
       MessageDlg('A terminal cannot be assigned to an empty Drive Thru space.',mtWarning,[mbok], 0);
       cbTerminalName.SetFocus;
     end
  else
      ModalResult := mrOk;
  ButtonClicked(Sender);
end;

procedure TEditParkingSpace.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
end;

function TEditParkingSpace.GetTerminalList: TStrings;
begin
    TerminalList.Clear;
    with dmThemeData.adoqRun do
    try
      Close;
      SQL.Text := 'SELECT 0 AS EposDeviceID, ''(None)'' AS Name '+
                  'UNION ALL '+
                  'SELECT EposDeviceID, Name FROM themeeposdevice '+
                  'WHERE IsServer <> 1 ORDER BY Name ';
      Open;
      while not EOF do
      begin
        // Set the combobox to display select terminal id
        if (TerminalID = FieldByName('EposDeviceID').AsInteger) then
          begin
            TerminalName := FieldByName('Name').AsString;
            TerminalList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('EposDeviceID').AsInteger)));
            Next;
          end
        else
        // If Terminal has been allocated to a different breakpoint, do not display it.
        if (EditOutletDriveThru.TerminalAllocated(FieldByName('EposDeviceID').AsInteger) = True) and (FieldByName('EposDeviceID').AsInteger > 0) then
           Next
        else
          begin
            TerminalList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('EposDeviceID').AsInteger)));
            Next;
          end;
      end;
    finally
      Close;
    end;
  Result := TerminalList;
end;

procedure TEditParkingSpace.cbTerminalNameChange(Sender: TObject);
begin
  TerminalID := Integer(cbTerminalName.Items.Objects[cbTerminalName.ItemIndex])  
end;

end.
