unit uEditDialogs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDesignDetail = class(TObject)
    OffSet : Integer;
    ScreenInterfaceID : Integer;
  end;

  TEditDialogs = class(TForm)
    Label1: TLabel;
    lbDialogs: TListBox;
    Button1: TButton;
    Label2: TLabel;
    cbPanelDesignType: TComboBox;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lbDialogsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbDialogsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbPanelDesignTypeChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    DesignDetail : TDesignDetail;
  public
    { Public declarations }
  end;

var
  EditDialogs: TEditDialogs;

implementation

uses uDMThemeData, uEditPanelDesign, uTillButton;

{$R *.dfm}

procedure TEditDialogs.FormShow(Sender: TObject);
begin
  with dmthemedata.adoqRun do
  begin
    SQL.Text :=
      'select PanelDesignType, PanelID-1 as Offset, b.DisplayName + '' '' +ISNULL(Name, '''') AS DisplayName, ScreenInterfaceID '+
      'from ThemeDialogPanelSet a '+
      'join ThemePanelDesignType b on a.PanelDesignType = b.PanelDesignTypeID '+
      'where DialogPanelName = ''ClockIn'' '+
      'order by PanelDesignType';
    Open;
    First;
    while not(EOF) do
    begin
      DesignDetail := TDesignDetail.Create;
      DesignDetail.OffSet := FieldByName('Offset').AsInteger;
      DesignDetail.ScreenInterfaceID :=  FieldByName('ScreenInterfaceID').AsInteger;
      cbPanelDesignType.Items.AddObject(
        Format('%s (+%d)', [FieldByName('DisplayName').AsString, FieldByName('Offset').AsInteger]),
        TObject(DesignDetail));
      next;
    end;
    cbPanelDesignType.ItemIndex := 0;

    sql.text := 'select a.dialogpanelname, a.panelid '+
      'from themedialogpanelset a '+
      'where paneldesigntype = 1 '+
      'order by 1';
    open;
    first;
    while not(eof) do
    begin
      lbDialogs.Items.Addobject(
        format('%s (%d)', [
        fieldbyname('dialogpanelname').asstring, fieldbyname('panelid').asinteger]),
      Tobject( fieldbyname('panelid').asinteger));
      next;
    end;
    close;
  end;
end;

procedure TEditDialogs.Button1Click(Sender: TObject);
var
  panelid, offset, ScreenInterfaceID: cardinal;
begin
  if lbDialogs.ItemIndex <> -1 then
  begin
    panelid := cardinal(lbDialogs.Items.Objects[lbDialogs.ItemIndex]);
    offset := cardinal(TDesignDetail(cbPanelDesignType.Items.Objects[cbPanelDesignType.ItemIndex]).OffSet);
    ScreenInterfaceID := cardinal(TDesignDetail(cbPanelDesignType.Items.Objects[cbPanelDesignType.ItemIndex]).ScreenInterfaceID);
    editpaneldesign.PanelManager.LoadPanel(dmthemedata.AztecConn, panelid+offset, lpmLocalSharedPanel, 0, ScreenInterfaceID);
  end;
end;

procedure TEditDialogs.lbDialogsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  button1.click;
end;

procedure TEditDialogs.lbDialogsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  button1.click;
end;

procedure TEditDialogs.cbPanelDesignTypeChange(Sender: TObject);
begin
  Button1.Click;
end;

procedure TEditDialogs.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
