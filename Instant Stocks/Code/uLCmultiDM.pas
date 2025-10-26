unit uLCmultiDM;

interface

uses
  SysUtils, Classes, ppBands, ppClass,  Graphics, ppReport, ppSubRpt, ppStrtch,
  ppRegion, ppCtrls, ppVar, ppPrnabl, ppCache, ppProd, ppComm, ppRelatv,
  ppDB, ppDBPipe, DB, Wwdatsrc, ADODB, ppDevice, Forms, dialogs, ppTypes, Windows,
  Messages;

type
  TLCmultiDM = class(TDataModule)
    adoqMLCMaster: TADOQuery;
    dsMLCMaster: TwwDataSource;
    pipeMLCMaster: TppDBPipeline;
    adoqMLCSlave: TADOQuery;
    dsMLCSlave: TwwDataSource;
    pipeMLCSlave: TppDBPipeline;
    repMLC: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppShape5: TppShape;
    ppLabel43: TppLabel;
    ppShape2: TppShape;
    ppLabel16: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel23: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel27: TppLabel;
    ppLabel30: TppLabel;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppSystemVariable4: TppSystemVariable;
    ppLine4: TppLine;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel22: TppLabel;
    ppLabel53: TppLabel;
    ppShape6: TppShape;
    ppLabel54: TppLabel;
    ppShape7: TppShape;
    ppDetailBand2: TppDetailBand;
    ppRegion1: TppRegion;
    ppDBText4: TppDBText;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLabel47: TppLabel;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLine47: TppLine;
    ppLine48: TppLine;
    ppLine49: TppLine;
    ppLine51: TppLine;
    ppLine52: TppLine;
    ppLine53: TppLine;
    ppLine50: TppLine;
    ppLabel50: TppLabel;
    ppLine54: TppLine;
    ppLabel51: TppLabel;
    ppLine56: TppLine;
    ppLine57: TppLine;
    ppLabel52: TppLabel;
    ppLine58: TppLine;
    ppLine82: TppLine;
    ppLine94: TppLine;
    ppDetailBand4: TppDetailBand;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText6: TppDBText;
    ppLine59: TppLine;
    ppLine60: TppLine;
    ppLine61: TppLine;
    ppLine67: TppLine;
    ppLine68: TppLine;
    ppLine69: TppLine;
    ppLine70: TppLine;
    ppLine71: TppLine;
    ppLine73: TppLine;
    ppLine80: TppLine;
    ppLine83: TppLine;
    ppLine93: TppLine;
    ppSummaryBand2: TppSummaryBand;
    ppLine81: TppLine;
    ppLine88: TppLine;
    ppLine89: TppLine;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLine46: TppLine;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText21: TppDBText;
    ppLine35: TppLine;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppLine39: TppLine;
    ppLine40: TppLine;
    ppLine41: TppLine;
    ppLine42: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppLine45: TppLine;
    ppFooterBand1: TppFooterBand;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppDBText31: TppDBText;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel36: TppLabel;
    ppLine5: TppLine;
    ppLine9: TppLine;
    ppLine14: TppLine;
    ppLine23: TppLine;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLine28: TppLine;
    ppLine29: TppLine;
    ppLine30: TppLine;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLabel41: TppLabel;
    ppLine34: TppLine;
    ppLabel42: TppLabel;
    ppLine95: TppLine;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppLine96: TppLine;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLine1: TppLine;
    ppLine2: TppLine;
    procedure ppDBText15GetText(Sender: TObject; var Text: String);
    procedure ppHeaderBand2BeforePrint(Sender: TObject);
    procedure ppRegion1Print(Sender: TObject);
    procedure ppShape6DrawCommandClick(Sender, aDrawCommand: TObject);
    procedure ppShape7DrawCommandClick(Sender, aDrawCommand: TObject);
    procedure repMLCPreviewFormCreate(Sender: TObject);
    procedure ppDBText8Print(Sender: TObject);
    procedure ppDBText8GetText(Sender: TObject; var Text: String);
  private
    { Private declarations }
  public
    { Public declarations }
    theDiv, curTidName : string;
    Expanded: Boolean;
  end;

var
  LCmultiDM: TLCmultiDM;

implementation

uses udata1, uADO, uLC;

{$R *.dfm}


procedure TLCmultiDM.ppDBText15GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText13.Text,Text);
end;

procedure TLCmultiDM.repMLCPreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TLCmultiDM.ppHeaderBand2BeforePrint(Sender: TObject);
begin
  pplabel32.Text := 'Header: ' + data1.repHdr;
  pplabel31.Text := 'Thread Name: ' + curTidName;
  pplabel27.Text := 'Division: ' + theDiv;

  if repMLC.DeviceType = 'Printer' then
  begin
    pplabel43.visible := False;
    ppshape5.visible := False;
    pplabel53.visible := False;
    ppshape6.visible := False;
    pplabel54.visible := False;
    ppshape7.visible := False;
  end
  else
  begin
    if ppsubreport1.ExpandAll then
    begin
      pplabel43.visible := False;
      ppshape5.visible := False;
      ppregion1.Brush.Color := $00C0C0C0; //  clSilver;
    end
    else
    begin
      pplabel43.visible := true;
      ppshape5.visible := true;
      ppregion1.Brush.Color := $0000FFFF; //  clYellow;
    end;
    pplabel53.visible := true;
    ppshape6.visible := true;
    pplabel54.visible := true;
    ppshape7.visible := true;
  end;
end;

procedure TLCmultiDM.ppRegion1Print(Sender: TObject);
begin
  if repMLC.DeviceType = 'Printer' then
  begin
    ppregion1.Brush.Color := $00FFFFFF; // this is white clWhite;
  end
  else
  begin
    if ppsubreport1.ExpandAll then
      ppregion1.Brush.Color := $00C0C0C0 //  clSilver;
    else
      ppregion1.Brush.Color := $0000FFFF; //  clYellow;
  end;
end;


// Expand ALL
procedure TLCmultiDM.ppShape6DrawCommandClick(Sender, aDrawCommand: TObject);
begin
  if not Expanded then
    PostMessage(fLC.Handle, WM_USER + 3646, 0, 0);
end;

// Collapse ALL
procedure TLCmultiDM.ppShape7DrawCommandClick(Sender, aDrawCommand: TObject);
begin
  Expanded := True;
  if Expanded then
    PostMessage(fLC.handle, WM_USER + 3646, 0, 0);
end;

procedure TLCmultiDM.ppDBText8Print(Sender: TObject);
begin
  if adoqmlcslave.FieldByName('cumVar').asinteger = 1 then
    TppDBText(Sender).Font.Style := [fsBold]
  else
    TppDBText(Sender).Font.Style := [];
end;

procedure TLCmultiDM.ppDBText8GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppdbText13.Text,Text);
end;

end.
