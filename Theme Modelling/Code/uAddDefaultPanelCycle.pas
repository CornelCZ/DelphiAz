unit uAddDefaultPanelCycle;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TAddDefaultPanelCycle = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    edtCycleName: TEdit;
    Label1: TLabel;
    procedure OKBtnClick(Sender: TObject);
  private
    function DefaultNameExists: Boolean;
    { Private declarations }
  public
    { Public declarations }
    PanelDesignID : integer;
  end;

implementation

{$R *.dfm}
uses udmThemeData, DB, ADODB;

procedure TAddDefaultPanelCycle.OKBtnClick(Sender: TObject);
begin
  if edtCycleName.Text = '' then
     raise Exception.Create('A new Cycle cannot be created without a valid name.')
  else
  if (DefaultNameExists) then
     raise Exception.Create('A similar name already exists.')
  else
  ModalResult := mrOk;
end;

function TAddDefaultPanelCycle.DefaultNameExists: Boolean;
begin
  Result := False;
  with dmThemeData.adoqRun do
    begin
      Close;
      SQL.Text := Format('SELECT * FROM ThemeDefaultPanelCycles '+
                         '  WHERE Name = %s AND PanelDesignID = %d',  [QuotedStr(edtCycleName.Text), PanelDesignID]);
      Open;

      if RecordCount > 0 then
         Result := True;
    end;
end;
end.
