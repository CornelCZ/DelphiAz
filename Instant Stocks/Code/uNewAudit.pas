unit uNewAudit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, StdCtrls, Buttons, Wwkeycb,
  DB, ADODB, Wwdatsrc, wwDialog, Wwlocate, Math;

type
  TfNewAudit = class(TForm)
    Panel1: TPanel;
    wwGrid1: TwwDBGrid;
    wwDataSource1: TwwDataSource;
    findPur: TwwIncrementalSearch;
    Label3: TLabel;
    FBoxSC: TComboBox;
    FBoxCnt: TComboBox;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    lblAv: TLabel;
    lblSel: TLabel;
    ADOQuery1: TADOTable;
    Label8: TLabel;
    wwFind: TwwLocateDialog;
    ADOQuery1entitycode: TFloatField;
    ADOQuery1subcat: TStringField;
    ADOQuery1purchasename: TStringField;
    ADOQuery1entitytype: TStringField;
    ADOQuery1purchaseunit: TStringField;
    ADOQuery1Sel: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FBoxCntCloseUp(Sender: TObject);
    procedure FBoxSCCloseUp(Sender: TObject);
    procedure FBoxSCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FBoxSCKeyPress(Sender: TObject; var Key: Char);
    procedure wwGrid1TitleButtonClick(Sender: TObject; AFieldName: String);
    procedure wwGrid1CalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure ADOQuery1AfterPost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure findPurAfterSearch(Sender: TwwIncrementalSearch;
      MatchFound: Boolean);
    procedure ADOQuery1SelChange(Sender: TField);
  private
    { Private declarations }
    filSub, filType : string;
    selsofar : integer;
    procedure ChangeFilter;
  public
    { Public declarations }
  end;

var
  fNewAudit: TfNewAudit;

implementation

uses uADO, udata1;

{$R *.dfm}

procedure TfNewAudit.FormShow(Sender: TObject);
begin
  adoquery1.TableName := '#newAudit';
  adoquery1.Open;

  lblAv.Caption := ' ' + inttostr(adoquery1.RecordCount) + ' ';
  lblSel.Caption := ' 0 ';

  with wwGrid1, wwGrid1.DataSource.DataSet do   // grid field names, etc...
  begin
    DisableControls;
    Selected.Clear;

    if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
    begin
      label3.Caption := 'Sub-Category Filter';
      Selected.Add('subcat'#9'20'#9'Sub-Category Name'#9'F')
    end
    else
    begin
      label3.Caption := 'Category Filter';
      Selected.Add('subcat'#9'20'#9'Category Name'#9'F');
    end;

    Selected.Add('purchasename'#9'40'#9'Purchase Name'#9'F');
    Selected.Add('entitytype'#9'15'#9'Entity Type'#9'F');
    Selected.Add('purchaseunit'#9'15'#9'Purchase Unit'#9'F');
    Selected.Add('Sel'#9'5'#9'Add'#9'F');

    wwgrid1.ApplySelected;

    EnableControls;
  end;

  FBoxSC.Items.Clear;
  fBoxSC.Items.Add('Show All');

  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct [subcat] from [#newAudit] order by [subcat]');
    open;

    while not eof do
    begin
      fBoxSC.Items.Add(FieldByName('subCat').asstring);
      next;
    end;
    close;
  end;

  FBoxSC.ItemIndex := 0;

  // 18207 add entity types to the filter so it does not contain any not in the #newAudit table...
  FBoxCnt.Items.Clear;
  fBoxCnt.Items.Add('Show All');

  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select distinct [EntityType] from [#newAudit] order by [EntityType]');
    open;

    while not eof do
    begin
      fBoxCnt.Items.Add(FieldByName('EntityType').asstring);
      next;
    end;
    close;
  end;

  FBoxCnt.ItemIndex := 0;
end;

procedure TfNewAudit.FormCreate(Sender: TObject);
begin
  filSub := '';
  filType := '';
  selsofar := 0; //18209
end;

procedure TfNewAudit.ChangeFilter;
begin
  adoquery1.DisableControls;

  if filSub = '' then
  begin
    if filType = '' then           // both empty, no filter
    begin
      adoquery1.Filter := '';
      adoquery1.Filtered := False;
    end
    else                           // no filSub, just filType
    begin
      adoquery1.Filter := filType;
      adoquery1.Filtered := True;
    end;
  end  // if.. then..
  else
  begin
    if filType = '' then           // just filSub, no filType
    begin
      adoquery1.Filter := filSub;
      adoquery1.Filtered := True;
    end
    else                           // both full
    begin
      adoquery1.Filter := '(' + filSub + ') AND (' + filType + ')';
      adoquery1.Filtered := True;
    end;

  end; //if.. then.. else..

  adoquery1.EnableControls;
end; // procedure..


procedure TfNewAudit.FBoxCntCloseUp(Sender: TObject);
begin
  with adoquery1 do
  begin
    if state = dsEdit then
      Post;
  end;

  // 18207 make the selection dynamic as entity types are no longer hardcoded in this filter...
  if FBoxCnt.ItemIndex = 0 then
  begin
    filType := '';
  end
  else
  begin
    filType := 'EntityType = ' + quotedStr(FBoxCnt.Items[FBoxCnt.ItemIndex]);
  end;

  ChangeFilter;
end;

procedure TfNewAudit.FBoxSCCloseUp(Sender: TObject);
begin
  with adoquery1 do
  begin
    if state = dsEdit then
      Post;
  end;

  if FBoxSC.ItemIndex = 0 then
  begin
    filSub := '';
  end
  else
  begin
    filSub := 'SubCat = ' + quotedStr(FBoxSC.Items[FBoxSC.ItemIndex]);
  end;

  ChangeFilter;
end;

procedure TfNewAudit.FBoxSCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  key := 0;
end;

procedure TfNewAudit.FBoxSCKeyPress(Sender: TObject; var Key: Char);
begin
  key := #0;
end;

procedure TfNewAudit.wwGrid1TitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  adoquery1.DisableControls;
  adoquery1.IndexFieldNames := AFieldName;
  adoquery1.EnableControls;
end;

procedure TfNewAudit.wwGrid1CalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if afieldname = adoquery1.IndexFieldNames then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
    aFont.Style := [fsBold];
  end;
end;

procedure TfNewAudit.ADOQuery1AfterPost(DataSet: TDataSet);
begin
  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select count([entitycode]) as thecount from [#newAudit]');
    sql.Add('where [sel] = ''Y''');
    open;
    selsofar := FieldByName('thecount').asinteger;    //18209
    lblSel.Caption := ' ' + inttostr(selsofar) + ' ';
    close;
  end;
end;

procedure TfNewAudit.BitBtn1Click(Sender: TObject);
begin
  with adoquery1 do
  begin
    if state = dsEdit then
      Post;
  end;
end;


procedure TfNewAudit.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then    // 18208
  begin
    Key := 0;

    if wwFind.FieldValue = '' then
      exit;

    if not wwFind.FindNext then
    begin
      if MessageDlg('No more matches found to the end of the table!'+#13+#10+''+
        #13+#10+'Do you want to continue searching from the start of the table?',
        mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      wwFind.FindFirst;
    end;
  end;
end;

procedure TfNewAudit.findPurAfterSearch(Sender: TwwIncrementalSearch;
  MatchFound: Boolean);
begin
  wwFind.SearchField := findPur.SearchField; // 18208
  wwFind.FieldValue := findPur.Text;
end;

procedure TfNewAudit.ADOQuery1SelChange(Sender: TField);
begin
  if ADOQuery1Sel.Value = 'Y' then    // 18209
  begin
    lblSel.Caption := ' ' + inttostr(MIN(selsofar + 1, adoquery1.RecordCount)) + ' ';
  end
  else
  begin
    lblSel.Caption := ' ' + inttostr(MAX(selsofar - 1, 0)) + ' ';
  end;
end;

end.
