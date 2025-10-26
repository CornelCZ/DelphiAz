unit uEditOrderDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, wwdblook, DB, ADODB, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, DBCtrls;

type
  TEditOrderDisplay = class(TForm)
    ADOqryTerminaGraphics: TADOQuery;
    Label1: TLabel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    dsTerminalGraphics: TDataSource;
    cbGraphicNames: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;
function EditOrderDisplay(out GraphicID: integer):Boolean;

implementation

{$R *.dfm}
Uses uADO, uGlobals;

function EditOrderDisplay(Out GraphicID: integer):Boolean;
var
  EditOrderDisplay:TEditOrderDisplay;
begin
  EditOrderDisplay:=TEditOrderDisplay.Create(nil);
  with EditOrderDisplay do
  begin
    cbGraphicNames.items.Clear;
    ADOqryTerminaGraphics.Open;
    ADOqryTerminaGraphics.First;
    while not ADOqryTerminaGraphics.EOF do
    begin
      cbGraphicNames.Items.AddObject(ADOqryTerminaGraphics.FieldByName('FileName').AsString,
        TObject(ADOqryTerminaGraphics.FieldByName('ID').AsInteger));
      ADOqryTerminaGraphics.Next;
    end;
    cbGraphicNames.Text:= '<Default>';
    Result:= ShowModal = mrOK;
    If cbGraphicNames.ItemIndex < 1 then
      GraphicID:=-1
    else
      GraphicID:=Integer(cbGraphicNames.Items.Objects[cbGraphicNames.ItemIndex]);
    ADOqryTerminaGraphics.Close;
  end;
  FreeAndNil(EditOrderDisplay);
end;

procedure TEditOrderDisplay.FormCreate(Sender: TObject);
begin
  if HelpExists then
    SetHelpContextID(self,AZTM_EDIT_ORDER_DISPLAY);
end;

end.
