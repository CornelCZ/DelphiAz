unit uEditValidationConfigs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, db, ADODB;

type
  TDisableControlsProc = procedure(ParentControl: TWinControl);

  TfrmEditValidationConfigs = class(TForm)
    grpbxRegistered: TGroupBox;
    grbxNoResponse: TGroupBox;
    edNoResponseMsg: TEdit;
    edAbsentMsg: TEdit;
    btnClose: TButton;
    cbxDefaultRating: TComboBox;
    lblDefaultRating: TLabel;
    lblMessageResponse: TLabel;
    lblMessageReg: TLabel;
    grbxNotRegistered: TGroupBox;
    lblMessageNotReg: TLabel;
    edPresentMsg: TEdit;
    qValidConfigs: TADOQuery;
    qValidConfigsNoSoapRating: TIntegerField;
    qValidConfigsNoSoapMsg: TStringField;
    qValidConfigsPresentMsg: TStringField;
    qValidConfigsAbsentMsg: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FSwipeCardRangeID : Integer;
    FIsPromotional: Boolean;
    FReadOnly: Boolean;
    FDisableControls: TDisableControlsProc;
  public
    property SwipeCardRangeID : Integer write FSwipeCardRangeID;
    property IsPromotional: Boolean read FIsPromotional write FIsPromotional;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property DisableControls: TDisableControlsProc read FDisableControls write FDisableControls;
  end;

var
  frmEditValidationConfigs: TfrmEditValidationConfigs;

implementation

uses uADO_SwipeRange;

{$R *.dfm}

procedure TfrmEditValidationConfigs.FormShow(Sender: TObject);

  procedure addValidationConfig(SwipeCardRangeID : integer);
  begin
    with dmADO_SwipeRange.qRun do
      begin
        SQL.Text := Format(' INSERT INTO CardRangeValidationConfig (RangeID, NoSoapRating, NoSoapMsg, PresentMsg, AbsentMsg) '+
                                                          ' VALUES(%d, 0, NULL, NULL, NULL) ', [SwipeCardRangeID]);
        ExecSQL;
      end;
  end;

begin
  if FIsPromotional then
    HelpContext := 7108
  else
    HelpContext := 5078;

  qValidConfigs.Parameters[0].Value := FSwipeCardRangeID;
  qValidConfigs.Open;

  if qValidConfigs.RecordCount = 0 then
     begin
       addValidationConfig(FSwipeCardRangeID);
       qValidConfigs.Close;
       qValidConfigs.Parameters[0].Value := FSwipeCardRangeID;
       qValidConfigs.Open;
     end;
     
  edNoResponseMsg.Text := qValidConfigsNoSoapMsg.Value;
  edAbsentMsg.Text := qValidConfigsAbsentMsg.Value;
  edPresentMsg.Text := qValidConfigsPresentMsg.Value;

  with dmADO_SwipeRange.qRun do
    begin
      // populate drop down
      SQL.Text := ' SELECT Rating AS CardRating, DisplayString AS Name FROM CardRangeValidationRatings WHERE Deleted = 0';
      Open;

      if RecordCount = 0 then
         cbxDefaultRating.Enabled := False
      else
        begin
          cbxDefaultRating.ItemIndex := 0;
          First;
          while not EOF do
          begin
            cbxDefaultRating.Items.AddObject(FieldByName('Name').AsString, TObject(FieldByName('CardRating').AsInteger));
            if qValidConfigsNoSoapRating.value = FieldByName('CardRating').AsInteger then
               cbxDefaultRating.ItemIndex := Integer(cbxDefaultRating.Items.Count -1);

            next;
          end;
        end;
   end;
  if FReadOnly and Assigned(FDisableControls) then
  begin
    FDisableControls(Self);
    btnClose.Enabled := True;
    cbxDefaultRating.Enabled := False;
  end;
end;

procedure TfrmEditValidationConfigs.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not FReadOnly then
  begin
    qValidConfigs.Edit;
    qValidConfigsNoSoapMsg.Value := edNoResponseMsg.Text;
    qValidConfigsAbsentMsg.Value := edAbsentMsg.Text;
    qValidConfigsPresentMsg.Value := edPresentMsg.Text;
    if cbxDefaultRating.Enabled then
       qValidConfigsNoSoapRating.Value := integer(cbxDefaultRating.Items.Objects[cbxDefaultRating.ItemIndex]);
    qValidConfigs.Post;
  end;
end;

end.
