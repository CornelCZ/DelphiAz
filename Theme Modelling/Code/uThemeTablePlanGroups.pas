unit uThemeTablePlanGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TThemeTablePlanGroups = class(TForm)
    lbUngrouped: TListBox;
    Label1: TLabel;
    lbGroup1: TListBox;
    lbGroup2: TListBox;
    lbGroup3: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    btCancel: TButton;
    btOk: TButton;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    themeid: integer;
    { Private declarations }
    procedure listboxmove(source, dest: TListbox);
    procedure lbsave(source: TListbox; groupvalue: variant);
    procedure lbload(dest: TListbox; groupvalue: variant);
  public
    { Public declarations }
    class procedure EditGroups(theme_id: integer);
  end;

implementation

uses uADO, uAztecLog, uFormNavigate;

{$R *.dfm}

procedure TThemeTablePlanGroups.Button1Click(Sender: TObject);
begin
  listboxmove(lbUngrouped, lbGroup1);
end;

procedure TThemeTablePlanGroups.Button2Click(Sender: TObject);
begin
  listboxmove(lbGroup1, lbUngrouped);
end;

procedure TThemeTablePlanGroups.Button3Click(Sender: TObject);
begin
  listboxmove(lbUngrouped, lbGroup2);
end;

procedure TThemeTablePlanGroups.Button4Click(Sender: TObject);
begin
  listboxmove(lbGroup2, lbUngrouped);
end;

procedure TThemeTablePlanGroups.Button5Click(Sender: TObject);
begin
  listboxmove(lbUngrouped, lbGroup3);
end;

procedure TThemeTablePlanGroups.Button6Click(Sender: TObject);
begin
  listboxmove(lbGroup3, lbUngrouped);
end;

procedure TThemeTablePlanGroups.btOkClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  lbsave(lbUngrouped, null);
  lbsave(lbGroup1, 1);
  lbsave(lbGroup2, 2);
  lbsave(lbGroup3, 3);
  modalresult := mrCancel;
  Close;
end;

class procedure TThemeTablePlanGroups.EditGroups(theme_id: integer);
var
  ThemeTablePlanGroups: TThemeTablePlanGroups;
begin
  ThemeTablePlanGroups := TThemeTablePlanGroups.Create(nil);
  with ThemeTablePlanGroups do try
    themeid := theme_id;
    lbload(lbUngrouped, null);
    lbload(lbGroup1, 1);
    lbload(lbGroup2, 2);
    lbload(lbGroup3, 3);
    Nav.MoveForward(ThemeTablePlanGroups, true);
  finally
  end;
end;

procedure TThemeTablePlanGroups.lbload(dest: TListbox;
  groupvalue: variant);
begin
  with dmado.qRun do
  begin
    if groupvalue = null then
    begin
      sql.text := 'select name, tableplanid from themetableplan '+
        'where themeid = :theme and groupid is null';
      parameters.ParamByName('theme').value := themeid;
    end
    else
    begin
      sql.text := 'select name, tableplanid from themetableplan '+
        'where themeid = :theme and groupid = :group';
      parameters.ParamByName('theme').value := themeid;
      parameters.parambyname('group').Value := groupvalue;
    end;
    open;
    dest.clear;
    while not (eof) do
    begin
      dest.AddItem(fieldbyname('name').asstring, TObject(fieldbyname('tableplanid').asinteger));
      next;
    end;
    close;
  end;
end;

procedure TThemeTablePlanGroups.lbsave(source: TListbox; groupvalue: variant);
var
  i: integer;
begin
  for i := 0 to pred(source.items.Count) do
  begin
    with dmado.qrun do
    begin
      if groupvalue = null then
      begin
        sql.text := 'update themetableplan set groupid = null '+
          'where tableplanid = :tableplanid';
        parameters.ParamByName('tableplanid').value := integer(source.items.Objects[i]);
      end
      else
      begin
        sql.text := 'update themetableplan set groupid = :group '+
          'where tableplanid = :tableplanid';
        parameters.ParamByName('tableplanid').value := integer(source.items.Objects[i]);
        parameters.parambyname('group').Value := groupvalue;
      end;
      execsql;
    end;
  end;
end;

procedure TThemeTablePlanGroups.listboxmove(source, dest: TListbox);
begin
  if source.ItemIndex = -1 then
    if source.items.count = 0 then
      raise exception.create('There are no items to move!')
    else
      source.itemindex := 0;

  Log(source.Items[source.itemindex] + ' moved to ' + copy(dest.Name,3,length(dest.Name)));
  dest.additem(source.Items[source.itemindex], source.Items.objects[source.itemindex]);
  source.DeleteSelected;
end;

procedure TThemeTablePlanGroups.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  Nav.MoveBack;
end;

procedure TThemeTablePlanGroups.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
end;

procedure TThemeTablePlanGroups.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  Close;
end;

end.
