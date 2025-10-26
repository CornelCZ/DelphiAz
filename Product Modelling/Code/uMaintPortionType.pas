unit uMaintPortionType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uAztecDBComboBox, Buttons, DB, uAztecDBLookupBox,
  ADODB;

const
  NEW_ITEM = '<Create New...>';

type
  TfMaintPortionType = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtName: TEdit;
    Label4: TLabel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    tblPortionType: TADOTable;
    dsPortion: TDataSource;
    tblCourses: TADOTable;
    dsCourses: TDataSource;
    edtDescription: TEdit;
    edtEpos1: TEdit;
    edtEpos2: TEdit;
    edtEpos3: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    rbNextSel: TRadioButton;
    rbAllSel: TRadioButton;
    Label6: TLabel;
    Label7: TLabel;
    edtPriceFactor: TEdit;
    chkAutoAnd: TCheckBox;
    MandatoryFieldLabel: TLabel;
    PriceFactorGroupBox: TGroupBox;
    PercentageRadioButton: TRadioButton;
    FactorRadioButton: TRadioButton;
    CourseOverrideComboBox: TComboBox;
    procedure btnOKClick(Sender: TObject);
    procedure cbxCourseCreateNew(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPriceFactorKeyPress(Sender: TObject; var Key: Char);
    procedure CourseOverrideComboBoxChange(Sender: TObject);
    procedure PriceFactorChange(Sender: TObject);
  private
    FCourseList: TStringList;
    function ValidPriceFactor(AFactor: string;
      IsPercentage: Boolean): Boolean;
    procedure PopulateCourseList;
    procedure PopulateCourseOverrideComboBox(Courses: String);
    procedure CreateNewCourse;
  public
    { Public declarations }
    NewPortionName: string;
    NewPortionId: Integer;
  end;

implementation

uses uADO, uLog, uMaintCourses, uGlobals, uGuiUtils;

{$R *.dfm}

procedure TfMaintPortionType.btnOKClick(Sender: TObject);
var
  TempAutoAnd: Integer;
  TempCancelAfterSelect: Integer;
  TempCourseOverride: String;
  Description: String;
begin
  NewPortionName := edtName.Text;

  if edtName.Text = '' then
  begin
    ShowMessage('Please supply a Name for the Portion Type.');
    edtName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if (edtEpos1.Text = '') and (edtEpos2.Text = '') and (edtEpos3.Text = '') then
  begin
    ShowMessage('Please supply an EPoS Panel Name for the Portion Type.');
    edtEpos1.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if edtPriceFactor.Text = '' then
  begin
    ShowMessage('Please supply a Price Factor for the Portion Type.');
    edtPriceFactor.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if not ValidPriceFactor(edtPriceFactor.Text,PercentageRadioButton.Checked) then
  begin
    ShowMessage('Price Factor must be in range 0.01 - 100 OR 1% - 10000%.');
    edtPriceFactor.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  with dmADO.adoqRun do
  begin
    case chkAutoAnd.Checked of
      True: TempAutoAnd := 1;
      else
        TempAutoAnd := 0;
    end;

    case rbNextSel.Checked of
      True: TempCancelAfterSelect := 1;
      else
        TempCancelAfterSelect := 0;
    end;

    if CourseOverrideComboBox.Text = '' then
      TempCourseOverride := 'null'
    else
      TempCourseOverride := QuotedStr(CourseOverrideComboBox.Text);

    if edtDescription.Text = '' then
      Description := 'null'
    else
      Description := QuotedStr(edtDescription.Text);

    Log.Event('Create Portion Type - ' + QuotedStr(edtName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertPortionType %s,%s,%s,%s,%s,%s,%s,%d,%d,%d,@ID OUTPUT',
            [QuotedStr(edtName.Text),
             Description,
             QuotedStr(edtEpos1.Text),
             QuotedStr(edtEpos2.Text),
             QuotedStr(edtEpos3.Text),
             TempCourseOverride,
             edtPriceFactor.Text,
             Integer(PercentageRadioButton.Checked),
             TempCancelAfterSelect,
             TempAutoAnd
             ]));
    SQL.Add('SELECT @ID as ID');
    try
      Open;
      NewPortionId := 1;
      if (RecordCount > 0) and not (FieldByName('ID').IsNULL) then
        NewPortionId := FieldByName('ID').AsInteger;
      Close;
    except
      on E:Exception do
      begin
        log.Event('Create Portion Type Failure - ' + E.Message);
        MessageDlg('Failed to create portion type: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

procedure TfMaintPortionType.cbxCourseCreateNew(Sender: TObject);
begin
  fMaintCourses := TfMaintCourses.Create(Self);

  try
    fMaintCourses.ShowModal;
  finally
    fMaintCourses.Free;
  end;
end;

procedure TfMaintPortionType.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_NEW_PORTIONTYPE_FORM );

  PopulateCourseList;
  PopulateCourseOverrideComboBox(FCourseList.Text);

  tblPortionType.Open;
  tblCourses.Open;

  tblPortionType.Insert;
end;

procedure TfMaintPortionType.btnCancelClick(Sender: TObject);
begin
  tblPortionType.Cancel;
end;

procedure TfMaintPortionType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  tblPortionType.Close;
  tblCourses.Close;
end;

function TfMaintPortionType.ValidPriceFactor(AFactor: string; IsPercentage: Boolean): Boolean;
var
  FValue: real;
  IValue: integer;
begin
  Result := True;

  if IsPercentage then
  begin
    try
      IValue := StrToInt(AFactor);
    except
      Result := False;
      Exit;
    end;

    if (IValue < 1) or (IValue > 10000) then
      Result := False;
  end
  else //factor
  begin
    try
      FValue := StrToFloat(AFactor);
    except
      Result := False;
      Exit;
    end;

    if (FValue < 0.01) or (FValue > 100) then
      Result := False;
  end;
end;

procedure TfMaintPortionType.edtPriceFactorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not((Key in ['0'..'9', '.']) or (ord(Key) in [VK_BACK, VK_DELETE, VK_ESCAPE, VK_LEFT, VK_RIGHT])) then
    Key := #0;
end;

procedure TfMaintPortionType.PopulateCourseList;
begin
  if Assigned(FCourseList) then
    FCourseList.Free;

  FCourseList := TStringList.Create;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select CourseName from Courses');
    Open;

    While not EOF do
    begin
      FCourseList.Add(FieldByName('CourseName').asString);
      Next;
    end;
    Close;
  end;
end;

procedure TfMaintPortionType.PopulateCourseOverrideComboBox(Courses: String);
begin
  CourseOverrideComboBox.Items.Clear;
  CourseOverrideComboBox.Items.Text := Courses;

  if (CourseOverrideComboBox.Items.IndexOf(NEW_ITEM) = -1) then
    CourseOverrideComboBox.Items.Add(NEW_ITEM);
end;

procedure TfMaintPortionType.CourseOverrideComboBoxChange(Sender: TObject);
begin
  with sender as TComboBox do
  begin
    if ItemIndex = Items.IndexOf(NEW_ITEM) then
    begin
      CreateNewCourse;

      Parent.SetFocus;
    end;
  end;
end;

procedure TfMaintPortionType.CreateNewCourse;
begin
  fMaintCourses := TfMaintCourses.Create(Self);
  try
    fMaintCourses.ShowModal;

    PopulateCourseList;
    PopulateCourseOverrideComboBox(FCourseList.Text);

    if fMaintCourses.CourseName <> '' then
    begin
      CourseOverrideComboBox.ItemIndex := CourseOverrideComboBox.Items.IndexOf(fMaintCourses.CourseName);
    end;
  finally
    fMaintCourses.Free;
  end;
end;

procedure TfmaintPortionType.PriceFactorChange(Sender: TObject);
begin
  case FactorRadioButton.Checked of
    True:
      edtPriceFactor.Text := FloatToStr(StrToFloat(edtPriceFactor.Text)/100);
    False:
      edtPriceFactor.Text := FloatToStr(StrToFloat(edtPriceFactor.Text)*100);
  end;
end;

end.
