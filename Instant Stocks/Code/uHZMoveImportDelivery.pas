unit uHZMoveImportDelivery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, DB, ADODB,
  Wwkeycb, Buttons, ActnList, wwDialog, Wwlocate, wwfltdlg, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, wwdblook;

const
  NO_FILTER_TEXT = '<No Filter>';

type
  TfHZMoveImportDelivery = class(TForm)
    TopPanel: TPanel;
    BottomPanel: TPanel;
    DeliveryNotePanel: TPanel;
    Panel1: TPanel;
    ProductsLabel: TLabel;
    ProductDetailDBGrid: TwwDBGrid;
    ADOQueryDeliveries: TADOQuery;
    DataSourceDeliveries: TDataSource;
    DataSourceADODeliveryProducts: TDataSource;
    ADOQueryDeliveryProducts: TADOQuery;
    ActionList: TActionList;
    ActionIncrementalSearch: TAction;
    ActionMidwordSearch: TAction;
    ActionSearchNext: TAction;
    ActionSearchPrev: TAction;
    wwFind: TwwLocateDialog;
    PanelSearch: TPanel;
    LabelDelNoteNoSearch: TLabel;
    EditMidwordSearchDeliveryNoteNo: TEdit;
    RadioButtonIncremental: TRadioButton;
    RadioButtonMidword: TRadioButton;
    BitBtnPrev: TBitBtn;
    BitBtnNext: TBitBtn;
    LabelF7: TLabel;
    LabelF8: TLabel;
    wwIncrementalSearchDeliveryNoteNo: TwwIncrementalSearch;
    PanelDeliveryNote: TPanel;
    DeliveryNotesDBGrid: TwwDBGrid;
    DeliveryNotesLabel: TLabel;
    BitBtnCancel: TBitBtn;
    LabelSupplierFilter: TLabel;
    Bevel1: TBevel;
    ComboBoxSupplierFilter: TComboBox;
    BitBtnImport: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure ActionIncrementalSearchExecute(Sender: TObject);
    procedure ActionMidwordSearchExecute(Sender: TObject);
    procedure ActionSearchNextExecute(Sender: TObject);
    procedure ActionSearchPrevExecute(Sender: TObject);
    procedure ComboBoxSupplierFilterChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtnImportClick(Sender: TObject);
  private
    { Private declarations }
    FSupplierName: String;
    FDeliveryNoteNo: String;
    FSiteCode: Integer;
    FCurr: Boolean;
    FSupplierList: TStringList;

    procedure BuildSupplierFilterList;
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
  public
    { Public declarations }
    property SupplierName: String read FSupplierName;
    property DeliveryNoteNo: String read FDeliveryNoteNo;
    property SiteCode: Integer read FSiteCode;
    property Curr: Boolean read FCurr;
  end;

var
  fHZMoveImportDelivery: TfHZMoveImportDelivery;

implementation

uses uADO, udata1, StrUtils, uGlobals;

{$R *.dfm}

procedure TfHZMoveImportDelivery.FormShow(Sender: TObject);
begin
  Caption := 'Import From ' + uGlobals.GetLocalisedName(lsInvoice);
  DeliveryNotesLabel.Caption := uGlobals.GetLocalisedName(lsOrders) + ':';
  LabelDelNoteNoSearch.Caption := uGlobals.GetLocalisedName(lsInvoice) + ' No. Search:';

  with DeliveryNotesDBGrid, DeliveryNotesDBGrid.DataSource.DataSet do
  begin
    DisableControls;
    Selected.Clear;

    DeliveryNotesDBGrid.Selected.Add('SupplierName'#9'20'#9'Supplier Name'#9'F');
    DeliveryNotesDBGrid.Selected.Add('DeliveryNoteNo'#9'15'#9+uGlobals.GetLocalisedName(lsInvoice)+' No.'#9'F');
    DeliveryNotesDBGrid.Selected.Add('Date'#9'10'#9'Date'#9'F');

    ApplySelected;
    EnableControls;
  end;

  ADOQueryDeliveries.Open;
  ADOQueryDeliveryProducts.Open;
  RadioButtonIncremental.Checked := True;

  BuildSupplierFilterList;
end;

procedure TfHZMoveImportDelivery.ActionIncrementalSearchExecute(
  Sender: TObject);
begin
  wwIncrementalSearchDeliveryNoteNo.Visible := ActionIncrementalSearch.Checked;
  EditMidwordSearchDeliveryNoteNo.Visible := not ActionIncrementalSearch.Checked;

  if wwIncrementalSearchDeliveryNoteNo.Visible then
  begin
    wwFind.MatchType := mtPartialMatchStart;
    wwIncrementalSearchDeliveryNoteNo.SetFocus;
  end;
end;

procedure TfHZMoveImportDelivery.ActionMidwordSearchExecute(
  Sender: TObject);
begin
  wwIncrementalSearchDeliveryNoteNo.Visible := not ActionMidwordSearch.Checked;
  EditMidwordSearchDeliveryNoteNo.Visible := ActionMidwordSearch.Checked;

  if EditMidwordSearchDeliveryNoteNo.Visible then
  begin
    wwFind.MatchType := mtPartialMatchAny;
    EditMidwordSearchDeliveryNoteNo.SetFocus;
  end;
end;

procedure TfHZMoveImportDelivery.ActionSearchNextExecute(Sender: TObject);
begin
  if wwIncrementalSearchDeliveryNoteNo.Visible then
    wwFind.FieldValue := wwIncrementalSearchDeliveryNoteNo.Text
  else
    wwFind.FieldValue := EditMidwordSearchDeliveryNoteNo.Text;

  if wwFind.FieldValue = '' then
    exit;
  wwFind.FindNext;
end;

procedure TfHZMoveImportDelivery.ActionSearchPrevExecute(Sender: TObject);
var
   SavePlace: TBookmark;
   matchyes : boolean;
begin
  if wwIncrementalSearchDeliveryNoteNo.Visible then
    wwFind.FieldValue := wwIncrementalSearchDeliveryNoteNo.Text
  else
    wwFind.FieldValue := EditMidwordSearchDeliveryNoteNo.Text;

  if wwFind.FieldValue = '' then
    exit;

  // find prior has to be done programatically...
  with ADOQueryDeliveries do
  begin
    disablecontrols;

    { get a bookmark so that we can return to the same record }
    SavePlace := GetBookmark;
    try
      matchyes := false;

      while (not bof) do
      begin
        Prior;

        // check for match
        if ActionIncrementalSearch.Checked then // incremental.
          matchyes := AnsiStartsText(wwIncrementalSearchDeliveryNoteNo.Text, FieldByName('DeliveryNoteNo').asstring)
        else                   // mid-word.
          matchyes := AnsiContainsText(FieldByName('DeliveryNoteNo').asstring,EditMidwordSearchDeliveryNoteNo.Text);

        if matchyes then break;
      end;

      {if match not found Move back to the bookmark}
      if not matchyes then
      begin
        GotoBookmark(SavePlace);
        showMessage('No More Matches found!');
      end;

      { Free the bookmark }
    finally
      FreeBookmark(SavePlace);
    end;

    enablecontrols;
  end;
end;

procedure TfHZMoveImportDelivery.BuildSupplierFilterList;
var
  Bkmark: TBookmark;
begin
  ComboBoxSupplierFilter.Clear;
  ComboBoxSupplierFilter.Items.Add(NO_FILTER_TEXT);

  with ADOQueryDeliveries do
  begin
    DisableControls;
    Bkmark := GetBookmark;
    try
      First;

      while not EOF do
      begin
        FSupplierList.Add(FieldByName('SupplierName').AsString);
        Next;
      end;
    finally
      GotoBookmark(Bkmark);
      FreeBookmark(Bkmark);
      EnableControls;
    end;
  end;

  ComboBoxSupplierFilter.Items.AddStrings(FSupplierList);

  ComboBoxSupplierFilter.Text := NO_FILTER_TEXT;
end;

procedure TfHZMoveImportDelivery.ComboBoxSupplierFilterChange(
  Sender: TObject);
begin
  with ComboBoxSupplierFilter do
  begin
    if Text <> NO_FILTER_TEXT then
    begin
      ADOQueryDeliveries.Filter := 'SupplierName = ''' + Text + '''';
      ADOQueryDeliveries.Filtered := True;
    end
    else begin
      ADOQueryDeliveries.Filter := '';
      ADOQueryDeliveries.Filtered := False;
    end;
  end;
end;

procedure TfHZMoveImportDelivery.FormCreate(Sender: TObject);
begin
  FSupplierList := TStringList.Create;
  FSupplierList.Sorted := True;
end;

procedure TfHZMoveImportDelivery.FormDestroy(Sender: TObject);
begin
  if Assigned(FSupplierList) then
    FSupplierList.Free;
end;

procedure TfHZMoveImportDelivery.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure TfHZMoveImportDelivery.BitBtnImportClick(Sender: TObject);
begin
  FSupplierName := ADOQueryDeliveries.FieldByName('SupplierName').AsString;
  FDeliveryNoteNo := ADOQueryDeliveries.FieldByName('DeliveryNoteNo').AsString;
  FSiteCode := ADOQueryDeliveries.FieldByName('SiteCode').AsInteger;
  FCurr := (ADOQueryDeliveries.FieldByName('curr').AsInteger = 1);

  if MessageDlg(Format('Import details from %s ''%s: %s''?',
                      [Lowercase(uGlobals.GetLocalisedName(lsInvoice)),FDeliveryNoteNo, FSupplierName]),
    mtConfirmation,
    mbOKCancel,
    0) = mrOK then
    ModalResult := mrOK
  else
    ModalResult := mrNone;
end;

end.
