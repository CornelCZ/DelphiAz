unit uRateOverrides;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uADO, ADODB, DB, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls;

type
  TfRateOverrides = class(TForm)
    PanelBottom: TPanel;
    PanelMain: TPanel;
    wwDBGrid1: TwwDBGrid;
    ButtonPostChanges: TButton;
    ButtonCancel: TButton;
    adotRateOverrides: TADOTable;
    adoqSave: TADOQuery;
    dsRateOverrides: TDataSource;
    adotRateOverridesBandType: TIntegerField;
    adotPaySchemeBandTypes: TADOTable;
    adotRateOverridesBandName: TStringField;
    adoqPopulate: TADOQuery;
    adotRateOverridesOverriddenPayRate: TBCDField;
    adotRateOverridesOldOverriddenPayRate: TBCDField;
    adotRateOverridesBasePayRate: TBCDField;
    procedure FormShow(Sender: TObject);
    procedure ButtonPostChangesClick(Sender: TObject);
  private
    FWorkedPaySchemeVersionID: Integer;
    FWorkedUserPayRateOverrideVersionID: Integer;
    FSiteId: Integer;
    FUserId: Int64;
    FSchin: TDatetime;
    { Private declarations }
  public
    { Public declarations }
    property WorkedPaySchemeVersionID: Integer read FWorkedPaySchemeVersionID
                                               write FWorkedPaySchemeVersionID;
    property WorkedUserPayRateOverrideVersionID: Integer read FWorkedUserPayRateOverrideVersionID
                                                         write FWorkedUserPayRateOverrideVersionID;
    property SiteId: Integer read FSiteId write FSiteid;
    property UserId: Int64 read FUserId write FUserId;
    property Schin: TDatetime read FSchin write FSchin;
  end;

var
  fRateOverrides: TfRateOverrides;

implementation

{$R *.dfm}

procedure TfRateOverrides.FormShow(Sender: TObject);
begin
  dmado.EmptySQLTable('#RateOverrides');

  with adoqPopulate do
  begin
    Parameters.ParamByName('SiteId').Value := FSiteId;
    Parameters.ParamByName('UserId').Value := FUserId;
    Parameters.ParamByName('Schin').Value := FSchin;
    Parameters.ParamByName('PaySchemeVersion').Value := FWorkedPaySchemeVersionID;
    Parameters.ParamByName('UserPayRateOverride').Value := FWorkedUserPayRateOverrideVersionID;
    ExecSQL;
  end;

  adotRateOverrides.Open;
end;

procedure TfRateOverrides.ButtonPostChangesClick(Sender: TObject);
begin
  if adotRateOverrides.State = dsEdit then adotRateOverrides.Post;

  with adoqSave do
  begin
    Parameters.ParamByName('SiteId').Value := FSiteId;
    Parameters.ParamByName('UserId').Value := FUserId;
    Parameters.ParamByName('Schin').Value := FSchin;
    Open;

    if not FieldbyName('ChangesMade').AsBoolean then
    begin
      if MessageDlg('No changes have been made to the pay rates for this shift.' + #13#10 +
                    'Continue without making any changes?',
                    mtInformation,
                    mbOKCancel,
                    0) = mrOK then
        ModalResult := mrCancel
      else
        ModalResult := mrNone;
    end;
    Close;
  end;
end;

end.
