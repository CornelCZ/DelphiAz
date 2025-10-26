unit uMapFooterText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMThemeData, uDMPromotionalFooter, Grids, Wwdbigrd, Wwdbgrid,
  ActnList, StdCtrls, wwdblook, DB, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  ExtCtrls;

type
  TMapFooterText = class(TForm)
    dbgFootersWithOverrides: TwwDBGrid;
    wwDBGrid1: TwwDBGrid;
    ActionList1: TActionList;
    ShowForm: TAction;
    HideForm: TAction;
    wwDBLookupCombo1: TwwDBLookupCombo;
    btClose: TButton;
    lblFooters: TLabel;
    lblMapSAOverrides: TLabel;
    Bevel1: TBevel;
    procedure ShowFormExecute(Sender: TObject);
    procedure HideFormExecute(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure ShowOverrideMappingForm;
  end;


implementation

uses Useful;

{$R *.dfm}

class procedure TMapFooterText.ShowOverrideMappingForm;
var
  MapFooters: TMapFooterText;
begin
  MapFooters := TMapFooterText.Create(nil);
  try
    dmThemeData.adoqRun.SQL.Text := GetStringResource('LoadSalesAreaOverrideMapping', 'TEXT');
    dmThemeData.SafeExecSQL;
    dmPromotionalFooter.qFootersWithOverrides.Open;
    if (dmPromotionalFooter.qFootersWithOverrides.RecordCount = 0) then
    begin
      MessageDlg('There are no Site Footer Text Overrides set up',mtInformation,[mbOK],0);
      dmPromotionalFooter.qFootersWithOverrides.Close;
    end
    else
      MapFooters.ShowModal;
  finally
    MapFooters.Release;
  end;
end;


procedure TMapFooterText.ShowFormExecute(Sender: TObject);
begin
  dmPromotionalFooter.qFooterOverrides.Open;
  dmPromotionalFooter.qSalesAreaFooterOverride.Open;
end;

procedure TMapFooterText.HideFormExecute(Sender: TObject);
begin
  dmPromotionalFooter.qFootersWithOverrides.Close;
  dmPromotionalFooter.qFooterOverrides.Close;
  if (dmPromotionalFooter.qSalesAreaFooterOverride.State in [dsEdit,dsInsert]) then
    dmPromotionalFooter.qSalesAreaFooterOverride.Post;
  dmPromotionalFooter.qSalesAreaFooterOverride.Close;
  dmThemeData.adoqRun.SQL.Text := GetStringResource('SaveSalesAreaOverrideMapping', 'TEXT');
  dmThemeData.SafeExecSQL;
end;

procedure TMapFooterText.btCloseClick(Sender: TObject);
begin
  if (dmPromotionalFooter.qSalesAreaFooterOverride.State in [dsEdit,dsInsert]) then
    dmPromotionalFooter.qSalesAreaFooterOverride.Post;
  ModalResult := mrOk;
  Close;
end;

end.
