unit dRunSP;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmRunSP = class(TDataModule)
    SPconn: TADOConnection;
    adoqRunSP: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    theUDL, UserPass : string;
  end;

var
  dmRunSP: TdmRunSP;

implementation

uses dADOAbstract, uADO, uAztecDatabaseUtils;

{$R *.dfm}

procedure TdmRunSP.DataModuleCreate(Sender: TObject);
begin
  SetUpAztecADOConnection(spConn);
end;

end.

