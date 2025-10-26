unit uMaintSubCateg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, uAztecDBComboBox, Mask, wwdbedit, Wwdbspin,
  ActnList;

type
  TfMaintSubCateg = class(TForm)
    Label1: TLabel;
    edtSubCategName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    DivisionLabel: TLabel;
    CategoryLabel: TLabel;
    NameLabel: TLabel;
    cmbbxDivision: TComboBox;
    cmbbxCategory: TComboBox;
    btnDivision: TButton;
    btnCategory: TButton;
    sedtMinCustomerAge: TwwDBSpinEdit;
    lblMinCustAge: TLabel;
    AllowSitePricingCheckBox: TCheckBox;
    CoverCountCheckBox: TCheckBox;
    CategoryDescriptionMemo: TMemo;
    DescriptionLabel: TLabel;
    AgeRestrictionComboBox: TCheckBox;
    ActionListSubCat: TActionList;
    ActionAgeRestriction: TAction;
    cmbbxSuperCategory: TComboBox;
    cmbbxSubDivision: TComboBox;
    lblSubDivision: TLabel;
    lblSuperCategory: TLabel;
    btnSubDivision: TButton;
    btnSuperCategory: TButton;
    cbAllowSiteNaming: TCheckBox;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbbxDivisionExit(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure btnDivisionClick(Sender: TObject);
    procedure sedtMinCustomerAgeChange(Sender: TObject);
    procedure AgeRestrictionComboBoxClick(Sender: TObject);
    procedure btnSubDivisionClick(Sender: TObject);
    procedure btnSuperCategoryClick(Sender: TObject);
    procedure cmbbxSubDivisionExit(Sender: TObject);
    procedure cmbbxSuperCategoryExit(Sender: TObject);
    procedure ClearCategoryList;
    procedure ClearDivisionList;
    procedure ClearSubDivisionList;
    procedure ClearSuperCategoryList;
  private
    procedure BuildCategoryList;
    procedure BuildDivisionList;
    procedure BuildSubDivisionList;
    procedure BuildSuperCategoryList;
    { Private declarations }
  public
    { Public declarations }
  end;

  TLevel = class(TObject)
    Name: String;
    ID: Integer;
  end;

var
  fMaintSubCateg: TfMaintSubCateg;

implementation

uses uDatabaseADO, uADO, uLineEdit, uLog, uGuiUtils, uMaintCategory,
  uMaintDivision, uGlobals, uMaintSubDivision, uMaintSuperCategory;

{$R *.dfm}

procedure TfMaintSubCateg.btnOKClick(Sender: TObject);
var
  Category: String;
  Description: String;
begin
  if edtSubCategName.Text = '' then
  begin
    ShowMessage('Please supply a name for the Sub-Category.');
    edtSubCategName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if cmbbxDivision.Text = '' then
  begin
    ShowMessage('Please select a Division.');
    cmbbxDivision.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;
  if not doesComboTextMatchPickList(cmbbxDivision,false) then
  begin
    ShowMessage( cmbbxDivision.Text + ' is not a valid division.');
    cmbbxDivision.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if cmbbxCategory.Text = '' then
  begin
    ShowMessage('Please select a Category.');
    cmbbxCategory.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;
  if not doesComboTextMatchPickList(cmbbxCategory,false) then
  begin
    ShowMessage( cmbbxCategory.Text + ' is not a valid category.');
    cmbbxCategory.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if cmbbxCategory.ItemIndex <> -1 then
    Category := InttoStr(TLevel(cmbbxCategory.Items.Objects[cmbbxCategory.ItemIndex]).ID)
  else
    Category := 'null';

  if CategoryDescriptionMemo.Text = '' then
    Description := 'null'
  else
    Description := QuotedStr(CategoryDescriptionMemo.Text);


  with dmADO.adoqRun do
  begin
    Log.Event('Create Sub-Category - ' + QuotedStr(edtSubCategName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertSubCategory %s,%s,%s,%d,%d,%d,%d,%s,@ID OUTPUT',
           [Category,
            QuotedStr(edtSubCategName.Text),
            Description,
            Integer(AllowSitePricingCheckBox.Checked),
            Integer(cbAllowSiteNaming.Checked),
            Integer(CoverCountCheckBox.Checked),
            Integer(AgeRestrictionComboBox.Checked),
            sedtMinCustomerAge.text]));
    try
      ExecSQL;
      Close;

      ProductsDB.AddSubCateg(edtSubCategName.Text, TLevel(cmbbxDivision.Items.Objects[cmbbxDivision.ItemIndex]).Id);

      LineEditForm.setupStaticPickLists;
    except
      on E:Exception do
      begin
        log.Event('Create Sub-Category Failure - ' + E.Message);
        MessageDlg('Failed to create sub-category: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

procedure TfMaintSubCateg.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_NEW_SUBCATEGORY_FORM );

  BuildDivisionList;
end;

procedure TfMaintSubCateg.cmbbxDivisionExit(Sender: TObject);
begin
  BuildSubDivisionList;
end;

procedure TfMaintSubCateg.btnCategoryClick(Sender: TObject);
begin
  if cmbbxSuperCategory.Text = '' then
  begin
    ShowMessage('Please select a Super Category.');
    cmbbxSuperCategory.SetFocus;
    Exit;
  end;
  if not doesComboTextMatchPickList(cmbbxSuperCategory,false) then
  begin
    ShowMessage( cmbbxSuperCategory.Text + ' is not a valid Super Category.');
    cmbbxSuperCategory.SetFocus;
    Exit;
  end;

  fMaintCategory := TfMaintCategory.Create(Self);

  try
    fMaintCategory.DivisionID := TLevel(cmbbxDivision.Items.Objects[cmbbxDivision.ItemIndex]).ID;
    fMaintCategory.SuperCategoryID := TLevel(cmbbxSuperCategory.Items.Objects[cmbbxSuperCategory.ItemIndex]).ID;
    if fMaintCategory.ShowModal = mrOK then
    begin
      BuildCategoryList;
      cmbbxCategory.ItemIndex := cmbbxCategory.Items.IndexOf(fMaintCategory.CategoryName);
    end;
  finally
    fMaintCategory.Free;
  end;
end;

procedure TfMaintSubCateg.btnDivisionClick(Sender: TObject);
begin
  fMaintDivision := TfMaintDivision.Create(Self);

  try
    if (fMaintDivision.ShowModal = mrOK) then
    begin
      BuildDivisionList;
      cmbbxDivision.ItemIndex := cmbbxDivision.Items.IndexOf(fMaintDivision.DivisionName);
    end;
  finally
    fMaintDivision.Free;
  end;
end;

procedure TfMaintSubCateg.sedtMinCustomerAgeChange(Sender: TObject);
begin
  if TwwDBSpinEdit(Sender).Value < 1 then
    TwwDBSpinEdit(Sender).Value := 1;
  if TwwDBSpinEdit(Sender).Value > 99 then
    TwwDBSpinEdit(Sender).Value := 99;
end;

procedure TfMaintSubCateg.BuildDivisionList;
var
  TempLevel: TLevel;
begin
  ClearDivisionList;
  ClearSubDivisionList;
  ClearSuperCategoryList;
  ClearCategoryList;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ID,Name from ac_ProductDivision');
    SQL.Add('order by Name');
    Open;

    while not EOF do
    begin
      TempLevel := TLevel.Create;
      TempLevel.Name := FieldByName('Name').AsString;
      Templevel.ID := FieldByName('ID').AsInteger;
      cmbbxDivision.Items.AddObject(TempLevel.name,Templevel);
      Next;
    end;

    Close;
  end;

  if not doesComboTextMatchPickList(cmbbxDivision,false) then
    cmbbxDivision.Text := '';
end;

procedure TfMaintSubCateg.BuildCategoryList;
var
  TempLevel: TLevel;
begin
  ClearCategoryList;

  if cmbbxSuperCategory.ItemIndex = -1 then Exit;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ID,Name from ac_ProductCategory');
    SQL.Add('where ProductSuperCategoryID = ' + (InttoStr(TLevel(cmbbxSuperCategory.Items.Objects[cmbbxSuperCategory.ItemIndex]).ID)));
    SQL.Add('order by [Name]');
    Open;

    while not EOF do
    begin
      TempLevel := TLevel.Create;
      TempLevel.Name := FieldByName('Name').AsString;
      Templevel.ID := FieldByName('ID').AsInteger;
      cmbbxCategory.Items.AddObject(TempLevel.name,TempLevel);
      Next;
    end;

    Close;
  end;

  if not doesComboTextMatchPickList(cmbbxCategory,false) then
    cmbbxCategory.Text := '';
end;

procedure TfMaintSubCateg.AgeRestrictionComboBoxClick(Sender: TObject);
begin
  sedtMinCustomerAge.Enabled := AgeRestrictionComboBox.Checked;
  lblMinCustAge.Enabled := AgeRestrictionComboBox.Checked;
end;

procedure TfMaintSubCateg.btnSubDivisionClick(Sender: TObject);
begin
  if cmbbxDivision.Text = '' then
  begin
    ShowMessage('Please select a Division.');
    cmbbxDivision.SetFocus;
    Exit;
  end;
  if not doesComboTextMatchPickList(cmbbxDivision,false) then
  begin
    ShowMessage( cmbbxDivision.Text + ' is not a valid division.');
    cmbbxDivision.SetFocus;
    Exit;
  end;

  fMaintSubDivision := TfMaintSubDivision.Create(Self);

  try
    fMaintSubDivision.Division := TLevel(cmbbxDivision.Items.Objects[cmbbxDivision.ItemIndex]).ID;
    if fMaintSubDivision.ShowModal = mrOK then
    begin
      BuildSubDivisionList;
      cmbbxSubDivision.ItemIndex := cmbbxSubDivision.Items.IndexOf(fMaintSubDivision.SubDivisionName);
    end;
  finally
    fMaintSubDivision.Free;
  end;
end;

procedure TfMaintSubCateg.BuildSubDivisionList;
var
  TempLevel: TLevel;
begin
  ClearSubDivisionList;
  ClearSuperCategoryList;
  ClearCategoryList;

  //Sub Division needs a division to work against...
  if cmbbxDivision.ItemIndex = -1 then Exit;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ID,Name from ac_ProductSubDivision');
    SQL.Add('where ProductDivisionID = ' + (InttoStr(TLevel(cmbbxDivision.Items.Objects[cmbbxDivision.ItemIndex]).ID)));
    SQL.Add('order by [Name]');
    Open;

    while not EOF do
    begin
      TempLevel := TLevel.Create;
      TempLevel.Name := FieldByName('Name').AsString;
      Templevel.ID := FieldByName('ID').AsInteger;
      cmbbxSubDivision.Items.AddObject(TempLevel.name,TempLevel);
      Next;
    end;

    Close;
  end;

  if not doesComboTextMatchPickList(cmbbxSubDivision,false) then
    cmbbxSubDivision.Text := '';
end;

procedure TfMaintSubCateg.BuildSuperCategoryList;
var
  TempLevel: TLevel;
begin
  ClearSuperCategoryList;
  ClearCategoryList;

  //Super Categopry needs a sub division to work against...
  if cmbbxSubDivision.ItemIndex = -1 then Exit;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ID,Name from ac_ProductSuperCategory');
    SQL.Add('where ProductSubDivisionID = ' + (InttoStr(TLevel(cmbbxSubDivision.Items.Objects[cmbbxSubDivision.ItemIndex]).ID)));
    SQL.Add('order by [Name]');
    Open;

    while not EOF do
    begin
      TempLevel := TLevel.Create;
      TempLevel.Name := FieldByName('Name').AsString;
      Templevel.ID := FieldByName('ID').AsInteger;
      cmbbxSuperCategory.Items.AddObject(TempLevel.name,TempLevel);
      Next;
    end;

    Close;
  end;

  if not doesComboTextMatchPickList(cmbbxSuperCategory,false) then
    cmbbxSuperCategory.Text := '';
end;

procedure TfMaintSubCateg.btnSuperCategoryClick(Sender: TObject);
begin
  if cmbbxSubDivision.Text = '' then
  begin
    ShowMessage('Please select a Sub Division.');
    cmbbxSubDivision.SetFocus;
    Exit;
  end;
  if not doesComboTextMatchPickList(cmbbxSubDivision,false) then
  begin
    ShowMessage( cmbbxSubDivision.Text + ' is not a valid Sub Division.');
    cmbbxSubDivision.SetFocus;
    Exit;
  end;

  fMaintSuperCategory := TfMaintSuperCategory.Create(Self);

  try
    fMaintSuperCategory.SubDivision := TLevel(cmbbxSubDivision.Items.Objects[cmbbxSubDivision.ItemIndex]).ID;
    if fMaintSuperCategory.ShowModal = mrOK then
    begin
      BuildSuperCategoryList;
      cmbbxSuperCategory.ItemIndex := cmbbxSuperCategory.Items.IndexOf(fMaintSuperCategory.SuperCategoryName);
    end;
  finally
    fMaintSuperCategory.Free;
  end;
end;

procedure TfMaintSubCateg.cmbbxSubDivisionExit(Sender: TObject);
begin
  BuildSuperCategoryList;
end;

procedure TfMaintSubCateg.cmbbxSuperCategoryExit(Sender: TObject);
begin
  BuildCategoryList;
end;

procedure TfMaintSubCateg.ClearDivisionList;
var
  i: Integer;
begin
  for i := 0 to cmbbxDivision.Items.Count - 1 do
    TLevel(cmbbxDivision.Items.Objects[i]).Free;
  cmbbxDivision.Clear;
end;

procedure TfMaintSubCateg.ClearSuperCategoryList;
var
  i: Integer;
begin
  for i := 0 to cmbbxSuperCategory.Items.Count - 1 do
    TLevel(cmbbxSuperCategory.Items.Objects[i]).Free;
  cmbbxSuperCategory.Clear;
end;

procedure TfMaintSubCateg.ClearSubDivisionList;
var
  i: Integer;
begin
  for i := 0 to cmbbxSubDivision.Items.Count - 1 do
    TLevel(cmbbxSubDivision.Items.Objects[i]).Free;
  cmbbxSubDivision.Clear;
end;

procedure TfMaintSubCateg.ClearCategoryList;
var
  i: Integer;
begin
  for i := 0 to cmbbxCategory.Items.Count - 1 do
    TLevel(cmbbxCategory.Items.Objects[i]).Free;
  cmbbxCategory.Clear;
end;

end.
