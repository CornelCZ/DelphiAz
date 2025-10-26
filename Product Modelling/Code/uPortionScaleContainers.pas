unit uPortionScaleContainers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, ExtCtrls, wwdblook,
  uDatabaseADO;

type
  TPortionScaleContainers = class(TForm)
    PanelBottom: TPanel;
    PanelMain: TPanel;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    dbgPortionScaleContainers: TwwDBGrid;
    wwDBLookupComboContainer: TwwDBLookupCombo;
    procedure FormShow(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDoSave: Boolean;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AsOfDateCaption: String); reintroduce;
  end;

var
  PortionScaleContainers: TPortionScaleContainers;

implementation

{$R *.dfm}

{ TPortionScaleContainers }

constructor TPortionScaleContainers.Create(AOwner: TComponent;
  AsOfDateCaption: String);
begin
  inherited Create(AOwner);
  Caption := 'Portion Containers as of: ' + AsOfDateCaption;
end;

procedure TPortionScaleContainers.FormShow(Sender: TObject);
begin
  dbgPortionScaleContainers.BeginUpdate;
  try
    ProductsDB.qEditContainers.Close;
    ProductsDB.qScaleContainers.Close;

    ProductsDB.qEditContainers.Open;
    ProductsDB.qScaleContainers.Open;

    ButtonSave.Enabled := not ProductsDB.CurrentEntityControlledByRM;
    if ProductsDB.CurrentEntityControlledByRM then
      dbgPortionScaleContainers.options := dbgPortionScaleContainers.Options - [dgEditing];
  finally
    dbgPortionScaleContainers.EndUpdate;
  end;
end;

procedure TPortionScaleContainers.ButtonSaveClick(Sender: TObject);
begin
  FDoSave := True;
end;

procedure TPortionScaleContainers.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FDoSave then
  begin
    if ProductsDB.qEditContainers.Active then
    begin
      ProductsDB.qEditContainers.UpdateBatch;
    end;
  end;
end;

end.
