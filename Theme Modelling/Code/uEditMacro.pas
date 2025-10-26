unit uEditMacro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uEPOSTextHelper, uGlobals;

type
  TEditMacro = class(TForm)
    lbName: TLabel;
    lbDescription: TLabel;
    edName: TEdit;
    mmDescription: TMemo;
    Label1: TLabel;
    mmEposName: TMemo;
    btOk: TButton;
    btCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    EditMode: boolean;
    EPOSTextHelper: TEposTextHelper;
    { Private declarations }
    procedure AddRecord;
    procedure LoadRecord;
    procedure SaveRecord;
    procedure CheckNameIsUnique;
  public
    { Public declarations }
    procedure AddMacro;
    procedure EditMacro;
  end;

var
  EditMacro: TEditMacro;

implementation

uses uDMThemeData, ADODB, DB, uGenerateThemeIDs, uDefineMacros, math, useful,
  uSimpleEPOSLineWrap;

{$R *.dfm}

procedure TEditMacro.AddMacro;
begin
  EditMode := false;
  if ShowModal = mrOk then
  begin
    AddRecord;
  end;
end;

procedure TEditMacro.AddRecord;
begin
  dmThemeData.qMacros.Insert;
  dmThemeData.qMacros.FieldByName('MacroID').AsInteger := uGenerateThemeIDs.GetNewId(scMacro);
  SaveRecord;
end;

procedure TEditMacro.EditMacro;
begin
  LoadRecord;
  EditMode := true;
  if ShowModal = mrOk then
    SaveRecord;
end;

procedure TEditMacro.FormShow(Sender: TObject);
begin
  if EditMode then
  begin
    // load the macro data
  end;
end;

procedure TEditMacro.LoadRecord;
var
  Name1, Name2, Name3: string;
begin
  edName.Text := dmThemeData.qMacros.FieldByName('Name').AsString;
  mmDescription.Text := dmThemeData.qMacros.FieldByName('Description').AsString;

  Name1 := dmThemeData.qMacros.FieldByName('EposName1').AsString;
  Name2 := dmThemeData.qMacros.FieldByName('EposName2').AsString;
  Name3 := dmThemeData.qMacros.FieldByName('EposName3').AsString;

  mmEPOSName.Clear;
  mmEPOSName.Lines.Add(Name1);
  mmEPOSName.Lines.Add(Name2);
  mmEPOSName.Lines.Add(Name3);
end;

procedure TEditMacro.SaveRecord;
var
  Name1, Name2, Name3: string;
begin
  if mmEPOSName.Lines.Count > 0 then
    Name1 := mmEPOSName.Lines[0];
  if mmEPOSName.Lines.Count > 1 then
    Name2 := mmEPOSName.Lines[1];
  if mmEPOSName.Lines.Count > 2 then
    Name3 := mmEPOSName.Lines[2];

  with dmThemeData.qMacros do
  begin
    if not (State in [dsEdit, dsInsert]) then Edit;
    FieldByName('PanelDesignID').AsInteger := DefineMacros.PanelDesignID;
    FieldByName('Name').AsString := edName.Text;
    FieldByName('Description').AsString := mmDescription.Text;
    FieldByName('EposName1').AsString := Name1;
    FieldByName('EposName2').AsString := Name2;
    FieldByName('EposName3').AsString := Name3;
    Post;
  end;
end;

procedure TEditMacro.FormCreate(Sender: TObject);
var epostext : String;
begin
  EPOSTextHelper := TEPOSTextHelper.Create(edName, mmEposName);

  if UKUSmode = 'US' then
     epostext := 'POS'
  else
     epostext := 'EPoS';

  Label1.Caption := epostext +' text:';

end;

procedure TEditMacro.btOkClick(Sender: TObject);
begin
  if Trim(edName.Text) = '' then
    raise Exception.Create('Please enter a name');
  if Trim(mmEposName.lines.Text) = '' then
    raise Exception.Create('Please enter non-blank text for EPOS');
  CheckNameIsUnique;

  ModalResult := mrOk;
end;

procedure TEditMacro.CheckNameIsUnique;
var
  NonUnique: boolean;
begin
  if not EditMode then
    dmThemeData.ADOqRun.SQL.Text :=
      Format('select * from ThemePanelDesignMacro where name = %s '+
        'and PanelDesignID = %d', [QuotedStr(edName.Text), DefineMacros.PanelDesignID])
  else
    dmThemeData.adoqRun.SQL.Text :=
      Format('select * from ThemePanelDesignMacro where name = %s '+
      'and MacroID <> %d '+
      'and PanelDesignID = %d',
      [QuotedStr(edName.Text), dmThemeData.qMacros.FieldByName('MacroID').AsInteger,
        DefineMacros.PanelDesignID]);
  dmThemeData.adoqRun.Open;
  NonUnique := dmThemeData.adoqrun.RecordCount > 0;
  dmThemeData.adoqRun.Close;
  if NonUnique then
    raise Exception.Create('This name is already in use by another macro.');


end;

end.
