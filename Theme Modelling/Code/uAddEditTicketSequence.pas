unit uAddEditTicketSequence;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, uPickProduct;

type
  TAddEditTicketSequence = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    cbPerTerminal: TCheckBox;
    Label2: TLabel;
    dtpReset: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbProducts: TListBox;
    btAdd: TButton;
    btDelete: TButton;
    btCancel: TButton;
    btOk: TButton;
    cbPrintTwoCopies: TCheckBox;
    cmbTicketImage: TComboBox;
    Label6: TLabel;
    edLinesBeforeImage: TEdit;
    udLinesBeforeImage: TUpDown;
    Label7: TLabel;
    edLinesAfterImage: TEdit;
    udLinesAfterImage: TUpDown;
    Label8: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label9: TLabel;
    edLinesBeforeSequenceNumber: TEdit;
    udLinesBeforeSequenceNumber: TUpDown;
    Label10: TLabel;
    edLinesBeforeProductInfo: TEdit;
    udLinesBeforeProductInfo: TUpDown;
    Label11: TLabel;
    edLinesBetweeProductTicketPair: TEdit;
    udLinesBetweenProductTicketPair: TUpDown;
    Bevel3: TBevel;
    Label12: TLabel;
    cbPrintTicketNumber: TCheckBox;
    procedure btDeleteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure cbPerTerminalClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbTicketImageChange(Sender: TObject);
    procedure cbPrintTicketNumberClick(Sender: TObject);
  private
    { Private declarations }
    editing: boolean;
    theme_id: integer;
    pickProduct: TPickProduct;
    procedure ResizeListBox; overload;
    procedure ResizeListBox(NewItem: String); overload;
  public
    { Public declarations }
    edit_id: integer;
    procedure prepare(themeid: integer; editid: integer = -1);
  end;

  TBigIntTag = record
    data: int64;
  end;
  PBigIntTag = ^TBigIntTag;

var
  AddEditTicketSequence: TAddEditTicketSequence;

implementation

uses uDMThemeData, useful, db, uGenerateThemeIDs, uAztecLog, Math;

{$R *.dfm}

{ TAddEditTicketSequence }

procedure TAddEditTicketSequence.prepare(themeid: integer; editid: integer);
var
  tmpp: PBigIntTag;
  i: integer;
begin
  dtpreset.Format := 'HH:mm';
  theme_id := themeid;
  edit_id := editid;
  editing := editid <> -1;
  dmThemeData.PopulateTicketImageList(ThemeId, cmbTicketImage.Items);
  cmbTicketImage.ItemIndex := 0;

  if editing then
  begin
    caption := 'Edit ticket sequence';
    // load the data
    with dmThemeData.adoqRun do
    begin
      SQL.Text := 'select * from ThemeCloakRoomSequence '+
        'where CloakroomSequenceID = '+inttostr(editid);
      open;
      edName.text := fieldbyname('name').asstring;
      dtpReset.Time := fieldbyname('resettime').asdatetime;
      cbPerTerminal.Checked := fieldbyname('perterminal').asboolean;
      cbPrintTwoCopies.Checked := FieldByName('PrintTwoCopies').AsBoolean;
      cbPrintTicketNumber.Checked := FieldByName('PrintTicketNumber').AsBoolean;
      udLinesBeforeSequenceNumber.Position := FieldByName('LinesBeforeSequenceNumber').AsInteger;
      udLinesBeforeProductInfo.Position := FieldByName('LinesBeforeProductInfo').AsInteger;
      udLinesBetweenProductTicketPair.Position := FieldByName('LinesBetweenProductTicketPair').AsInteger;
      udLinesBeforeImage.Position := FieldByName('LinesBeforeImage').AsInteger;
      udLinesAfterImage.Position := FieldByName('LinesAfterImage').AsInteger;
      if FieldByName('CloakroomImageId').IsNull then
        cmbTicketImage.ItemIndex := 0
      else
      begin
        for i := 0 to pred(cmbTicketImage.Items.Count) do
        begin
          if Integer(cmbTicketImage.Items.Objects[i]) = FieldByName('CloakroomImageId').AsInteger then
          begin
            cmbTicketImage.ItemIndex := i;
            break;
          end;
        end;
      end;
      close;
      SQL.text := 'select cast([entitycode] as bigint) as productid, [sub-category name] + '' / '' + [extended rtl name] + '' '' + '+
        'case isnull([retail description], '''') when '''' then '''' else ''('' + [retail description] + '')'' end  as name '+
        'from ThemeCloakroomSequenceProductList '+
        'join products on productid = entitycode '+
        'where CloakroomSequenceID = '+inttostr(editid);
      open;
      while not (EOF) do
      begin
        new(tmpp);
        tmpp.data := TLargeIntField(fieldbyname('productid')).aslargeint;
        lbProducts.AddItem(fieldbyname('name').asstring, Tobject(tmpp));
        next;
      end;
      ResizeListBox;
      close;
    end;
  end
  else
  begin
    caption := 'Add ticket sequence';
    edName.Text := '';
    dtpReset.Time := encodetime(7, 0, 0, 0);
    cbPerTerminal.checked := true;
  end;
  cmbTicketImage.OnChange(cmbTicketImage);

end;

procedure TAddEditTicketSequence.btDeleteClick(Sender: TObject);
begin
  ButtonClicked(sender);
  if lbProducts.itemindex = -1 then
    raise Exception.create('Please select an item to delete!');
  dispose(pointer(lbProducts.items.objects[lbProducts.itemindex]));
  Log('Deleting ' + lbproducts.Items[lbproducts.ItemIndex]);
  lbproducts.Items.Delete(lbproducts.ItemIndex);
  ResizeListBox;
end;

procedure TAddEditTicketSequence.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to pred(lbproducts.count) do
    dispose(pointer(lbproducts.Items.Objects[i]));
  pickProduct.Free;
end;

procedure TAddEditTicketSequence.btAddClick(Sender: TObject);
var
  i: integer;
  tmpp: PBigIntTag;
begin
  ButtonClicked(Sender);
  if pickProduct = nil then
    pickProduct := TPickProduct.create(nil);

  if pickProduct.ShowModal <> mrOk then
    exit;

  for i := 0 to pred(lbProducts.count) do
    if PBigIntTag(lbproducts.Items.Objects[i]).data = pickProduct.selectedProduct then Exit;

  new(tmpp);
  tmpp.data := pickProduct.selectedProduct;

  with dmThemeData.adoqRun do
  begin
    SQL.text := 'select cast([entitycode] as bigint) as productid, [sub-category name] + '' / '' + [extended rtl name] + '' '' + '+
      'case isnull([retail description], '''') when '''' then '''' else ''('' + [retail description] + '')'' end  as name '+
      'from products where entitycode = '+inttostr(pickProduct.selectedProduct);
    open;
    lbProducts.AddItem(fieldbyname('name').asstring, Tobject(tmpp));
    ResizeListBox(fieldbyname('name').asstring);
    close;
  end;
end;

procedure TAddEditTicketSequence.btOkClick(Sender: TObject);
var
  i: integer;
  TicketImage: string;
begin

{
      edName.text := fieldbyname('name').asstring;
      dtpReset.Time := fieldbyname('resettime').asdatetime;
      cbPerTerminal.Checked := fieldbyname('perterminal').asboolean;
      cbPrintTwoCopies.Checked := FieldByName('PrintTwoCopies').AsBoolean;
      udLinesBeforeImage.Position := FieldByName('LinesBeforeImage').AsInteger;
      udLinesAfterImage.Position := FieldByName('LinesAfterImage').AsInteger;
      if FieldByName('CloakroomImageId').IsNull then
        cmbTicketImage.ItemIndex := 0;
}
  if Assigned(cmbTicketImage.Items.Objects[cmbTicketImage.ItemIndex]) then
    TicketImage := IntToStr(Integer(cmbTicketImage.Items.Objects[cmbTicketImage.ItemIndex]))
  else
    TicketImage := 'null';
  // update sequence settings
  ButtonClicked(Sender);
  if editing then
  with dmThemeData.adoqRun do
  begin
    Log('Updating Theme Cloakroom Sequence, ID : ' + IntToStr(edit_id));
    sql.text := format('update ThemeCloakroomSequence set Name = %s, ResetTime = %s, PerTerminal = %d, '+
      'PrintTwoCopies = %d, LinesBeforeSequenceNumber = %d, LinesBeforeProductInfo = %d, LinesBetweenProductTicketPair = %d, '+
      'LinesBeforeImage = %d, LinesAfterImage = %d, CloakroomImageID = %s, PrintTicketNumber = %d '+
      'where CloakroomSequenceID = %d',
      [quotedstr(edName.text), quotedstr(formatdatetime('hh:mm', dtpReset.time)), integer(cbPerTerminal.Checked),
      integer(cbPrintTwoCopies.Checked), udLinesBeforeSequenceNumber.Position, udLinesBeforeProductInfo.Position,
      udLinesBetweenProductTicketPair.Position, udLinesBeforeImage.Position, udLinesAfterImage.Position, TicketImage,
      integer(cbPrintTicketNumber.Checked), edit_id]);
    execsql;
  end
  else
  with dmThemeData.adoqRun do
  begin
    edit_id := GetNewId(scThemeCloakroomSequence);
    Log('Adding new Theme Cloakroom Sequence, ID : ' + IntToStr(edit_id));
    sql.text := format('insert ThemeCloakroomSequence (CloakroomSequenceID, ThemeID, Name, ResetTime, PerTerminal, '+
      'PrintTwoCopies, LinesBeforeSequenceNumber, LinesBeforeProductInfo, LinesBetweenProductTicketPair, '+
      'LinesBeforeImage, LinesAfterImage, CloakroomImageID, PrintTicketNumber) '+
      'values (%d, %d, %s, %s, %d, %d, %d, %d, %d, %d, %d, %s, %d)',
      [edit_id, Theme_Id,
      quotedstr(edName.text), quotedstr(formatdatetime('hh:mm', dtpReset.time)), integer(cbPerTerminal.Checked),
      integer(cbPrintTwoCopies.Checked), udLinesBeforeSequenceNumber.Position, udLinesBeforeProductInfo.Position,
      udLinesBetweenProductTicketPair.Position, udLinesBeforeImage.Position, udLinesAfterImage.Position, TicketImage,
      integer(cbPrintTicketNumber.Checked)
      ]);
    execsql;
  end;
  // update product list
  with dmThemeData.adoqRun do
  begin
    sql.text := 'create table #prodlist(productid bigint)';
    for i := 0 to pred(lbProducts.Count) do
      sql.add('insert #prodlist select '+inttostr(PBigIntTag(lbproducts.Items.Objects[i]).data));
    sql.text := sql.text + #13 +
      'declare @sequenceid int, @themeid int '+#13+
      'set @sequenceid = '+inttostr(edit_id)+' '+#13+
      'set @themeid  = '+inttostr(theme_id)+' '+#13+

      'declare @ThemeSequenceID table (CloakroomSequenceID int not null) '+#13+

      'insert @ThemeSequenceID '+#13+
      'select CloakroomSequenceID from ThemeCloakroomSequence '+#13+
      'where ThemeID = @themeid '+#13+

      'delete ThemeCloakroomSequenceProductList '+#13+
      'from ThemeCloakroomSequenceProductList a '+#13+
      'join #prodlist b on a.ProductID = b.ProductID '+#13+
      'join @ThemeSequenceID c on a.CloakroomSequenceID = c.CloakroomSequenceID '+#13+

      'delete ThemeCloakroomSequenceProductList '+#13+
      'from ThemeCloakroomSequenceProductList a '+#13+
      'left outer join #prodlist b on a.ProductID = b.ProductID '+#13+
      'where CloakroomSequenceID = @sequenceid and b.ProductID is null '+#13+

      'insert ThemeCloakroomSequenceProductList '+#13+
      'select @sequenceid, productid '+#13+
      'from #prodlist '+#13+
      'where productid not in (select productid from ThemeCloakroomSequenceProductList where cloakroomsequenceid = @sequenceid) '+#13+
      'drop table #prodlist ';
    execsql;
  end;
  modalresult := mrok;
end;

procedure TAddEditTicketSequence.cbPerTerminalClick(Sender: TObject);
begin
  if cbPerTerminal.Checked then
    log('Seperate Sequence Per Terminal Checked')
  else
    log('Seperate Sequence Per Terminal UnChecked')
end;

procedure TAddEditTicketSequence.btCancelClick(Sender: TObject);
begin
  buttonClicked(Sender);
end;

procedure TAddEditTicketSequence.FormShow(Sender: TObject);
begin
  log('Form Show ' + Caption);
end;

procedure TAddEditTicketSequence.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log('Form Close ' + Caption);
end;

//------------------------------------------------------------------------------
procedure TAddEditTicketSequence.cmbTicketImageChange(Sender: TObject);
var
  State: boolean;
begin
  State := TComboBox(Sender).ItemIndex <> 0;
  if State = false then
  begin
    udLinesBeforeImage.Position := 0;
    udLinesAfterImage.Position := 0;
  end;
  edLinesBeforeImage.Enabled := State;
  edLinesAfterImage.Enabled := State;
end;

procedure TAddEditTicketSequence.cbPrintTicketNumberClick(Sender: TObject);
begin
  if cbPrintTicketNumber.Checked then
    log('Print Ticket Number on Receipt Checked')
  else
    log('Print Ticket Number on Receipt UnChecked')
end;

procedure TAddEditTicketSequence.ResizeListBox;
var
  Index: Integer;
begin
  lbProducts.ScrollWidth := 0;
  for Index := 0 to lbProducts.Items.Count - 1 do
  begin
    ResizeListBox(lbProducts.Items[Index]);
  end;
end;

procedure TAddEditTicketSequence.ResizeListBox(NewItem: String);
begin
  lbProducts.ScrollWidth := Max(lbProducts.ScrollWidth, lbProducts.Canvas.TextWidth(NewItem));
end;

end.
