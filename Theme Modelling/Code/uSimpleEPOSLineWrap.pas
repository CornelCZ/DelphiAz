unit uSimpleEPOSLineWrap;

interface

// PW 31 July 2009
// A dumb text wrapping algorithm for epos button text
// Works pretty simply:
//   Uses tahoma 10 to apprixmate the font proprtions on the till
//   Sets a target number of lines which is Min(Num_words, 3)
//   Attempts to apportion the words into lines of width (total width/target lines)
//   If:
//     The biggest word has its own line and is over 40 pixels wide
//   Then:
//     Assume that breaking this word will give a better fit to a single button
//     (If other words overflowed onto the line the first condition wouldn't be true)
//     Pick the smallest other line to wrap part of the word into
//     (Because of condition 1 we can wrap forward or backward without repaginating the rest)
//     Work out approximately where the syllables are and break the word to even up the width
//     of the two selected lines.

// Better syllable hacking can be done with regexps.

function GetWrappedText(Input: string):string;

implementation

uses Graphics, Controls, sysutils, classes, math, useful;

function InstrumentSyllables(word: String): string;
// Terrible algorithm to roughly find the syllables and mark
// the syllable boundaries with _
// Has a funny side effect that _ will always break the word
// although other non-alpha characters currently don't.
const
  vowels = 'aeiouy';
var
  count: integer;
  i: integer;
  outword: string;

  function IsVowel(input: integer): boolean;
  begin
    if input > Length(word) then
      result := false
    else
      result := Pos(Word[input], vowels) > 0;
  end;

begin
  // Make the string case insensitive.
  outword := word;
  word := lowercase(word);
  count :=0;
  for i := 1 to Length(Word) do
  begin
    if (i = 1) or (Word[i-1] = ' ') then
    begin
      if IsVowel(i-1) then
      begin
        Inc(Count);
        insert('_', outword, 1+i+count);
      end;
    end
    else
    if i = Length(Word) then
    begin
      if (Word[i] <> 'e') and IsVowel(i) and not IsVowel(i-1) then
        begin
          Inc(Count);
          insert('_', outword, 1+i+count);
        end;
    end
    else
    if IsVowel(i) and not IsVowel(i-1) then
    begin
      // crap fix for words ending in s
      if (i = Length(Word)-2) and (Word[i+2] = 's') then break;

      Inc(Count);
      // crude fixup for double vowels
      if IsVowel(i+1) and (Word[i+1] <> 'y') then
        insert('_', outword, 2+i+count)
      else if (i+1 < Length(word)) and (
        (Word[i+1] = Word[i+2])
        or
        // consonsant pairs not to split
        ((Word[i+1] = 'c') and (word[i+2] = 'k'))
        or
        ((Word[i+1] = 'c') and (word[i+2] = 'h'))
        or
        ((Word[i+1] = 'r') and (word[i+2] = 't'))
        or
        ((Word[i+1] = 'r') and (word[i+2] = 'n'))
        or
        ((Word[i+1] = 'r') and (word[i+2] = 'd'))
        or
        ((Word[i+1] = 's') and (word[i+2] = 't'))
        or
        ((Word[i+1] = 'n') and (word[i+2] = 't'))
        or
        ((Word[i+1] = 'n') and (word[i+2] = 'g'))
        or
        ((Word[i+1] = 't') and (word[i+2] = 'h'))
        or
        ((Word[i+1] = 'n') and (word[i+2] = 'd'))
        or
        ((Word[i+1] = 's') and (word[i+2] = 'h'))
      ) then
        insert('_', outword, 2+i+count)
      else
        insert('_', outword, 1+i+count);
    end;
  end;
  if (Length(Outword) > 0) and (outword[Length(Outword)] = '_') then
    SetLength(Outword, Length(Outword)-1);
  result := outword;
end;

function GetButtonText(Canvas: TCanvas; NameText:string): string;
// Wrap the given string to 3 lines of CR terminated text
const
  WordBreakWidth = 60;
  Hyphen = '';
var
  Word: TStrings;
  i,j: integer;
  SpaceWidth: integer;
  TotalWidth, TargetLines, TargetWidth, LineWidth: integer;
  LineStarts: array[1..4] of integer;
  Line: array[1..3] of string;
  LineWidths: array[1..3] of integer;
  SplitRatio: double;
  DestSpace: string;

  procedure Paginate;
  var
    i,j: integer;
  begin
    for i := 1 to 3 do
    begin
      Line[i] := '';
      for j := LineStarts[i] to Pred(LineStarts[i+1]) do
      begin
        Line[i] := Line[i] + Word[j];
        if j < Pred(LineStarts[i+1]) then
          Line[i] := Line[i] + ' ';
      end;
      LineWidths[i] := Canvas.TextWidth(Line[i]);
    end;
  end;

  function WordSplit: boolean;
  // Try and split the largest word if it takes a line to itself
  // and is too big to fit on a single button
  var
    MaxW, MinW, SourceLine, DestLine, BigWord, BigWordWidth: integer;
    i: integer;
    slTemp: TStringList;
    TmpWidth, Breakpoint: integer;
    Bits: array[1..2] of string;

    procedure SwapLine(A, B: integer);
    var
      Tw: integer;
      Tl: string;
    begin
      Tw := LineWidths[A];
      LineWidths[A] := LineWidths[B];
      LineWidths[B] := Tw;
      Tl := Line[A];
      Line[A] := Line[B];
      Line[B] := Tl;
    end;
  begin
    result := true;
    MaxW := Max(LineWidths[1], Max(LineWidths[2], LineWidths[3]));
    MinW := Min(LineWidths[1], Min(LineWidths[2], LineWidths[3]));

    BigWord := 0;
    BigWordWidth := 0;
    for i := 0 to pred(Word.Count) do
      if Canvas.TextWidth(Word[i]) > BigWordWidth then
      begin
        BigWord := i;
        BigWordWidth := Canvas.TextWidth(Word[i]);
      end;

    if (MaxW > MinW) and (MaxW = BigWordWidth) and (MaxW > WordBreakWidth) then
    begin
      // work out where we're wrapping to
      if Line[1] = Word[BigWord] then
      begin
        SourceLine := 1;
        if LineWidths[3] = 0 then
        begin
          SwapLine(2, 3);
        end;
        DestLine := 2;
      end
      else
      if Line[2] = Word[BigWord] then
      begin
        SourceLine := 2;
        if LineWidths[1] = MinW then
          DestLine := 1
        else
          DestLine := 3;
      end
      else
      begin
        SourceLine := 3;
        DestLine := 2;
      end;

      // calculate a ratio for word split
      if LineWidths[DestLine] > 0 then
        DestSpace := ' '
      else
        DestSpace := '';

      SplitRatio := ((LineWidths[DestLine] + Canvas.TextWidth(DestSpace) + LineWidths[SourceLine]) / 2.0) /
        (LineWidths[SourceLine]);
      if DestLine < SourceLine then SplitRatio := 1-SplitRatio;

      slTemp := TStringlist.create;
      useful.SeparateList(
        InstrumentSyllables(Word[BigWord]), '_', slTemp
      );

      for i := 0 to Pred(slTemp.Count) do
      begin
        slTemp.Objects[i] := TObject(Canvas.TextWidth(slTemp[i]));
      end;

      TmpWidth := 0;
      BreakPoint := 0;
      TargetWidth := Round(MaxW * SplitRatio);
      for i := 0 to Pred(slTemp.Count) do
      begin
        if (TmpWidth = 0) or (
          abs(TmpWidth + Integer(slTemp.Objects[i]) - TargetWidth) <
          abs(TmpWidth - TargetWidth)) then
        begin
          TmpWidth := TmpWidth + Integer(slTemp.Objects[i]);
          BreakPoint := BreakPoint + Length(slTemp[i]);
        end
        else
          break;
      end;

      Bits[1] := Copy(Word[BigWord], 1, BreakPoint);
      Bits[2] := Copy(Word[BigWord], BreakPoint + 1, Length(Word[BigWord]));

      // Check we could work out a syllable split
      if (Length(Bits[1]) = 0) or (Length(Bits[2]) = 0) then
      begin
        Result := false;
        exit;
      end;

      if DestLine < SourceLine then
      begin
        Line[DestLine] := Line[DestLine] + DestSpace + Bits[1]+Hyphen;
        Line[SourceLine] := StringReplace(Line[SourceLine], Word[BigWord], Bits[2], []);
      end
      else
      begin
        Line[DestLine] := Bits[2] + DestSpace + Line[DestLine];
        Line[SourceLine] := StringReplace(Line[SourceLine], Word[BigWord], Bits[1]+Hyphen, []);
      end;
    end
    else
      result := false;
  end;
begin
  if Trim(NameText) = '' then
  begin
    Result := NameText;
    exit;
  end;
  Word := TStringlist.create();
  useful.SeparateList(NameText, ' ', Word);
  SpaceWidth := Canvas.TextWidth(' ');

  TotalWidth := Canvas.TextWidth(NameText);
  TargetLines := Min(Word.Count, 3);
  TargetWidth := TotalWidth div TargetLines;

  for i := 0 to Pred(Word.Count) do
    Word.Objects[i] := TObject(Canvas.TextWidth(Word[i]));

  LineStarts[1] := 0;
  LineStarts[2] := Word.Count;
  LineStarts[3] := Word.Count;

  for i := 1 to 3 do
  begin
    LineWidth := 0;
    for j := LineStarts[i] to Pred(Word.Count) do
    begin
      if (LineWidth = 0) or (abs((LineWidth + SpaceWidth + Integer(Word.Objects[j])) - TargetWidth) <
        abs(LineWidth - TargetWidth)) then
      begin
        if LineWidth > 0 then LineWidth := LineWidth + SpaceWidth;
        LineWidth := LineWidth + Integer(Word.Objects[j]);
        LineStarts[i+1] := j+1;
      end
      else
        break;
    end;
  end;
  LineStarts[4] := Word.Count;

  Paginate;
  Result := Line[1] + #13 + Line[2] + #13 + Line[3];
  if WordSplit then
    Result := Line[1] + #13 + Line[2] + #13 + Line[3];

end;

var
  EPOSLineWrap_Bitmap: TBitmap;

function GetWrappedText(Input: string):string;
begin
  Result := GetButtonText(EPOSLineWrap_Bitmap.Canvas, Input);
end;

initialization

  EPOSLineWrap_Bitmap := TBitmap.create;
  with EPOSLineWrap_Bitmap do
  begin
    Width := 0;
    Height := 0;
    Canvas.Font.Name := 'Tahoma';
    Canvas.Font.Size := 10;
  end;

finalization
  EPOSLineWrap_Bitmap.Free;

end.
