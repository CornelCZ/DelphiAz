unit uMaintDivision;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls;

type
  TfMaintDivision = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    edtDivName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    lblType: TLabel;
    TypeComboBox: TComboBox;
    DivisionDescMemo: TMemo;
    DescriptionLabel: TLabel;
    ReferenceCodeEdit: TEdit;
    ReferenceCodeLabel: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure BuildDivisionTypeList;
    procedure ClearDivisionTypeList;
    { Private declarations }
  public
    { Public declarations }
    DivisionName: string;
  end;

  TDivisionObject = class(TObject)
    DivisionID: Integer;
    Name: String;
  end;

var
  fMaintDivision: TfMaintDivision;

implementation

uses uADO, uLog, uDatabaseADO, uGlobals;

{$R *.dfm}

procedure TfMaintDivision.btnOKClick(Sender: TObject);
var
  DivisionType: String;
  Description: String;
begin
  if edtDivName.Text = '' then
  begin
    ShowMessage('Please supply a name for the Division.');
    edtDivName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  if TypeComboBox.Text = '' then
  begin
    ShowMessage('You must assign a type to this division');
    TypeComboBox.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  with dmADO.adoqRun do
  begin
    if TypeComboBox.ItemIndex <> -1 then
      DivisionType := InttoStr(TDivisionObject(TypeComboBox.Items.Objects[TypeComboBox.ItemIndex]).DivisionID)
    else
      DivisionType := 'null';

    if DivisionDescMemo.Text = '' then
      Description := 'null'
    else
      Description := QuotedStr(DivisionDescMemo.Text);

    Log.Event('Create Division - ' + QuotedStr(edtDivName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertDivision %s,%s,%s,%s,@ID OUTPUT',
            [QuotedStr(edtDivName.Text),
             Description,
             DivisionType,
             QuotedStr(ReferenceCodeEdit.Text)]));
    try
      ExecSQL;
      Close;
      DivisionName := edtDivName.Text;
    except
      on E:Exception do
      begin
        log.Event('Create Division Failure - ' + E.Message);
        MessageDlg('Failed to create division: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

procedure TfMaintDivision.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_NEW_DIVISION_FORM );

  BuildDivisionTypeList;
end;

procedure TfMaintDivision.BuildDivisionTypeList;
var
  TempObj: TDivisionObject;
begin
  ClearDivisionTypeList;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ac_ProductDivisionType');
    Open;

    while not Eof do
    begin
      TempObj := TDivisionObject.Create;
      TempObj.Name := FieldByName('Name').AsString;
      TempObj.DivisionID := FieldByName('Id').AsInteger;

      TypeComboBox.Items.AddObject(TempObj.Name, TempObj);

      Next;
    end;

    Close;
  end;
end;

procedure TfMaintDivision.ClearDivisionTypeList;
var
  i: Integer;
begin
  for i := 0 to TypeComboBox.Items.Count - 1 do
    TDivisionObject(TypeComboBox.Items.Objects[i]).Free;
  TypeComboBox.Clear;
end;

end.
