unit uAud1Pr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, DB, Wwdatsrc, ADODB, StdCtrls,
  Buttons, DBCtrls, ExtCtrls;

type
  TfAud1Pr = class(TForm)
    wwDataSource1: TwwDataSource;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    wwDBGrid1: TwwDBGrid;
    ADOQuery1: TADOQuery;
    ADOQuery1unit: TStringField;
    ADOQuery1default: TStringField;
    ADOQuery1totQ: TBCDField;
    ADOQuery1ratio: TBCDField;
    ADOQuery1btu: TStringField;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    btnPrevious: TBitBtn;
    btnNext: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    ADOQuery1q1: TStringField;
    ADOQuery1q2: TStringField;
    ADOQuery1q3: TStringField;
    ADOQuery1q4: TStringField;
    ADOQuery1q5: TStringField;
    lblNewItem: TLabel;
    pnlPrepared: TPanel;
    Label6: TLabel;
    procedure wwDBGrid1UpdateFooter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid1ColEnter(Sender: TObject);
    procedure ADOQuery1BeforePost(DataSet: TDataSet);
    procedure wwDBGrid1DrawFooterCell(Sender: TObject; Canvas: TCanvas;
      FooterCellRect: TRect; Field: TField; FooterText: String;
      var DefaultDrawing: Boolean);
    procedure ADOQuery1q1GetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure ADOQuery1q1SetText(Sender: TField; const Text: String);
    procedure wwDBGrid1RowChanged(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADOQuery1q5SetText(Sender: TField; const Text: String);
  private
    procedure BuildUnits;
    { Private declarations }
  public
    { Public declarations }
    theValue : real;
    defUnit : string;
    newitem, prepitem : boolean;
  end;

var
  fAud1Pr: TfAud1Pr;

implementation

uses uADO, uAudit, udata1;

{$R *.dfm}

procedure TfAud1Pr.BuildUnits;
var
  btu : string;
  defr : real;
begin
  with data1.adoqRun do
  begin
    lblNewItem.Visible := (fAudit.wwtAuditCur.FieldByName('opstk').asfloat = -888888);

    dmADO.DelSQLTable('#1Prod');

    if fAudit.wwtAuditCur.FieldByName('Purchstk').asfloat = -999999 then // Prepared Item
    begin
      pnlPrepared.Visible := TRUE;

      close;        // get unit from PReparedItemDetail...
      sql.Clear;
      sql.Add('select [storageunit] as [unit], (''N'') as [default],');
      sql.Add('(''        0'') as [q1], (''        0'') as [q2], (''        0'') as [q3],');
      sql.Add('(''        0'') as [q4], (''        0'') as [q5], ([EntityCode] * 0) as [totQ],');
      sql.Add('([EntityCode] * 0) as [ratio], (''     '') as [btu]');
      sql.Add('INTO [#1Prod]');
      sql.Add('from [PreparedItemDetail]');
      sql.Add('where [EntityCode] = ' + fAudit.wwtAuditCur.FieldByName('EntityCode').asstring);

      sql.Add('UNION');  // add batch unit if different from storage unit

      sql.Add('select [batchunit] as [unit], (''N'') as [default],');
      sql.Add('(''        0'') as [q1], (''        0'') as [q2], (''        0'') as [q3],');
      sql.Add('(''        0'') as [q4], (''        0'') as [q5], ([EntityCode] * 0) as [totQ],');
      sql.Add('([EntityCode] * 0) as [ratio], (''     '') as [btu]');
      sql.Add('from [PreparedItemDetail]');
      sql.Add('where [EntityCode] = ' + fAudit.wwtAuditCur.FieldByName('EntityCode').asstring);
      sql.Add('and StorageUnit <> BatchUnit');
      execSQL;
    end
    else
    begin  // ------------------------------------------------------------  Normal Item
      pnlPrepared.Visible := FALSE;

      close;        // get unit from PUnits...
      sql.Clear;
      sql.Add('select distinct [unit name] as [unit], (''N'') as [default],');
      sql.Add('(''        0'') as [q1], (''        0'') as [q2], (''        0'') as [q3],');
      sql.Add('(''        0'') as [q4], (''        0'') as [q5], ([Entity Code] * 0) as [totQ],');
      sql.Add('([Entity Code] * 0) as [ratio], (''     '') as [btu]');
      sql.Add('INTO [#1Prod]');
      sql.Add('from [PUnits]');
      sql.Add('where [Entity Code] = ' + fAudit.wwtAuditCur.FieldByName('EntityCode').asstring);
      execSQL;
    end;

    // set Default Unit
    defUnit := fAudit.wwtAuditCur.FieldByName('PurchUnit').asstring;

    close;
    sql.Clear;
    sql.Add('select * from [#1Prod] where [unit] = ' +
      quotedStr(fAudit.wwtAuditCur.FieldByName('PurchUnit').asstring));
    open;

    if recordcount <> 0 then
    begin
      edit;
      FieldByName('default').asstring := 'Y';
      FieldByName('q1').asstring := fAudit.wwtAuditCur.FieldByName('ACount').asstring;

      if fAudit.wwtAuditCur.FieldByName('ACount').asstring = '' then
      begin
        FieldByName('totq').asfloat := 0;
      end
      else
      begin
        FieldByName('totq').asfloat :=
          data1.dozGallStrToFloat(defUnit,fAudit.wwtAuditCur.FieldByName('ACount').asstring);
      end;

      post;
    end
    else
    begin
      close;

      close;
      sql.Clear;
      sql.Add('insert into [#1Prod] VALUES (' + quotedStr(fAudit.wwtAuditCur.FieldByName('PurchUnit').asstring) + ', ');
      sql.Add(' ''Y'', ' + quotedStr(fAudit.wwtAuditCur.FieldByName('ACount').asstring) +
          ',''        0'',''        0'',''        0'',''        0'',');

      if fAudit.wwtAuditCur.FieldByName('ACount').asstring = '' then
      begin
        sql.Add('  0,0,''     '')');
      end
      else
      begin
        sql.Add('  ' + 
          floatToStr(data1.dozGallStrToFloat(defUnit,fAudit.wwtAuditCur.FieldByName('ACount').asstring)) +
         ',0,''     '')');    //data1.fmtRepQtyText
      end;


      execSQL;
    end;
    close;

    if fAudit.wwtAuditCur.FieldByName('ACount').asstring = '' then
    begin
      theValue := 0;
    end
    else
    begin
      theValue :=
        data1.dozGallStrToFloat(defUnit,fAudit.wwtAuditCur.FieldByName('ACount').asstring);
    end;

    // get the base units and the base type unit for each unit...
    close;
    sql.Clear;
    sql.Add('update [#1prod] set ratio = a.[base units], btu = a.[base type unit]');
    sql.Add('from [units] a');
    sql.Add('where [#1prod].unit = a.[unit name]');
    execSQL;

    // discard units with base type unit <> default base type unit
    // transform the ratio field as a ratio relative to the default unit...
    close;
    sql.Clear;
    sql.Add('select * from [#1prod] order by [default] desc, unit');
    open;

    defr := FieldByName('ratio').asfloat;
    btu := FieldByName('btu').asstring;

    edit;
    FieldByName('ratio').asfloat := 1;
    FieldByName('q1').AsString := Trim(FieldByName('q1').AsString);
    FieldByName('q2').AsString := Trim(FieldByName('q2').AsString);
    FieldByName('q3').AsString := Trim(FieldByName('q3').AsString);
    FieldByName('q4').AsString := Trim(FieldByName('q4').AsString);
    FieldByName('q5').AsString := Trim(FieldByName('q5').AsString);
    post;
    next;

    while not eof do
    begin
      if FieldByName('btu').asstring = btu then
      begin
        edit;
        FieldByName('ratio').asfloat := FieldByName('ratio').asfloat / defr;
        FieldByName('q1').AsString := Trim(FieldByName('q1').AsString);
        FieldByName('q2').AsString := Trim(FieldByName('q2').AsString);
        FieldByName('q3').AsString := Trim(FieldByName('q3').AsString);
        FieldByName('q4').AsString := Trim(FieldByName('q4').AsString);
        FieldByName('q5').AsString := Trim(FieldByName('q5').AsString);
        post;
        next;
      end
      else
      begin
        Delete;
      end;
    end;

    close;
  end;
end; // procedure..

procedure TfAud1Pr.wwDBGrid1UpdateFooter(Sender: TObject);
begin
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select sum(ratio * totQ) as sTot');
    sql.Add('from [#1Prod]');
    open;

    wwDBGrid1.Columns[0].FooterValue := defUnit;
    wwDBGrid1.Columns[1].FooterValue := data1.dozGallFloatToStr(defUnit, FieldByName('sTot').asfloat);
      //formFD(FieldByName('sTot').asfloat);

    theValue := FieldByName('sTot').asfloat;
  end;
end;

procedure TfAud1Pr.FormShow(Sender: TObject);
begin
  if data1.curFillClose then
  begin
    label3.Visible := True;
    dbtext3.Visible := True;
    label3.Caption := 'Theo. Close ' + data1.SSbig + ':';
  end
  else
  begin
    label3.Visible := False;
    dbtext3.Visible := False;
  end;

  if uppercase(data1.repHdr) = 'SUB-CATEGORY' then
    label1.caption := 'Sub-Category'
  else
    label1.caption := 'Category';

  buildUnits;

  adoquery1.Open;
end;

procedure TfAud1Pr.wwDBGrid1ColEnter(Sender: TObject);
begin
  if adoquery1.State = dsEdit then
  begin
    adoquery1.Post;
  end;
end;

procedure TfAud1Pr.ADOQuery1BeforePost(DataSet: TDataSet);
var
  tmpTotValue : double;
begin

  adoquery1.FieldByName('TotQ').AsFloat :=
    (data1.dozGallStrToFloat(adoquery1Unit.Value, adoquery1.FieldByName('q1').asstring) +
    data1.dozGallStrToFloat(adoquery1Unit.Value, adoquery1.FieldByName('q2').asstring) +
    data1.dozGallStrToFloat(adoquery1Unit.Value, adoquery1.FieldByName('q3').asstring) +
    data1.dozGallStrToFloat(adoquery1Unit.Value, adoquery1.FieldByName('q4').asstring) +
    data1.dozGallStrToFloat(adoquery1Unit.Value, adoquery1.FieldByName('q5').asstring));

  // ensure the number just typed in does not take the total (expressed in Purchase Units)
  // over the specified limit of 999999.99
  with dmADO.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select sum(ratio * totQ) as sTot');
    sql.Add('from [#1Prod] where [unit] <> ' + quotedStr(adoquery1Unit.Value));
    open;

    tmpTotValue := FieldByName('sTot').asfloat +
      (adoquery1.FieldByName('TotQ').AsFloat * adoquery1.FieldByName('ratio').AsFloat);

    close;
  end;

  if tmpTotValue > 999999.99 then
  begin
    showmessage('The Total Value (expressed in "' + defUnit +
      '" units) cannot exceed 999,999.99!');
    adoquery1.Cancel;
    Abort;
  end;
end;

procedure TfAud1Pr.wwDBGrid1DrawFooterCell(Sender: TObject;
  Canvas: TCanvas; FooterCellRect: TRect; Field: TField;
  FooterText: String; var DefaultDrawing: Boolean);
begin
  if Field.FieldName = 'totQ' then
  begin
    Canvas.Brush.Color := clBlue;
    Canvas.Font.Color := clYellow;
    Canvas.Font.Size := 9;
  end; // if..

  Canvas.Font.Style := [fsBold];
end;

procedure TfAud1Pr.ADOQuery1q1GetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if sender.asstring = '' then
  begin
    Text := '';
    exit;
  end;

  Text := data1.dozGallFloatToStr(adoquery1Unit.Value, sender.Asfloat);
end;

procedure TfAud1Pr.ADOQuery1q1SetText(Sender: TField; const Text: String);
begin
  if Text = '' then
  begin
    sender.AsString := '';
    exit;
  end;

  sender.AsFloat :=
    data1.dozGallStrToFloat(adoquery1Unit.Value,text);
end;

procedure TfAud1Pr.wwDBGrid1RowChanged(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to 4 do
  begin
    wwdbgrid1.PictureMasks.Strings[i] := 'q' + inttostr(i + 1) + data1.setGridMask(adoquery1Unit.Value,'');
  end; // for..
end;

procedure TfAud1Pr.btnPreviousClick(Sender: TObject);
begin
  if adoquery1.state = dsEdit then adoquery1.Post;
  if (theValue >= 0) and (theValue <> fAudit.wwtAuditCur.FieldByName('ActCloseStk').asfloat)  then
  begin
    fAudit.wwtAuditCur.edit;
    fAudit.wwtAuditCur.FieldByName('ACount').asstring := data1.dozGallFloatToStr(defUnit, theValue);
    fAudit.wwtAuditCur.post;
  end;
  if fAudit.wwtAuditCur.RecNo > 1 then
    fAudit.wwtAuditCur.RecNo := fAudit.wwtAuditCur.RecNo - 1;

  adoquery1.close;
  buildunits;
  adoquery1.open;
  defUnit := adoquery1.FieldByName('unit').asstring;
end;

procedure TfAud1Pr.btnNextClick(Sender: TObject);
begin
  if adoquery1.state = dsEdit then adoquery1.Post;
  if (theValue >= 0) and (theValue <> fAudit.wwtAuditCur.FieldByName('ActCloseStk').asfloat)  then
  begin
    fAudit.wwtAuditCur.edit;
    fAudit.wwtAuditCur.FieldByName('ACount').asstring := data1.dozGallFloatToStr(defUnit, theValue);//FormFD(theValue);
    fAudit.wwtAuditCur.post;
  end;

  fAudit.wwtAuditCur.RecNo := fAudit.wwtAuditCur.RecNo + 1;

  adoquery1.close;
  buildunits;
  adoquery1.open;
  defUnit := adoquery1.FieldByName('unit').asstring;

end;

procedure TfAud1Pr.btnOKClick(Sender: TObject);
begin
  if adoquery1.state = dsEdit then adoquery1.Post;
  if (theValue >= 0) and (theValue <> fAudit.wwtAuditCur.FieldByName('ActCloseStk').asfloat)  then
  begin
    fAudit.wwtAuditCur.edit;
    fAudit.wwtAuditCur.FieldByName('ACount').asstring := data1.dozGallFloatToStr(defUnit, theValue);//FormFD(theValue);
    fAudit.wwtAuditCur.post;
  end;

  modalResult := mrOK;
end;

procedure TfAud1Pr.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_PRIOR: btnPreviousClick(Sender);
    VK_NEXT: btnNextClick(Sender);
  else exit;
  end; // case..

  key := 0;
end;

procedure TfAud1Pr.ADOQuery1q5SetText(Sender: TField; const Text: String);
begin
  if Text = '' then
  begin
    sender.AsString := '';
    exit;
  end;

  sender.AsFloat :=
    data1.dozGallStrToFloat(adoquery1Unit.Value,text);
end;

end.
