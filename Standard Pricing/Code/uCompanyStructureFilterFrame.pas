unit uCompanyStructureFilterFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, DB, ADODB,
  ExtCtrls, uTagSelection, uTag;

type
  TCompanyStructureFilterFrame = class(TFrame)
    lblCompany: TLabel;
    lblArea: TLabel;
    lblSite: TLabel;
    lblSalesArea: TLabel;
    CbCompany: TComboBox;
    CbArea: TComboBox;
    CbSite: TComboBox;
    CbSalesArea: TComboBox;
    pnlSiteTag: TPanel;
    chkbxFilterBySiteTag: TCheckBox;
    btnSiteTags: TButton;
    CbSiteRef: TComboBox;
    lblSiteRef: TLabel;
    procedure CbCompanyChange(Sender: TObject);
    procedure CbAreaChange(Sender: TObject);
    procedure CbSiteChange(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure btnSiteTagsClick(Sender: TObject);
    procedure chkbxFilterBySiteTagClick(Sender: TObject);
    procedure CbSiteRefChange(Sender: TObject);
  private
    { Private declarations }
    FRestrictSiteTable: string;
    ADODataset: TADODataset;
    Initialised: Boolean;
    FFrameEnabled: boolean;
    FSiteTagList: TTagList;
    FDialogOwner: TComponent;

    procedure InitialiseWithAllValues(AComboBox : TComboBox);
    procedure RefreshCompanyComboBox;
    procedure RefreshAreaComboBox;
    procedure RefreshSiteComboBox(cbox: TCombobox; fieldToShow: string);
    procedure RefreshSalesAreaComboBox;
    procedure ClearComboBox(AComboBox: TComboBox);
    function GetSelectedCompanyCode: integer;
    function GetSelectedAreaCode: integer;
    function GetSelectedSiteCode: integer;
    function GetSelectedSalesAreaCode: integer;
    function GetSelectedCompanyName: string;
    function GetSelectedAreaName: string;
    function GetSelectedSiteName: string;
    function GetSelectedSalesAreaName: string;
    procedure SetFrameEnabled(const Value: boolean);
    function SiteTagsExists: boolean;
    procedure SelectSiteInComboBox(cbox: TComboBox; const siteId: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialise(RestrictSiteTable: string = '');

    property SelectedCompanyCode: integer read GetSelectedCompanyCode;
    property SelectedCompanyName: string read GetSelectedCompanyName;

    property SelectedAreaCode: integer read GetSelectedAreaCode;
    property SelectedAreaName: string read GetSelectedAreaName;

    property SelectedSiteCode: integer read GetSelectedSiteCode;
    property SelectedSiteName: string read GetSelectedSiteName;

    property SelectedSalesAreaCode: integer read GetSelectedSalesAreaCode;
    property SelectedSalesAreaName: string read GetSelectedSalesAreaName;

    property FrameEnabled : boolean read FFrameEnabled write SetFrameEnabled;

    property TagList: TTagList read FSiteTagList;

    property DialogOwner: TComponent read FDialogOwner write FDialogOwner;
  end;

implementation


uses
  uAdo, uAztecDatabaseUtils, uAztecMath, uGlobals;

{$R *.dfm}

const
  ALL_VALUES = '<all values>';

constructor TCompanyStructureFilterFrame.Create(AOwner: TComponent);
begin
  inherited;

  lblSalesArea.Caption := GetLocalisedName(lsSalesArea);

  ADODataset := GetADODataset(dmADO.AztecConn);

  { Initialise combo boxes with '<all values>' only. Can't initialise with all data here because at
    this point the parent form won't have made invisible the combo boxes it doesn't need. And the visible
    property is used to determine whether a combo box needs to be populated }
  InitialiseWithAllValues(CbCompany);
  InitialiseWithAllValues(CbArea);
  InitialiseWithAllValues(CbSite);
  InitialiseWithAllValues(CbSalesArea);

  FSiteTagList := TTagList.Create;

  FrameEnabled := TRUE;
  Initialised := FALSE;
end;

destructor TCompanyStructureFilterFrame.Destroy;
begin
  ClearComboBox(CbSalesArea);
  ClearComboBox(CbSite);
  ClearComboBox(CbArea);
  ClearComboBox(CbCompany);

  FSiteTagList.Free;

  FreeAndNil(ADODataset);

  inherited;
end;

procedure TCompanyStructureFilterFrame.FrameEnter(Sender: TObject);
begin
  if not initialised then
  begin
    Initialise;
  end;
end;

procedure TCompanyStructureFilterFrame.Initialise(RestrictSiteTable: string = '');
begin
  FRestrictSiteTable := RestrictSiteTable;
  RefreshCompanyComboBox;
  RefreshAreaComboBox;
  RefreshSiteComboBox(CbSite, 'Site Name');
  RefreshSiteComboBox(CbSiteRef, 'Site Ref');
  RefreshSalesAreaComboBox;
  if not SiteTagsExists then
  begin
    chkbxFilterBySiteTag.Enabled := False;
    btnSiteTags.Enabled := False;
  end;

  Initialised := TRUE;
end;

procedure TCompanyStructureFilterFrame.InitialiseWithAllValues(AComboBox: TComboBox);
begin
  ClearComboBox(AComboBox);
  AComboBox.Items.AddObject(ALL_VALUES, TInteger.Create(-1));
  AComboBox.ItemIndex := 0;
end;

procedure TCompanyStructureFilterFrame.ClearComboBox(AComboBox: TComboBox);
var
  i: integer;
begin
  for i := 0 to AComboBox.Items.Count - 1 do
    AComboBox.Items.Objects[i].Free;
  AComboBox.Items.Clear;
end;


procedure TCompanyStructureFilterFrame.RefreshCompanyComboBox;
begin
  if not CbCompany.Visible then
    Exit;

  InitialiseWithAllValues(CbCompany);

  with ADODataset do
  try
    CommandText :=
     'SELECT DISTINCT [Company Code], [Company Name] FROM Company ' +
     'WHERE Deleted IS NULL ' +
     '  AND [Company Code] IN ' +
     '      (SELECT [Company Code] FROM Config c INNER JOIN SiteAztec s ON c.[Site Code] = s.[Site Code] ' +
     '       WHERE s.Deleted IS NULL AND ISNULL(s.[Aztec Pricing], ''N'') = ''Y'') ' +
     'ORDER BY [Company Name]';
    Open;

    while not EOF do
    begin
      CbCompany.Items.AddObject(FieldByName('Company Name').AsString,
                                TInteger.Create(FieldByName('Company Code').AsInteger));
      Next;
    end;

  finally
    Close;
  end;

  CbCompany.ItemIndex := 0;
end;

procedure TCompanyStructureFilterFrame.RefreshAreaComboBox;
begin
  if not CbArea.Visible then
    Exit;

  InitialiseWithAllValues(CbArea);

  with ADODataset do
  try
    CommandText :=
      'SELECT DISTINCT [Area Code], [Area Name] FROM Area ' +
      'WHERE Deleted IS NULL ' +
      '  AND [Area Code] IN ' +
      '      (SELECT [Area Code] FROM Config c INNER JOIN SiteAztec s ON c.[Site Code] = s.[Site Code] ' +
      '       WHERE s.Deleted IS NULL AND ISNULL(s.[Aztec Pricing], ''N'') = ''Y'') ';

    if CbCompany.ItemIndex > 0 then
      CommandText := CommandText +
      'AND [Area Code] IN (SELECT [Area Code] FROM Config WHERE [Company Code] = ' +
              IntToStr(TInteger(CbCompany.Items.Objects[CbCompany.ItemIndex]).Value) + ')';

    CommandText := CommandText + 'ORDER BY [Area Name]';
    Open;

    while not EOF do
    begin
      CbArea.Items.AddObject(FieldByName('Area Name').AsString,
                             TInteger.Create(FieldByName('Area Code').AsInteger));
      Next;
    end;

  finally
    Close;
  end;

  CbArea.ItemIndex := 0;
end;

procedure TCompanyStructureFilterFrame.RefreshSiteComboBox(cbox: TCombobox; fieldToShow: string);
begin
  if not cbox.Visible then
    Exit;

  InitialiseWithAllValues(cbox);

  with ADODataset do
  try
    CommandText :=
      'SELECT [Site Code], [' + fieldToShow + '] FROM SiteAztec ';

    if FRestrictSiteTable <> '' then
      CommandText := CommandText +
        Format('JOIN %s ist ON SiteAztec.[Site Code] = ist.[SiteCode] ', [FRestrictSiteTable]);

    CommandText := CommandText +
     'WHERE [Deleted] IS NULL AND ISNULL([' + fieldToShow + '], '''') <> '''' AND ISNULL([Aztec Pricing], ''N'') = ''Y'' ';

    if CbArea.ItemIndex > 0 then
    begin
      CommandText := CommandText +
      'AND [Site Code] IN (SELECT [Site Code] FROM Config WHERE [Area Code] = ' +
        IntToStr(TInteger(CbArea.Items.Objects[CbArea.ItemIndex]).Value) + ') ';
    end
    else
    begin
      if CbCompany.ItemIndex > 0 then
        CommandText := CommandText +
        'AND [Site Code] IN (SELECT [Site Code] FROM Config WHERE [Company Code] = ' +
          IntToStr(TInteger(CbCompany.Items.Objects[CbCompany.ItemIndex]).Value) + ') ';
    end;

    CommandText := CommandText + 'ORDER BY [' + fieldToShow + ']';
    Open;

    while not EOF do
    begin
      cbox.Items.AddObject(FieldByName(fieldToShow).AsString,
                             TInteger.Create(FieldByName('Site Code').AsInteger));
      Next;
    end;

  finally
    Close;
  end;

  cbox.ItemIndex := 0;
end;


procedure TCompanyStructureFilterFrame.RefreshSalesAreaComboBox;
var siteId: integer;
begin
  if not CbSalesArea.Visible then
    Exit;

  InitialiseWithAllValues(CbSalesArea);

  { Unlike the Area and Site combo boxes the SalesArea combo box will only show sales areas if a site has
    been selected. Showing all sales areas, or those within a company or an area, would be pointless as
    sales areas tend to be named similarly on different sites e.g. "Bar", "Lounge", "Restaurant" }

  if (CbSite.ItemIndex > 0) or (CbSiteRef.ItemIndex > 0) then
  begin
    if CbSite.ItemIndex > 0 then
      siteId := TInteger(CbSite.Items.Objects[CbSite.ItemIndex]).Value
    else
      siteId := TInteger(CbSiteRef.Items.Objects[CbSiteRef.ItemIndex]).Value;

    with ADODataset do
    try
      CommandText :=
        'SELECT sa.Id, sa.Name ' +
        'FROM ac_SalesArea sa ' +
        '  LEFT OUTER JOIN #BookingsOnlySalesAreas b ON b.Id = sa.Id ' +
        'WHERE sa.Deleted = 0 AND sa.SiteId = ' + IntToStr(siteId) +
        '  AND b.Id IS NULL ' +
        'ORDER BY sa.Name';
      Open;

      while not EOF do
      begin
        CbSalesArea.Items.AddObject(FieldByName('Name').AsString,
                               TInteger.Create(FieldByName('Id').AsInteger));
        Next;
      end;

    finally
      Close;
    end;
  end;

  CbSalesArea.ItemIndex := 0;
end;

procedure TCompanyStructureFilterFrame.CbCompanyChange(Sender: TObject);
begin
  RefreshAreaComboBox;
  RefreshSiteComboBox(CbSite, 'Site Name');
  RefreshSiteComboBox(CbSiteRef, 'Site Ref');
  RefreshSalesAreaComboBox;
end;

procedure TCompanyStructureFilterFrame.CbAreaChange(Sender: TObject);
begin
  RefreshSiteComboBox(CbSite, 'Site Name');
  RefreshSiteComboBox(CbSiteRef, 'Site Ref');
  RefreshSalesAreaComboBox;
end;

procedure TCompanyStructureFilterFrame.CbSiteChange(Sender: TObject);
begin
  if CbSite.ItemIndex = 0 then
    CbSiteRef.ItemIndex := 0
  else
    SelectSiteInComboBox(CbSiteRef, TInteger(CbSite.Items.Objects[CbSite.ItemIndex]).Value);

  RefreshSalesAreaComboBox;
end;

procedure TCompanyStructureFilterFrame.CbSiteRefChange(Sender: TObject);
begin
  if CbSiteRef.ItemIndex = 0 then
    CbSite.ItemIndex := 0
  else
    SelectSiteInComboBox(CbSite, TInteger(CbSiteRef.Items.Objects[CbSiteRef.ItemIndex]).Value);

  RefreshSalesAreaComboBox;
end;

function TCompanyStructureFilterFrame.GetSelectedCompanyCode: integer;
begin
  Result := TInteger(CbCompany.Items.Objects[CbCompany.ItemIndex]).Value;
end;

function TCompanyStructureFilterFrame.GetSelectedAreaCode: integer;
begin
  Result := TInteger(CbArea.Items.Objects[CbArea.ItemIndex]).Value;
end;

function TCompanyStructureFilterFrame.GetSelectedSiteCode: integer;
begin
  Result := TInteger(CbSite.Items.Objects[CbSite.ItemIndex]).Value;
end;

function TCompanyStructureFilterFrame.GetSelectedSalesAreaCode: integer;
begin
  Result := TInteger(CbSalesArea.Items.Objects[CbSalesArea.ItemIndex]).Value;
end;

function TCompanyStructureFilterFrame.GetSelectedCompanyName: string;
begin
  Result := CbCompany.Text;
end;

function TCompanyStructureFilterFrame.GetSelectedAreaName: string;
begin
  Result := CbArea.Text;
end;

function TCompanyStructureFilterFrame.GetSelectedSiteName: string;
begin
  Result := CbSite.Text;
end;

function TCompanyStructureFilterFrame.GetSelectedSalesAreaName: string;
begin
  Result := CbSalesArea.Text;
end;

procedure TCompanyStructureFilterFrame.SetFrameEnabled(const Value: boolean);
  procedure EnableControls(Control: TControl;
    const Value: boolean);
  var
    i: Integer;
  begin
    if Control is TWinControl then
      with Control as TWinControl do
        for i := 0 to ControlCount - 1 do
        begin
          if Controls[i] is TWinControl then EnableControls(Controls[i], Value);
          Controls[i].Enabled := Value;
        end
    else
      Control.Enabled := Value;
  end;
begin
  FFrameEnabled := Value;

  EnableControls(Self, Value);

  btnSiteTags.Enabled := Value and chkbxFilterBySiteTag.Checked;
  Self.Refresh;
end;

procedure TCompanyStructureFilterFrame.btnSiteTagsClick(Sender: TObject);
var
  SiteTagFilterSelector: TfTagSelection;
  DlgOwner: TComponent;
begin
  if Assigned(FDialogOwner) then
    DlgOwner := FDialogOwner
  else
    DlgOwner := nil;
  SiteTagFilterSelector := TfTagSelection.Create(DlgOwner,FSiteTagList, tcSite, dmADO.AztecConn);
  try
    if SiteTagFilterSelector.ShowModal = mrOK then
    begin
      FSiteTagList.Clear;
      FSiteTagList.Free;
      FSiteTagList := SiteTagFilterSelector.SelectedTags.Clone;
    end;
  finally
    SiteTagFilterSelector.Free;
  end;
end;

procedure TCompanyStructureFilterFrame.chkbxFilterBySiteTagClick(
  Sender: TObject);
begin
  btnSiteTags.Enabled := (Sender as TCheckBox).Checked;  
end;

function TCompanyStructureFilterFrame.SiteTagsExists: boolean;
begin
  Result := False;
  with ADODataset do
  try
    CommandText := 'select count(*) as NumTags from ac_Tag where IsLocationTag = 1';
    Open;
    if not EOF then
      Result := FieldByName('NumTags').AsInteger > 0;
  finally
    Close;
  end;
end;

procedure TCompanyStructureFilterFrame.SelectSiteInComboBox(cbox: TComboBox; const siteId: integer);
var i, indexOfSite: integer;
begin
  indexOfSite := 0; // Select 'All Items' if given siteId not found.

  for i := 1 to cbox.Items.Count - 1 do
  begin
    if TInteger(cbox.Items.Objects[i]).Value = siteId then
    begin
      indexOfSite := i;
      break;
    end;
  end;

  cbox.ItemIndex := indexOfSite;
end;

end.
