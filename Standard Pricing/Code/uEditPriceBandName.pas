unit uEditPriceBandName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEditPriceBandNameForm = class(TForm)
    Edit1: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    procedure btnOkClick(Sender: TObject);
  private
    bandLetter: string;
    bandName: string;
    newBandName: string;
    MatrixID: Integer;
    MatrixName: String;
    function NameIsBandLetter(var theBandName: String; var isOwnBand: boolean): boolean;
    function NameUsedByOtherPriceBand(const theBandName: string): boolean;
    function NameIsValid(const theBandName: string; var FailureReason: string): boolean;
    function NameIsAlpha(const theBandName: string): boolean;
  public
    constructor Create(AOwner: TComponent; aBandLetter: string; _MatrixID: Integer; _MatrixName: String); reintroduce;
  end;

procedure EditPriceBandName (Aowner: TComponent; aBandLetter: string; MatrixID: Integer; MatrixName: String);
function GetDisplayLabel(bandLetter: string; MatrixID: Integer): string;

implementation

uses uADO, uPricingLog;

const
  MODULE_NAME = 'Edit Price Band Name';

{$R *.dfm}

procedure EditPriceBandName (AOwner: TComponent;
  aBandLetter: string;
  MatrixID: Integer;
  MatrixName: String);
begin
  with TEditPriceBandNameForm.Create(AOwner, aBandLetter, MatrixID, MatrixName) do
  try
    ShowModal;
  finally
    Free;
  end;
end;


function GetDisplayLabel(bandLetter: string; MatrixID: Integer): string;
begin
  with dmADO.ADOqRun do
  try
    Close;
    SQL.Text := Format('SELECT Displayname FROM PriceBandNames WHERE Band = %s AND MatrixID = %d',
                       [QuotedStr(bandLetter), MatrixID]);
    Open;
    if Fields[0].AsString <> '' then
      Result := Fields[0].AsString
    else
      Result := bandLetter;
  finally
    Close;
  end;
end;


constructor TEditPriceBandNameForm.Create(AOwner: TComponent; aBandLetter: string; _MatrixID: Integer; _MatrixName: String);
begin
  inherited Create(AOwner);
  bandLetter := aBandLetter;
  bandName := GetDisplayLabel(bandLetter, MatrixID);
  MatrixName := _MatrixName;
  MatrixID := _MatrixID;
  Label1.Caption := 'Enter a new name for price band ' + bandName;
  Edit1.Text := bandName;
end;


function TEditPriceBandNameForm.NameIsBandLetter(var theBandName: string; var isOwnBand: boolean): boolean;
begin
  //A one or two character name will match one of the default band names A..Z, AA..AZ,..., ZA..ZZ.
  if ((length(theBandName) = 1) or (length(theBandName) = 2)) and NameIsAlpha(theBandName) then
  begin
    Result := TRUE;
    isOwnBand := UpperCase(theBandName) = bandLetter;
    if isOwnBand then
      theBandName := UpperCase(theBandName);
  end
  else
    Result := FALSE;
end;

function TEditPriceBandNameForm.NameUsedByOtherPriceBand(const theBandName: string): boolean;
begin
    with dmADO.ADOqRun do
    try
      Close;
      SQL.Text := Format('SELECT COUNT(*) AS Count FROM PriceBandNames ' +
                         'WHERE DisplayName = %s AND Band <> %s ' +
                         'AND MatrixID = %d',
                         [QuotedStr(theBandName), QuotedStr(bandLetter), MatrixID]);
      Open;
      Result := (FieldByName('Count').AsInteger > 0);
    finally
      Close;
    end;
end;


function TEditPriceBandNameForm.NameIsValid(const theBandName: string; var FailureReason: string): boolean;
begin
  Result := FALSE;
  FailureReason := '';
  if ((pos('[', theBandName) > 0) or (pos(']', theBandName) > 0)) then FailureReason := 'contains a square bracket' + #13#10;
  if (pos('%', theBandName) > 0) then FailureReason := FailureReason + 'contains a percent sign' + #13#10;
  if (pos('_', theBandName) > 0) then FailureReason := FailureReason + 'contains an underscore' + #13#10;
  if (pos('..', theBandName) > 0) then FailureReason := FailureReason + 'contains ".."' + #13#10;
  if (Length(FailureReason) = 0) then
    Result := TRUE;
end;

function TEditPriceBandNameForm.NameIsAlpha(const theBandName: string): boolean;
var
  theChar: Char;
  i: SmallInt;
  HasNonAlphaChar: Boolean;
begin
  HasNonAlphaChar := FALSE;
  for i := 1 to Length(theBandName) do
  begin
    theChar := theBandName[i];
    if not (theChar in ['A'..'Z','a'..'z']) then
      HasNonAlphaChar := TRUE;
  end;
  Result := not HasNonAlphaChar;
end;

procedure TEditPriceBandNameForm.btnOkClick(Sender: TObject);
var
  FailureReason: string;
  isOwnBand: boolean;
begin
  newBandName := Edit1.Text;

  if not NameIsValid(newBandName, FailureReason) then
  begin
    ShowMessage(Format('The name %s is invalid because it:'#13#10#10'%s',
                       [QuotedStr(newBandName),FailureReason]));
    Exit;
  end;

  newBandName := Trim(newBandName);

  if NameIsBandLetter(newBandName, isOwnBand) then
    if not isOwnBand then
    begin
      ShowMessage(Format('The name %s is the band letter of another price band.',[QuotedStr(newBandName)]));
      Exit;
    end;

  if NameUsedByOtherPriceBand(newBandName) then
    ShowMessage(Format('The name %s is used by another price band.',[QuotedStr(newBandName)]))
  else
  begin

    try
      if (newBandName = bandLetter) or (newBandName = '') then
      begin
        //Reset to band letter
        Log.Event(MODULE_NAME, Format('Resetting band %s in price matrix %s.  name was %s.',
                                      [QuotedStr(bandLetter),QuotedStr(MatrixName),QuotedStr(BandName)]));
        dmADO.adocRun.CommandText := Format('DELETE FROM PriceBandNames ' +
                                            'WHERE Band = %s AND MatrixID = %d',
                                            [QuotedStr(bandLetter),MatrixID]);
        dmADO.adocRun.Execute;
      end
      else
      begin
        //Save new band name
        Log.Event(MODULE_NAME, Format('Renaming band %s in price matrix %s.  New name is %s (was %s).',
                                      [QuotedStr(bandLetter),QuotedStr(MatrixName),QuotedStr(newBandName),QuotedStr(BandName)]));
        dmADO.adocRun.CommandText :=
         Format('IF EXISTS(SELECT * FROM PriceBandNames WHERE Band = %0:s AND MatrixID = %1:d) ' +
                 '  UPDATE PriceBandNames SET Displayname = %2:s WHERE Band = %0:s AND MatrixID = %1:d '+
                 'ELSE ' +
                 '  INSERT INTO PriceBandNames VALUES(%1:d,%0:s,%2:s)',
                 [QuotedStr(bandLetter),MatrixID,QuotedStr(newBandName)]);
        dmADO.adocRun.Execute;
      end;

      ModalResult := mrOk;
    except
      on E: Exception do
      begin
        Log.Event(MODULE_NAME, Format('Error saving Band %s for price matrix %s.  New name was %s: %s.',
                                      [QuotedStr(bandLetter),QuotedStr(MatrixName),QuotedStr(newBandName),E.Message]));
      end;
    end;
  end;
end;

end.
