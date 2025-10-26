unit uPassToken;

interface

  function Obfuscate(username, password: string) : string;
  procedure Deobfuscate(param :string; var Username: string; var Password: string);

implementation

uses SysUtils, SynCommons, SynCrypto;

////////////////////////////////////////////////////////////////////////////////
//
//  Obfuscation
//
////////////////////////////////////////////////////////////////////////////////

function MakeRandomString(const ALength: Integer;
  const ACharSequence: String = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'): String;
var
  C1, sequence_length: Integer;
begin
  sequence_length := Length(ACharSequence);
  SetLength(result, ALength);
 
  for C1 := 1 to ALength do
    result[C1] := ACharSequence[Random32(sequence_length) + 1];
end;

function GetKeyFromString(const ClueNo: integer): string;
const
  SourceString: string = 'Tw6unn2XgMz4yLv8vN0XBw9kkbQY61yLaXfCDioIwdx7kD14MRc2UUWmmK9bv3RfdNSzwR' +
                  'ucphroX10F9McdNwPf1SfR8ddslhSvMrxUnYCDsxnkKt1HQDrGWCxDBC4b4X3G8uTHfgPNTcMsuT7E'+
                  'buBGPcx7STiKUqztuGcfyiszMCMKP58Gup0ymlQUVMOlX5RsBiXNJQ5R12TcpMhNKBfvp078OhjLt7'+
                  'BHKj8x6kYDj7wjrEv9v1zlPl3BaPXpwjoTqbq5DIGpBBcisNFaKagrwfRogwmfly60ICRfdpuLqaId'+
                  '9K8m9NEm3Vnbj2O6mr43vbyPUqWkEt8mvDevoY6xTIWLfGVaAnoR6FHWbirIQjGyN0EEMjHnlv8LeM'+
                  'zdtLJh5fgPVhj6xmGAcnWe1gngF1wzwUInHde4yptxJOIvYBOXNxIPOlcdntA3IFi0xUnj7B2BTouc'+
                  'xQg3bxKYbRxl01F4NpO3wHW3duPbv7VqQ0FwcxRa';
var
  k1, k2 : string;
  k1Len, k2Len, k2Pos: integer;
  Year, Month, Day: Word;
begin
  Result := '-1';
  if ClueNo = -1 then
    exit;

  DecodeDate(Date, Year, Month, Day);
  k1Len := (Day mod 6) + 5;
  k1 := Copy(SourceString, ClueNo + 1, k1Len);

  k2Len := (ClueNo mod 4) + 6;
  k2Pos := (Day * (Month + 2)) + DayOfWeek(Date) - 1; // DoW Delphi: 1..7 Sun-Sat, C#: 0..6 Sun-Sat
  k2 := Copy(SourceString, k2Pos + 1, k2Len);

  Result := IntToStr(Day) + k1 + (Copy(IntToStr(Year), 3, 2)) + k2 + IntToStr(Month);
end;

function Encrypt(const AText: String; const APassword: String): String; overload;
var
  key : TSHA256Digest;
  aes: TAESCBC;
begin
  HexToBin(Pointer(SHA256(APassword)), @key, 32);

  aes := TAESCBC.Create(key, 256);
  Result := aes.EncryptPKCS7(aText, TRUE);
  aes.Free;
end;



function Obfuscate(username, password: string) : string;
var
  keyNumber, whatFake : integer;
  thePayload, thePassKey, s2 : string;
  output1, output2, r1, fake1 : string;
begin
  keyNumber := 11 + Random32(470);
  thePassKey := GetKeyFromString(keyNumber);

  whatFake := (Length(UserName) + Length(Password)) mod 3;

  thePayload := Copy(UserName + BinToBase64(MakeRandomString(25)), 1, 25);
  s2 := '00' + inttostr(Length(UserName));
  thePayload := thePayload + copy(s2, Length(s2) - 1, 2) + Password;

  output1 := BinToBase64(Encrypt(thePayload, thePassKey));

  r1 := '000' + inttostr(keyNumber);
  r1 := copy(r1, Length(r1) - 2, 3);

  fake1 := MakeRandomString(10, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');

  if keyNumber mod 2 = 0 then
    output2 := copy(fake1, 1, 1) + copy(r1, 1, 1)
  else
    output2 := copy(r1, 1, 1) + copy(fake1, 1, 1) ;

  case keyNumber mod 3 of
   0 : output2 := output2 + copy(fake1, 2, 2) + copy(r1, 2, 2) + copy(fake1, 4, 3);
   1 : output2 := output2 + copy(fake1, 2, 3) + copy(r1, 2, 2) + copy(fake1, 4, 2);
  else output2 := output2 + copy(fake1, 2, 1) + copy(r1, 2, 1) + copy(fake1, 3, 2) +
                    copy(r1, 3, 1) + copy(fake1, 4, 2);
  end;

  output2 := output2 + output1;
  insert('=', output2, 16);

  case whatFake mod 3 of
   1 : begin
         insert(copy(fake1, 7, 1), output2, 17);
         insert('=', output2, Length(output2) - 19);
       end;
   2 : begin
         insert('==', output2, Length(output2) - 19);
       end;
  else insert(copy(fake1, 7, 2), output2, 17);
  end;

  result := output2;
end;




////////////////////////////////////////////////////////////////////////////////
//
//  De-Obfuscation
//
////////////////////////////////////////////////////////////////////////////////

function GetClueFromString(const theString: string): integer;
var
  num : string;
begin
  if (theString[1] in ['0'..'9']) then
    num := theString[1]
  else
    num := theString[2];

  if (theString[4] in ['0'..'9']) then
    num := num + theString[4] + theString[7]
  else if (theString[5] in ['0'..'9']) then
    num := num + theString[5] + theString[6]
  else
    num := num + theString[6] + theString[7];

  try
    Result := StrToInt(num);
  except
    Result := -1;
  end;
end;

function GetKeyFromParts(const ClueNo: integer): string;
const
  SourceString: string = 'Tw6unn2XgMz4yLv8vN0XBw9kkbQY61yLaXfCDioIwdx7kD14MRc2UUWmmK9bv3RfdNSzwR' +
                  'ucphroX10F9McdNwPf1SfR8ddslhSvMrxUnYCDsxnkKt1HQDrGWCxDBC4b4X3G8uTHfgPNTcMsuT7E'+
                  'buBGPcx7STiKUqztuGcfyiszMCMKP58Gup0ymlQUVMOlX5RsBiXNJQ5R12TcpMhNKBfvp078OhjLt7'+
                  'BHKj8x6kYDj7wjrEv9v1zlPl3BaPXpwjoTqbq5DIGpBBcisNFaKagrwfRogwmfly60ICRfdpuLqaId'+
                  '9K8m9NEm3Vnbj2O6mr43vbyPUqWkEt8mvDevoY6xTIWLfGVaAnoR6FHWbirIQjGyN0EEMjHnlv8LeM'+
                  'zdtLJh5fgPVhj6xmGAcnWe1gngF1wzwUInHde4yptxJOIvYBOXNxIPOlcdntA3IFi0xUnj7B2BTouc'+
                  'xQg3bxKYbRxl01F4NpO3wHW3duPbv7VqQ0FwcxRa';
var
  k1, k2 : string;
  k1Len, k2Len, k2Pos: integer;
  Year, Month, Day: Word;
begin
  Result := '-1';
  if ClueNo = -1 then
    exit;

  DecodeDate(Date, Year, Month, Day);
  k1Len := (Day mod 6) + 5;
  k1 := Copy(SourceString, ClueNo + 1, k1Len);

  k2Len := (ClueNo mod 4) + 6;
  k2Pos := (Day * (Month + 2)) + DayOfWeek(Date) - 1; // DoW Delphi: 1..7 Sun-Sat, C#: 0..6 Sun-Sat
  k2 := Copy(SourceString, k2Pos + 1, k2Len);

  Result := IntToStr(Day) + k1 + (Copy(IntToStr(Year), 3, 2)) + k2 + IntToStr(Month);
end;

function Decrypt(const AText: String; const APassword: String): String; overload;
var
  textBytes: AnsiString;
  key : TSHA256Digest;
  aes: TAESCBC;
  iv: TAESBlock;
begin
  FillChar(iv, 16, 65); // 65 = A

  textBytes := Base64ToBin(AText);
  Move(textBytes[1], IV, 16);

  HexToBin(Pointer(SHA256(APassword)), @key, 32);

  aes := TAESCBC.Create(key, 256);
  aes.IV := iv;
  Result := UTF8ToString(aes.DecryptPKCS7(Base64ToBin(aText), TRUE));
  aes.Free;
end;



procedure Deobfuscate(param: string; var Username, Password: string);
var
  deObParam, s2, thePassKey : String;
  thePayload : string;
  i : integer; 
begin
  Username := '';
  Password := '';

  try
    s2 := Copy(param, Length(param) - 21, 2);

    if s2 = '==' then
      deObParam := Copy(param, 1, Length(param) - 22) + Copy(param, Length(param) - 19, 20)
    else if s2[2] = '=' then
      deObParam := Copy(param, 1, 16) + Copy(param, 18, Length(param) - 38) + Copy(param, Length(param) - 19, 20)
    else
      deObParam := Copy(param, 1, 16) + Copy(param, 19, Length(param));

    Delete(deObParam, 16,1); //  2.	Discard the first "=" (always the 16th char).

    // the Key No is in the first 9 chars; get the key from that number...
    thePassKey := GetKeyFromParts(GetClueFromString(Copy(deObParam, 1, 9)));

    if thePassKey = '-1' then
      raise Exception.Create('Error: Could not get Pass Key');

    Delete(deObParam, 1,9); // delete first 9 chars; what is left of the Parameter is now theParameterString.

    if ((Length(thePassKey) < 15) or (Length(thePassKey) > 30)) then
      raise Exception.Create('Error: Pass Key length invalid');

    if ((Length(deObParam) < 64) or (Length(deObParam) > 175)) then
      raise Exception.Create('Error: Temp text length invalid');

    try
      thePayload := Decrypt(deObParam, thePassKey);
    except
      on E:Exception do
      begin
        raise Exception.Create('Error decrypting payload; Msg: ' + E.Message);
      end;
    end;

    try
      i := StrToInt(Copy(thePayload, 26, 2));
      UserName := Copy(thePayload, 1, i);
      Password := Copy(thePayload, 28, Length(thePayload));
    except
        raise Exception.Create('Error: (in payload) ' + Copy(thePayload, 26, 2) + ' is not an Integer');
    end;
  except
    on E:Exception do
    begin
      Username := '';
      Password := '';
      raise Exception.Create('Could not get login details; Msg: ' + E.Message);
    end;
  end;
end;

end.
 