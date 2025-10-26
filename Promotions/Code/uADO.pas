unit uADO;

interface

// This unit/data module is a dummy file created due to frmPassword's reliance
// on a data module named dmADO, in unit uADO. Long term, this needs to be replaced
// i.e. with a parameter in the interface to frmPassword.

// PW: This unit was updated to act as a shim to allow common utilities to access
// an instance of TdmADOAbstract. Used to be that all modules had a dmAdo...
// Long term the common functions (in this case those from uGenerateUniqueId)
// could be changed to require a connection to be passed in.

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dADOAbstract, DB, ADODB, udmPromotions;

type
  TdmADO = class(TdmADOAbstract)
    procedure DataModuleCreate(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmADO: TdmADO;

implementation

{$R *.dfm}

procedure TdmADO.DataModuleCreate(Sender: TObject);
begin
  self.AztecConn := dmPromotions.AztecConn;
end;

end.
