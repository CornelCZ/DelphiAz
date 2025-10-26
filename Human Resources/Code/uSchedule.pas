unit uSchedule;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, wwdblook, DB,
  Wwdatsrc, Mask, Wwdbedit, Wwdotdot, Wwdbcomb, DBTables, Wwquery, Wwtable,
  Dialogs, ShellAPI, Messages, ppCtrls, ppClass, ppBands, ppDB,
  ppDBBDE, ppPrnabl, ppCache, ppComm, ppReport, ppProd, pptypes, DBCtrls,
  ppVar, ppDBPipe, ppRelatv, ppStrtch, ppSubRpt, ppViewr, Variants, ADODB, uADO,
  Math, AppEvnts;

type
  TfSchedule = class(TForm)
    DisplayDS: TwwDataSource;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    btnInsertEmployee: TBitBtn;
    copybut: TBitBtn;
    btnDeleteEmployee: TBitBtn;
    ListBox1: TListBox;
    grpBoxReports: TGroupBox;
    btnByJobType: TBitBtn;
    btnByName: TBitBtn;
    DS4: TwwDataSource;
    ByName: TppReport;
    ByNameHeaderBand1: TppHeaderBand;
    ByNameShape1: TppShape;
    ByNameLabel1: TppLabel;
    ByNameLabel2: TppLabel;
    BNLabel4: TppLabel;
    ByNameLabel5: TppLabel;
    ByNameLabel6: TppLabel;
    ByNameLabel7: TppLabel;
    ByNameLabel8: TppLabel;
    ByNameLabel9: TppLabel;
    ByNameLabel10: TppLabel;
    ByNameLabel11: TppLabel;
    ByNameLabel13: TppLabel;
    ByNameLabel14: TppLabel;
    ByNameLabel15: TppLabel;
    ByNameLabel16: TppLabel;
    ByNameLabel17: TppLabel;
    ByNameLabel18: TppLabel;
    ByNameLabel19: TppLabel;
    ByNameLabel20: TppLabel;
    ByNameLabel21: TppLabel;
    ByNameLabel22: TppLabel;
    ByNameLabel23: TppLabel;
    ByNameLabel24: TppLabel;
    ByNameLabel25: TppLabel;
    ByNameLabel26: TppLabel;
    ByNameLabel27: TppLabel;
    ByNameLine7: TppLine;
    ByNameLine8: TppLine;
    ByNameLine9: TppLine;
    ByNameLine10: TppLine;
    ByNameLine11: TppLine;
    ByNameLine12: TppLine;
    ByNameDetailBand1: TppDetailBand;
    ByNameDBText2: TppDBText;
    ByNameDBText3: TppDBText;
    ByNameDBText4: TppDBText;
    ByNameDBText5: TppDBText;
    ByNameDBText6: TppDBText;
    ByNameDBText7: TppDBText;
    ByNameDBText8: TppDBText;
    ByNameDBText9: TppDBText;
    ByNameDBText10: TppDBText;
    ByNameDBText11: TppDBText;
    ByNameDBText12: TppDBText;
    ByNameDBText13: TppDBText;
    ByNameDBText14: TppDBText;
    ByNameDBText15: TppDBText;
    ByNameDBText16: TppDBText;
    ByNameDBText17: TppDBText;
    ByNameDBText18: TppDBText;
    Bottom: TppLine;
    ByNameLine18: TppLine;
    ByNameLine13: TppLine;
    ByNameLine14: TppLine;
    ByNameLine15: TppLine;
    ByNameLine16: TppLine;
    ByNameLine17: TppLine;
    ByNameLine19: TppLine;
    ByNameLine20: TppLine;
    ByNameLine21: TppLine;
    ByNameFooterBand1: TppFooterBand;
    JobsalDS: TwwDataSource;
    Bynamepipe: TppBDEPipeline;
    Jobsalpipe: TppBDEPipeline;
    DS3: TwwDataSource;
    Byjobpipe: TppBDEPipeline;
    byjobtype: TppReport;
    ByJobTypeHeaderBand1: TppHeaderBand;
    ByJobTypeShape5: TppShape;
    titlelab: TppLabel;
    ByJobTypeLabel2: TppLabel;
    ByJobTypeDetailBand1: TppDetailBand;
    ByJobTypeDBText2: TppDBText;
    ByJobTypeDBText3: TppDBText;
    ByJobTypeDBText4: TppDBText;
    ByJobTypeDBText5: TppDBText;
    ByJobTypeDBText6: TppDBText;
    ByJobTypeDBText7: TppDBText;
    ByJobTypeDBText8: TppDBText;
    ByJobTypeDBText9: TppDBText;
    ByJobTypeDBText10: TppDBText;
    ByJobTypeDBText11: TppDBText;
    ByJobTypeDBText12: TppDBText;
    ByJobTypeDBText13: TppDBText;
    ByJobTypeDBText14: TppDBText;
    ByJobTypeDBText15: TppDBText;
    ByJobTypeDBText16: TppDBText;
    ByJobTypeDBText17: TppDBText;
    ByJobTop: TppLine;
    ByJobBottom: TppLine;
    ByJobLine1: TppLine;
    ByJobTypeLine14: TppLine;
    ByJobTypeLine8: TppLine;
    ByJobTypeLine9: TppLine;
    ByJobTypeLine10: TppLine;
    ByJobTypeLine11: TppLine;
    ByJobTypeLine12: TppLine;
    ByJobTypeLine13: TppLine;
    ByJobTypeLine16: TppLine;
    ByJobTypeFooterBand1: TppFooterBand;
    ByJobTypeGroup1: TppGroup;
    ByJobTypeGroupHeaderBand1: TppGroupHeaderBand;
    ByJobTypeShape1: TppShape;
    ByJobTypeShape2: TppShape;
    ByJobTypeLabel5: TppLabel;
    ByJobTypeLabel6: TppLabel;
    ByJobTypeLabel7: TppLabel;
    ByJobTypeLabel8: TppLabel;
    ByJobTypeLabel9: TppLabel;
    ByJobTypeLabel10: TppLabel;
    ByJobTypeLabel11: TppLabel;
    ByJobTypeShape4: TppShape;
    ByJobTypeDBText1: TppDBText;
    ByJobTypeLine2: TppLine;
    ByJobTypeLine3: TppLine;
    ByJobTypeLine4: TppLine;
    ByJobTypeLine5: TppLine;
    ByJobTypeLine6: TppLine;
    ByJobTypeLine7: TppLine;
    ByJobTypeLabel12: TppLabel;
    ByJobTypeLabel13: TppLabel;
    ByJobTypeLabel14: TppLabel;
    ByJobTypeLabel15: TppLabel;
    ByJobTypeLabel16: TppLabel;
    ByJobTypeLabel17: TppLabel;
    ByJobTypeLabel18: TppLabel;
    ByJobTypeLabel20: TppLabel;
    ByJobTypeLabel21: TppLabel;
    ByJobTypeLabel22: TppLabel;
    ByJobTypeLabel23: TppLabel;
    ByJobTypeLabel24: TppLabel;
    ByJobTypeLabel25: TppLabel;
    ByJobTypeLabel19: TppLabel;
    ByJobTypeGroupFooterBand1: TppGroupFooterBand;
    ByJobTypeLine15: TppLine;
    byjobtypeLine1: TppLine;
    ByNameLabel4: TppLabel;
    ByNameLine22: TppLine;
    ByNameLine1: TppLine;
    ByNameCalc1: TppSystemVariable;
    ByNameCalc2: TppSystemVariable;
    ByJobTypeCalc2: TppSystemVariable;
    ByJobTypeCalc1: TppSystemVariable;
    Panel6: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    lblEmpHrs: TLabel;
    lblEmpCost: TLabel;
    lblJobHrs: TLabel;
    lblJobCost: TLabel;
    lblDayHrs: TLabel;
    lblDayCost: TLabel;
    lblWkHrs: TLabel;
    lblWkCost: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    bbtReCalc: TBitBtn;
    Panel8: TPanel;
    Copybtn: TBitBtn;
    Pastebtn: TBitBtn;
    fillbtn: TBitBtn;
    Panel11: TPanel;
    PageControl1: TPageControl;
    ppSummaryBand1: TppSummaryBand;
    ppSubReport1: TppSubReport;
    jobsal: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppShape1: TppShape;
    ppDBText1: TppDBText;
    ppShape2: TppShape;
    ppShape3: TppShape;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLine7: TppLine;
    jobsalDBText2: TppDBText;
    jobsalDBText1: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    jobsaltop: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine12: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLabel24: TppLabel;
    ppLabel22: TppLabel;
    ppTitleBand1: TppTitleBand;
    ppLine8: TppLine;
    btnEmptySchedule: TBitBtn;
    lblExpTake: TLabel;
    lblExpTPc: TLabel;
    sbExpTake: TSpeedButton;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine23: TppLine;
    ppLine24: TppLine;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLabel23: TppLabel;
    byNametopL: TppLine;
    ppDBText2: TppDBText;
    Panel1: TPanel;
    sprevert: TSpeedButton;
    wwtGhost: TADOTable;
    wwtOpClose: TADOTable;
    wwghost3: TADOTable;
    tblRun: TADOTable;
    TempTable: TADOTable;
    qryRun2: TADOQuery;
    WeekQuery: TADOQuery;
    wwQborrow: TADOQuery;
    qryRun: TADOQuery;
    DisplayQuery: TADOQuery;
    DisplayQuerySname: TStringField;
    DisplayQueryFName: TStringField;
    DisplayQueryMonin: TStringField;
    DisplayQueryMonout: TStringField;
    DisplayQueryTuein: TStringField;
    DisplayQueryTueout: TStringField;
    DisplayQueryWedin: TStringField;
    DisplayQueryWedout: TStringField;
    DisplayQueryThuin: TStringField;
    DisplayQueryThuout: TStringField;
    DisplayQueryFriin: TStringField;
    DisplayQueryFriout: TStringField;
    DisplayQuerySatin: TStringField;
    DisplayQuerySatout: TStringField;
    DisplayQuerySunin: TStringField;
    DisplayQuerySunout: TStringField;
    DisplayQueryWeekTotal: TStringField;
    DisplayQueryUserId: TLargeintField;
    DisplayQueryRoleId: TIntegerField;
    DisplayQueryShift: TSmallintField;
    DisplayQueryF1: TStringField;
    DisplayQueryF2: TStringField;
    DisplayQueryF3: TStringField;
    DisplayQueryF4: TStringField;
    DisplayQueryF5: TStringField;
    DisplayQueryF6: TStringField;
    DisplayQueryF7: TStringField;
    DisplayQuerymonoc: TStringField;
    DisplayQuerytueoc: TStringField;
    DisplayQuerywedoc: TStringField;
    DisplayQuerythuoc: TStringField;
    DisplayQueryfrioc: TStringField;
    DisplayQuerysatoc: TStringField;
    DisplayQuerysunoc: TStringField;
    DisplayQueryDeleted: TStringField;
    DisplayQueryTerminated: TStringField;
    qryEmployeeJobs: TADOQuery;
    sbxSchedule: TScrollBox;
    DBGrid: TwwDBGrid;
    DisplayQueryRoleName: TStringField;
    DisplayQueryLeftJob: TBooleanField;
    qryEmployeeJobsId: TIntegerField;
    qryEmployeeJobsName: TStringField;
    cmdWageCostCalc: TADOCommand;
    PanelTop: TPanel;
    Panel10: TPanel;
    Label38: TLabel;
    lblWeek: TLabel;
    pnlEmpJobColumnHeading: TPanel;
    lblEmployeeName: TLabel;
    lblJobName: TLabel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label46: TLabel;
    Label52: TLabel;
    DBText1: TDBText;
    Panel5: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Panel4: TPanel;
    cbEmployeeJobsLookup: TwwDBLookupCombo;
    Panel7: TPanel;
    DisplayQueryLastName: TStringField;
    DisplayQueryFirstName: TStringField;
    DisplayQueryJobName: TStringField;
    evntMouseWheelCatcher: TApplicationEvents;
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DisplayDSUpdateData(Sender: TObject);
    procedure InitialiseLabels;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid45KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    function JobType(Job: integer): string;
    procedure btnInsertEmployeeClick(Sender: TObject);
    procedure btnScheduleReportClick(Sender: TObject);
    procedure bbtReCalcClick(Sender: TObject);
    procedure GetShifts;
    procedure PopulateTable;
    procedure DisplayJobs;
    procedure btnDeleteEmployeeClick(Sender: TObject);
    procedure DBGridColEnter(Sender: TObject);
    procedure DBGridColExit(Sender: TObject);
    procedure Overlap;
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure DBGridEnter(Sender: TObject);
    procedure DBGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure copybutClick(Sender: TObject);
    procedure CopybtnClick(Sender: TObject);
    procedure PastebtnClick(Sender: TObject);
    procedure fillbtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Warnings;
    procedure TxSchedule;
    function Convert(timestr: string): string;
    procedure DBGridCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure ByNameDBText5GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeDBText4GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeGroupFooterBand1BeforePrint(Sender: TObject);
    procedure ByJobTypeDetailBand1BeforePrint(Sender: TObject);
    procedure ByJobTypeStartPage(Sender: TObject);
    procedure ByNameDetailBand1BeforePrint(Sender: TObject);
    procedure ByJobTypeLabel5GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeLabel6GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeLabel7GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeLabel8GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeLabel9GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeLabel10GetText(Sender: TObject; var Text: string);
    procedure ByJobTypeLabel11GetText(Sender: TObject; var Text: string);
    procedure ByNameLabel5GetText(Sender: TObject; var Text: string);
    procedure ByNameLabel6GetText(Sender: TObject; var Text: string);
    procedure ByNameLabel7GetText(Sender: TObject; var Text: string);
    procedure ByNameLabel8GetText(Sender: TObject; var Text: string);
    procedure ByNameLabel9GetText(Sender: TObject; var Text: string);
    procedure ByNameLabel10GetText(Sender: TObject; var Text: string);
    procedure ByNameLabel11GetText(Sender: TObject; var Text: string);
    procedure JobsalStartPage(Sender: TObject);
    procedure JobsalDetailBand1BeforePrint(Sender: TObject);
    procedure FillAllEmps;
    procedure JobsalLabel26GetText(Sender: TObject; var Text: string);
    procedure JobsalLabel27GetText(Sender: TObject; var Text: string);
    procedure JobsalLabel28GetText(Sender: TObject; var Text: string);
    procedure JobsalLabel29GetText(Sender: TObject; var Text: string);
    procedure JobsalLabel30GetText(Sender: TObject; var Text: string);
    procedure JobsalLabel31GetText(Sender: TObject; var Text: string);
    procedure JobsalLabel32GetText(Sender: TObject; var Text: string);
    procedure lblEmployeeNameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ReCalculate;
    procedure SetEmpLabels;
    procedure SetJobLabels;
    procedure SetDayLabels;
    procedure SetWeekLabels;
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure byjobtypePreviewFormCreate(Sender: TObject);
    procedure DisplayQueryCalcFields(DataSet: TDataSet);
    procedure DisplayQueryNewRecord(DataSet: TDataSet);
    procedure DisplayQueryAfterPost(DataSet: TDataSet);
    procedure DisplayQueryBeforeEdit(DataSet: TDataSet);
    procedure btnEmptyScheduleClick(Sender: TObject);
    procedure sbExpTakeClick(Sender: TObject);
    procedure ppDBText2Format(Sender: TObject; DisplayFormat: String;
      DataType: TppDataType; Value: Variant; var Text: String);
    procedure ppDBText2GetText(Sender: TObject; var Text: String);
    procedure DisplayQueryWeekTotalGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure sprevertClick(Sender: TObject);
    procedure DisplayQueryBeforeOpen(DataSet: TDataSet);
    procedure DisplayQueryAfterClose(DataSet: TDataSet);
    procedure DisplayQueryAfterEdit(DataSet: TDataSet);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
    procedure DisplayQueryAfterScroll(DataSet: TDataSet);
    procedure DisplayQueryAfterOpen(DataSet: TDataSet);
    procedure DBGridExit(Sender: TObject);
    procedure ppLabel24Print(Sender: TObject);
    procedure DisplayQueryTimeChange(Sender: TField);
    procedure lblJobNameClick(Sender: TObject);
    procedure lblEmployeeNameClick(Sender: TObject);
    procedure evntMouseWheelCatcherMessage(var Msg: tagMSG;
      var Handled: Boolean);

  private
    { Private declarations }
    editsch: Boolean;
    copyarray: array[1..14] of string;
    singlearray: array[1..2] of string;
    emphlab, jobhlab, dayhlab, weekhlab : integer; // no of minutes              |  these are used in
    empclab, jobclab, dayclab, weekclab, exptake, expwage : double; // cost in $ |  Re-Calculate and in Warnings
    FSortOrder: Integer; // 1 = ByName 2 = ByJob

    // logging variables
    userins, userdel, validTmpShifts, userempty, useredit : integer;
    opstring, wstring : string;
    logarray : array[1..7, 1..5] of integer;
    InTimeChangeHandler : boolean;

    procedure SetExpWage;
    procedure SetExpTake(ReCalc: Boolean);
    procedure ResetOpenCloseFlags;
    procedure SetOpenFlag;
    procedure SetCloseFlag;
    procedure EnableControls(aEnabled : Boolean);
    function GridHasEditableContent: Boolean;
    Procedure UpdateJobStatus;
  public
    { Public declarations }
    sendflag: boolean;
    FirstName, LstName: string;
    daystr, monstr, currday: tdatetime;
    errflag, valflag: boolean;
    CurrUserid: Int64;
    CurrShift, CurrRoleID, CurrRoleRef: integer;
    chkin, chkout, cfield, calcday: string;
    vSiteCode : integer;
    vSiteName : string[20];
    procedure LogScheduleUpdateConflicts(errorMessage: String; debugStr: String; aUserID: Int64; aSchin: TDateTime);
    procedure LogTempTableUpdateFailure(errorMessage: String; debugStr: String; aUserID: Int64; Alert: Boolean = True);
  end;

const
  dayarray : array[1..7] of string = ('sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat');
  dayarray2 : array[1..7] of string = ('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
  theWeek: array[1..7] of string = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
    'Saturday', 'Sunday');
  ALL_ROLES_ID = -1;
  WINDOW_MAX_WIDTH  = 901;
  WINDOW_MIN_WIDTH  = 791;

var
  fSchedule: TfSchedule;


implementation

uses dmodule1, UInsEmp, uempmnu, Ufrowdlg, UCopyopt, uPickWeek, uExpTake, uGlobals,
     useful, ulog, uAztecDatabaseUtils, uDiagnosticLog, ADOInt, StrUtils;

{$R *.DFM}

procedure PostTimes(currday: tdatetime; fieldno: string);
var
  Timein, Timeout: tdatetime;
  fieldname : string;
  debugStr: string;
begin
  fieldname := dayarray2[strtoint(fieldno)];
  debugStr := '';

  with fSchedule.TempTable do
  begin
    // special case if the record has been deleted then try to delete the corresponding
    // records in schedule but double check there are no clockin-out times
    if FieldByName('deleted').asstring = 'Y' then
    begin
      debugStr := debugStr + 'PostTimes 01: schedule record has been deleted;';
      if DMod1.SchdlTable.locate('sitecode;UserId;schin', VarArrayOf([fSchedule.vSiteCode,
       fieldbyname('UserId').Value, fieldbyname('old' + fieldno).asdatetime]), []) then
      begin // record existing, make invisible...
        if (DMod1.SchdlTable.FieldByName('accin').value = null) and
          (DMod1.SchdlTable.FieldByName('accout').value = null) then
        begin
          debugStr := debugStr + 'PostTimes 02: record exists - making it invisible;';
          DMod1.SchdlTable.edit;
          DMod1.SchdlTable.FieldByName('visible').value := 'N';
          try
            DMod1.SchdlTable.post;     
          except
            on E: Exception do
            begin     
              fSchedule.LogScheduleUpdateConflicts(E.Message, debugStr, fieldByName('UserId').Value, fieldbyname('old' + fieldno).asdatetime);
            end;
          end;
          inc(fSchedule.logarray[strtoint(fieldno), 2]); // log
        end;
        exit;
      end;
      exit;
    end;

    //  Deals with getting correct dates for new scheduled times
    if ((fieldbyname(fieldname + 'in').asstring <> '') and
      (fieldbyname(fieldname + 'out').asstring <> '')) then
    begin
      if (fieldbyname(fieldname + 'in').asstring) < fempmnu.grace then
      begin
        debugStr := debugStr + 'PostTimes 03: ' + fieldName + 'in value is less than fempmnu.grace;';
        timein := (currday + 1.0) +
          strtotime(fieldbyname(fieldname + 'in').asstring);
        if fieldbyname(fieldname + 'in').asstring >
          fieldbyname(fieldname + 'out').asstring then
        begin
          debugStr := debugStr + 'PostTimes 04: ' + fieldName + 'in value is greater than ' + fieldName + 'out value;';
          timeout := (currday + 2.0) +
            strtotime(fieldbyname(fieldname + 'out').asstring);
        end
        else
        begin
          debugStr := debugStr + 'PostTimes 05: ' + fieldName + 'in value is not greater than ' + fieldName + 'out value;';
          timeout := (currday + 1.0) +
            strtotime(fieldbyname(fieldname + 'out').asstring);
        end;
      end
      else
      begin
        debugStr := debugStr + 'PostTimes 06: ' + fieldName + 'in value is not less than fempmnu.grace;';
        timein := currday + strtotime(fieldbyname(fieldname + 'in').asstring);
        if fieldbyname(fieldname + 'in').asstring >
          fieldbyname(fieldname + 'out').asstring then
        begin
          debugStr := debugStr + 'PostTimes 07: ' + fieldName + 'in value is greater than ' + fieldName + 'out value;';
          timeout := (currday + 1.0) +
            strtotime(fieldbyname(fieldname + 'out').asstring);
        end
        else
        begin
          debugStr := debugStr + 'PostTimes 08: ' + fieldName + 'in value is not greater than ' + fieldName + 'out value;';
          timeout := currday + strtotime(fieldbyname(fieldname + 'out').asstring);
        end;
      end;

      //We're about to start filling in payschemeversionid/UserPayRateOverrideVersionId
      //so make sure we have an up-to-date copy of the data.
      if dmod1.adoqGetAllEmployeesAndJobs.Active then
        dmod1.adoqGetAllEmployeesAndJobs.Requery
      else
        dmod1.adoqGetAllEmployeesAndJobs.Open;

      with DMod1.SchdlTable do
      begin
        // cc-9/11/01 - 15128
        if locate('sitecode;UserId;schin', VarArrayOf([fSchedule.vSiteCode,
           fSchedule.TempTable.fieldbyname('UserId').Value,
           fSchedule.TempTable.fieldbyname('old' + fieldno).asdatetime]), []) then
        begin // record existing, was loaded from schedule to begin with, update...
              // or copy schedule, in which case could be deleted so also do visible = Y
          // if record was loaded with say in=08:00, user changed it to in=09:00 original
          // record is thus updated to i=09:00. But what if there was a rec with in=09:00 and
          // visible=N already there? Then key violation so deal with it...
          debugStr := debugStr + 'PostTimes 09: Record exists and was loaded;';

          if (fSchedule.TempTable.fieldbyname('old' + fieldno).asdatetime <> timein) then
          begin
            // whatever happens in next if statement delete the original record...
            debugStr := debugStr + 'PostTimes 10: in time has been changed;';
            edit;
            fieldbyname('visible').asstring := 'N';
            inc(fSchedule.logarray[strtoint(fieldno), 3]); // log
            // now check to see if there is a record with schin = new timein; it could only be
            // a previously deleted one else it would have been shown and lead to an overlap, etc...
            if (locate('sitecode;UserId;schin', VarArrayOf([fSchedule.vSiteCode,
              fSchedule.TempTable.fieldbyname('UserId').Value, timein]), [])) then
            begin // take over the 'old' record with new timein using edit...
              debugStr := debugStr + 'PostTimes 11: a matching record has been found (could be a deleted or overlapping one);';
              edit;
              fieldbyname('schout').asdatetime := timeout;
              fieldbyname('RoleId').asinteger := fSchedule.TempTable.fieldbyname('RoleId').asinteger;
              fieldbyname('shift').asinteger := fSchedule.TempTable.fieldbyname('F' + fieldno).asinteger;
              fieldbyname('rec').asinteger := fSchedule.TempTable.fieldbyname('shift').asinteger;
              fieldbyname('oc').asstring := fSchedule.TempTable.fieldbyname(fieldname + 'oc').asstring;

              if dmod1.adoqGetAllEmployeesAndJobs.locate('RoleId;UserId', VarArrayOf([FieldByName('RoleId').asinteger,
                FieldByName('UserId').Value]), []) then
              begin
                FieldByName('PaySchemeVersionId').Value :=  dmod1.adoqGetAllEmployeesAndJobs.FieldByName('PaySchemeVersionId').Value;
                FieldByName('UserPayRateOverrideVersionID').Value := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('UserPayRateOverrideVersionId').Value;
              end;
              fieldbyname('visible').asstring := 'Y';
            end  // if.. then..
            else
            begin // no record with schin = new timein found, insert a new record...
              debugStr := debugStr + 'PostTimes 12: no matching record has been found, new record being inserted;';
              insert;
              fieldbyname('sitecode').asinteger := fSchedule.vSiteCode;
              TLargeIntField(fieldbyname('UserId')).AsLargeInt := fSchedule.TempTable.fieldbyname('UserId').Value;
              fieldbyname('schin').asdatetime := timein;
              fieldbyname('schout').asdatetime := timeout;
              fieldbyname('RoleId').asinteger := fSchedule.TempTable.fieldbyname('RoleId').asinteger;
              fieldbyname('shift').asinteger := fSchedule.TempTable.fieldbyname('F' + fieldno).asinteger;
              fieldbyname('rec').asinteger := fSchedule.TempTable.fieldbyname('shift').asinteger;
              fieldbyname('oc').asstring := fSchedule.TempTable.fieldbyname(fieldname + 'oc').asstring;

              if fempmnu.grace > formatDateTime('hh:nn', timein) then
              begin //previous day
                FieldByName('BsDate').asstring := formatDateTime(shortdateformat+'yy', timein - 1);
              end
              else
              begin // same day
                FieldByName('BsDate').asstring := formatDateTime(shortdateformat+'yy', timein);
              end;

              if dmod1.adoqGetAllEmployeesAndJobs.locate('RoleId;UserId', VarArrayOf([FieldByName('RoleId').asinteger,
                FieldByName('UserId').Value]), []) then
              begin
                debugStr := debugStr + 'PostTimes 13: updating PaySchemeVersionID and UserPayRateOverrideVersionId;';
                FieldByName('PaySchemeVersionId').Value :=  dmod1.adoqGetAllEmployeesAndJobs.FieldByName('PaySchemeVersionId').Value;
                FieldByName('UserPayRateOverrideVersionID').Value := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('UserPayRateOverrideVersionId').Value;
              end;
            end; //if.. then.. else..
          end
          else // time in was left the same
          begin
            debugStr := debugStr + 'PostTimes 14: in time has not been changed;';
            // was the record really edited? if not don't do anything
            if (fieldbyname('schout').asdatetime = timeout) and
              (fieldbyname('RoleId').asinteger = fSchedule.TempTable.fieldbyname('RoleId').asinteger) and
              (fieldbyname('shift').asinteger = fSchedule.TempTable.fieldbyname('F' + fieldno).asinteger) and
              (FieldByName('visible').asstring = 'Y') then // CC - 15514
            begin
              // no true changes were done, log but leave Schedule table alone...
              inc(fSchedule.logarray[strtoint(fieldno), 5]); // log
              debugStr := debugStr + 'PostTimes 15: schout, RoleId and Shift have not been changed;';
            end  // if.. then..
            else
            begin
              debugStr := debugStr + 'PostTimes 16: one of schout, RoleId or Shift has been changed;';
              edit;
              fieldbyname('schout').asdatetime := timeout;
              fieldbyname('RoleId').asinteger := fSchedule.TempTable.fieldbyname('RoleId').asinteger;
              fieldbyname('shift').asinteger := fSchedule.TempTable.fieldbyname('F' + fieldno).asinteger;
              fieldbyname('rec').asinteger := fSchedule.TempTable.fieldbyname('shift').asinteger;
              fieldbyname('oc').asstring := fSchedule.TempTable.fieldbyname(fieldname + 'oc').asstring;

              // commented out as if schin is not changed then bsdate cannot be changed either...
  //            if fempmnu.grace > formatDateTime('hh:nn', timein) then
  //            begin //previous day
  //              FieldByName('BsDate').asstring := formatDateTime(shortdateformat+'yy', timein - 1);
  //            end
  //            else
  //            begin // same day
  //              FieldByName('BsDate').asstring := formatDateTime(shortdateformat+'yy', timein);
  //            end;

              if dmod1.adoqGetAllEmployeesAndJobs.locate('RoleId;UserId', VarArrayOf([FieldByName('RoleId').asinteger,
                FieldByName('UserId').Value]), []) then
              begin
                debugStr := debugStr + 'PostTimes 17: updating PaySchemeVersionID and UserPayRateOverrideVersionId;';
                FieldByName('PaySchemeVersionId').Value :=  dmod1.adoqGetAllEmployeesAndJobs.FieldByName('PaySchemeVersionId').Value;
                FieldByName('UserPayRateOverrideVersionID').Value := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('UserPayRateOverrideVersionId').Value;
              end;

              fieldbyname('visible').asstring := 'Y';
              inc(fSchedule.logarray[strtoint(fieldno), 4]); // log

            end; //if.. then.. else..
          end;
        end //15128 - ends...
        else if locate('sitecode;UserId;schin', VarArrayOf([fSchedule.vSiteCode,
           fSchedule.TempTable.fieldbyname('UserId').Value, timein]), []) then
        begin // record existing, was NOT loaded from schedule, but was maybe deleted? update...
          debugStr := debugStr + 'PostTimes 18: Record exists but was not loaded;';
          edit;
          //fieldbyname('schin').asdatetime := timein; //not needed..
          fieldbyname('schout').asdatetime := timeout;
          fieldbyname('RoleId').asinteger := fSchedule.TempTable.fieldbyname('RoleId').asinteger;
          fieldbyname('shift').asinteger := fSchedule.TempTable.fieldbyname('F' + fieldno).asinteger;
          fieldbyname('rec').asinteger := fSchedule.TempTable.fieldbyname('shift').asinteger;
          fieldbyname('oc').asstring := fSchedule.TempTable.fieldbyname(fieldname + 'oc').asstring;

          if dmod1.adoqGetAllEmployeesAndJobs.locate('RoleId;UserId', VarArrayOf([FieldByName('RoleId').asinteger,
            FieldByName('UserId').Value]), []) then
          begin
            debugStr := debugStr + 'PostTimes 19: updating PaySchemeVersionID and UserPayRateOverrideVersionId;';
            FieldByName('PaySchemeVersionId').Value :=  dmod1.adoqGetAllEmployeesAndJobs.FieldByName('PaySchemeVersionId').Value;
            FieldByName('UserPayRateOverrideVersionID').Value := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('UserPayRateOverrideVersionId').Value;
          end;
          fieldbyname('visible').asstring := 'Y';
          inc(fSchedule.logarray[strtoint(fieldno), 1]); // log

        end
        else
        begin // rec does not exist, insert
          debugStr := debugStr + 'PostTimes 20: Record does not exist and will be inserted;';
          insert;
          fieldbyname('sitecode').asinteger := fSchedule.vSiteCode;
          TLargeIntField(fieldbyname('UserId')).AsLargeInt := fSchedule.TempTable.fieldbyname('UserId').Value;
          fieldbyname('schin').asdatetime := timein;
          fieldbyname('schout').asdatetime := timeout;
          fieldbyname('RoleId').asInteger := fSchedule.TempTable.fieldbyname('RoleId').asinteger;
          fieldbyname('shift').asinteger := fSchedule.TempTable.fieldbyname('F' + fieldno).asinteger;
          fieldbyname('rec').asinteger := fSchedule.TempTable.fieldbyname('shift').asinteger;
          fieldbyname('oc').asstring := fSchedule.TempTable.fieldbyname(fieldname + 'oc').asstring;

          if fempmnu.grace > formatDateTime('hh:nn', timein) then
          begin //previous day
            FieldByName('BsDate').asstring := formatDateTime(shortdateformat+'yy', timein - 1);
          end
          else
          begin // same day
            FieldByName('BsDate').asstring := formatDateTime(shortdateformat+'yy', timein);
          end;

          if dmod1.adoqGetAllEmployeesAndJobs.locate('RoleId;UserId', VarArrayOf([FieldByName('RoleId').asinteger,
            FieldByName('UserId').Value]), []) then
          begin
            debugStr := debugStr + 'PostTimes 21: updating PaySchemeVersionID and UserPayRateOverrideVersionId;';
            FieldByName('PaySchemeVersionId').Value :=  dmod1.adoqGetAllEmployeesAndJobs.FieldByName('PaySchemeVersionId').Value;
            FieldByName('UserPayRateOverrideVersionID').Value := dmod1.adoqGetAllEmployeesAndJobs.FieldByName('UserPayRateOverrideVersionId').Value;
          end;
          inc(fSchedule.logarray[strtoint(fieldno), 1]); // log
        end;

        try
          if (state = dsEdit) or (state = dsInsert) then
            post;    // dmod1.schdltable
        except
          on E:exception do
          begin
            fSchedule.LogScheduleUpdateConflicts(E.Message, debugStr, dMod1.SchdlTable.FieldByName('UserID').Value, dMod1.SchdlTable.FieldByName('schin').AsDateTime);
            fempmnu.loglist.items.clear;
            with fempmnu.loglist.items do
            begin
              add('fSchedule.PostTimes ERROR on post to Schedule.db; Error Msg: ');
              add(E.message);
              add('Record: ' + fSchedule.TempTable.fieldbyname('UserId').asstring + '; ' +
                formatDateTime(shortdateformat+'yy hh:nn', timein) + '; ' +
                formatDateTime(shortdateformat+'yy hh:nn', timeout));
            end;
            fempmnu.LogInfo;
            cancel;
          end;
        end;
      end;
    end
    else  // either/both in and out are empty strings, check to see if there were times
    begin // in those fields coming from schedule.db and if so go there and delete them
      debugStr := debugStr + 'PostTimes 22: either or both in and out fields are empty strings;';
      if not DMod1.SchdlTable.locate('SiteCode;UserId;schin', VarArrayOf([fSchedule.vSiteCode,
        fieldbyname('UserId').Value,null]), []) then
      begin // record existing, make invisible...
        if FieldByName('old' + fieldno).asstring <> '' then
        begin
          debugStr := debugStr + 'PostTimes 23: Old value is not an empty string';
          if DMod1.SchdlTable.locate('SiteCode;UserId;schin', VarArrayOf([fSchedule.vSiteCode,
           fieldbyname('UserId').Value,fieldbyname('old' + fieldno).asdatetime]), []) then
          begin // record existing, make invisible...
            if (DMod1.SchdlTable.FieldByName('accin').value = null) and
              (DMod1.SchdlTable.FieldByName('accout').value = null) then
            begin
              debugStr := debugStr + 'PostTimes 24: Record exists matching old value';
              DMod1.SchdlTable.edit;
              DMod1.SchdlTable.FieldByName('visible').value := 'N';
              try
                DMod1.SchdlTable.post;      
              except
                on E: Exception do
                begin     
                  fSchedule.LogScheduleUpdateConflicts(E.Message, debugStr, fieldByName('UserId').Value, fieldbyname('old' + fieldno).asdatetime);
                end;
              end;
              inc(fSchedule.logarray[strtoint(fieldno), 2]); // log
            end;

            Exit;
          end;
        end;
      end;
    end;
  end;
end;

// This procedure goes to the first line of the temporary table and makes
// up to 7 entries in 'schedule.db' from it. An entry is made for each day
// which does not contain null 'in' and 'out' values. The entry also contains
// the employee ID, the date of the shift, and the job ID.
// This process is repeated for each line of the temporary table.
// A key is created from the relevant fields in the temp table and if a match
// is found then the current recvords schedule times are added to the matching
// record. If no match is found then a new record is added to schedule.db using
// the current values.
// ** Shift is always set to 1 but this can be used as a separate variable
// if a person can be scheduled for more than one shift on the same day. **

procedure TfSchedule.PopulateTable;
var
  i,j,k : smallint;
label
  mon, tue, wed, thu, fri, sat, sun;
begin
  if DBGrid.FixedCols = 17 then
    exit;

  validtmpshifts := 0;

  // cc- 14/11/01 - 15096 (1)
  // delete all "empty" records (not saved anyway) to speed up PostTimes
  //with qryRun do
  //begin
    //close;
    //sql.Clear;
    //sql.Add('delete from #tmpschdl where Deleted is NULL');
    //sql.Add('and "old1" is null and "old2" is null and "old3" is null and "old4" is null');
    //sql.Add('and "old5" is null and "old6" is null and "old7" is null');
    //execSQL;
  //end;

  // reuse log variables to log saving stuff
  opstring := '';
  for i := 1 to 7 do
  begin
    for j := 1 to 5 do
    begin
      logarray[i,j] := 0;
    end;
  end;

  DMod1.SchdlTable.open;

  opstring := 'Begin. Schd recs: ' + inttostr(DMod1.SchdlTable.RecordCount) + ' ';

  with TempTable do
  begin
    open;
    requery;
    log.Event('Before Saving- ValidTmpShifts: ' + inttostr(validtmpshifts) +
      ' TmpRecsLeft: ' + inttostr(recordcount));

    first;
    while not EOF do
    begin
      case DBGrid.FixedCols of
        2, 3: goto mon;
        5: goto tue;
        7: goto wed;
        9: goto thu;
        11: goto fri;
        13: goto sat;
        15: goto sun;
      end;
      mon:  PostTimes(monstr, '1');
      tue:  PostTimes(monstr + 1, '2');
      wed:  PostTimes(monstr + 2, '3');
      thu:  PostTimes(monstr + 3, '4');
      fri:  PostTimes(monstr + 4, '5');
      sat:  PostTimes(monstr + 5, '6');
      sun:  PostTimes(monstr + 6, '7');

      next;
    end;
  end;

  qryRun.close;

  opstring := opstring + ' >>ins,del,edkey,edit,ok>> ';
  for i := 1 to 7 do
  begin
    wstring := 'd' + inttostr(i) + ':';
    k := 0;
    for j := 1 to 5 do
    begin
      wstring := wstring + inttostr(logarray[i,j]) + ',';
      if logarray[i,j] <> 0 then
        inc(k);
    end;
    if k > 0 then
      opstring := opstring + wstring + ' ';
  end;

  opstring := opstring + '<< Schd recs: ' + inttostr(DMod1.SchdlTable.RecordCount) + ' End.';
  log.event('Saving- ' + opstring);

  DMod1.SchdlTable.close;
end;

// Selects all shifts from 'schedule.db' which fall on or between the Monday
// and following Sunday.
// EACH SHIFT IS THEN PLACED INTO THE TEMPORARY TABLE FROM WHICH THE SCHEDULE GRID IS
// DISPLAYED. THEY GO INTO THE TABLE AGAINST THE PERSON AND DAY  RELEVANT TO THAT SHIFT.

procedure TfSchedule.GetShifts;
var
  currUserId: Int64;
  currec, dow2, dow, currRole, wkqRec, tmpRec : integer;
  sday, sno, tin, tout, theoc: string;
  tindate : tdatetime;

begin
  with WeekQuery do
  begin
    close;

    Parameters.ParamByName('site').value := vSiteCode;
    Parameters.ParamByName('monstr').value := ((monstr) + strtotime(fempmnu.grace));
    Parameters.ParamByName('sunstr').value :=
      ((monstr + 7) + (strtotime(fempmnu.grace) - strtotime('00:01')));

    //prepare;
    open;
    wkqRec := recordcount;
    first;
    TempTable.open;
    TempTable.insert;
    if VarIsNull(fieldbyname('UserId').Value) then
      currUserId := 0
    else
      currUserId := fieldbyname('UserId').Value;
    currRole := fieldbyname('RoleId').asinteger;
    currec := fieldbyname('rec').asinteger;
    //    start forming 1st record
    while not eof do
    begin
      if (currUserId= fieldbyname('UserId').Value) and
        (currRole = fieldbyname('RoleId').asinteger) and
        (currec = fieldbyname('rec').asinteger) then
      begin
        // moves schedule time details into temporary tables
        theoc := fieldbyname('oc').asstring;

        tin := formatdatetime('hh:nn', fieldbyname('schin').asdatetime);
        if tin < fempmnu.grace then
          tindate := (fieldbyname('schin').asdatetime) - 1
        else
          tindate := fieldbyname('schin').asdatetime;

        tout := formatdatetime('hh:nn', fieldbyname('schout').asdatetime);

        // determines which day the details should be entered against

        dow := ((dayofweek(tindate) + 7) - stWeek) mod 7;
        if dow = 0 then
          dow := 7;
        case dow of
          1:
            begin
              sday := 'Sun';
              sno := '7';
            end;
          2:
            begin
              sday := 'Mon';
              sno := '1';
            end;
          3:
            begin
              sday := 'Tue';
              sno := '2';
            end;
          4:
            begin
              sday := 'Wed';
              sno := '3';
            end;
          5:
            begin
              sday := 'Thu';
              sno := '4';
            end;
          6:
            begin
              sday := 'Fri';
              sno := '5';
            end;
          7:
            begin
              sday := 'Sat';
              sno := '6';
            end;
        end; // end of case
        TempTable.fieldbyname(sday + 'in').asstring := tin;
        TempTable.fieldbyname(sday + 'out').asstring := tout;
        TempTable.fieldbyname(sday + 'oc').asstring := theoc;
        TempTable.fieldbyname('F' + sno).asstring := fieldbyname('shift').asstring;
        TempTable.fieldbyname('Old' + sno).asdatetime := fieldbyname('schin').asdatetime;
        next;
      end
      else
      begin
        TLargeIntField(TempTable.fieldbyname('UserId')).AsLargeInt := currUserId;
        TempTable.fieldbyname('RoleId').asInteger := currRole;
        TempTable.fieldbyname('shift').asinteger := currec;
        try
          TempTable.post;   
        except
          on E: Exception do
            LogTempTableUpdateFailure(E.Message, 'GetShifts 01', currUserId);
        end;
        TempTable.insert;
        currUserId := fieldbyname('UserId').Value;
        currRole := fieldbyname('RoleId').asInteger;
        currec := fieldbyname('rec').asinteger;
      end; //end of if-else
    end; // end of whle not eof query
    if recordcount > 0 then
    begin
      TLargeIntField(TempTable.fieldbyname('UserId')).AsLargeInt := currUserId;
      TempTable.fieldbyname('RoleId').asinteger := currRole;
      TempTable.fieldbyname('shift').asinteger := currec;
      try
        TempTable.post;   
      except
        on E: Exception do
          LogTempTableUpdateFailure(E.Message, 'GetShifts 02', CurrUserID);
      end;

      tmpRec := TempTable.recordcount;

      // cc 13/11/01 - 15096 (1)
      if fempmnu.fillschALL then
        FillAllEmps;
    end
    else
    begin
      TempTable.Cancel;    
      tmpRec := TempTable.recordcount;

      if fempmnu.fillsch then
        FillAllEmps;
    end;
  end; // end of loop


  // cc 15502
  dow2 := trunc(monstr - Date + 1);

  // NUMBER OF READ ONLY COLUMNS IS now (15502, ES3.2.1, 17/01/02) SET ACCORDING
  // TO today's date
  // IF A PREVIOUS WEEK IS BEING VIEWED THEN ALL FIELDS ARE READ ONLY AS HISTORICAL DATA
  // CANNOT BE ALTERED
  if dow2 >= 1 then
    DBGrid.FixedCols := 2
  else
  begin
    case dow2 of
      0: DBGrid.FixedCols := 5;
      - 1: DBGrid.FixedCols := 7;
      - 2: DBGrid.FixedCols := 9;
      - 3: DBGrid.FixedCols := 11;
      - 4: DBGrid.FixedCols := 13;
      - 5: DBGrid.FixedCols := 15;
    else
      DBGrid.FixedCols := 17;
    end;
  end; // end of else

  if not isSite then
  begin
    DBGrid.FixedCols := 17;
  end;

  daystr := (monstr + 6) - ((14 - DBGrid.FixedCols) / 2);

  // log getShifts results (only if NOT reviewing)
  if DBGrid.FixedCols <= 15 then
  begin
    log.Event('1st Day: ' + formatDateTime('ddddd', monstr) +
      ' GetShifts- qry Recs: ' + inttostr(wkqRec) + ', tmpRecs: ' +
      inttostr(tmpRec) + ', fixDays: ' + inttostr((DBGrid.FixedCols - 2) div 2));
  end;
end;

// Selects all jobs for current week and currently selected job ID.
// MAKES BUTTONS ENABLED OR NOT ACCORDING TO CIRCUMSTANCES.

//------------------------------------------------------------------------------
procedure TfSchedule.EnableControls(aEnabled : Boolean);
begin
  // Job 327245
  DBGrid.ReadOnly := not aEnabled;
  BtnInsertEmployee.Enabled := aEnabled; {Insert Employee}
  btnDeleteEmployee.Enabled := aEnabled; {Delete Employee}
  BtnEmptySchedule.Enabled := aEnabled; {Empty Schedule}
  copybut.Enabled := aEnabled;
  CopyBtn.Enabled := aEnabled;
  Pastebtn.Enabled := aEnabled;
  fillbtn.Enabled := aEnabled;
  sbExpTake.Enabled := aEnabled;
  sprevert.Enabled := aEnabled;
end;

//------------------------------------------------------------------------------
function TfSchedule.GridHasEditableContent : Boolean;
begin
  {If all rows are greyed out then it means the entire week is in the past and
   no information can be modified}
  Result := DBGrid.FixedCols < 16;
end;


//------------------------------------------------------------------------------
procedure TfSchedule.DisplayJobs;
begin
  EnableControls(GridHasEditableContent);
  with DisplayQuery do
  begin
    close;
    SQL.Clear;
    SQL.Add('SELECT t.*, u.LastName, u.FirstName, r.Name AS JobName');
    SQL.Add('FROM #tmpschdl t');
    SQL.Add('JOIN ac_User u ON t.UserID = u.Id');
    SQL.Add('JOIN ac_Role r ON t.RoleId = r.Id');
    if pagecontrol1.activepage.tag <> ALL_ROLES_ID then
    begin
      SQL.Add('WHERE RoleId = :roleid ');
      Parameters.ParamByName('roleid').value := pagecontrol1.activepage.tag;
      qryEmployeeJobs.DataSource := nil;
      qryemployeejobs.Close;
      open;
    end
    else
    begin
      open;
      qryEmployeeJobs.DataSource := DisplayDS;
      qryemployeejobs.Open;
    end;

    if FSortOrder = 2 then
      DisplayQuery.Sort :=  'JobName, LastName, FirstName'
    else
      DisplayQuery.Sort := 'LastName, FirstName';

    if eof and bof then
    begin
      DBGrid.Readonly := true;
      btnDeleteEmployee.enabled := false;
    end
    else if DBGrid.FixedCols = 17 then
    begin
      btnDeleteEmployee.enabled := false;
      DBGrid.Readonly := true;
    end
    else
    begin
      btnDeleteEmployee.enabled := BtnInsertEmployee.Enabled; // del but like ins but
      DBGrid.Readonly := false;
    end;
  end;

  // if any days have passed in the schedule then the user can't change the job type
  if DBGrid.FixedCols < 4 then
    if (pagecontrol1.activepage.tag = ALL_ROLES_ID) then
      DBGrid.FixedCols := 2
    else
      DBGrid.FixedCols := 3;

  ReCalculate;
  warnings;
end;


// *********************************************************************
// ************* CALCULATION ROUTINES **********************************

///////////  CC  //////////////////////////////////////////////////////////////
//  Date: 22.09.99
//  Inputs: None
//  Outputs: None
//  Globals (R): None
//  Globals (W): None
//  Objects used: DBGrid, qryRun, tblRun, bmRun
//
//  Master Re-Calc proc, calls all other procs, does major jobs of the re-calc process
//
///////////////////////////////////////////////////////////////////////////////
procedure TfSchedule.ReCalculate;
var
  i: integer;
  timein, timeout: tdatetime;
  ShiftsToProcess: boolean;
begin
  ShiftsToProcess := False;

  with qryRun do
  try
    close;
    sql.Clear;
    sql.Add('select * from #tmpschdl where Deleted is NULL');
    open;

    if not(eof) then
    begin
      // send all data from #tmpschdl to #WeekShifts
      tblRun.close;
      tblRun.tablename := '#WeekShifts';
      dmADO.emptySQLTable('#WeekShifts');
      tblRun.open;

      first;

      while not eof do
      begin
        for i := 1 to 7 do
        begin
          if ((fieldbyname(dayarray2[i] + 'in').asstring <> '') and
            (fieldbyname(dayarray2[i] + 'out').asstring <> '')) then
          begin
            if (fieldbyname(dayarray2[i] + 'in').asstring) < fempmnu.grace then
            begin
              timein := (monstr + (i - 1) + 1.0) +
                strtotime(fieldbyname(dayarray2[i] + 'in').asstring);
              if fieldbyname(dayarray2[i] + 'in').asstring >
                fieldbyname(dayarray2[i] + 'out').asstring then
                timeout := (monstr + (i - 1) + 2.0) +
                  strtotime(fieldbyname(dayarray2[i] + 'out').asstring)
              else
                timeout := (monstr + (i - 1) + 1.0) +
                  strtotime(fieldbyname(dayarray2[i] + 'out').asstring);
            end
            else
            begin
              timein := monstr + (i - 1) + strtotime(fieldbyname(dayarray2[i] + 'in').asstring);
              if fieldbyname(dayarray2[i] + 'in').asstring >
                fieldbyname(dayarray2[i] + 'out').asstring then
                timeout := (monstr + (i - 1) + 1.0) +
                  strtotime(fieldbyname(dayarray2[i] + 'out').asstring)
              else
                timeout := monstr + (i - 1) + strtotime(fieldbyname(dayarray2[i] + 'out').asstring);
            end;

            ShiftsToProcess := True;

            tblRun.insert;
            TLargeIntField(tblRun.fieldbyname('UserId')).AsLargeInt := fieldbyname('UserId').Value;
            tblRun.fieldbyname('InTime').asdatetime := timein;
            tblRun.fieldbyname('OutTime').asdatetime := timeout;
            tblRun.fieldbyname('RoleId').asinteger := fieldbyname('RoleId').asinteger;
            // job 17308 The exit will be cause by the overlapping shift warning
            // this has to be done to prevent a key violation
            try
              tblRun.post;
            except
              exit;
            end;
          end; // if there are scheduled times...
        end; // for i = 1 to 7 (all days of the current record)
        next;
      end; // while still records to process in #tmpschdl (qryRun)
      close;
      tblRun.close;
    end; //if not(eof)
  finally
    Close
  end; // with qryRun


  if ShiftsToProcess then
  begin
    // Take the pay scheme and user override information for the shift from the Schedule table if it exists there,
    // if not use the latest pay scheme and user override that is currently assigned to the user and role.
    with cmdWageCostCalc do
    begin
      Parameters.ParamByName('SiteId').Value := vSiteCode;
      Parameters.ParamByName('StartOfWeek').Value := monstr;
      Execute;
    end;
  end
  else
    dmADO.EmptySQLTable('#DailyWageCosts');

  SetEmpLabels;
  SetJobLabels;
  SetDayLabels;
  SetWeekLabels;
  SetExpWage;

  Application.processMessages;
end; // procedure..

function LeftPad0(s1 :string):string;
begin
  if length(s1) = 1 then
  begin
    Result := '0' + s1;
  end
  else
  begin
    Result := s1;
  end;
end;

procedure TfSchedule.SetEmpLabels;
begin
  emphlab := 0;
  empclab := 0;

  if DisplayQuery.FieldByName('UserId').asString <> '' then
    with qryRun do
    try
      close;
      sql.Text :=
        'SELECT ISNULL(SUM(WorkedTimeMins), 0) as Mins, ISNULL(SUM(WageCost), 0) as WageCost ' +
        'FROM #DailyWageCosts where UserId = ' + DisplayQuery.FieldByName('UserId').asString;
      Open;
      emphlab := FieldByName('Mins').asinteger;
      empclab := FieldByName('WageCost').ascurrency;
    finally
      Close;
    end;

  lblEmpHrs.Caption := leftpad0(inttostr(emphlab div 60)) + ':' + leftpad0(inttostr(emphlab mod 60));
  lblEmpCost.Caption := formatfloat(currencystring + ',0.00', empclab);
end; // procedure..

procedure TfSchedule.SetJobLabels;
begin
  jobhlab := 0;
  jobclab := 0;

  if DisplayQuery.fieldbyname('RoleId').asString <> '' then
    with qryRun do
    try
      close;
      sql.Clear;
      sql.Add('SELECT ISNULL(SUM(WorkedTimeMins), 0) as Mins, ISNULL(SUM(WageCost), 0) as WageCost FROM #DailyWageCosts');
      if PageControl1.ActivePage.Tag <> ALL_ROLES_ID then
        sql.Add('WHERE RoleId = ' + DisplayQuery.fieldbyname('RoleId').asString);
      open;
      jobhlab := FieldByName('Mins').asinteger;
      jobclab := FieldByName('WageCost').ascurrency;
    finally
      close;
    end;

  lblJobHrs.Caption := leftpad0(inttostr(jobhlab div 60)) + ':' + leftpad0(inttostr(jobhlab mod 60));
  lblJobCost.Caption := formatfloat(currencystring + ',0.00', jobclab);
end; // procedure..

procedure TfSchedule.SetDayLabels;
begin
  // total day hours label
  with qryRun do
  try
    close;
    sql.Text :=
      'SELECT ISNULL(SUM(WorkedTimeMins), 0) as Mins, ISNULL(SUM(WageCost), 0) as WageCost ' +
      'FROM #DailyWageCosts where BusinessDate = ' + dmADO.FormatDateForSQL(currDay);
    Open;
    dayhlab := FieldByName('Mins').asinteger;
    dayclab := FieldByName('WageCost').ascurrency;
  finally
    Close;
  end;

  lblDayHrs.Caption := leftpad0(inttostr(dayhlab div 60)) + ':' + leftpad0(inttostr(dayhlab mod 60));
  lblDayCost.Caption := formatfloat(currencystring + ',0.00', dayclab);
end; // procedure..

procedure TfSchedule.SetWeekLabels;
begin
  // total week hours label
  with qryRun do
  try
    close;
    sql.Text :=
      'SELECT ISNULL(SUM(WorkedTimeMins), 0) as Mins, ISNULL(SUM(WageCost), 0) as WageCost ' +
      'FROM #DailyWageCosts';
    open;
    weekhlab := FieldByName('Mins').asinteger;
    weekclab := FieldByName('WageCost').ascurrency;
  finally
    close;
  end;

  lblWkHrs.Caption := leftpad0(inttostr(weekhlab div 60)) + ':' + leftpad0(inttostr(weekhlab mod 60));
  lblWkCost.Caption := formatfloat(currencystring + ',0.00', weekclab);
end; // procedure..

// this will only recalculate the exp wage % with the new total wage figure
// the expected weekly setting is done separately.
procedure TfSchedule.SetExpWage;
var
  WeeklyCost: Double;
begin
  WeeklyCost := (WeekCLab / 100) * (100 + dMod1.WagePercentUplift);

  if exptake <> 0 then
  begin
    expwage := WeeklyCost / exptake * 100;
  end
  else
  begin
    expwage := 0;
  end;
  
  lblExpTPc.caption := formatfloat('0.00', expwage);
end; // procedure..

// this is not really a recalculate proc as it is not called everytime. It sets
// the exptake variable (as well as the label) either from last month's figure
// or from the ExpTake.db table. It is called at form show and every time after
// the sbExpTake button is pressed to change the current figure.
procedure TfSchedule.SetExpTake(Recalc: Boolean);
begin
  // first go look in the exptake.db table too see if there is a figure for this
  // week. If it is then take it from there....

  with qryRun do
  begin
    close;
    sql.Clear;
    sql.Add('select a."value" from "exptake" a');
    sql.Add('where a."sitecode" = ' + inttostr(vSiteCode));
    sql.Add('and a."wstart" = ' + quotedstr(formatDateTime('mm/dd/yyyy', monstr)));
    open;

    if (recordcount = 1) and (not Recalc) then
    begin
      exptake := FieldByName('value').asfloat;
      lblExpTake.Font.Style := [fsBold, fsUnderline];
      close;
    end
    else
    begin // ... if not then take it from Aztec_SSales according to the config in
      if not Recalc then
        lblExpTake.Font.Style := [];

      Close;
      SQL.Clear;
      SQL.Add('select sum(Income) / 4 as income');
      SQL.Add('FROM ( SELECT te.POSCode as [POS Code],');
      SQL.Add('         [Date] AS [TimeOfSale], ');
      SQL.Add('         p.OrderLine AS [OrderLineNo], ');
      SQL.Add('         p.Product AS [Entity Code],');
      SQL.Add('         p.Quantity * p.Ratio as Quantity, p.Price / 100 AS [Income]');
      SQL.Add('         FROM ProductLine p ');
      SQL.Add('       INNER JOIN ThemeEposDevice te ON p.[TerminalID] = te.EPOSDeviceID) sales');
      SQL.Add('where [TimeOfSale] > ' + quotedstr(formatDateTime('mm/dd/yyyy hh:nn', monstr - 28 + RollOverTime)));
      SQL.Add('and [TimeOfSale] <= ' + quotedstr(formatDateTime('mm/dd/yyyy hh:nn', monstr + RollOverTime)));
      SQL.Add('and [POS Code] in');
      SQL.Add('   (select distinct [POS Code] from Config');
      SQL.Add('    where [Site Code] = ' + inttostr(vSiteCode) + ')');

      Open;
      ExpTake := FieldByName('Income').AsFloat;
      Close;
    end;
  end;
  lblExpTake.caption := formatfloat(currencystring + ',0.00', exptake);
end;

// ******************** END OF CALCULATION ROUTINES ***********************
// ************************************************************************

procedure TfSchedule.bbtReCalcClick(Sender: TObject);
begin
  screen.cursor := crhourglass;

  ReCalculate;

  screen.cursor := crdefault;
  dbgrid.setfocus;
  Application.processmessages;
  warnings;
end;

function WarnConvert(i1: integer): real;
begin
  warnconvert := strtofloat(inttostr(i1 div 60) + '.' + inttostr(i1 mod 60));
end;

// DISPLAYS ERROR MESSAGES ON SCHEDULE SCREEN ACCORDING TO WARNING LIMITS SET ON
// WARNINGS SCREEN

procedure TfSchedule.Warnings;
begin
  with qryRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from "warnings" a');
    open;
    listbox1.items.clear;
    listbox1.refresh;
    if (warnconvert(emphlab) > (fieldbyname('Emphrsval').asfloat)) and
      (lblEmpHrs.visible = true) and (fieldbyname('Emphrsflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Employee hours exceeded !');
    if (empclab > (fieldbyname('Empcstval').asfloat)) and
      (lblEmpCost.visible = true) and (fieldbyname('Empcstflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Employee cost exceeded !');
    if (warnconvert(jobhlab) > (fieldbyname('Jobhrsval').asfloat)) and
      (lblJobHrs.visible = true) and (fieldbyname('Jobhrsflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Job hours exceeded !');
    if (jobclab > (fieldbyname('Jobcstval').asfloat)) and
      (lblJobCost.visible = true) and (fieldbyname('Jobcstflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Job cost exceeded !');
    if (warnconvert(dayhlab) > (fieldbyname('Dayhrsval').asfloat)) and
      (lblDayHrs.visible = true) and (fieldbyname('Dayhrsflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Day hours exceeded !');
    if (dayclab > (fieldbyname('Daycstval').asfloat)) and
      (lblDayCost.visible = true) and (fieldbyname('Daycstflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Day cost exceeded !');
    if (warnconvert(weekhlab) > (fieldbyname('Weekhrsval').asfloat)) and
      (lblWkHrs.visible = true) and (fieldbyname('Weekhrsflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Week hours exceeded !');
    if (weekclab > (fieldbyname('Weekcstval').asfloat)) and
      (lblWkCost.visible = true) and (fieldbyname('Weekcstflag').asstring <> 'N') then
      listbox1.items.add('WARNING :-      Maximum Week cost exceeded !');
    listbox1.refresh;
    close;
  end;
end;

// 'Zeros' all display labels on page change

procedure TfSchedule.InitialiseLabels;
begin
  lblEmpHrs.caption := '00:00';
  lblDayHrs.caption := '00:00';
  lblJobHrs.caption := '00:00';
  lblWkHrs.caption := '00:00';
  lblEmpCost.caption := '0.00';
  lblDayCost.caption := '0.00';
  lblJobCost.caption := '0.00';
  lblWkCost.caption := '0.00';
  lblExpTPc.caption := '0.00';
  listbox1.Clear;
end;

// RESETS ALL LABELS AND POSTS ANY UNSAVED DATA

procedure TfSchedule.PageControl1Change(Sender: TObject);
begin
  if (DisplayQuery.state = dsinsert) or
    (DisplayQuery.state = dsedit) then
    try
      DisplayQuery.post;    
    except
      on E: Exception do
        LogTempTableUpdateFailure(E.Message, 'PageControl1Change', DisplayQuery.FieldByName('UserId').Value);
    end;
  CurrRoleRef := pagecontrol1.activepage.tag;
  InitialiseLabels;
  DisplayJobs;
  dbgrid.setfocus;
  dbgridcolenter(sender);

  opstring := opstring + ' JOB' + inttostr(pagecontrol1.activepage.tag) + ' ';
end;

// Updates the leftjob flag
//328432
Procedure TfSchedule.UpdateJobStatus;
begin
  qryRun.Close;
  qryRun.SQL.Clear;
  qryRun.SQL.Add('UPDATE [#tmpschdl] SET [LeftJob] = 0');
  qryRun.SQL.Add('FROM [#tmpschdl]');
  qryRun.SQL.Add('  LEFT JOIN [ac_UserRoles]');
  qryRun.SQL.Add('  ON  [ac_UserRoles].[UserId]=[#tmpschdl].[UserId] AND [ac_UserRoles].[RoleId]=[#tmpschdl].[RoleId]');
  qryRun.SQL.Add('  WHERE ([#tmpschdl].[UserId] IS NULL) AND ([#tmpschdl].[RoleId] IS NULL)');
  try
    qryRun.ExecSQL;        
  except
    on E: Exception do
      LogTempTableUpdateFailure(E.Message, 'UpdateJobStatus', 0);
  end;
end;

// Creates date strings for each day using existing captions which contain
// day and date, and appending the year value. Displays values relating to
// the currently viewed records.

procedure TfSchedule.FormShow(Sender: TObject);
var
  i      : integer;
  totstr : string;
begin
  with dmod1.adoqGetAllEmployeesAndJobs do
  begin
    Close;
    Parameters.ParamByName('SiteId').value := vSiteCode;
    Open;
  end;

  dmod1.CreateScheduleTempTables;

  if not isSite then
    Caption := Caption + ' for Site "' + vSiteName + '" (Read Only)';

  with dmod1.adoqGetAllEmployeesAndJobs do
  begin
    Close;
    Parameters.ParamByName('SiteId').value := vSiteCode;
    Open;
  end;

  wwtopclose.open;

  // Get job refs and names from the JobCode table but only for those jobs
  // which are actually allocated to an employee on the site.
  with dmod1.adoqGetAllJobs do
  begin
    Close;
    Parameters.ParamByName('siteid').value := vSiteCode;
    Open;

    while not eof do
    begin
      with TTabSheet.Create(pagecontrol1) do
      begin
        pagecontrol := pagecontrol1;
        tag := fieldbyname('RoleId').asinteger;
        caption := fieldbyname('RoleName').asstring;
      end;
      next;
    end;
    if RecordCount > 1 then
    begin
      with TTabSheet.Create(pagecontrol1) do
      begin
        pagecontrol := pagecontrol1;
        tag := ALL_ROLES_ID;
        caption := 'All Jobs';
      end;
    end;
    close;
  end;

  // make labels at the bottom visible or not depending on sysvar setting
  // job totals may be made invisible later anyway depending on grid.fixedcolumns
  dmod1.wwtsysvar.open;
  totstr := dmod1.wwtsysvar.fieldbyname('Totals').asstring;
  for i := 0 to (panel6.controlcount - 1) do
  begin
    if (panel6.controls[i].tag) > 0 then
    begin
      if copy(totstr, panel6.controls[i].tag, 1) = '1' then
        panel6.controls[i].visible := true
      else
        panel6.controls[i].visible := false;
    end;
  end;

  copyoptdlg := Tcopyoptdlg.create(self);
  pagecontrol1.ActivePageIndex := 0;
  CurrRoleRef := pagecontrol1.activepage.tag;
  TempTable.active := false;
  //dmADO.emptySQLTable('#tmpschdl');

  opstring := 'GS';
  userins := 0;
  userdel := 0;
  validtmpshifts := 0;
  userempty := 0;
  useredit := 0;

  GetShifts; // and set fixed columns, buttons status, etc. VIP
  opstring := opstring + ' JOB' + inttostr(pagecontrol1.activepage.tag) + ' ';
  InitialiseLabels;
  DisplayJobs;
  //328432
  UpdateJobStatus;
  // Refresh expected takings
  SetExpTake(False);
  lblExpTake.caption := formatfloat(currencystring + ',0.00', exptake);

  CopyBut.Enabled := DBGrid.FixedCols <= 2;

  if DBGrid.FixedCols > 14 then
  begin
    BtnInsertEmployee.enabled := false;
    fillbtn.enabled := false;
    copybtn.enabled := false;
    btnDeleteEmployee.enabled := false;
    sbExpTake.enabled := false;
    sprevert.Enabled := false;

    label33.Visible:=false;
    label34.Visible:=false;
    lblDayHrs.Visible:=false;
    lbldaycost.Visible:=false;
  end
  else
  begin
    BtnInsertEmployee.enabled := true;
    fillbtn.enabled := true;
    copybtn.enabled := true;
    sbExpTake.enabled := true;
  end;

  BtnEmptySchedule.Enabled := copybut.Enabled;

  lblWeek.caption := formatDateTime(shortdateformat, monstr) + ' -- ' +
    formatDateTime(shortdateformat, monstr + 6);

  dbgrid.setfocus;
  dbgridcolenter(sender);

  SetExpWage;
  lblEmployeeNameClick(nil); // default order by name;
  screen.Cursor := crDefault;
end;

// On each attempt at posting a record the current job reference (given by
// the currently selected page) is inserted into the record.

procedure TfSchedule.DisplayDSUpdateData(Sender: TObject);
begin
  with DisplayQuery do
  begin
    Open;
    if CurrRoleRef <> ALL_ROLES_ID then
      fieldbyname('RoleId').asinteger := CurrRoleRef;
  end;
end;


//Remove the 'o' (Open) or 'c' (Close) values for the current employee/day in the #tmpSchedl table,
//depending on whether the current cell being edited is an 'in' time or an 'out' time.
procedure TfSchedule.ResetOpenCloseFlags;
begin
  with DisplayQuery do
    if copy((DBGrid.fieldname(DBGrid.GetActiveCol)), 4, 2) = 'in' then
    begin // dayin....
      if pos('o', fieldbyname(calcday + 'oc').asstring) = 0 then
        exit;

      if pos('c', fieldbyname(calcday + 'oc').asstring) = 0 then
        // delete the 'o' if it's there
        fieldbyname(calcday + 'oc').asstring := ''
      else
        // leave the 'c', delete 'o'
        fieldbyname(calcday + 'oc').asstring := 'c';
    end
    else
    begin // dayout...
      if pos('c', fieldbyname(calcday + 'oc').asstring) = 0 then
        exit;

      if pos('o', fieldbyname(calcday + 'oc').asstring) = 0 then
        // delete the 'c' if it's there
        fieldbyname(calcday + 'oc').asstring := ''
      else
        // leave the 'o', delete 'c'
        fieldbyname(calcday + 'oc').asstring := 'o';
    end;
end;

//Set the 'c' (Close) flag for the current employee/day in the #tmpSchedl table.
procedure TfSchedule.SetCloseFlag;
begin
  // if the flag 'o' not already there....
  if pos('o', DisplayQuery.fieldbyname(calcday + 'oc').asstring) = 0 then
    // the flag field is just 'c'
    DisplayQuery.fieldbyname(calcday + 'oc').asstring := 'c'
  else
    // else the field is 'oc'
    DisplayQuery.fieldbyname(calcday + 'oc').asstring := 'oc';
end;

//Set the 'o' (Open) flag for the current employee/day in the #tmpSchedl table.
procedure TfSchedule.SetOpenFlag;
begin
  // if the flag 'c' not already there....
  if pos('c', DisplayQuery.fieldbyname(calcday + 'oc').asstring) = 0 then
     // the flag field is just 'o'
    DisplayQuery.fieldbyname(calcday + 'oc').asstring := 'o'
  else
    // else the field is 'oc'
    DisplayQuery.fieldbyname(calcday + 'oc').asstring := 'oc';
end;


procedure TfSchedule.DBGrid45KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // if this emp has been terminated do not allow any typing
  //job 328432
  if (dbGrid.DataSource.DataSet.FieldByName('terminated').AsBoolean = True) or
      (dbGrid.DataSource.DataSet.FieldByName('LeftJob').AsBoolean = True) then
  begin
    exit;
  end;

  case key of
    VK_insert:
      if BtnInsertEmployee.enabled then btnInsertEmployeeClick(Sender);

    VK_delete:
      if (ssctrl in shift) then
      begin
        if (btnDeleteEmployee.enabled) then
          btnDeleteEmployeeclick(sender);
      end
      else if PageControl1.ActivePage.Tag <> ALL_ROLES_ID then
        with DisplayQuery do
        begin
          edit;
          fieldbyname(DBGrid.fieldname(DBGrid.GetActiveCol)).value := '';
          try
            post;    
          except
            on E: Exception do
              LogTempTableUpdateFailure(E.Message, 'DBGrid45KeyDown', DisplayQuery.FieldByName('UserId').Value);
          end;
        end;
  end; { case key of }

end;

function TfSchedule.JobType(Job: integer): string;
var
  pageno: integer;
begin
  for pageno := 0 to (pagecontrol1.pagecount - 1) do
  begin
    if pagecontrol1.pages[pageno].tag = job then
    begin
      jobtype := pagecontrol1.pages[pageno].caption;
      exit;
    end;
  end;
end;

// CHECKS TIME VALIDITY WHEN ALL 5 CHARS HAVE BEEN ENTERED

procedure TfSchedule.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //screen.cursor := crhourglass;

  log.Event('User Ops: ' + opstring);
  PopulateTable;
  if sendflag and (((date >= monstr) and (date <= (monstr + 6))) or
    (((date + 7) >= monstr) and ((date + 7) <= (monstr + 6)))) then
    TxSchedule;
  screen.cursor := crdefault;
  WeekQuery.Active := false;
  DisplayQuery.Active := false;
  copyoptdlg.free;
  dmod1.adoqGetAllEmployeesAndJobs.Close;
  dmod1.DeleteScheduleTempTables;
  modalresult := mrOK;
end;

procedure TfSchedule.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

// Insert Employee
procedure TfSchedule.btnInsertEmployeeClick(Sender: TObject);
var
  thenewEmp: Int64;
  theshift, SelectedJob: integer;
begin
  //qryEmployeeJobs.DataSource := nil;
  FinsEmp := TFinsemp.create(fSchedule);
  FinsEmp.RoleId := pagecontrol1.activepage.tag;
  if FinsEmp.showmodal = mrCancel then
  begin
    FinsEmp.free;
    exit;
  end;
  thenewEmp := FinsEmp.theNewEmp;

  if pagecontrol1.activepage.tag = ALL_ROLES_ID then
  begin
    SelectedJob := FinsEmp.qryEmployeeJobs.fieldbyname('Id').AsInteger;
    qryEmployeeJobs.DataSource := nil;
    qryEmployeeJobs.Close;
  end
  else
    SelectedJob := pagecontrol1.activepage.tag;

  FinsEmp.free;

  theshift := -1;

  with DisplayQuery do
  begin
    try
      insert;

      inc(userins);
      wstring := 'i';

      fieldbyname('shift').asinteger := 1;
      TLargeIntField(fieldbyname('UserId')).AsLargeInt := thenewEmp;
      fieldbyname('Roleid').asInteger := SelectedJob;
      try
        post;
      except on E:Exception do
        begin
          LogTempTableUpdateFailure(E.Message, 'btnInsertEmployee.  Shift already exists? Attempt to add a second shift', DisplayQuery.FieldByName('UserId').Value, False);
          raise;
        end;
      end;
      theshift := 1;
    except
      on E: Exception do
      try
        cancel;
        insert;
        fieldbyname('shift').asinteger := 2;
        TLargeintField(fieldbyname('UserId')).AsLargeInt := thenewEmp;
        fieldbyname('RoleId').asinteger := SelectedJob;
        try
          post;
        except on E:Exception do
          begin
            LogTempTableUpdateFailure(E.Message, 'btnInsertEmployee.  2nd shift insertion failed - already scheduled twice?', DisplayQuery.FieldByName('UserId').Value, False);
            raise;
          end;
        end;
        theshift := 2;
      except
        on exception do
        begin
          cancel;
          dec(userins);
          wstring := '';
          showmessage('Already scheduled twice today!');
        end;
      end;
    end;
    Requery;
    if DBGrid.Readonly = true then
      DBGrid.Readonly := false;

    opstring := opstring + wstring;
    DisplayJobs;

    if (theshift = 1) or (theshift = 2) then
      locate('UserId;shift;RoleId', VarArrayOf([thenewEmp, theshift, SelectedJob]), []);

    DBGrid.refresh;

    DBGrid.SetFocus;
  end;
end;

procedure Tfschedule.WMSysCommand;
{Used to minimise the whole app if the current form is minimised}
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
//    flogdlg.theForm := self;
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;


// PREVENTS DELETION OF HISTERICAL DATA

// Delete Employee
procedure TfSchedule.btnDeleteEmployeeClick(Sender: TObject);
var
  negshift : integer;
label
  mond, tues, wedn, thur, frid, satu, okdel;

begin
  case DBGrid.FixedCols of
    5: goto mond;
    7: goto tues;
    9: goto wedn;
    11: goto thur;
    13: goto frid;
    15: goto satu
  else
    goto okdel;
  end;
  satu: if DisplayQuery.fieldbyname('satin').asstring <> '' then
  begin
    MessageDlg('Cannot delete this Record !', mtError, [mbOk], 0);
    exit;
  end;
  frid: if DisplayQuery.fieldbyname('friin').asstring <> '' then
  begin
    MessageDlg('Cannot delete this Record !', mtError, [mbOk], 0);
    exit;
  end;
  thur: if DisplayQuery.fieldbyname('thuin').asstring <> '' then
  begin
    MessageDlg('Cannot delete this Record !', mtError, [mbOk], 0);
    exit;
  end;
  wedn: if DisplayQuery.fieldbyname('wedin').asstring <> '' then
  begin
    MessageDlg('Cannot delete this Record !', mtError, [mbOk], 0);
    exit;
  end;
  tues: if DisplayQuery.fieldbyname('tuein').asstring <> '' then
  begin
    MessageDlg('Cannot delete this Record !', mtError, [mbOk], 0);
    exit;
  end;
  mond: if DisplayQuery.fieldbyname('monin').asstring <> '' then
  begin
    MessageDlg('Cannot delete this Record !', mtError, [mbOk], 0);
    exit;
  end;

  okdel: if MessageDlg('Delete this Record ?', mtConfirmation, [mbOk, mbCancel]
    , 0) = mrok then
  begin
    initialiselabels;

    with qryRun do
    begin
      close;
      sql.Clear;
      sql.Add('select min(a."shift") as negshift from "#tmpschdl" a');
      sql.Add('where a.UserId = ' + DisplayQuery.FieldByName('UserId').asstring);
      sql.Add('and a.Deleted = ''Y''');
      open;
      negshift := FieldByName('negshift').asinteger - 1;
      close;
    end;

    DisplayQuery.edit;

    dec(useredit);
    inc(userdel);
    opstring := opstring + 'd';

    DisplayQuery.FieldByName('Deleted').asstring := 'Y';
    DisplayQuery.FieldByName('shift').asinteger := negshift;
    try
      DisplayQuery.post;   
    except
      on E: Exception do
        LogTempTableUpdateFailure(E.Message, 'btnDeleteEmployeeClick', DisplayQuery.FieldByName('UserId').Value);
    end;
    DBGrid.SetActivefield('UserId');
    DisplayJobs;
  end;
end;

procedure TfSchedule.DBGridColEnter(Sender: TObject);
var
  EnableCopyAndPaste: Boolean;
begin
  EnableCopyAndPaste := GridHasEditableContent;
  if DBGrid.FieldName(DBGrid.getactivecol) = 'RoleName' then
  begin
    EnableCopyAndPaste := False;
  end
  else
  begin
    EnableCopyAndPaste := EnableCopyAndPaste AND TRUE;
  end;

  Copybtn.Enabled  := EnableCopyAndPaste;
  Pastebtn.Enabled := EnableCopyAndPaste;

  if DBGrid.getactivecol = 18 then
    DBGrid.setactivefield('sunout');
  CurrUserId := TLargeIntField(DisplayQuery.fieldbyname('UserId')).AsLargeInt;
  CurrRoleId := DisplayQuery.fieldbyname('RoleId').asInteger;
  CurrShift := DisplayQuery.fieldbyname('shift').asinteger;
  calcday := lowercase(copy(dbgrid.FieldName(dbgrid.GetActiveCol), 1, 3));
  case dbgrid.getactivecol of
      4, 5: currday := monstr;
      6, 7: currday := monstr + 1;
      8, 9: currday := monstr + 2;
     10, 11: currday := monstr + 3;
    12, 13: currday := monstr + 4;
    14, 15: currday := monstr + 5;
    16, 17: currday := monstr + 6;
  end;
end;

procedure TfSchedule.DBGridColExit(Sender: TObject);
begin
  //Post the current record if a change was made to the cell. This is necessary in order to invoke
  //the code in the AfterPost event handler which recalcs the values of various non-dataaware controls.
  try
    if DisplayQuery.State = dsEdit
      then DisplayQuery.Post;   
  except
    on E: Exception do
      LogTempTableUpdateFailure(E.Message, 'DBGridColExit', DisplayQuery.FieldByName('UserId').Value);
  end;
end;

function TfSchedule.Convert(timestr: string): string;
begin
  convert := inttostr(strtoint(copy(timestr, 1, 2)) + 24) + ':' + copy(timestr, 4, 2);
end;


procedure TfSchedule.Overlap;
var
  chk1, chk2, daystr, instr, outstr, jobn: string;
  alljob, i, j, intF: integer;
  chk1Value, chk2Value: integer;
begin

  // check to see if less than 2 shifts ALREADY in SCHEDULE FOR THIS PERSON

  i := 1; // comment
  for j := 1 to 7 do
  begin
    if dayarray[j] = calcday then
    begin
      i := j;
      break;
    end;
  end;
  intF := ((i + 5) mod 7) + 1;

  // check for overlapping shifts -- ONLY WITHIN WEEK -- OVERLAPS FROM LAST DAY OF
  // PREVIOUS WEEK AND FIRST DAY OF FOLLOWING WEEK NOT CHECKED.
  with qryRun do
  begin
    close;
    sql.clear;
    sql.add('select *');
    sql.add('from "#tmpschdl" a');
    sql.add('where a.UserId = ' + floattostr(CurrUserId));
    sql.add('and a."' + cfield + 'in" is not null');
    sql.add('and a."' + cfield + 'out" is not null');
    sql.add('and a."' + cfield + 'in" <> ''''');
    sql.add('and a."' + cfield + 'out" <> ''''');
    sql.Add('and a.Deleted is NULL');
    open;

    if recordcount > 2 then
    begin
      errflag := true;
      // job 18782
      MessageDlg('This employee is already scheduled to work two shifts on ' +
        theWeek[(intF+stweek)mod 7],   //today.',
        mtWarning, [mbOK], 0);
      // job
      with DisplayQuery do
      begin
        (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleID, CurrShift]), []));
        edit;
        fieldbyname(cfield + 'in').asstring := '';
        fieldbyname(cfield + 'out').asstring := '';
        try
          post;          
        except
          on E: Exception do
            LogTempTableUpdateFailure(E.Message, 'Overlap 01', CurrUserId);
        end;
        dbgrid.refresh;
        exit;
      end;
    end;

    if recordcount = 2 then
    begin
      first;
      if (FieldByName('shift').asinteger = CurrShift) and
        (FieldByName('RoleId').asinteger = CurrRoleId) then
        next;
      alljob := fieldbyname('RoleId').asinteger;
      instr := fieldbyname(cfield + 'in').asstring;
      outstr := fieldbyname(cfield + 'out').asstring;

      if instr > outstr then
      begin
        outstr := convert(outstr);
      end
      else
      begin
        if instr < fempmnu.grace then
        begin
          instr := convert(instr);
          outstr := convert(outstr);
        end;
      end;

      if chkin > chkout then
      begin
        chk1 := chkin;
        chk2 := convert(chkout);
      end
      else
      begin
        if chkin < fempmnu.grace then
        begin
          chk1 := convert(chkin);
          chk2 := convert(chkout);
        end
        else
        begin
          chk1 := chkin;
          chk2 := chkout;
        end;
      end;

      // 17308 the same stuff needs done for 0 mins shifts as clashing shifts, so much of the same code
      // is used (the only diffrence being the warning
      if (chk2 > instr) and (chk1 < outstr) then
      begin
        for j := 0 to pagecontrol1.PageCount - 1 do
        begin
          if pagecontrol1.Pages[j].tag = alljob then
          begin
            jobn := pagecontrol1.Pages[j].caption;
            break;
          end;
        end;
        //errflag := true;   commented in 14551
        MessageDlg('The ' + dayarray[dayofweek(currday)] + '. ' +
          'shift overlaps shift ' + #13 +
          inttostr(strtoint(copy(instr, 1, 2)) mod 24) + copy(instr, 3, 3) +
          ' - ' + inttostr(strtoint(copy(outstr, 1, 2)) mod 24) + copy(outstr, 3, 3) +
          ' as a ' + jobn, mtWarning, [mbOK], 0);


        with DisplayQuery do
        begin
          (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), []));
          edit;
          fieldbyname(cfield + 'in').asstring := '';
          fieldbyname(cfield + 'out').asstring := '';
          try
            post;              
          except
            on E: Exception do
              LogTempTableUpdateFailure(E.Message, 'Overlap 02', CurrUserId);
          end;
          dbgrid.refresh;
          exit;
        end;
      end;
    end; // if there are 2 records...
    close;
  end; // with qryRun

  // checks overlapping shifts from previous day
  if (chkin >= fempmnu.grace) and (calcday <> 'mon') then
  begin
    daystr := dayarray[((i + 5) mod 7) + 1];
    with qryRun do
    begin
      close;
      sql.clear;
      sql.add('select a.' + daystr + 'in, a.' + daystr + 'out,a.RoleId');
      sql.add('from #tmpschdl a');
      sql.add('where a.UserId = ' + floattostr(CurrUserId));
      sql.add('and a.' + daystr + 'out > ' + QuotedStr(fempmnu.grace));
      sql.add('and (( a.' + daystr + 'out < a.' + daystr + 'in)');
      sql.add('  or (a.' + daystr + 'in < '  + QuotedStr(fempmnu.grace) + '))');
      sql.add('and a.' + daystr + 'out > '  + QuotedStr(chkin));
      sql.Add('and a.Deleted is NULL');
      open;
    end;
    if not ((qryRun.eof) and (qryRun.bof)) then
    begin
      //errflag := true;   commented in 14551
      alljob := qryRun.fieldbyname('RoleId').asinteger;
      for j := 0 to pagecontrol1.PageCount - 1 do
      begin
        if pagecontrol1.Pages[j].tag = alljob then
        begin
          jobn := pagecontrol1.Pages[j].caption;
          break;
        end;
      end;
      MessageDlg('The ' + dayarray[dayofweek(currday)] + '. ' +
        'shift overlaps shift ' +
        qryRun.fieldbyname(daystr + 'in').asstring
        + ' - ' + qryRun.fieldbyname(daystr + 'out').asstring + #13 +
        ' as ' + jobn + ' from previous day ', mtWarning, [mbOK], 0);
      with DisplayQuery do
      begin
        (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), []));
        edit;
        fieldbyname(cfield + 'in').asstring := '';
        fieldbyname(cfield + 'out').asstring := '';
        try
          post;              
        except
          on E: Exception do
            LogTempTableUpdateFailure(E.Message, 'Overlap 03', CurrUserId);
        end;
        dbgrid.refresh;
        exit;
      end;
    end
  end;
  // checks overlapping shifts from following day
  if (chkout >= fempmnu.grace) and (calcday <> 'sun') and
    ((chkout < chkin) or (chkin < fempmnu.grace)) then
  begin
    daystr := dayarray[((i mod 7) + 1)];
    with qryRun do
    begin
      close;
      sql.clear;
      sql.add('select a.' + daystr + 'in, a.' + daystr + 'out, a.RoleId');
      sql.add('from #tmpschdl a');
      sql.add('where a.UserId = ' + floattostr(CurrUserId));
      sql.add('and a.' + daystr + 'in > ' + QuotedStr(fempmnu.grace));
      sql.add('and a.' + daystr + 'in < ' + QuotedStr(chkout));
      sql.Add('and a.Deleted is NULL');
      open;
    end;
    if not ((qryRun.eof) and (qryRun.bof)) then
    begin
      //errflag := true;   commented in 14551
      alljob := qryRun.fieldbyname('RoleId').asinteger;
      for j := 0 to pagecontrol1.PageCount - 1 do
      begin
        if pagecontrol1.Pages[j].tag = alljob then
        begin
          jobn := pagecontrol1.Pages[j].caption;
          break;
        end;
      end;
      MessageDlg('The ' + dayarray[dayofweek(currday)] + '. ' +
        'shift overlaps shift ' +
        qryRun.fieldbyname(daystr + 'in').asstring
        + ' - ' + qryRun.fieldbyname(daystr + 'out').asstring + #13 +
        ' as ' + jobn + ' from following day ', mtWarning, [mbOK], 0);
      with DisplayQuery do
      begin
        (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), []));
        edit;
        fieldbyname(cfield + 'in').asstring := '';
        fieldbyname(cfield + 'out').asstring := '';
        try
          post;      
        except
          on E: Exception do
            LogTempTableUpdateFailure(E.Message, 'Overlap 04', CurrUserId);
        end;
        dbgrid.refresh;
        exit;
      end;
    end
  end;
  qryRun.Close;

  with qryRun do
  begin
    close;
    sql.clear;
    sql.add('select *');
    sql.add('from #tmpschdl a');
    sql.add('where a.UserId = ' + floattostr(CurrUserId));
    sql.add('and a.' + cfield + 'in is not null');
    sql.add('and a.' + cfield + 'out is not null');
    sql.add('and a.' + cfield + 'in <> ''''');
    sql.add('and a.' + cfield + 'out <> ''''');
    sql.Add('and a.Deleted is NULL');
    open;
    first;
    if recordcount = 1 then
    begin
      close;
      sql.clear;
      sql.add('update #tmpschdl');
      sql.add('set F' + inttostr(intF) + ' = ''1''');
      sql.add('where UserId = ' + floattostr(CurrUserId));
      sql.add('and ' + cfield + 'in is not null');
      sql.add('and ' + cfield + 'out is not null');
      sql.add('and ' + cfield + 'in <> ''''');
      sql.add('and ' + cfield + 'out <> ''''');
      sql.Add('and Deleted is NULL');
      try
        execSQL;       
      except
        on E: Exception do
          LogTempTableUpdateFailure(E.Message, 'Overlap 05', CurrUserId);
      end;

    end
    else
    begin
      chk1 := FieldByName(cfield + 'in').asstring;
      if chk1 < fempmnu.grace then
        chk1 := convert(chk1);
      next;
      chk2 := FieldByName(cfield + 'in').asstring;
      if chk2 < fempmnu.grace then
        chk2 := convert(chk2);

      if chk1 > chk2 then
      begin
        chk1Value := 2;
        chk2Value := 1;
      end
      else
      begin
        chk1Value := 1;
        chk2Value := 2;
      end;

      chk2 := FieldByName(cfield + 'in').asstring;
      prior;
      chk1 := FieldByName(cfield + 'in').asstring;

      close;
      sql.clear;
      sql.add('update #tmpschdl');
      sql.add('set F' + inttostr(intF) + ' = ' + inttostr(chk1Value));
      sql.add('where UserId = ' + IntToStr(CurrUserId));
      sql.add('and ' + cfield + 'in = ''' + chk1 + '''');
      sql.Add('and Deleted is NULL');
      try
        execSQL;       
      except
        on E: Exception do
          LogTempTableUpdateFailure(E.Message, 'Overlap 06', CurrUserId);
      end;

      close;
      sql.clear;
      sql.add('update #tmpschdl');
      sql.add('set F' + inttostr(intF) + ' = ' + inttostr(chk2Value));
      sql.add('where UserId = ' + floattostr(CurrUserId));
      sql.add('and ' + cfield + 'in = ''' + chk2 + '''');
      sql.Add('and Deleted is NULL');
      try
        execSQL;       
      except
        on E: Exception do
          LogTempTableUpdateFailure(E.Message, 'Overlap 07', CurrUserId);
      end;
    end;
    close;
  end; // with qryRun
  
  with DisplayQuery do
  begin
    Requery;    
    locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), []);
  end;
end;

procedure TfSchedule.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  errflag := false;
  try
    if DisplayQuery.State = dsEdit then
      DisplayQuery.Post;  
  except
    on E: Exception do
      LogTempTableUpdateFailure(E.Message, 'PageControl1Changing', DisplayQuery.FieldByName('UserID').Value);
  end;
  allowchange := not errflag;
  errflag := false;
end;

procedure TfSchedule.DBGridEnter(Sender: TObject);
begin
  dbgridcolenter(sender);
end;

procedure TfSchedule.DBGridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if errflag then
  begin
    errflag := not errflag;
    DisplayQuery.locate('UserId;RoleId;shift',
      vararrayof([CurrUserId, CurrRoleId, CurrShift]), []);
  end
  else
    dbgridcolenter(sender);
end;

procedure TfSchedule.DBGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_up) or (key = VK_down) then
    if errflag then
    begin
      errflag := not errflag;
      DisplayQuery.locate('UserId;RoleId;shift',
        vararrayof([CurrUserId, CurrRoleId, CurrShift]), []);
    end
    else
      dbgridcolenter(sender);
end;

procedure TfSchedule.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  errflag := false;
  try
    if DisplayQuery.State = dsEdit then
      DisplayQuery.Post;   
  except
    on E: Exception do
      LogTempTableUpdateFailure(E.Message, 'FormCloseQuery', DisplayQuery.FieldByName('UserID').Value);
  end;

  canclose := not errflag;
  errflag := false;
  dbgrid.setfocus;
end;


// this copies an old week schedule into the current week schedule....
procedure TfSchedule.copybutClick(Sender: TObject);
var
  moncopy, suncopy, tindate: tdatetime;
  currRole, currec, dow: integer;
  sday, sno, tin, tout, theoc : string;
  ScheduleLookAheadWeeks: integer;
  currUserId: int64;
begin
  displayquery.DisableControls;
  TempTable.open;
  TempTable.Requery;
  if TempTable.recordcount > 0 then
    if MessageDlg('The records existing in this week''s schedule will' + #13 +
      'be deleted if you copy data from another week!' + #13 + #13 +
      'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      exit;

  // show the week picker (MODAL!) with new caption and buttons OK & Cancel
  // if Cancel then just exit...
  // else get the start date of the week (monstr) and give it to moncopy then...
  // temporarily get your week from maskedit1...

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from MasterVar');
    Open;
    ScheduleLookAheadWeeks := FieldByName('ScheduleLookAhead').AsInteger;
    Close;
  end;

  fPickWeek := TfPickWeek.Create(self);
  fPickWeek.Caption := 'Choose a week to copy from';
  fPickweek.extraDays := ScheduleLookAheadWeeks * 7;
  fPickweek.mode := pwmSchedule;
  if fPickWeek.showModal = mrCancel then
  begin
    fPickWeek.free;
    screen.cursor := crDefault;
    exit;
  end;

  moncopy := fpickweek.selWeekSt;
  suncopy := moncopy + 6;
  fPickWeek.free;

  with wwqborrow do
  begin //1
    close;
    Parameters.ParamByName('site').value := vSiteCode;
    Parameters.ParamByName('mid1').value := moncopy + strtotime(fempmnu.grace);
    Parameters.ParamByName('mid2').value := 1 + suncopy + strtotime(fempmnu.grace) - strtotime('00:01');
    open;
    first;

    if recordcount > 0 then
    begin

      with qryRun do // delete any existing shifts
      begin
        close;
        sql.Clear;
        sql.Add('update #tmpschdl set "deleted" = ''Y'', "shift" = ("shift" - 2000)');
        try
          execSQL;
        except
          on E: Exception do
            LogTempTableUpdateFailure(E.Message, 'copybutClick 01', 0);
        end;
      end;

      TempTable.close;
      TempTable.open;
      TempTable.insert;
      currUserId := fieldbyname('UserId').Value;
      currRole := fieldbyname('RoleId').asInteger;
      currec := fieldbyname('rec').asInteger;
      //    start forming 1st record
      while not eof do
      begin
        if (currUserId = fieldbyname('UserId').Value) and
          (currRole = fieldbyname('RoleId').asInteger) and
          (currec = fieldbyname('rec').asInteger) then
        begin
          // moves schedule time details into temporary tables
          theoc := fieldbyname('oc').asstring;

          tin := formatdatetime('hh:nn', fieldbyname('schin').asdatetime);
          if tin < fempmnu.grace then
            tindate := (fieldbyname('schin').asdatetime) - 1
          else
            tindate := fieldbyname('schin').asdatetime;

          tout := formatdatetime('hh:nn', fieldbyname('schout').asdatetime);

          // determines which day the details should be entered against

          dow := ((dayofweek(tindate) + 7) - stweek) mod 7;
          if dow = 0 then
            dow := 7;
          case dow of
            1:
              begin
                sday := 'Sun';
                sno := '7';
              end;
            2:
              begin
                sday := 'Mon';
                sno := '1';
              end;
            3:
              begin
                sday := 'Tue';
                sno := '2';
              end;
            4:
              begin
                sday := 'Wed';
                sno := '3';
              end;
            5:
              begin
                sday := 'Thu';
                sno := '4';
              end;
            6:
              begin
                sday := 'Fri';
                sno := '5';
              end;
            7:
              begin
                sday := 'Sat';
                sno := '6';
              end;
          end; // end of case
          TempTable.fieldbyname(sday + 'in').asstring := tin;
          TempTable.fieldbyname(sday + 'out').asstring := tout;
          TempTable.fieldbyname(sday + 'oc').asstring := theoc;
          TempTable.fieldbyname('F' + sno).asstring := fieldbyname('shift').asstring;
          if tin < fempmnu.grace then
            TempTable.fieldbyname('Old' + sno).asdatetime :=
              monstr + strtoint(sno) + frac(fieldbyname('schin').asfloat)
          else
            TempTable.fieldbyname('Old' + sno).asdatetime :=
              monstr + strtoint(sno) - 1 + frac(fieldbyname('schin').asfloat);
          next;
        end
        else
        begin
          TLargeIntField(TempTable.fieldbyname('UserId')).AsLargeInt := currUserId;
          TempTable.fieldbyname('RoleId').asInteger := currRole;
          TempTable.fieldbyname('shift').asInteger := currec;
          try
            TempTable.post;    
          except
            on E: Exception do
              LogTempTableUpdateFailure(E.Message, 'copybutClick 02', TempTable.FieldByName('UserID').Value);
          end;
          TempTable.insert;
          currUserId := fieldbyname('UserId').Value;
          currRole := fieldbyname('RoleId').asInteger;
          currec := fieldbyname('rec').asinteger;
        end; //end of if-else
      end; // end of loop
      if recordcount > 0 then
      begin
        TLargeIntField(TempTable.fieldbyname('UserId')).AsLargeInt:= currUserId;
        TempTable.fieldbyname('RoleId').asinteger := currRole;
        TempTable.fieldbyname('shift').asinteger := currec;
        try
          TempTable.post;  
        except
          on E: Exception do
            LogTempTableUpdateFailure(E.Message, 'copybutClick 03', TempTable.FieldByName('UserID').Value);
        end;
      end
      else
      begin
        TempTable.Cancel;
      end;
      close;

      opstring := opstring + ' BORROW ';

      log.Event('Borrow from: ' + formatDateTime('ddddd', moncopy));

      fSchedule.sendflag := true;
    end
    else
    begin
      close;
      ShowMessage('No shifts were found in the selected week, nothing to copy.');
    end;
  end; // with
  DisplayQuery.Requery;
  displayquery.EnableControls;
  DisplayJobs;
end;

// COPIES SCHEDULE FOR ONE PERSON FOR ONE JOB FOR ENTIRE WEEK

procedure TfSchedule.CopybtnClick(Sender: TObject);
var
  todaystr: string;

begin
  if copyoptdlg.showmodal = mrcancel then
    exit
  else
  begin
    with DisplayQuery do
    begin
      if eof and bof then
      begin
        showmessage('Nothing to copy !');
        exit;
      end;
      if copyoptdlg.radiobutton2.checked = true then
      begin
        copyarray[1] := fieldbyname('monin').asstring;
        copyarray[2] := fieldbyname('monout').asstring;
        copyarray[3] := fieldbyname('tuein').asstring;
        copyarray[4] := fieldbyname('tueout').asstring;
        copyarray[5] := fieldbyname('wedin').asstring;
        copyarray[6] := fieldbyname('wedout').asstring;
        copyarray[7] := fieldbyname('thuin').asstring;
        copyarray[8] := fieldbyname('thuout').asstring;
        copyarray[9] := fieldbyname('friin').asstring;
        copyarray[10] := fieldbyname('friout').asstring;
        copyarray[11] := fieldbyname('satin').asstring;
        copyarray[12] := fieldbyname('satout').asstring;
        copyarray[13] := fieldbyname('sunin').asstring;
        copyarray[14] := fieldbyname('sunout').asstring;
      end
      else
      begin
        todaystr := copy(DBGrid.fieldname(DBGrid.GetActiveCol), 1, 3);
        singlearray[1] := fieldbyname(todaystr + 'in').asstring;
        singlearray[2] := fieldbyname(todaystr + 'out').asstring;
      end;
      pastebtn.enabled := true;
    end;
  end;
end;

procedure TfSchedule.PastebtnClick(Sender: TObject);
var
  todaystr: string;
  i : integer;
label
  mon, tue, wed, thu, fri, sat, sun;

begin
  with DisplayQuery do
  begin
    if recordcount = 0 then
    begin
      showmessage('Please insert an employee first !');
      exit;
    end;
    edit;
    if copyoptdlg.radiobutton1.checked = true then
    begin
      todaystr := copy(DBGrid.fieldname(DBGrid.GetActiveCol), 1, 3);
      fieldbyname(todaystr + 'in').asstring := singlearray[1];
      fieldbyname(todaystr + 'out').asstring := singlearray[2];
      try
        post;         
      except
        on E: Exception do
          LogTempTableUpdateFailure(e.Message, 'PastebtnClick 01', FieldByName('UserID').Value);
      end;
      // 14551 beg
      dbgrid.setactivefield(todaystr + 'in');
      dbgridcolenter(nil);

      cfield := calcday;
      // PROCESS WHICH LEADS TO CHECKING OF OVERLAPPING SHIFTS
      with TempTable do
      begin
        requery;
        if DBGrid.getactivecol = 18 then
          DBGrid.setactivefield('sunout')
        else
        begin
          if (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), [])) then
          begin
            chkin := fieldbyname(cfield + 'in').asstring;
            chkout := fieldbyname(cfield + 'out').asstring;
          end
          else
          begin
            chkin := '';
            chkout := '';
          end;
          if (chkin <> '') and (chkout <> '') then
            overlap;
        end;
      end;
      // 14551 ends

      dbgrid.setfocus;
    end
    else
    begin
      case DBGrid.FixedCols of
        2, 3: goto mon;
        5: goto tue;
        7: goto wed;
        9: goto thu;
        11: goto fri;
        13: goto sat;
        15: goto sun
      end;
      mon: fieldbyname('monin').asstring := copyarray[1];
          fieldbyname('monout').asstring := copyarray[2];
      tue: fieldbyname('tuein').asstring := copyarray[3];
          fieldbyname('tueout').asstring := copyarray[4];
      wed: fieldbyname('wedin').asstring := copyarray[5];
          fieldbyname('wedout').asstring := copyarray[6];
      thu: fieldbyname('thuin').asstring := copyarray[7];
          fieldbyname('thuout').asstring := copyarray[8];
      fri: fieldbyname('friin').asstring := copyarray[9];
          fieldbyname('friout').asstring := copyarray[10];
      sat: fieldbyname('satin').asstring := copyarray[11];
          fieldbyname('satout').asstring := copyarray[12];
      sun: fieldbyname('sunin').asstring := copyarray[13];
          fieldbyname('sunout').asstring := copyarray[14];
      try
        post;     
      except
        on E: Exception do
          LogTempTableUpdateFailure(E.Message, 'PastebtnClick 02', FieldByName('UserID').Value);
      end;

      // 14551 beg
      for i := (DBGrid.FixedCols div 2) to 7 do
      begin
        dbgrid.setactivefield(dayarray2[i] + 'in');
        dbgridcolenter(nil);

        cfield := calcday;
        // PROCESS WHICH LEADS TO CHECKING OF OVERLAPPING SHIFTS
        with TempTable do
        begin
          requery;
          if DBGrid.getactivecol = 18 then
            DBGrid.setactivefield('sunout')
          else
          begin
            if (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), [])) then
            begin
              chkin := fieldbyname(cfield + 'in').asstring;
              chkout := fieldbyname(cfield + 'out').asstring;
            end
            else
            begin
              chkin := '';
              chkout := '';
            end;
            if (chkin <> '') and (chkout <> '') then
              overlap;
          end;
        end;
      end;
      // 14551 ends

      dbgrid.setfocus;
    end;
  end;
end;

// TAKES INPUT VALUES AND FILLS ENTIRE WEEK SCHEDULE (CURRENT RECORD)
// WITH THESE VALUES

procedure TfSchedule.fillbtnClick(Sender: TObject);
var
  i : integer;
label
  mon, tue, wed, thu, fri, sat, sun;

begin
  if (DisplayQuery.eof) and (DisplayQuery.bof) then
  begin
    showmessage('No scheduled employees - nothing to fill');
    exit;
  end;
  ffrowdlg := tffrowdlg.create(fSchedule);
  if ffrowdlg.showmodal = mrok then
  begin
    with DisplayQuery do
    begin
      edit;
      case DBGrid.FixedCols of
        2, 3: goto mon;
        5: goto tue;
        7: goto wed;
        9: goto thu;
        11: goto fri;
        13: goto sat;
        15: goto sun;
      end;
      mon: fieldbyname('monin').asstring := ffrowdlg.instr;
      fieldbyname('monout').asstring := ffrowdlg.outstr;
      tue: fieldbyname('tuein').asstring := ffrowdlg.instr;
      fieldbyname('tueout').asstring := ffrowdlg.outstr;
      wed: fieldbyname('wedin').asstring := ffrowdlg.instr;
      fieldbyname('wedout').asstring := ffrowdlg.outstr;
      thu: fieldbyname('thuin').asstring := ffrowdlg.instr;
      fieldbyname('thuout').asstring := ffrowdlg.outstr;
      fri: fieldbyname('friin').asstring := ffrowdlg.instr;
      fieldbyname('friout').asstring := ffrowdlg.outstr;
      sat: fieldbyname('satin').asstring := ffrowdlg.instr;
      fieldbyname('satout').asstring := ffrowdlg.outstr;
      sun: fieldbyname('sunin').asstring := ffrowdlg.instr;
      fieldbyname('sunout').asstring := ffrowdlg.outstr;
      try
        post;     
      except
        on E: Exception do
          LogTempTableUpdateFailure(E.Message, 'fillbtnClick', FieldByName('UserID').Value);
      end;

      // 14551 beg
      for i := (DBGrid.FixedCols div 2) to 7 do
      begin
        dbgrid.setactivefield(dayarray2[i] + 'in');
        dbgridcolenter(nil);

        cfield := calcday;
        // PROCESS WHICH LEADS TO CHECKING OF OVERLAPPING SHIFTS
        with TempTable do
        begin
          requery;
          if DBGrid.getactivecol = 18 then
            DBGrid.setactivefield('sunout')
          else
          begin
            if (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), [])) then
            begin
              chkin := fieldbyname(cfield + 'in').asstring;
              chkout := fieldbyname(cfield + 'out').asstring;
            end
            else
            begin
              chkin := '';
              chkout := '';
            end;
            if (chkin <> '') and (chkout <> '') then
              overlap;
          end;
        end;
      end;
      // 14551 ends
      dbgrid.setfocus;
      dbgrid.refresh;
    end;
  end;
  ffrowdlg.free;
end;

procedure TfSchedule.FormCreate(Sender: TObject);
begin
  log.SetModule('Schedule');

  editsch := true;
  sendflag := false;
  label52.caption := ' NOTE: Start of day for schedule is  ' + fempmnu.grace +
    '  -  Start of business day is  ' + fempmnu.roll;
  InTimeChangeHandler := false;

  if HelpExists then
    setHelpContextID(self, EMP_WEEK_SCHEDULE);

  grpBoxReports.Visible := uGlobals.IsSite;
end;


procedure TfSchedule.TxSchedule;
var
  aUserID: Int64;
  aSchin: TDateTime;
begin
  aUserID := 0;
  aSchin := now;
  try
    if (DMod1.SchdlTable.state = dsEdit) or (DMod1.SchdlTable.state = dsInsert) then
    begin
      aUserID := DMod1.SchdlTable.FieldByName('UserID').Value;
      aSchin := DMod1.SchdlTable.FieldByName('schin').AsDateTime;
      DMod1.SchdlTable.Post;   
    end;
  except
    on E: Exception do
    begin
      LogScheduleUpdateConflicts(E.Message, 'TxSchedule 01;', aUserID, aSchin);
      MessageDlg('An error with the following message:' + #13 + #34 +
        E.Message + #34 + #13 + 'has occured while trying to save the changes made' +
        ' to the database.' + #13 +
        'WARNING : The database may now be corrupted or contain innacurate data!',
        mtError, [mbOK], 0);

    end;
  end;
end;


procedure TfSchedule.DBGridCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (field.fieldname = 'WeekTotal') then
  begin
    ABrush.Color := clBtnFace;
  end;

  if dbGrid.DataSource.DataSet.FieldByName('terminated').asBoolean = True then
  begin
    if (field.fieldname <> 'WeekTotal') then
      ABrush.color := clBtnFace;
  end;
end;

procedure TfSchedule.ByNameDBText5GetText(Sender: TObject; var Text: string);
var
  s1, s2: string;

begin
  if uGlobals.UKUSmode <> 'US' then
    exit;

  if (text <> '') and (text <> 'Close') and (text <> 'Open') then
  begin
    s1 := copy(text, 1, 2);
    s2 := copy(text, 3, 3);
    if strtoint(s1) > 12 then
    begin
      s1 := inttostr(strtoint(s1) - 12);
      s2 := s2 + 'p';
    end
    else if strtoint(s1) = 12 then
    begin
      s2 := s2 + 'p';
    end
    else if strtoint(s1) = 0 then
    begin
      s1 := '12';
    end;
    text := s1 + s2;
  end;

end;

procedure TfSchedule.ByJobTypeDBText4GetText(Sender: TObject; var Text: string);
var
  s1, s2: string;
begin
  if uGlobals.UKUSmode <> 'US' then
    exit;

  if (text <> '') and (text <> 'Close') and (text <> 'Open') then
  begin
    s1 := copy(text, 1, 2);
    s2 := copy(text, 3, 3);
    if strtoint(s1) > 12 then
    begin
      s1 := inttostr(strtoint(s1) - 12);
      s2 := s2 + 'p';
    end
    else if strtoint(s1) = 12 then
    begin
      s2 := s2 + 'p';
    end
    else if strtoint(s1) = 0 then
    begin
      s1 := '12';
    end;
    text := s1 + s2;
  end;
end;

procedure TfSchedule.ByJobTypeGroupFooterBand1BeforePrint(Sender: TObject);
begin
  LstName := '';
  FirstName := '';
end;

procedure TfSchedule.ByJobTypeDetailBand1BeforePrint(Sender: TObject);
begin
  if (ByJobTypeDBText2.Text = FirstName) and (ByJobTypeDBText3.text = LstName) then
  begin
    ByJobTypeDBText3.visible := false;
    ByJobTypeDBText2.visible := false;
    ByJobtop.pen.color := clwhite;
  end
  else
  begin
    ByJobTypeDBText3.visible := true;
    ByJobTypeDBText2.visible := true;
    ByJobtop.pen.color := clblack;
  end;
  Lstname := ByJobTypeDBText3.Text;
  FirstName := ByJobTypeDBText2.Text;

end;

procedure TfSchedule.ByJobTypeStartPage(Sender: TObject);
begin
  FirstName := '';
  LstName := '';
  ByJobtop.visible := true;
  ByJobbottom.visible := true;
end;

procedure TfSchedule.ByNameDetailBand1BeforePrint(Sender: TObject);
begin
  if bynamedbtext2.text = '' then
  begin
    byNameTopL.pen.color := clwhite;
    byNameTopL.Pen.Width := 2;
  end
  else
  begin
    byNameTopL.pen.color := clblack;
    byNameTopL.Pen.Width := 1;
  end;
end;



procedure TfSchedule.ByJobTypeLabel5GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label1.Caption;
end;

procedure TfSchedule.ByJobTypeLabel6GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label2.Caption;
end;

procedure TfSchedule.ByJobTypeLabel7GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label3.Caption;
end;

procedure TfSchedule.ByJobTypeLabel8GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label4.Caption;
end;

procedure TfSchedule.ByJobTypeLabel9GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label5.Caption;
end;

procedure TfSchedule.ByJobTypeLabel10GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label6.Caption;
end;

procedure TfSchedule.ByJobTypeLabel11GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label7.Caption;
end;

procedure TfSchedule.ByNameLabel5GetText(Sender: TObject; var Text: string);
begin
  text := fSchedule.label1.Caption;
end;

procedure TfSchedule.ByNameLabel6GetText(Sender: TObject; var Text: string);
begin
  text := fSchedule.label2.Caption;
end;

procedure TfSchedule.ByNameLabel7GetText(Sender: TObject; var Text: string);
begin
  text := fSchedule.label3.Caption;
end;

procedure TfSchedule.ByNameLabel8GetText(Sender: TObject; var Text: string);
begin
  text := fSchedule.label4.Caption;
end;

procedure TfSchedule.ByNameLabel9GetText(Sender: TObject; var Text: string);
begin
  text := fSchedule.label5.Caption;
end;

procedure TfSchedule.ByNameLabel10GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label6.Caption;
end;

procedure TfSchedule.ByNameLabel11GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label7.Caption;
end;

procedure TfSchedule.JobsalStartPage(Sender: TObject);
begin
  FirstName := '';
  LstName := '';
  jobsaltop.visible := true;
end;

procedure TfSchedule.JobsalDetailBand1BeforePrint(Sender: TObject);
begin
  if (jobsalDBText1.Text = FirstName) and (jobsalDBText2.text = LstName) then
  begin
    jobsalDBText2.visible := false;
    jobsalDBText1.visible := false;
    jobsaltop.pen.color := clwhite;
  end
  else
  begin
    jobsalDBText2.visible := true;
    jobsalDBText1.visible := true;
    jobsaltop.pen.color := clblack;
  end;
  LstName := jobsalDBText2.Text;
  FirstName := jobsalDBText1.Text;
end;

procedure TfSchedule.FillAllEmps;
var
  aUserID: Int64;
begin
  with TempTable do
    begin
    Open;
    if dmod1.adoqGetAllEmployeesAndJobs.Active then
      dmod1.adoqGetAllEmployeesAndJobs.Requery
    else
      dmod1.adoqGetAllEmployeesAndJobs.Open;
    dmod1.adoqGetAllEmployeesAndJobs.first;
    while not (dmod1.adoqGetAllEmployeesAndJobs.eof) do
      begin
        if not locate('UserId;shift;RoleId',
                    VarArrayOf([dmod1.adoqGetAllEmployeesAndJobs.fieldbyname('UserId').asfloat, 1,
                                dmod1.adoqGetAllEmployeesAndJobs.fieldbyname('RoleId').asinteger]), []) then
        begin
          insert;
          fieldbyname('shift').asinteger := 1;
          fieldbyname('UserId').asfloat := dmod1.adoqGetAllEmployeesAndJobs.fieldbyname('UserId').asfloat;
          aUserID := fieldbyname('UserId').Value;
          fieldbyname('RoleId').asinteger := dmod1.adoqGetAllEmployeesAndJobs.fieldbyname('RoleId').asinteger;
          try
            post;     
          except
            on E: Exception do
              LogTempTableUpdateFailure(E.Message, 'FillAllEmps', aUserID);
          end;
        end;
        dmod1.adoqGetAllEmployeesAndJobs.next;
      end;
    end;
end; // procedure


procedure TfSchedule.JobsalLabel26GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label1.Caption;
end;

procedure TfSchedule.JobsalLabel27GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label2.Caption;
end;

procedure TfSchedule.JobsalLabel28GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label3.Caption;
end;

procedure TfSchedule.JobsalLabel29GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label4.Caption;
end;

procedure TfSchedule.JobsalLabel30GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label5.Caption;
end;

procedure TfSchedule.JobsalLabel31GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label6.Caption;
end;

procedure TfSchedule.JobsalLabel32GetText(Sender: TObject;
  var Text: string);
begin
  text := fSchedule.label7.Caption;
end;

procedure TfSchedule.lblEmployeeNameMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (button = mbright) and (ssalt in shift) and (ssshift in shift) then
  begin
    dbtext1.Visible := not (dbtext1.Visible);
  end;
end;

procedure TfSchedule.byjobtypePreviewFormCreate(Sender: TObject);
begin
  //18787
  dMod1.dopaper(TppReport(sender),uglobals.UKUSmode);
end;

procedure TfSchedule.DisplayQueryCalcFields(DataSet: TDataSet);
var
  d1, d2, d3, d4, d5, d6, d7: tdatetime;
  hr, min, sec, msec: word;
  ht, mt: integer;
begin
  with DisplayQuery do
  begin
    mt := 0;
    ht := 0;
    if IsValidTime(fieldbyname('monin').AsString) and
       IsValidTime(fieldbyname('monout').asstring) then
    begin
      d1 := (strtotime(fieldbyname('monout').asstring) -
        strtotime(fieldbyname('monin').asstring));
      if strtotime(fieldbyname('monout').asstring) <
        strtotime(fieldbyname('monin').asstring) then
        d1 := d1 + 1.0;
      decodetime(d1, hr, min, sec, msec);
      ht := ht + hr;
      mt := mt + min;
    end;
    if IsValidTime(fieldbyname('tuein').asstring) and
       IsValidTime(fieldbyname('tueout').asstring) then
    begin
      d2 := (strtotime(fieldbyname('tueout').asstring) -
        strtotime(fieldbyname('tuein').asstring));
      if strtotime(fieldbyname('tueout').asstring) <
        strtotime(fieldbyname('tuein').asstring) then
        d2 := d2 + 1.0;
      decodetime(d2, hr, min, sec, msec);
      ht := ht + hr;
      mt := mt + min;
    end;
    if IsValidTime(fieldbyname('wedin').asstring) and
       IsValidTime(fieldbyname('wedout').asstring) then
    begin
      d3 := (strtotime(fieldbyname('wedout').asstring) -
        strtotime(fieldbyname('wedin').asstring));
      if strtotime(fieldbyname('wedout').asstring) <
        strtotime(fieldbyname('wedin').asstring) then
        d3 := d3 + 1.0;
      decodetime(d3, hr, min, sec, msec);
      ht := ht + hr;
      mt := mt + min;
    end;
    if IsValidTime(fieldbyname('thuin').asstring) and
       IsValidTime(fieldbyname('thuout').asstring) then
    begin
      d4 := (strtotime(fieldbyname('thuout').asstring) -
        strtotime(fieldbyname('thuin').asstring));
      if strtotime(fieldbyname('thuout').asstring) <
        strtotime(fieldbyname('thuin').asstring) then
        d4 := d4 + 1.0;
      decodetime(d4, hr, min, sec, msec);
      ht := ht + hr;
      mt := mt + min;
    end;
    if IsValidTime(fieldbyname('friin').asstring) and
       IsValidTime(fieldbyname('friout').asstring) then
    begin
      d5 := (strtotime(fieldbyname('friout').asstring) -
        strtotime(fieldbyname('friin').asstring));
      if strtotime(fieldbyname('friout').asstring) <
        strtotime(fieldbyname('friin').asstring) then
        d5 := d5 + 1.0;
      decodetime(d5, hr, min, sec, msec);
      ht := ht + hr;
      mt := mt + min;
    end;
    if IsValidTime(fieldbyname('satin').asstring) and
       IsValidTime(fieldbyname('satout').asstring) then
    begin
      d6 := (strtotime(fieldbyname('satout').asstring) -
        strtotime(fieldbyname('satin').asstring));
      if strtotime(fieldbyname('satout').asstring) <
        strtotime(fieldbyname('satin').asstring) then
        d6 := d6 + 1.0;
      decodetime(d6, hr, min, sec, msec);
      ht := ht + hr;
      mt := mt + min;
    end;
    if IsValidTime(fieldbyname('sunin').asstring) and
       IsValidTime(fieldbyname('sunout').asstring) then
    begin
      d7 := (strtotime(fieldbyname('sunout').asstring) -
        strtotime(fieldbyname('sunin').asstring));
      if strtotime(fieldbyname('sunout').asstring) <
        strtotime(fieldbyname('sunin').asstring) then
        d7 := d7 + 1.0;
      decodetime(d7, hr, min, sec, msec);
      ht := ht + hr;
      mt := mt + min;
    end;
    DisplayQuery.fieldbyname('Weektotal').value :=
      (inttostr(ht + (mt div 60)) + '.' + copy((inttostr((mt mod 60) + 100)), 2, 2));
  end;
end;

procedure TfSchedule.DisplayQueryNewRecord(DataSet: TDataSet);
begin
  DBGrid.SetActiveField('UserId');
end;

procedure TfSchedule.DisplayQueryAfterPost(DataSet: TDataSet);
begin
  fSchedule.sendflag := true;

  // Job 18619 - These calls take too long, and end up making it difficult for the
  // user to enter times quickly.  User will need to press the recalculate button
  // in order to display updated job totals and warnings.  May be reinstated in the
  // future if we can get them to go a bit faster.  DJ 16/6/2003.
  //ReCalculate;
  //Warnings;

  // PROCESS WHICH LEADS TO CHECKING OF OVERLAPPING SHIFTS
  // CHECKS ARE PERFORMED REGARDLESS OF DIFFERING JOB TYPES.
  // CONSECUTIVE SHIFTS WHICH END AND SUBSEQUENTLY START IN THE SAME MINUTE
  // ARE DEEMED TO BE ALLOWABLE
  // NO CHECKING IS PERFORMED BETWEEN LAST DAY OF WEEK AND START OF FOLLOWING
  // WEEK OR END OF PREVIOUS WEEK AND START OF CURRENT WEEK
  cfield := calcday;
  with TempTable do
  begin
    requery;
    if DBGrid.getactivecol = 18 then
      DBGrid.setactivefield('sunout')
    else
    begin
      if cfield <> 'rol' then
      begin
        if (locate('UserId;RoleId;shift', vararrayof([CurrUserId, CurrRoleId, CurrShift]), [])) then
        begin
          chkin := fieldbyname(cfield + 'in').asstring;
          chkout := fieldbyname(cfield + 'out').asstring;
        end
        else
        begin
          chkin := '';
          chkout := '';
        end;
        if (chkin <> '') and (chkout <> '') then
        overlap;
      end;

    end;
  end; { with TempTable }
end;

procedure TfSchedule.DisplayQueryBeforeEdit(DataSet: TDataSet);
begin
  if editsch = true then
  begin
    editsch := false;
    // log the action..
    fempmnu.loglist.items.clear;
    with fempmnu.loglist.items do
    begin
      add('Edit Schedule started;');
    end;
    fempmnu.LogInfo;
    // end of logging..
  end;
end;

//Empty Schedule....
procedure TfSchedule.btnEmptyScheduleClick(Sender: TObject);
begin
  if MessageDlg('All records in the current schedule will be deleted!' +
  #13 + 'These records cannot be recovered.' + #13 +
  'Are you sure you wish to delete the current schedule? YES/NO?', mtConfirmation, [mbYes, mbNo]
    , 0) = mrYes then
  begin
    with qryRun do
    begin
      close;
      sql.Clear;
      sql.Add('update #tmpschdl set "deleted" = ''Y'', "shift" = ("shift" - 1000)');
      try
        execSQL;   
      except
        on E: Exception do
          LogTempTableUpdateFailure(E.Message, 'btnEmptyScheduleClick', 0);
      end;
    end;

    inc(userempty);
    opstring := opstring + 'EMPTY';

    fSchedule.sendflag := true;
    DisplayQuery.Requery;
    DisplayJobs;
  end;
end;

procedure TfSchedule.sbExpTakeClick(Sender: TObject);
begin
  fExpTake := TfExpTake.Create(self);
  fExpTake.lblWeek.Caption := formatDateTime('ddd ' + shortdateformat, monstr) + ' -- ' +
    formatDateTime('ddd ' + shortdateformat, monstr + 6);
  fExpTake.lblCurVal.Caption := lblExpTake.Caption;

  if fExpTake.ShowModal = mrOK then
  begin
    with tblRun do
    begin
      close;
      tablename := 'exptake';
      open;

      if locate('sitecode;wstart', VarArrayOf([vSiteCode, monstr]), []) then
      begin
        edit;
        FieldByName('value').asfloat := fExpTake.newvalue;
        FieldByName('lmby').asstring := CurrentUser.UserName;
        FieldByName('lmdt').asdatetime := Now;
        post;     
      end
      else
      begin
        insert;
        FieldByName('sitecode').asinteger := vSiteCode;
        FieldByName('wstart').asdatetime := monstr;
        FieldByName('value').asfloat := fExpTake.newvalue;
        FieldByName('lmby').asstring := CurrentUser.UserName;
        FieldByName('lmdt').asdatetime := Now;
        post;
      end;
      close;
    end;

    SetExpTake(False);
    ReCalculate;
  end;

  fExpTake.free;
end;

procedure TfSchedule.ppDBText2Format(Sender: TObject;
  DisplayFormat: String; DataType: TppDataType; Value: Variant;
  var Text: String);
begin
  if Value <> NULL then
    Text := formatfloat('00.00', Value);
end;

procedure TfSchedule.ppDBText2GetText(Sender: TObject; var Text: String);
begin
  Text := StringReplace(Text, '.', ':', []);
end;

procedure TfSchedule.DisplayQueryWeekTotalGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := StringReplace(DisplayQueryWeekTotal.asstring, '.', ':', []);
end;

//15096 -3
procedure TfSchedule.sprevertClick(Sender: TObject);
begin
  if mrOK=messagedlg('Are you sure you want to revert to the Aztec generated "Expected Takings" figure',
  mtinformation,[mbOK,mbCancel],0) then
  begin
    SetExpTake(True);

    with tblrun do
    begin
      close;
      tablename := 'exptake';
      open;
      if locate('sitecode;wstart',vararrayof([vsitecode,monstr]),[]) then
      begin
        edit;
        Fieldbyname('Value').asfloat := exptake;
        fieldbyname('lmby').asstring := CurrentUser.UserName;
        fieldbyname('lmdt').asdatetime := now;
        post;    
      end;
      ReCalculate;
    end;
  end;

end;

procedure TfSchedule.DisplayQueryBeforeOpen(DataSet: TDataSet);
begin
  {restore defaults to the table that is looked up to find emp. names}
  //dmod1.wwtEmployee.close;
  //dmod1.wwtEmployee.indexname := '';
  //dmod1.wwtEmployee.filtered := false;
  //dmod1.wwtEmployee.open;
  dmod1.wwtac_User.open;
  dmod1.wwtac_Role.open;
end;

procedure TfSchedule.DisplayQueryAfterClose(DataSet: TDataSet);
begin
  //dmod1.wwtEmployee.close;
  dmod1.wwtac_User.close;
  dmod1.wwtac_Role.close;
end;

procedure TfSchedule.DisplayQueryAfterEdit(DataSet: TDataSet);
begin
  inc(useredit);
end;

procedure TfSchedule.DBGridKeyPress(Sender: TObject; var Key: Char);
begin
  // if this emp has been terminated do not allow any typing
  if (dbGrid.DataSource.DataSet.FieldByName('terminated').AsBoolean = True) or
     (dbGrid.DataSource.DataSet.FieldByName('LeftJob').AsBoolean = True) then
  begin
    if (key < #33) or (key > #126) then
      exit;

    messagedlg('This Employee has been terminated or no longer works the assigned job!' + #13 +
      'No more schedule times can be entered for this employee.', mterror, [mbok], 0);
    key := #0;
    exit;
  end;
end;

procedure TfSchedule.DisplayQueryAfterScroll(DataSet: TDataSet);
begin
  with Dataset do
  begin
    if FieldByName('terminated').asBoolean = True then
    begin
      pastebtn.Visible := False;
      fillbtn.Visible := False;
      lblEmployeeName.Caption := 'Terminated Employee';
      lblEmployeeName.Color := clBlack;
      lblEmployeeName.Font.Color := clYellow;
      lblEmployeeName.Font.Style := [fsBold];
    end
    else
    begin
      pastebtn.Visible := True;
      fillbtn.Visible := True;
      lblEmployeeName.Caption := 'Employee Name';
      lblEmployeeName.Color := clBtnFace;
      lblEmployeeName.Font.Color := clBlack;
      lblEmployeeName.Font.Style := [];
    end;
  end;
end;

procedure TfSchedule.DisplayQueryAfterOpen(DataSet: TDataSet);
begin
  with Dataset do
  begin
    if FieldByName('terminated').asBoolean = True then
    begin
      pastebtn.Visible := False;
      fillbtn.Visible := False;
      lblEmployeeName.Caption := 'Terminated Employee';
      lblEmployeeName.Color := clBlack;
      lblEmployeeName.Font.Color := clYellow;
      lblEmployeeName.Font.Style := [fsBold];
    end
    else
    begin
      pastebtn.Visible := True;
      fillbtn.Visible := True;
      lblEmployeeName.Caption := 'Employee Name';
      lblEmployeeName.Color := clBtnFace;
      lblEmployeeName.Font.Color := clBlack;
      lblEmployeeName.Font.Style := [];
    end;
  end;
end;

procedure TfSchedule.DBGridExit(Sender: TObject);
begin
  if (dbGrid.DataSource.DataSet.State = dsEdit) or
    (dbGrid.DataSource.DataSet.State = dsInsert) then
  begin
    try
      dbGrid.DataSource.DataSet.Post;
    except
      on E: Exception do
        LogTempTableUpdateFailure(E.Message, 'DBGridExit', dbGrid.DataSource.DataSet.FieldByName('UserID').Value);
    end;
  end;
end;

procedure TfSchedule.ppLabel24Print(Sender: TObject);
begin
  if byJobType.PageNo = 1 then
    ppLabel24.Visible := True
  else
    ppLabel24.Visible := False;
end;

procedure TfSchedule.DisplayQueryTimeChange(Sender: TField);
var
  hrstr : string;
  TimeField : TStringField;
begin
  if InTimeChangeHandler then exit;

  InTimeChangeHandler := true;
  try
    //job 328432
    if (DisplayQuery.FieldByName('terminated').AsBoolean = True) or
       (dbGrid.DataSource.DataSet.FieldByName('LeftJob').AsBoolean = True) then
       exit;

    TimeField := TStringField(Sender);

    case length(TimeField.Value) of //.InPlaceEditor.Text) of
      1: //Accepts 'c' as Close time, 'o' as open time
        if (TimeField.Value = 'o') or // open?
           (TimeField.Value = 'O') then
        begin
          if wwtopclose.locate('tday', dayofweek(currday), []) and
             IsValidTime(wwtopclose.fieldbyname('open').asstring) then
          begin
            // put open time in table
            TimeField.Value := wwtopclose.fieldbyname('open').asstring;
            SetOpenFlag;
          end
          else
          begin
            // no open time in wwtopclose (OpenTime.db)
            messagedlg('No Open time is specified for this day', mterror, [mbok], 0);
            DisplayQuery.fieldbyname(dbgrid.fieldname(dbgrid.getactivecol)).asstring := '';
          end;
        end

        else if (TimeField.Value = 'c') or //not open,is it close?
                (TimeField.Value = 'C') then
        begin
          if wwtopclose.locate('tday', dayofweek(currday), []) and
             IsValidTime(wwtopclose.fieldbyname('close').asstring) then
          begin
            // put close time in table
            TimeField.Value := wwtopclose.fieldbyname('close').asstring;
            SetCloseFlag;
          end
          else
          begin
            // no close time in wwtopclose (OpenTime.db)
            messagedlg('No Close time is specified for this day', mterror, [mbok], 0);
            TimeField.Value := '';
          end;

        end

        else // not open, not close, something else...
        begin
          messagedlg(dbgrid.inplaceeditor.text + ' is not a valid time !', mterror, [mbok], 0);
          TimeField.Value := '';
        end;

      3: //Auto add '00' minutes
        begin
          hrstr := copy(TimeField.Value, 1, 2);
          if strtoint(hrstr) > 23 then
          begin
            messagedlg((hrstr) + ' is not a valid hour !', mterror, [mbok], 0);
            TimeField.Value := '';
          end
          else
          begin
            TimeField.Value := TimeField.Value + '00';
          end;
          ResetOpenCloseFlags;
        end;

      else // Check time is valid
        begin
          if (TimeField.Value <> '') and not IsValidTime(TimeField.Value) then
          begin
            messagedlg(TimeField.Value + ' is not a valid time !', mterror, [mbok], 0);
            TimeField.Value := '';
            errflag := true;
          end;
          ResetOpenCloseFlags;
        end;
    end; { case length(dbgrid.InPlaceEditor.Text) }

  finally
    InTimeChangeHandler := false;
  end;
end;

procedure TfSchedule.btnScheduleReportClick(Sender: TObject);
begin
  DMod1.DimReport(CurrentUser.UserName, CurrentUser.Password, 'Time & Attendance', TbitBtn(Sender).Name,
               monstr, monstr + 6);
end;

procedure TfSchedule.lblJobNameClick(Sender: TObject);
begin
  lblJobName.Font.Style := [fsBold];
  lblEmployeeName.Font.Style := [];
  FSortOrder := 2; // order by JobID
  DisplayJobs;
end;

procedure TfSchedule.lblEmployeeNameClick(Sender: TObject);
begin
  lblJobName.Font.Style := [];
  lblEmployeeName.Font.Style := [fsBold];
  FSortOrder := 1; // order by SEC
  DisplayJobs;
end;

procedure TfSchedule.LogScheduleUpdateConflicts(errorMessage: String; debugStr: String; aUserID: Int64; aSchin: TDateTime);
var
  i: integer;
  CurrSchedule: TADODataSet;

const
  ConflictError = 'Row cannot be located for updating';
begin
  try
    if (copy(errorMessage, 0, Length(ConflictError)) = ConflictError) then
    begin

      diagLog.Event('Conflict occurred saving changes in the dMod1.SchdlTable (Schedule table) to the database. Details below:');
      diagLog.Event('Notes:(1) ORIGINAL=Value initially read from DB, DB NOW = Value currently in DB, NEW=Value currently set in HR Schedule');
      diagLog.Event('      (2) Only conflicting fields (where ORIGINAL is different from DB NOW) are listed');

      CurrSchedule := TADODataSet.Create(nil);
      try
        try
          CurrSchedule.Connection := dmADO.AztecConn;
          CurrSchedule.CommandText := 'SELECT * FROM Schedule where SiteCode = ' + IntToStr(fSchedule.vSiteCode) +
                                      ' AND UserID = ' + IntToStr(aUserID) + ' AND schin = ' + QuotedStr(FormatDateTime('yyyymmdd hh:nn', aSchin));
          CurrSchedule.Open;

          with dmod1.SchdlTable do
            for i := 0 to Fields.Count-1 do
              if (Fields[i].FieldKind = fkData) then
              begin
                if (Fields[i].DataType = ftLargeInt) then
                begin
                  if (VarToStr(fields[i].OldValue) <> VarToStr(CurrSchedule.FieldByName(Fields[i].FieldName).CurValue)) then
                    diagLog.Event('  [' + Fields[i].FieldName + ']' +
                      ' ORIGINAL: "'+ VarToStr(Fields[i].OldValue) + '"' +
                      ' DB NOW: "'  + VarToStr(CurrSchedule.FieldByName(Fields[i].FieldName).CurValue) + '"' +
                      ' NEW: "'    + VarToStr(Fields[i].NewValue) + '"');
                end
                else
                begin
                  if(Fields[i].OldValue <> CurrSchedule.FieldByName(Fields[i].FieldName).CurValue) then
                    diagLog.Event('  [' + Fields[i].FieldName + ']' +
                      ' ORIGINAL: "'+ VarToStr(Fields[i].OldValue) + '"' +
                      ' DB NOW: "'  + VarToStr(CurrSchedule.FieldByName(Fields[i].FieldName).CurValue) + '"' +
                      ' NEW: "'    + VarToStr(Fields[i].NewValue) + '"');
                end;
              end;
          CurrSchedule.Close;
        except
          on e: Exception do
            diagLog.Event('Error in LogClientEntityTableUpdateConflicts: ' + E.ClassName + ' ' + E.Message);
        end;
      finally
        CurrSchedule.Free;
      end;
    end
    else
    begin
      diagLog.Event('Unexpected Error: ' + errorMessage);
    end;
  finally
    debugStr := StringReplace(debugStr,';', #13#10#10, [rfReplaceAll]);
    diagLog.Event('R&D Diagnostic Info: To find where the problem happened in the code search for the last string in this list:' + #13#10#10 +
                  debugStr);
    ShowMessage('Failed to save changes to the schedule table for EmployeeId ' + VarToStr(aUserID) + ', Scheduled In date/time ' + VarToStr(aSchin) + #13#10 +
                  'Your changes have been undone.'#13#10#13#10 +
                  'Error message: ' +errorMessage);
  end;
end;


procedure TfSchedule.LogTempTableUpdateFailure(errorMessage: String; debugStr: String; aUserID: Int64; Alert: Boolean = True);
begin
  diagLog.Event('R&D Diagnostic Info: To find where the problem happened in the code search for this string "' + debugStr + '"');
  if Alert then
    ShowMessage('Failed to update the temporary table with changes for EmployeeID ' + VarToStr(aUserID));
end;

procedure TfSchedule.evntMouseWheelCatcherMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if (Msg.message = WM_MOUSEWHEEL) and
    (ActiveControl is TwwDBLookupCombo) then
    ConvertMouseWheelMessageToCursorKey(Msg, Handled);
end;

end.

