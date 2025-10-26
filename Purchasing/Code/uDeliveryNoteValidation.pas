unit uDeliveryNoteValidation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls, uGlobals;

type
  TfrmDeliveryNoteValidation = class(TForm)
    Label1: TLabel;
    lblDeliveryNotes: TLabel;
    lvDeliveryNotes: TListView;
    Panel1: TPanel;
    btnCorrectNote: TButton;
    btnDiscardNote: TButton;
    Label2: TLabel;
    reErrors: TRichEdit;
    btnClose: TBitBtn;
    procedure btnCloseClick(Sender: TObject);
    procedure btnCorrectNoteClick(Sender: TObject);
    procedure btnDiscardNoteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvDeliveryNotesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayErrors ( NoteRecordID : String );
    procedure RemoveSelectedItemFromList;
    procedure SetFixedLabels;
  public
    { Public declarations }
  end;

var
  frmDeliveryNoteValidation: TfrmDeliveryNoteValidation;

implementation

uses
  uADO, uDeliveryNoteCorrection;

{$R *.dfm}

procedure TfrmDeliveryNoteValidation.btnCloseClick(Sender: TObject);
begin
  if lvDeliveryNotes.Items.Count > 0 then
  begin
    if MessageDlg('There are still outstanding Hand Held ' + GetLocalisedName(lsOrders) + ' that require '
      + 'user validation before a stock can be performed.' + #13#10 + #13#10
      + 'Are you sure you want to exit without addressing these?', mtInformation, [mbYes, mbNo], 0) = mrNo then
    Exit;
  end;

  Close;

end;

procedure TfrmDeliveryNoteValidation.btnCorrectNoteClick(Sender: TObject);
begin
  if lvDeliveryNotes.SelCount = 0 then Exit;

  Application.CreateForm(TfrmDeliveryNoteCorrection, frmDeliveryNoteCorrection);
  frmDeliveryNoteCorrection.RecordID := lvDeliveryNotes.Selected.SubItems[3];

  frmDeliveryNoteCorrection.ShowModal;

  if frmDeliveryNoteCorrection.WasDeleted then
    RemoveSelectedItemFromList;

  frmDeliveryNoteCorrection.Free;

end;

procedure TfrmDeliveryNoteValidation.btnDiscardNoteClick(Sender: TObject);
begin
  if lvDeliveryNotes.SelCount = 0 then Exit;
  if MessageDlg('Are you sure you want to discard the selected ' + GetLocalisedName(lsInvoice) + '?',
      mtConfirmation, [mbNo,mbYes], 0) = mrNo then exit;

  dmAdo.BeginTransaction;
  try
    with dmAdo.adoqrun do
    begin
      Close;
      Sql.Clear;
      Sql.Add('EXEC zspRemoveDeliveriesFromFailure ' + lvDeliveryNotes.Selected.SubItems[3]);
      ExecSQL;
    end;
    RemoveSelectedItemFromList;
    lvDeliveryNotes.SetFocus;
    dmAdo.CommitTransaction;
  Except on e:Exception do
  begin
    dmAdo.RollbackTransaction;
    MessageDlg('An error has occured while removing the ' + GetLocalisedName(lsInvoice) + '. The error is reported as:'
        +#13#10 + #13#10 + e.Message
        + #13#10 + #13#10 + 'Contact Zonal Support for assistance.', mtError, [mbOK], 0);
  end;
  end;
end;

procedure TfrmDeliveryNoteValidation.DisplayErrors(NoteRecordID: String);
begin
  reErrors.Lines.Clear;

  with dmAdo.adoqRun do
  begin
    Close;
    Sql.Clear;
    Sql.Add ('SELECT [Description], [SubText]');
    Sql.Add ('FROM dbo.[HandHeldFailureReasons]');
    Sql.Add ('WHERE [RecordID] = ' + NoteRecordID);
    Open;
    While NOT EOF do
    begin
      reErrors.SelAttributes.Style := [fsBold];
      reErrors.Lines.Add( FieldByName('Description').AsString);
      reErrors.SelAttributes.Style := [];
      reErrors.Lines.Add ('  (' +  FieldByName('SubText').AsString + ')');
      Next;
    end;
  end;
end;

procedure TfrmDeliveryNoteValidation.FormShow(Sender: TObject);
var
  lstItem : tListItem;
begin
  SetFixedLabels;
  
  with dmAdo.adoqRun do
  begin
    Close;
    Sql.Clear;
    Sql.Add ('SELECT h.[RecordID], s.[Supplier Name], h.[OrderNumber], h.[DeliveryNoteNumber],');
    Sql.Add ('h.[FinalisedDateTime]');
    Sql.Add ('FROM dbo.[HandHeldDeliveryFailureHeader] h, ');
    Sql.Add ('  (SELECT s2.[Supplier Code], s2.[Supplier Name] , s1.SiteID');
    Sql.Add ('   FROM (select * from ac_SiteSuppliers where SiteId = dbo.fnGetSiteCode()) s1 LEFT OUTER JOIN Supplier s2 ');
    Sql.Add ('      ON s1.SupplierID = s2.[Supplier Code]) s ');
    Sql.Add ('WHERE s.[Supplier Code] = h.[SupplierID] ');
    Sql.Add ('AND s.SiteID = h.SiteCode ');
    Sql.Add ('AND h.[Deleted]=0');
    Open;
    While NOT EOF do
    begin
      lstItem := lvDeliveryNotes.Items.Add;
      lstItem.Caption := FieldByName('Supplier Name').AsString;
      lstItem.SubItems.Add(FieldByName('DeliveryNoteNumber').AsString);
      LstItem.SubItems.Add(FormatDateTime('DD/MM/YYYY', FieldByName('FinalisedDateTime').AsDateTime));
      LstItem.SubItems.Add(FieldByName('OrderNumber').AsString);
      LstItem.SubItems.Add(FieldByName('RecordID').AsString);
      Next;
    end;
  end;
  if lvDeliveryNotes.Items.Count > 0 then
  begin
    lvDeliveryNotes.Items[0].Selected := true;
    lvDeliveryNotes.SetFocus;
  end;

end;

procedure TfrmDeliveryNoteValidation.lvDeliveryNotesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if lvDeliveryNotes.SelCount = 0 then Exit;
  DisplayErrors ( lvDeliveryNotes.Selected.SubItems[3] );
end;

procedure TfrmDeliveryNoteValidation.RemoveSelectedItemFromList;
var
  SelectedItemNo : Integer;
begin
  reErrors.Lines.Clear;
  SelectedItemNo := lvDeliveryNotes.Selected.Index;
  lvDeliveryNotes.Selected.Delete;
  if lvDeliveryNotes.Items.Count > 0 then
  begin
    if SelectedItemNo = 0 then
      lvDeliveryNotes.Items.Item[0].Selected := true
    else
      lvDeliveryNotes.Items.Item[SelectedItemNo-1].Selected := true
  end;
end;

procedure TfrmDeliveryNoteValidation.FormCreate(Sender: TObject);
begin

 if purchHelpExists then
  setHelpContextID(Self, HLP_HH_DELIVERY_NOTE_VALIDATION);

end;

procedure TfrmDeliveryNoteValidation.SetFixedLabels;
begin
  Caption := 'Handheld ' + GetLocalisedName(lsInvoice) + ' Validation';

  lblDeliveryNotes.Caption := GetLocalisedName(lsOrders);

  btnCorrectNote.Caption := 'Correct ' + GetLocalisedName(lsInvoice) + ' Errors';
  btnCorrectNote.Hint := 'Correct the selected ' + GetLocalisedName(lsInvoice);

  btnDiscardNote.Caption := 'Discard ' + GetLocalisedName(lsInvoice);
  btnDiscardNote.Hint := 'Remove the selected ' + GetLocalisedName(lsInvoice);

  lvDeliveryNotes.Columns[1].Caption := GetLocalisedName(lsInvoice) + ' No.';

  Label1.Caption := 'The imported ' + LowerCase(GetLocalisedName(lsOrders)) + ' ' +
                    'listed below require reconciliation before being added ' +
                    'to the Purchasing system.';
end;

end.
