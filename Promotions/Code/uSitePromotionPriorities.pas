unit uSitePromotionPriorities;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uSetPromotionOrderFrame;

type
  TfSitePromotionPriorities = class(TForm)
    Panel5: TPanel;
    Label13: TLabel;
    Bevel3: TBevel;
    imLogo: TImage;
    Label2: TLabel;
    btOk: TButton;
    btCancel: TButton;
    SetPromotionOrderFrame: TSetPromotionOrderFrame;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    TemplateID: Integer;
    procedure CreateTempTables;
    procedure SavePromotionOrder;
    function GetTemplateID: Integer;
    procedure SaveAutoPriorityOrder;
    { Private declarations }
  public
    { Public declarations }
    class function ShowDialog(aFilterString: String = '';
      aMidWordSearch: Boolean = FALSE): boolean;
  end;

var
  fSitePromotionPriorities: TfSitePromotionPriorities;

implementation

uses
  ADODB, uAztecLog, udmPromotions, uPromoCommon, uGlobals, uTagSelection;

{$R *.dfm}

procedure TfSitePromotionPriorities.FormCreate(Sender: TObject);
begin
  imLogo.Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk50x50');

  TemplateID := GetTemplateID;
  CreateTempTables;
  SetPromotionOrderFrame.InitialiseFrame;
end;

function TfSitePromotionPriorities.GetTemplateID: Integer;
var
  query: TADOQuery;
begin
  query := dmPromotions.adoqRun;
  query.Close;
  query.SQL.Text := 'select top 1 PriorityTemplateID from ac_SitePriorityTemplate';
  query.Open;
  result := query.FieldByName('PriorityTemplateID').AsInteger;
end;

procedure TfSitePromotionPriorities.CreateTempTables;
var
  query: TADOQuery;
begin
  query := dmPromotions.adoqRun;
  query.SQL.Text := Format('if object_id(''tempdb..#PriorityTemplate'') is not null  ' + #13#10 +
                '  drop table #PriorityTemplate; ' + #13#10 +

                'create table #PriorityTemplate ( ' + #13#10 +
                '  Id integer, ' + #13#10 +
                '  Name varchar(50),' + #13#10 +
                '  AutoPriorityModeId tinyint,' + #13#10 +
                '  Primary key (Id)); ' + #13#10 +

                'if object_id(''tempdb..#PriorityTemplateOrder'') is not null  ' + #13#10 +
                '  drop table #PriorityTemplateOrder; ' + #13#10 +

                'create table #PriorityTemplateOrder ( ' + #13#10 +
                '  TemplateID integer, ' + #13#10 +
                '  PromotionID bigint, ' + #13#10 +
                '  Priority integer, ' + #13#10 +
                '  Primary key (TemplateID, PromotionID)); ' + #13#10 +

                'insert #PriorityTemplate ' + #13#10 +
                '  select  t.Id, t.Name, t.AutoPriorityModeId ' + #13#10 +
                '  from ac_PromotionPriorityTemplate t' + #13#10 +
                '  join ac_SitePriorityTemplate s ' + #13#10 +
                '  on t.Id = s.PriorityTemplateID ' + #13#10 +
                '  where s.SiteID = %0:d; ' + #13#10 +

                'insert #PriorityTemplateOrder ' + #13#10 +
                '  select pto.TemplateID, pto.PromotionID, pto.Priority ' + #13#10 +
                '  from ac_PromotionPriorityTemplateOrder pto ' + #13#10 +
                '  join Promotion p ' + #13#10 +
                '  on pto.PromotionID = p.PromotionID ' + #13#10 +
                '  join ac_SitePriorityTemplate spt ' + #13#10 +
                '  on spt.PriorityTemplateID = pto.TemplateID ' + #13#10 +
                '  where p.SiteCode = %0:d ' + #13#10 +
                '  and spt.SiteID = %0:d;', [dmPromotions.SiteCode]);
  query.ExecSQL;
end;

class function TfSitePromotionPriorities.ShowDialog(aFilterString: String = ''; aMidWordSearch: Boolean = FALSE): boolean;
begin
  Log('SitePromotionPriorities', 'Creating Instance...');
  with TfSitePromotionPriorities.Create(nil) do
  try
    SetPromotionOrderFrame.LoadData(aFilterString, aMidWordSearch);
    SetPromotionOrderFrame.FormShow;
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfSitePromotionPriorities.btOkClick(Sender: TObject);
begin
  Log('SetPromotionOrder', 'Ok Button Clicked');
  SavePromotionOrder;
end;

procedure TfSitePromotionPriorities.SavePromotionOrder;
var
  query: TADOQuery;
begin
  SetPromotionOrderFrame.savePromoOrder(TemplateID);
  query := dmPromotions.adoqRun;
  query.SQL.Text := 'UPDATE ac_PromotionPriorityTemplateOrder ' +
                        ' SET Priority = temp.Priority ' +
                        ' FROM ac_PromotionPriorityTemplateOrder pto ' +
                        ' JOIN #PriorityTemplateOrder temp ' +
                        ' ON pto.PromotionID = temp.PromotionID ';
  query.ExecSQL;

  if isMaster then  // for single site masters
    SaveAutoPriorityOrder;
end;

procedure TfSitePromotionPriorities.SaveAutoPriorityOrder;
var
  query: TADOQuery;
begin
  query := dmPromotions.adoqRun;
  query.SQL.Text := 'UPDATE ac_PromotionPriorityTemplate ' +
                        ' SET AutoPriorityModeId = temp.AutoPriorityModeId ' +
                        ' FROM #PriorityTemplate temp ';
  query.ExecSQL;
end;

procedure TfSitePromotionPriorities.FormResize(Sender: TObject);
begin
  SetPromotionOrderFrame.FormResize(sender);
end;

procedure TfSitePromotionPriorities.FormShow(Sender: TObject);
begin
  dmPromotions.InsertMissingPromotionPriorities;
end;

end.
