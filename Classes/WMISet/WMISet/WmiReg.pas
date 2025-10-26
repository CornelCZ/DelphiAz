unit WmiReg;

interface

procedure Register;

implementation
                     
Uses Classes, WmiAbstract, WmiProcessControl, WmiStorageInfo,
     AdsBrowser, WmiDiskQuotaControl, WmiConnection, WmiDataSet,
     WmiRegistry, WmiOs, WmiSystemEvents, WmiMethod;

{$R WmiProcessControl.dcr}
{$R WmiStorageInfo.dcr}
{$R AdsBrowser.dcr}
{$R WmiDiskQuotaControl.dcr}
{$R WmiConnection.dcr}
{$R WmiDataSet.dcr}
{$R WmiRegistry.dcr}
{$R WmiOs.dcr}
{$R WmiSystemEvents.dcr}
{$R WmiMethod.dcr}

const cnstSectionName = 'WmiSet';

procedure Register;
begin
  RegisterComponents(cnstSectionName, [TWmiProcessControl]);
  RegisterComponents(cnstSectionName, [TWmiStorageInfo]);
  RegisterComponents(cnstSectionName, [TWmiDiskQuotaControl]);
  RegisterComponents(cnstSectionName, [TWmiConnection]);
  RegisterComponents(cnstSectionName, [TWmiQuery]);
  RegisterComponents(cnstSectionName, [TWmiRegistry]);
  RegisterComponents(cnstSectionName, [TWmiOs]);
  RegisterComponents(cnstSectionName, [TWmiSystemEvents]);
  RegisterComponents(cnstSectionName, [TWmiMethod]);
//  RegisterComponents(cnstSectionName, [TAdsBrowser]);

end;

end.
