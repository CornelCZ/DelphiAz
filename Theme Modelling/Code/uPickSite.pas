unit uPickSite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, DB, ADODB, uGridSortHelper, Wwdbigrd,
  Wwdbgrid;

type
  TPickSite = class(TForm)
    StatusBar1: TStatusBar;
    DBGridOutlets: TwwDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridOutletsKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    SiteListSortHelper: TGridSortHelper;
    { Private declarations }
  public
    procedure SetGridDoubleClick(WhatToDo: TNotifyEvent; Desc: string);
    { Public declarations }
  end;

var
  PickSite: TPickSite;

implementation

uses
  uAztecLog, uADO, uDMThemeData, uFormNavigate;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TPickSite.SetGridDoubleClick(WhatToDo : TNotifyEvent; Desc : string);
begin
  DBGridOutlets.OnDblClick := WhatToDo;
  StatusBar1.Panels[0].Text := Desc;
  SiteListSortHelper.Initialise(DBGridOutlets);
end;

//------------------------------------------------------------------------------
procedure TPickSite.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  dmThemeData.AccessDataset('qOutlets');
  SiteListSortHelper.Reset;
end;

//------------------------------------------------------------------------------
procedure TPickSite.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmThemeData.DeAccessDataset('qOutlets');
//  DBGridOutlets.OnDblClick := nil;
  StatusBar1.Panels[0].Text := '';
  Log('Form Closed : ' + Caption);
  Nav.MoveBack;
end;

//------------------------------------------------------------------------------
procedure TPickSite.DBGridOutletsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    DBGridOutlets.OnDblClick(DBGridOutlets);
end;

procedure TPickSite.FormCreate(Sender: TObject);
begin
  SiteListSortHelper := TGridSortHelper.Create;
  SiteListSortHelper.Initialise(DBGridOutlets);
end;

procedure TPickSite.FormDestroy(Sender: TObject);
begin
  SiteListSortHelper.Free;
end;

end.
