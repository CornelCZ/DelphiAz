unit uADO;

interface

uses
  SysUtils, Classes, DB, ADODB, Forms, ppReport, ppViewr, dADOAbstract;

type
  TdmADO = class(TdmADOAbstract)
    adoqRun2: TADOQuery;
    procedure ALLRepsPreviewFormCreate(Sender: TObject; papname : string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LogError(Error: string); override;
  end;

var
  dmADO: TdmADO;

implementation

uses ulog, ppForms, ppProd, ppClass, uSetupRBuilderPreview;

{$R *.dfm}

procedure TDMADO.ALLRepsPreviewFormCreate(Sender: TObject; papname : string);
begin
  TppReport(Sender).PrinterSetup.PaperName := papname;
  SetupRBuilderPreview(TppReport(Sender));
end;

procedure TdmADO.LogError(Error: string);
begin
  Log.Event(Error);
end;

end.
