unit WmiException;

interface
{$I DEFINE.INC}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

Uses Windows, SysUtils, WbemScripting_TLB, ActiveX, ComObj;

type
  TWmiException = class(Exception);

procedure CreateWmiException(AError: integer);

implementation

procedure CreateWmiException(AError: integer);
begin
  raise TWmiException.Create('Error code: ' + IntToStr(AError));
end;


end.
