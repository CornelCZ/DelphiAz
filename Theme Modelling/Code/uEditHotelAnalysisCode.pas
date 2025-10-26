unit uEditHotelAnalysisCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uEditGenericDetails, StdCtrls;

type
  TEditHotelAnalysisCode = class(TEditGenericDetails)
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodeID: integer;
  end;

var
  EditHotelAnalysisCode: TEditHotelAnalysisCode;

implementation

uses
  uAztecLog, uDMThemeData;

{$R *.dfm}

procedure TEditHotelAnalysisCode.btOkClick(Sender: TObject);
var
  TrimmedName: String;
begin
  ButtonClicked(Sender);
  TrimmedName := Trim(edName.Text);
  if (TrimmedName = '') then
    raise Exception.create('Please specify a code');

  if not dmThemeData.CheckAnalysisCodeUnique(CodeID, TrimmedName) then
    raise Exception.Create(Format('The code %s already exists in another Hotel Analysis Code record, it may be a deleted record.',
                                  [QuotedStr(TrimmedName)]));

  modalresult := mrOk;
end;

end.
