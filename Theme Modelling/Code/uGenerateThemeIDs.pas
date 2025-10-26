unit uGenerateThemeIDs;

interface

uses sysutils, adodb, db;

type
{
  Theme - ThemeId: int
  ThemePanelDesign - PanelDesignID: int
  ThemeTablePlan - TablePlanID: int

  ThemeOutletTablePlan - OutletTablePlanID: bigint
  ThemeEposPrinter - PrinterID: bigint
  ThemeOutletTablePlanButton - ButtonID: bigint
  ThemeOutletTablePlanLabel - LabelID: bigint
  ThemePanel - PanelID: bigint
  ThemePanelButton - ButtonID: bigint
  ThemePanelLabel - LabelID: bigint
}
  TThemeIDCategory =
    (scTheme, scThemeOutletTablePlan, scThemePanelDesign, scThemeTablePlan,
    scThemeEposPrinter, scThemeOutletTablePlanButton, scThemeOutletTablePlanLabel,
    scThemePanel, scThemePanelButton, scThemePanelLabel, scThemeDialogSecurity, scThemePanelButtonTimedSecurity,
    scThemeDiscount, scThemeCloakroomSequence,scThemeDialogueTimedSecurity,
    scThemeReason, scThemeHotelDivision, scThemeSwipeCardRange, scThemeDriveThruQueue, scThemeDriveThruButton, scThemeDriveThruLabel,
    scMacro, scThemeEposDevice, scThemeDefaultPanelCycle, scThemeDefaultPanelTimes, scThemeSwipeCardException,
    scThemeSwipeCardExceptionRange, scThemeCloakroomImage, scThemeDefaultJobPanel, scThemeDefaultJobPanelRole, scThemeSwipeCardGroup, scThemeSwipeCardGroupRange,
    scThemeScrollingMessageOverride, scThemeStandardFooterOverride, scThemeBillFooterOverride,
    scThemeSiteAutoSendToEPoS, scThemeCustomerInformationPrompt);

function GetNewId(category: TThemeIDCategory): int64;

implementation

uses uAdo;

// TO  DO
// read new seeds from seed table, checking

function GetNewId(category: TThemeIDCategory): int64;
var
  MinRange, MaxRange: int64;
  TableName, FieldName: string;
  qSeed: TAdoQuery;
begin
  result := -1;
  // bigints have range 0 to 9223372036854775807
  // ints have range 0 to 2147483647
  case category of
    scTheme: begin TableName := 'Theme_repl'; FieldName := 'ThemeId' end;
    scThemeOutletTablePlan: begin TableName := 'ThemeOutletTablePlan_repl'; FieldName := 'OutletTablePlanId' end;
    scThemePanelDesign: begin TableName := 'ThemePanelDesign_repl'; FieldName := 'PanelDesignId' end;
    scThemeTablePlan: begin TableName := 'ThemeTablePlan_repl'; FieldName := 'TablePlanID' end;
    scThemeEposPrinter: begin TableName := 'ThemeEposPrinter_repl'; FieldName := 'PrinterId' end;
    scThemeOutletTablePlanButton: begin TableName := 'ThemeOutletTablePlanButton_repl'; FieldName := 'ButtonId' end;
    scThemeOutletTablePlanLabel: begin TableName := 'ThemeOutletTablePlanLabel_repl'; FieldName := 'LabelId' end;
    scThemePanel: begin TableName := 'ThemePanel_repl'; FieldName := 'PanelId' end;
    scThemePanelButton: begin TableName := 'ThemePanelButton_repl'; FieldName := 'ButtonId' end;
    scThemePanelLabel: begin TableName := 'ThemePanelLabel_repl'; FieldName := 'LabelId' end;
    scThemeDialogSecurity: begin TableName := 'ThemeDialogSecurity_repl'; FieldName := 'SecurityID' end;
    scThemePanelButtonTimedSecurity: begin TableName := 'ThemePanelButtonTimedSecurity_repl'; FieldName := 'TimedSecurityID' end;
    scThemeDiscount: begin TableName := 'Discount_repl'; FieldName := 'DiscountID' end;
    scThemeCloakroomSequence: begin TableName := 'ThemeCloakroomSequence_repl'; FieldName := 'CloakroomSequenceID' end;
    scThemeDialogueTimedSecurity: begin TableName := 'ThemeDialogTimedSecurity_Repl'; FieldName := 'TimedSecurityID' end;
    scThemeReason: begin TableName := 'ThemeReason_repl'; FieldName := 'ReasonID' end;
    scThemeHotelDivision: begin TableName := 'ThemeHotelDivision_repl'; FieldName := 'HotelDivisionID' end;
    scThemeSwipeCardRange: begin TableName := 'ThemeSwipeCardRange_repl'; FieldName := 'SwipeCardRangeID' end;
    scThemeDriveThruButton: begin TableName := 'ThemeOutletDriveThruButton_repl'; FieldName := 'ButtonID' end;
    scThemeDriveThruLabel: begin TableName := 'ThemeOutletDriveThruLabel_repl'; FieldName := 'LabelID' end;
    scThemeEposDevice: begin TableName := 'ThemeEposDevice_repl'; FieldName := 'EPoSDeviceID' end;
    scMacro: begin TableName := 'ThemePanelDesignMacro_repl'; FieldName := 'MacroID' end;
    scThemeDefaultPanelCycle: begin TableName := 'ThemeDefaultPanelCycles_Repl'; FieldName := 'ID' end;
    scThemeDefaultPanelTimes: begin TableName := 'ThemeDefaultPanelCycleTimes_repl'; FieldName := 'ID' end;
    scThemeSwipeCardException: begin TableName := 'ThemeSwipeCardExceptions_Repl'; FieldName := 'ExceptionID' end;
    scThemeSwipeCardExceptionRange: begin TableName := 'ThemeSwipeCardExceptionRange_Repl'; FieldName := 'RangeID' end;
    scThemeCloakroomImage: begin TableName := 'ThemeCloakroomImage_Repl'; FieldName := 'CloakroomImageID' end;
    scThemeDefaultJobPanel: begin TableName := 'ThemeDefaultRolePanel_Repl'; FieldName := 'DefaultID' end;
    scThemeDefaultJobPanelRole: begin TableName := 'ThemeDefaultRolePanelRoles_Repl'; FieldName := 'ID' end;
    scThemeSwipeCardGroup: begin TableName := 'ThemeSwipeCardGroups_Repl'; FieldName := 'GroupID' end;
    scThemeSwipeCardGroupRange: begin TableName := 'ThemeSwipeCardGroupRange_Repl'; FieldName := 'RangeID' end;
    scThemeScrollingMessageOverride: begin TableName := 'ThemeScrollingMessageOverride_Repl'; FieldName := 'Id' end;
    scThemeStandardFooterOverride: begin TableName := 'ThemeReceiptFooterOverride_Repl'; FieldName := 'Id' end;
    scThemeBillFooterOverride: begin TableName := 'ThemeBillFooterOverride_repl'; FieldName := 'Id' end;
    scThemeSiteAutoSendToEPoS: begin TableName := 'ThemeSiteAutoSendToEPoS'; FieldName := 'Revision' end;
    scThemeCustomerInformationPrompt: begin TableName := 'ThemeCustomerInformationPrompts_repl'; FieldName := 'id' end;
  end;
  case Category of
    scTheme, scThemePanelDesign, scThemeTablePlan, scThemeDialogSecurity, scThemeDiscount, scThemeCloakroomSequence,
    scThemeReason, scThemeHotelDivision, scMacro, scThemeCloakroomImage, scThemeScrollingMessageOverride,
    scThemeStandardFooterOverride, scThemeBillFooterOverride, scThemeSiteAutoSendToEPoS, scThemeCustomerInformationPrompt:
    MaxRange := 2147483647
  else
    MaxRange := 9223372036854775807;
  end;
  case category of
    scThemePanel: MinRange := 100000;
    scThemePanelButton: MinRange := 10000;
    scThemePanelLabel: MinRange := 10000;
    scThemePanelDesign: MinRange := 100;
    scThemeDialogSecurity: MinRange := 100000;
  else
    MinRange := 1;
  end;

  qSeed := TAdoQuery.Create(nil);
  try
    qSeed.Connection := dmAdo.AztecConn;

    qSeed.SQL.Text :=
      format(
        'declare @output bigint '+
        'exec getnextuniqueid  %s, %s, %d, %d, @NextID = @output OUTPUT '+
        'select @output as Output', [quotedstr(TableName), quotedstr(FieldName), MinRange, MaxRange]);
    try
      qSeed.Open;
    except on E:Exception do
      raise Exception.create('Could not generate unique ID for save operation');
    end;
    result := TLargeIntField(qseed.fieldbyname('Output')).aslargeint;
    qSeed.close;
  finally
    qSeed.Free;
  end;
end;

end.
