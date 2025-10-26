unit uPromotionFilterFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB;

const
  NO_FILTER = '<Any>';

type
  TApplyFilter = procedure (const FilterText: string; MidwordSearch: boolean; SiteCode: Integer) of object;
  TClearFilter = procedure of object;

  TPromotionFilterFrame = class(TFrame)
    FilterPanel: TPanel;
    edtFilter: TEdit;
    chkbxMidwordSearch: TCheckBox;
    chkbxFiltered: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblSiteFilter: TLabel;
    cbxSiteFilter: TComboBox;
    procedure ApplyFilterSettings(Sender: TObject);
    procedure cbxSiteFilterDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    FApplyFilter: TApplyFilter;
    FClearFilter: TClearFilter;
    FSiteList: TStringList;
    procedure SetSiteList(AStringList: TStringList);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ApplyFilter: TApplyFilter write FApplyFilter;
    property ClearFilter: TClearFilter write FClearFilter;
    property SiteList: TStringList write SetSiteList;
  end;

implementation

{$R *.dfm}


procedure TPromotionFilterFrame.ApplyFilterSettings(Sender: TObject);
begin
  Assert(Assigned(FApplyFilter) and Assigned(FClearFilter),
         'TPromotionFilterFrame.ApplyFilterSettings: ApplyFilter and ClearFilter properties have not been set');

  if (chkbxFiltered.Checked) and ((edtFilter.Text <> '') or (cbxSiteFilter.Text <> NO_FILTER)) then
    FApplyFilter(edtFilter.Text, chkbxMidwordSearch.Checked, StrToIntDef(cbxSiteFilter.Items.Values[cbxSiteFilter.Items.Names[cbxSiteFilter.ItemIndex]],-1))
  else
    FClearFilter;
end;


constructor TPromotionFilterFrame.Create(AOwner: TComponent);
begin
  inherited;
  FSiteList := TStringList.Create;
end;

destructor TPromotionFilterFrame.Destroy;
begin
  FSiteList.Free;
  inherited;
end;

procedure TPromotionFilterFrame.SetSiteList(AStringList: TStringList);
begin
  FSiteList.Assign(AStringList);
  FSiteList.Insert(0, No_Filter + '=-1');
  cbxSiteFilter.Items.Assign(FSiteList);
  cbxSiteFilter.ItemIndex := 0;
end;

procedure TPromotionFilterFrame.cbxSiteFilterDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with TComboBox(Control) do
  begin
    Canvas.FillRect(Rect) ;
    Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Items.Names[Index]);
  end;
end;

end.
