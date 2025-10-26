unit uEditTableMoveReasons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList, uSelectReasonsFrame;

type
  TEditTableMoveReasons = class(TForm)
    SelectReasonsFrame: TSelectReasonsFrame;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure SaveMappedReasons;
  end;

implementation

uses uADO, uAztecLog;

{$R *.dfm}

procedure TEditTableMoveReasons.FormCreate(Sender: TObject);
begin
  SelectReasonsFrame.BehaveAsDialog := true;
  SelectReasonsFrame.PerformSave := SaveMappedReasons;
  SelectReasonsFrame.AllReasonsSQL :=
    'SELECT tr.ReasonID, Name, CAST(CASE WHEN ttmr.ReasonID IS NULL THEN 0 ELSE 1 END as BIT) as Used ' +
    'FROM ThemeReason tr ' +
    'LEFT JOIN ThemeTableMoveReasons ttmr ON tr.ReasonID = ttmr.ReasonID';

  SelectReasonsFrame.Initialise;
end;

procedure TEditTableMoveReasons.SaveMappedReasons;
var
  ReasonID, Index : integer;
begin
  //TODO: Should probably do this a better way which doesn't all rows first. Perhaps INSERT into a temp table and then
  //      update real table based on this.
  with dmADO.qRun do
  begin
    Close;

    SQL.Text := 'DELETE ThemeTableMoveReasons';
    ExecSQL;

    for Index := 0 to (SelectReasonsFrame.ChosenReasons.Count - 1) do
    begin
      ReasonID := Integer(SelectReasonsFrame.ChosenReasons.Objects[Index]);
      SQL.Text := Format('INSERT ThemeTableMoveReasons (ReasonID) VALUES (%0:d)', [ReasonID]);
      ExecSQL;
    end;
  end;
end;

end.
