unit uSiteChoose;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwdblook, Db, DBTables, Wwquery, Buttons, ADODB;

type
  TfSiteChoose = class(TForm)
    Label1: TLabel;
    lookSites: TwwDBLookupCombo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    wwqSites: TADOQuery;
    procedure lookSitesCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    thesite : integer;
    sitename : string;
  end;

var
  fSiteChoose: TfSiteChoose;

implementation

uses uADO;

{$R *.DFM}

procedure TfSiteChoose.lookSitesCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
	lookSites.PerformSearch;
end;

procedure TfSiteChoose.FormShow(Sender: TObject);
begin
  wwqSites.open;
  looksites.Text := wwqsites.FieldByName('site name').asstring;
end;

procedure TfSiteChoose.BitBtn1Click(Sender: TObject);
begin
  with wwqSites do
  begin
    theSite := FieldByName('Site Code').AsInteger;
    SiteName := FieldByName('Site Name').AsString;
  end;
end;

end.
