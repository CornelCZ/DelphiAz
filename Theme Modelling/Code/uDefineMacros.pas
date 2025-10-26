unit uDefineMacros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, uGridSortHelper;

type
  TDefineMacros = class(TForm)
    Label1: TLabel;
    btAddMacro: TButton;
    btEditMacro: TButton;
    btDeleteMacro: TButton;
    btClose: TButton;
    dbgDefineMacros: TwwDBGrid;
    btShowUses: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btDeleteMacroClick(Sender: TObject);
    procedure btEditMacroClick(Sender: TObject);
    procedure btAddMacroClick(Sender: TObject);
    procedure dbgDefineMacrosDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btShowUsesClick(Sender: TObject);
  private
    { Private declarations }
    MacrosSortHelper: TGridSortHelper;
    function MacroInUse: boolean;
  public
    { Public declarations }
    PanelDesignID: integer;

  end;

var
  DefineMacros: TDefineMacros;

implementation

uses udmThemeData, uFormNavigate, uEditMacro, uAztecLog;

{$R *.dfm}

procedure TDefineMacros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Nav.MoveBack;
end;

procedure TDefineMacros.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDefineMacros.FormShow(Sender: TObject);
begin
  dmThemeData.qMacros.Parameters.FindParam('PanelDesignID').value := PanelDesignID;
  dmThemeData.qMacros.Open;
  MacrosSortHelper.Reset;
end;

procedure TDefineMacros.FormHide(Sender: TObject);
begin
  dmThemeData.qMacros.Close;
end;

procedure TDefineMacros.btDeleteMacroClick(Sender: TObject);
begin
  if dmThemeData.qMacros.RecordCount = 0 then
    Raise exception.create('Please add some items first!');

  if MacroInUse then
    Raise Exception.Create('This Macro is in use on one or more panels - cannot delete.');

  if messagedlg(
    format('Are you sure you want to delete Macro "%s"?', [dmThemeData.qMacros.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    Log('Deleting Macro :' +dmThemeData.qPanelDesigns.fieldbyname('Name').asstring);
    dmThemeData.qMacros.Delete;
  end;
end;

procedure TDefineMacros.btEditMacroClick(Sender: TObject);
begin
  if dmThemeData.qMacros.RecordCount = 0 then
    Raise exception.create('Please add some items first!');

  with TEditMacro.Create(nil) do
  begin
    Log('Edit macro clicked');
    EditMacro;
    Free;
  end;
end;

procedure TDefineMacros.btAddMacroClick(Sender: TObject);
begin
  with TEditMacro.Create(nil) do
  begin
    Log('Add macro clicked');
    AddMacro;
    Free;
  end;
end;

procedure TDefineMacros.dbgDefineMacrosDblClick(Sender: TObject);
begin
  btEditMacro.click;
end;

procedure TDefineMacros.FormCreate(Sender: TObject);
begin
  MacrosSortHelper := TGridSortHelper.Create;
  MacrosSortHelper.Initialise(dbgDefineMacros);
end;

function TDefineMacros.MacroInUse: boolean;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format(
     'select * from ThemePanelButton where ButtonTypeChoiceID = ( '+
     '  select ID from ThemeButtonTypeChoiceLookup where Name = ''RunMacro'' '+
     ') and ButtonTypeChoiceAttr01 = %s',
      [QuotedStr(dmThemeData.qMacros.FieldByName('MacroID').AsString)]
    );
    Open;
    result := RecordCount > 0;
    Close;
  end;
end;

procedure TDefineMacros.btShowUsesClick(Sender: TObject);
var
  PanelList: string;
begin
  if dmThemeData.qMacros.RecordCount = 0 then
    Raise exception.create('Please add some items first!');

  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format(
     'select Name from ThemePanel '+
     'join ThemePanelButton on ThemePanel.PanelID = ThemePanelButton.PanelID '+
     'where ButtonTypeChoiceID = ( '+
     '  select ID from ThemeButtonTypeChoiceLookup where Name = ''RunMacro'' '+
     ') and ButtonTypeChoiceAttr01 = %s',
      [QuotedStr(dmThemeData.qMacros.FieldByName('MacroID').AsString)]
    );

    PanelList := '';
    Open;
    while not (EOF) do
    begin
      PanelList := PanelList + FieldByName('Name').AsString + ', ';
      next;
    end;
    close;
    if (PanelList = '') then
      raise Exception.Create('Macro is not in use on any panels.');
    SetLength(PanelList, Length(PanelList)-2);
    MessageDlg('Macro is in use on panels:' + #13 + PanelList, mtInformation, [mbOk], 0);
  end;
end;

end.
