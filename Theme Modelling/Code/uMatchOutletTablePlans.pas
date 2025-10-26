unit uMatchOutletTablePlans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  DB, ADODB;

type
  TMapping = class(TObject)
  private
    FOutletPlanID : Integer;
    FThemePlanID : Integer;
    FOL_ListIndex : Integer;
    FTP_ListIndex : Integer;
  public
//    procedure drawMapping;
  end;


  TMappingList = class(TList)
  private
  public
    Image : TImage;
    ItemHeight : Integer;
    procedure AddMapping(NewMapping : TMapping);
    procedure DrawMappings;
    procedure ClearMapping(OL_ListIndex, TP_ListIndex : Integer);
    destructor Destroy; Override; 
  end;

  TMatchOutletTablePlans = class(TForm)
    lbMatchTablePlansAdvice: TLabel;
    btOk: TButton;
    btCancel: TButton;
    lbxOTP: TListBox;
    lbxTTp: TListBox;
    btAddMatch: TButton;
    Label2: TLabel;
    Label3: TLabel;
    qApplyMappings: TADOQuery;
    btRemoveMatch: TButton;
    Panel1: TPanel;
    Image1: TImage;
    procedure btAddMatchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbxOTPDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbxOTPDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure btRemoveMatchClick(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
  private
    { Private declarations }
    FMappings : TMappingList;
    OTP_IDs : TStringList;
    TTP_IDs : TstringList;
    procedure PaintFunnyLines;
    procedure AssignMappings;
    procedure populateListBoxes;
    procedure CreateMappingList;
    function GetIndexFromID(TablePlanID: Integer): Integer;
    procedure ResizeForm();
  public
    SiteCode: integer;
    ThemeID: integer;
  end;

var
  MatchOutletTablePlans: TMatchOutletTablePlans;

implementation

uses
  uDMThemeData, uAztecLog, math;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.PaintFunnyLines;
var
  R : TRect;
begin
  ResizeForm();
  Image1.Canvas.Brush.Style := bsClear;
  Image1.Canvas.Brush.Color := clBtnFace;
  R.Left := 0;
  R.Right := Image1.Width;
  R.Top := 0;
  R.Bottom := Image1.Height;
  Image1.Canvas.FillRect(R);
  FMappings.DrawMappings;
end;


procedure TMatchOutletTablePlans.btAddMatchClick(Sender: TObject);
var
  NewMapping : TMapping;
begin
  ButtonClicked(Sender);
  if (lbxOTP.ItemIndex <> -1) and (lbxTTP.ItemIndex <> -1)  then
  begin
    NewMapping := TMapping.Create;
    NewMapping.FOL_ListIndex := lbxOTP.ItemIndex;
    NewMapping.FOutletPlanID := StrToInt(OTP_IDs[lbxOTP.ItemIndex]);
    NewMapping.FTP_ListIndex := lbxTTP.ItemIndex;
    NewMapping.FThemePlanID := StrToInt(TTP_IDs[lbxTTP.ItemIndex]); //**temporary
    Log(Format('Site Table Plan : %s Mapped to theme table Plan to %s',[OTP_IDs[lbxOTP.ItemIndex],TTP_IDs[lbxTTP.ItemIndex]]));
    FMappings.AddMapping(NewMapping);
    PaintFunnyLines;
  end;
end;

{ TMappingList }

//------------------------------------------------------------------------------
procedure TMappingList.AddMapping(NewMapping: TMapping);
var
  index : Integer;
  TmpMap : TMapping;
begin
  for index := count -1 downto 0 do
  begin
    //** One to One relation ship if other exists delete it!
    with TMapping (items[index]) do
    begin
      if (FOutletPlanID = NewMapping.FOutletPlanID) or  (FThemePlanID = NewMapping.FThemePlanID) then
      begin
        TmpMap := Items[Index];
        Remove(TmpMap);
        TmpMap.Free;
      end
    end;
  end;
  Add(NewMapping);
end;

//------------------------------------------------------------------------------
procedure TMappingList.ClearMapping(OL_ListIndex, TP_ListIndex: Integer);
var
  index : Integer;
  TmpMap : TMapping;
  Matched : Boolean;
begin
  Matched := False;
  for index := Count-1 downto 0 do
  begin
    TmpMap := Items[Index];
    if (TmpMap.FOL_ListIndex = OL_ListIndex) and (TmpMap.FTP_ListIndex = TP_ListIndex) then
    begin
      Remove(TmpMap);
      TmpMap.Free;
      Matched := True;
    end
  end;

  if not Matched then
     MessageDlg('Selected mappings are invalid.', mtError, [mbOK], 0);
end;

destructor TMappingList.Destroy;
var
  index : Integer;
begin
  for index := 0 to Count -1 do
  begin
    TMapping(items[index]).Free;
  end;
  inherited;
end;

procedure TMappingList.DrawMappings;
var
  index : Integer;
  TmpRect: TRect;
  TmpPoint1, TmpPoint2: TPoint;

begin

  Image.Canvas.Pen.Color := clBtnText;
  Image.Canvas.Brush.Style := bsSolid;

  Image.Canvas.Lock;
  try
    for index :=  0 to count -1 do
    begin
      with TMapping (items[index]) do
      begin
        Image.Canvas.Pen.Width := 2;
        TmpRect := Rect(0, (FOL_ListIndex *  ItemHeight) + (ItemHeight div 2), Image.Width-1,  (FTP_ListIndex *  ItemHeight) + (ItemHeight div 2));

        TmpRect.Left := TmpRect.Left + 2;
        TmpRect.Right := TmpRect.Right - 2;
        Image.Canvas.MoveTo(TmpRect.TopLeft.X, TmpRect.TopLeft.Y);
        Image.Canvas.LineTo(TmpRect.BottomRight.X, TmpRect.BottomRight.Y);

        Image.Canvas.Pen.Width := 1;
        TmpPoint1 := TmpRect.TopLeft;
        TmpPoint2 := TmpRect.TopLeft;
        TmpPoint1.X := TmpPoint1.X - 2;
        TmpPoint1.Y := TmpPoint1.Y - 2;
        TmpPoint2.X := TmpPoint2.X + 3;
        TmpPoint2.Y := TmpPoint2.Y + 3;
        Image.Canvas.Ellipse(TmpPoint1.X, TmpPoint1.Y, TmpPoint2.X, TmpPoint2.Y);

        TmpPoint1 := TmpRect.BottomRight;
        TmpPoint2 := TmpRect.BottomRight;
        TmpPoint1.X := TmpPoint1.X - 2;
        TmpPoint1.Y := TmpPoint1.Y - 2;
        TmpPoint2.X := TmpPoint2.X + 3;
        TmpPoint2.Y := TmpPoint2.Y + 3;
        Image.Canvas.Ellipse(TmpPoint1.X, TmpPoint1.Y, TmpPoint2.X, TmpPoint2.Y);
      end;
    end;
  finally
    Image.Canvas.Unlock;
  end;
end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.CreateMappingList;
begin
  FMappings := TMappingList.Create;
  FMappings.Image := Image1;
  FMappings.ItemHeight := lBxTTP.ItemHeight;
end;


procedure TMatchOutletTablePlans.FormCreate(Sender: TObject);
begin
  OTP_IDs := TStringList.Create;
  TTP_IDs := TstringList.Create;
  CreateMappingList;
end;

procedure TMatchOutletTablePlans.FormDestroy(Sender: TObject);
begin
  FMappings.Free;
  OTP_IDs.Free;
  TTP_IDs.Free;


end;

procedure TMatchOutletTablePlans.lbxOTPDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TMatchOutletTablePlans.lbxOTPDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  btAddMatchClick(Self);
end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.BitBtn2Click(Sender: TObject);
begin
  FMappings.ClearMapping(lbxOTP.ItemIndex, lbxTTp.ItemIndex);
  PaintFunnyLines;
end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.btOkClick(Sender: TObject);
var
  index : Integer;
  SiteCode : Integer;
  SQLTxt  : string;
begin
 //** NB the user does not have to allocate any Theme plans to Outlet Plans.
 //** It just means that the themem plan button will not be displayed on the
 //** till/ Epos Solution as were not sposed to call them tills!
 //** THis needs to be a two fold query
  ButtonClicked(Sender);
  SiteCode := dmThemeData.qOutlets.FieldByName('SiteCode').Value;
  with dmThemeData.qClearOutletMappings do
  begin
    Parameters[0].Value := SiteCode;
    ExecSQL;
  end;
  SQLTxt := 'Update ThemeOutletTablePlan Set TablePlanID = :TPID Where SiteCode = :SiteCode And OutletTAblePlanID = :OPID';
  qApplyMappings.SQL.Text := SQLTxt;
  for index := 0 to FMappings.count -1 do
  begin
    qApplyMappings.Parameters[0].Value := TMApping(Fmappings[index]).FThemePlanID;
    qApplyMappings.Parameters[1].Value := SiteCode;
    qApplyMappings.Parameters[2].Value := TMApping(Fmappings[index]).FOutletPlanID;
    qApplyMappings.ExecSQL;
  end;
end;

//------------------------------------------------------------------------------
function TMatchOutletTablePlans.GetIndexFromID(TablePlanID : Integer) : Integer;
begin
  Result := TTP_IDs.IndexOf(IntToStr(TablePlanID));
//**  Do I need to have some more list processing routines????
end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.populateListBoxes;
var
  Mapping : TMapping;
begin
  lbxOTP.Clear;
  OTP_IDs.Clear;

  lbxTTP.Clear;
  TTP_IDs.Clear;


  AssignMappings;
  //** Add theme Plans first so will know itemindexes if we find mapping info
  //** in the OutletTablePlans
  with dmThemeData.qThemeTablePlans do
  begin
    Parameters.ParamByName('ThemeId').Value := ThemeID;
    Requery();
    First;
    while not eof do
    begin
      lbxTTP.Items.Add(FieldByName('Name').Value);
      TTP_IDs.Add(IntToStr(FieldByName('TablePlanID').Value));
      Next;
    end;
  end;
  with dmThemeData.qOutletTablePlans do
  begin
    First;
    while not eof do
    begin
      lbxOTP.Items.Add(FieldByName('Name').Value);
      OTP_IDs.Add(IntToStr(FieldByName('OutletTablePlanID').Value));
      if not FieldByName('TablePlanID').isNull then
      begin
        //** We are editing and mapping exist already so set up current mappings
        Mapping := TMapping.Create;
        Mapping.FOL_ListIndex := lbxOTP.Items.Count-1;
        Mapping.FOutletPlanID := FieldByName('OutletTablePlanID').Value;
        Mapping.FTP_ListIndex := GetIndexFromID(FieldByName('TablePlanID').Value);
        Mapping.FThemePlanID := FieldByName('TablePlanID').Value;
        if (Mapping.FTP_ListIndex <> -1) and (Mapping.FOL_ListIndex <> -1) then
          FMappings.Add(Mapping)
      end;
      Next;
    end;
  end;

  PaintFunnyLines;
end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.AssignMappings;
begin
  //Need to clear any mapping currently associated with the form and oad afresh
  FMappings.Free;
  CreateMappingList;
end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.FormShow(Sender: TObject);
begin
  Log('Form Show '+ Caption);

  dmthemedata.aztecconn.open;

  if issite and not(ismaster) then
  with dmThemeData do
  begin
    lbMatchTablePlansAdvice.Caption :=
      'Please match the Theme table plans (defined at head office) with the table plans set up on site.';
    adoqrun.sql.text := 'select top 1 [site code] from siteaztec';
    adoqrun.open;
    sitecode := adoqrun.fieldbyname('site code').asinteger;

    adoqrun.SQL.text := 'select themeid from themesites '+
      'where sitecode = (select top 1 [site code] from siteaztec)';
    adoqrun.Open;
    themeid := adoqrun.Fieldbyname('themeid').AsInteger;
    if themeid = 0 then
    begin
      btAddMatch.Enabled := false;
      btOk.enabled := false;
      lbxOTP.enabled := false;
      lbxTTP.enabled := false;
      raise Exception.create('No theme selected for site! Table plans cannot be matched until a theme is selected for this site.');
    end;
  end
  else
  begin
    lbMatchTablePlansAdvice.Caption :=
      'Site have selected the following matchings of Theme table plans to site table plans:';
  end;

//  dmThemeData.AccessDataset('qPanelNames');

  dmThemeData.AccessDataset('qOutlets');
  dmThemeData.qOutlets.Locate('SiteCode', SiteCode, []);
  dmThemeData.AccessDataset('qOutletTablePlans');
  if issite and ismaster then
     dmThemeData.qThemeTablePlans.Parameters[0].Value := ThemeID;
  dmThemeData.AccessDataset('qThemeTablePlans');
  populateListBoxes;
  if udmthemedata.IsMaster and not udmthemedata.IsSite then
  begin
    lbxttp.Enabled := false;
    lbxotp.Enabled := false;
    btAddMatch.enabled := false;
    btRemoveMatch.Enabled := false;
  end;
end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close '+ Caption);
  dmThemeData.DeAccessDataset('qOutletTablePlans');
  dmThemeData.DeAccessDataset('qThemeTablePlans');
  dmThemeData.DeAccessDataset('qOutletTerminals');
  dmThemeData.DeAccessDataset('qPanelNames');

end;

//------------------------------------------------------------------------------
procedure TMatchOutletTablePlans.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
end;

procedure TMatchOutletTablePlans.btRemoveMatchClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if (lbxOTP.ItemIndex <> -1) and (lbxTTp.ItemIndex <> -1) then
  begin
    Log(Format('Site Table Plan : %s Table Match has been removed.',[OTP_IDs[lbxOTP.ItemIndex]]));
    FMappings.ClearMapping(lbxOTP.ItemIndex, lbxTTp.ItemIndex);
    PaintFunnyLines;
  end
  else
     MessageDlg('Please select both ends of the link.', mtError, [mbOk], 0);
end;

procedure TMatchOutletTablePlans.ResizeForm;
var
  CurrentMaxItems, NewMaxItems: integer;
begin
  CurrentMaxItems := lbxOTP.clientheight div lbxOTP.itemheight;
  NewMaxItems := math.Max(lbxOTP.Count, lbxttp.count);
  if NewMaxItems > CurrentMaxItems then
    self.ClientHeight := self.ClientHeight +
      lbxOTP.itemheight * (NewMaxItems - CurrentMaxItems);
end;

procedure TMatchOutletTablePlans.Panel1Resize(Sender: TObject);
var
  DrawBitmap: TBitmap;
begin
  DrawBitmap := TBitmap.Create;
  DrawBitmap.PixelFormat := pf1bit;
  DrawBitmap.Width := TPanel(sender).ClientWidth;
  DrawBitmap.Height := TPanel(sender).ClientHeight;
  Image1.Picture.Bitmap := DrawBitmap;
end;

end.
