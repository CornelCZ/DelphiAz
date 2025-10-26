unit uHZMedit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Wwdatsrc, ADODB, StdCtrls, Buttons, ExtCtrls, Grids,
  Wwdbigrd, Wwdbgrid, DBCtrls;

type
  TfHZMedit = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    wwDBGrid1: TwwDBGrid;
    Label4: TLabel;
    Bevel1: TBevel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADOQuery1: TADOQuery;
    ADOQuery1unit: TStringField;
    ADOQuery1default: TStringField;
    ADOQuery1totQ: TBCDField;
    ADOQuery1ratio: TBCDField;
    ADOQuery1btu: TStringField;
    ADOQuery1q1: TStringField;
    wwDataSource1: TwwDataSource;
    lblSub: TLabel;
    lblProd: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lblDesc: TLabel;
    Label18: TLabel;
    lblFrom: TLabel;
    Label20: TLabel;
    lblTo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ADOQuery1BeforePost(DataSet: TDataSet);
    procedure wwDBGrid1RowChanged(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure BuildUnits;
    { Private declarations }
  public
    { Public declarations }
    editmode : boolean;
    theEnt : real;
    thegrp, maxrecid : integer;
  end;

var
  fHZMedit: TfHZMedit;

implementation

uses udata1, uADO, uHZmove;

{$R *.dfm}

procedure TfHZMedit.FormShow(Sender: TObject);
begin
  if editmode then
  begin
    self.Caption := 'Edit Quantities';
    self.Width := 236;
    self.HelpContext := 1031;
  end
  else
  begin
    self.Caption := 'Set Transfer Quantities';
    self.Width := 355;
    self.HelpContext := 1030;
  end;

  lblFrom.Caption := fHZMove.lblFrom1.Caption;
  lblTo.Caption := fHZMove.lblTo1.Caption;


  buildUnits;

  adoquery1.Open;
end;

procedure TfHZMedit.BuildUnits;
var
  btu : string;
  i : integer;
begin
  with data1.adoqRun do
  begin
    dmADO.DelSQLTable('#1Prod');

    if editmode then
    begin
      // set EntityCode, prodName, subcategory
      theEnt := fHZMove.adotList.FieldByName('entitycode').asfloat;
      lblProd.caption := fHZMove.adotList.FieldByName('PurN').asstring;
      lblSub.caption := fHZMove.adotList.FieldByName('sub').asstring;
      thegrp := fHZMove.adotList.FieldByName('grp').asinteger;
      lblDesc.Caption := fHZMove.adotList.FieldByName('descr').asstring;

      // bring in qtys already in the list table only for the given grp...
      close;
      sql.Clear;
      sql.Add('select [unit], [recid], (''N'') as [default],');
      sql.Add('(''        0'') as [q1], [qty] as [totQ],');
      sql.Add('(baseunits) as [ratio], (''     '') as [btu]');
      sql.Add('INTO [#1Prod]');
      sql.Add('from [stkHZMListTmp]');
      sql.Add('where [EntityCode] = ' + fHZMove.adotList.FieldByName('EntityCode').asstring);
      sql.Add('and [grp] = ' + fHZMove.adotList.FieldByName('grp').asstring);
      execSQL;

      // set the q1 string field with the real qtys
      close;
      sql.Clear;
      sql.Add('select * from [#1prod]');
      open;

      while not eof do
      begin
        edit;
        FieldByName('q1').AsString :=
          data1.dozGallFloatToStr(FieldByName('unit').asstring, FieldByName('totq').asfloat);
        post;
        next;
      end;
      close;

    end
    else
    begin
      // get unit from PUnits...
      close;
      sql.Clear;
      sql.Add('select distinct [unit name] as [unit], (0) as [recid], (''N'') as [default],');
      sql.Add('(''        0'') as [q1], ([Entity Code] * 0) as [totQ],');
      sql.Add('([Entity Code] * 0) as [ratio], (''     '') as [btu]');
      sql.Add('INTO [#1Prod]');
      sql.Add('from [PUnits]');
      sql.Add('where [Entity Code] = ' + fHZMove.adotProds.FieldByName('EntityCode').asstring);
      execSQL;

      // set EntityCode, prodName, subcategory
      theEnt := fHZMove.adotProds.FieldByName('entitycode').asfloat;
      lblProd.caption := fHZMove.adotProds.FieldByName('PurN').asstring;
      lblSub.caption := fHZMove.adotProds.FieldByName('sub').asstring;
      lblDesc.Caption := fHZMove.adotProds.FieldByName('descr').asstring;

      close;
      sql.Clear;
      sql.Add('select * from [#1Prod] where [unit] = ' +
        quotedStr(fHZMove.adotProds.FieldByName('PurUnit').asstring));
      open;

      if recordcount <> 0 then
      begin
        edit;
        FieldByName('default').asstring := 'Y';
        FieldByName('q1').asstring := '        0';
        FieldByName('totq').asfloat := 0;
        post;
      end
      else
      begin
        close;
        sql.Clear;
        sql.Add('insert into [#1Prod] VALUES (');
        sql.Add(quotedStr(fHZMove.adotProds.FieldByName('PurUnit').asstring) + ', 0,');
        sql.Add(' ''Y'', ''        0'',');
        sql.Add('  0,0,''     '')');
        execSQL;
      end;
      close;

      // get the base units and the base type unit for each unit...
      close;
      sql.Clear;
      sql.Add('update [#1prod] set ratio = a.[base units], btu = a.[base type unit]');
      sql.Add('from [units] a');
      sql.Add('where [#1prod].unit = a.[unit name]');
      execSQL;

      // discard units with base type unit <> default base type unit
      close;
      sql.Clear;
      sql.Add('select * from [#1prod] order by [default] desc, unit');
      open;

      btu := FieldByName('btu').asstring;
      i := 1;

      edit;
      FieldByName('q1').AsString := Trim(FieldByName('q1').AsString);
      FieldByName('recid').asinteger := i;
      post;
      next;

      while not eof do
      begin
        if FieldByName('btu').asstring = btu then
        begin
          inc(i);
          edit;
          FieldByName('q1').AsString := Trim(FieldByName('q1').AsString);
          FieldByName('recid').asinteger := i;
          post;
          next;
        end
        else
        begin
          Delete;
        end;
      end;
    end;

    close;
  end;
end; // procedure..


procedure TfHZMedit.ADOQuery1BeforePost(DataSet: TDataSet);
begin
  adoquery1.FieldByName('TotQ').AsFloat :=
    data1.dozGallStrToFloat(adoquery1Unit.Value, adoquery1.FieldByName('q1').asstring);
end;

procedure TfHZMedit.wwDBGrid1RowChanged(Sender: TObject);
begin
  wwdbgrid1.PictureMasks.Strings[0] := 'q1' + data1.setGridMask(adoquery1Unit.Value,'');
end;

procedure TfHZMedit.BitBtn3Click(Sender: TObject);
begin
  if adoquery1.state = dsEdit then adoquery1.Post;

  if editmode then
  begin

  end
  else  // insert
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(recid) as thecount from [#1prod] where totq > 0');
      open;

      if FieldByName('thecount').asinteger > 0 then
      begin
        // get the grp
        close;
        sql.Clear;
        sql.Add('select max(grp) as thegrp from stkHZMListTmp');
        open;

        thegrp := FieldByName('thegrp').asinteger + 1;
        close;

        // now insert the quantities wherever totq > 0...
        close;
        sql.Clear;
        sql.Add('insert stkHZMListTmp ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr])');
        sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
        sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
        sql.Add('    (' + quotedStr(lblDesc.Caption) + ')');
        sql.Add('  from [#1prod] where totq > 0');
        execSQL;

        // renumber the list table...
        close;
        sql.Clear;
        sql.Add('select * from stkHZMListTmp order by grp, recid');
        open;

        while not eof do
        begin
          edit;
          FieldByName('recid2').asinteger := recno;
          post;
          next;
        end;

        close;

        close;
        sql.Clear;
        sql.Add('update stkHZMListTmp set recid = recid2');
        execSQL;

        fHZMove.adotList.disablecontrols;
        fHZMove.adotList.requery;
        fHZMove.adotList.enablecontrols;
      end;
      close;
    end;
  end;

  if fHZMove.adotProds.RecNo > 1 then
    fHZMove.adotProds.RecNo := fHZMove.adotProds.RecNo - 1;

  adoquery1.close;
  buildunits;
  adoquery1.open;
end;

procedure TfHZMedit.BitBtn4Click(Sender: TObject);
begin
  if adoquery1.state = dsEdit then adoquery1.Post;

  if editmode then
  begin

  end
  else  // insert
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(recid) as thecount from [#1prod] where totq > 0');
      open;

      if FieldByName('thecount').asinteger > 0 then
      begin
        // get the grp
        close;
        sql.Clear;
        sql.Add('select max(grp) as thegrp from stkHZMListTmp');
        open;

        thegrp := FieldByName('thegrp').asinteger + 1;
        close;

        // now insert the quantities wherever totq > 0...
        close;
        sql.Clear;
        sql.Add('insert stkHZMListTmp ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr])');
        sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
        sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
        sql.Add('    (' + quotedStr(lblDesc.Caption) + ')');
        sql.Add('  from [#1prod] where totq > 0');
        execSQL;

        // renumber the list table...
        close;
        sql.Clear;
        sql.Add('select * from stkHZMListTmp order by grp, recid');
        open;

        while not eof do
        begin
          edit;
          FieldByName('recid2').asinteger := recno;
          post;
          next;
        end;

        close;

        close;
        sql.Clear;
        sql.Add('update stkHZMListTmp set recid = recid2');
        execSQL;

        fHZMove.adotList.disablecontrols;
        fHZMove.adotList.requery;
        fHZMove.adotList.enablecontrols;
      end;
      close;
    end;
  end;

  fHZMove.adotProds.RecNo := fHZMove.adotProds.RecNo + 1;

  adoquery1.close;
  buildunits;
  adoquery1.open;
end;

procedure TfHZMedit.BitBtn1Click(Sender: TObject);
begin
  if adoquery1.state = dsEdit then adoquery1.Post;

  if editmode then
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(recid) as thecount from [#1prod] where totq > 0');
      open;

      if FieldByName('thecount').asinteger > 0 then
      begin
        // delete and insert the quantities wherever totq > 0 as 1 batch...
        close;
        sql.Clear;
        sql.Add('delete from stkHZMListTmp ');
        sql.Add('where [EntityCode] = ' + floattostr(theEnt));
        sql.Add('and [grp] = ' + inttostr(thegrp));
        sql.Add('');
        sql.Add('');
        sql.Add('insert stkHZMListTmp ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr])');
        sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
        sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
        sql.Add('    (' + quotedStr(lblDesc.Caption) + ')');
        sql.Add('  from [#1prod] where totq > 0');
        execSQL;
      end
      else
      begin
        // delete only
        close;
        sql.Clear;
        sql.Add('delete from stkHZMListTmp ');
        sql.Add('where [EntityCode] = ' + floattostr(theEnt));
        sql.Add('and [grp] = ' + inttostr(thegrp));
        execSQL;
      end;
      close;

      // renumber the list table...
      close;
      sql.Clear;
      sql.Add('select * from stkHZMListTmp order by grp, recid');
      open;

      while not eof do
      begin
        edit;
        FieldByName('recid2').asinteger := recno;
        post;
        next;
      end;

      close;

      close;
      sql.Clear;
      sql.Add('update stkHZMListTmp set recid = recid2');
      execSQL;

      fHZMove.adotList.disablecontrols;
      fHZMove.adotList.requery;
      fHZMove.adotList.enablecontrols;
    end;
  end
  else  // insert
  begin
    with data1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('select count(recid) as thecount from [#1prod] where totq > 0');
      open;

      if FieldByName('thecount').asinteger > 0 then
      begin
        // get the grp
        close;
        sql.Clear;
        sql.Add('select max(grp) as thegrp from stkHZMListTmp');
        open;

        thegrp := FieldByName('thegrp').asinteger + 1;
        close;

        // now insert the quantities wherever totq > 0...
        close;
        sql.Clear;
        sql.Add('insert stkHZMListTmp ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr])');
        sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
        sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
        sql.Add('    (' + quotedStr(lblDesc.Caption) + ')');
        sql.Add('  from [#1prod] where totq > 0');
        execSQL;

        // renumber the list table...
        close;
        sql.Clear;
        sql.Add('select * from stkHZMListTmp order by grp, recid');
        open;

        while not eof do
        begin
          edit;
          FieldByName('recid2').asinteger := recno;
          post;
          next;
        end;

        close;

        close;
        sql.Clear;
        sql.Add('update stkHZMListTmp set recid = recid2');
        execSQL;

        fHZMove.adotList.disablecontrols;
        fHZMove.adotList.requery;
        fHZMove.adotList.enablecontrols;
      end;
      close;
    end;
  end;

end;

procedure TfHZMedit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    BitBtn1Click(Sender);
    key := 0;
    modalResult := mrOK;
    exit;
  end;


  if editmode then exit;

  case key of
    VK_PRIOR: BitBtn3Click(Sender);
    VK_NEXT: BitBtn4Click(Sender);
  else exit;
  end; // case..

  key := 0;

end;

end.
