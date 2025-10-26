unit uPCWasteEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Wwdatsrc, ADODB, StdCtrls, Buttons, ExtCtrls, Grids,
  Wwdbigrd, Wwdbgrid, DBCtrls;

type
  TfPCWasteEdit = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    wwDBGrid1: TwwDBGrid;
    Label4: TLabel;
    Bevel1: TBevel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
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
    LabelNote: TLabel;
    MemoNote: TMemo;
    lblPrep: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ADOQuery1BeforePost(DataSet: TDataSet);
    procedure wwDBGrid1RowChanged(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FProductDataset: TADODataset;
    FWasteDataset: TADODataset;
    procedure BuildUnits;
    { Private declarations }
  public
    { Public declarations }
    editmode, isPrepItem : boolean;
    theEnt : real;
    thegrp, maxrecid : integer;
    property ProductDataset: TADODataset read FProductDataset write FProductDataset;
    property WasteDataset: TADODataset read FWasteDataset write FWasteDataset;
  end;

var
  fPCWasteEdit: TfPCWasteEdit;

implementation

uses udata1, uADO;

{$R *.dfm}

procedure TfPCWasteEdit.FormShow(Sender: TObject);
begin
  if editmode then
  begin
    self.Caption := 'Edit Waste';
    self.Width := 569;
    self.HelpContext := 1031;
  end
  else
  begin
    self.Caption := 'Set Waste Quantities';
    self.Width := 569;
    self.HelpContext := 1030;
  end;

  buildUnits;

  if data1.ssDebug then
  with dmADO.adoqRun2 do
  begin
    Close;
    sql.Clear;
    sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_1prod'')) DROP TABLE [stkZZ_1prod]');
    sql.Add('SELECT * INTO dbo.[stkZZ_1prod] FROM [#1prod]');
    execSQL;
  end;
  
  adoquery1.Open;

end;

procedure TfPCWasteEdit.BuildUnits;
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
      theEnt := WasteDataset.FieldByName('entitycode').asfloat;
      lblProd.caption := WasteDataset.FieldByName('PurN').asstring;
      lblSub.caption := WasteDataset.FieldByName('sub').asstring;
      thegrp := WasteDataset.FieldByName('grp').asinteger;
      lblDesc.Caption := WasteDataset.FieldByName('descr').asstring;
      MemoNote.Text :=  WasteDataset.FieldByName('note').asstring;

      isPrepItem := (WasteDataset.FieldByName('ETCode').asstring = 'P');

      // bring in qtys already in the list table only for the given grp...
      close;
      sql.Clear;
      sql.Add('select [unit], [recid], (''N'') as [default],');
      sql.Add('(''        0'') as [q1], [qty] as [totQ],');
      sql.Add('(baseunits) as [ratio], (''     '') as [btu]');
      sql.Add('INTO [#1Prod]');
      sql.Add('from [#PCWaste]');
      sql.Add('where [EntityCode] = ' + WasteDataset.FieldByName('EntityCode').asstring);
      sql.Add('and [grp] = ' + WasteDataset.FieldByName('grp').asstring);
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
      sql.Add('where [Entity Code] = ' + ProductDataset.FieldByName('EntityCode').asstring);
      execSQL;

      // set EntityCode, prodName, subcategory
      theEnt := ProductDataset.FieldByName('entitycode').asfloat;
      lblProd.caption := ProductDataset.FieldByName('Name').asstring;
      lblSub.caption := ProductDataset.FieldByName('sub').asstring;
      lblDesc.Caption := ProductDataset.FieldByName('descr').asstring;

      isPrepItem := (ProductDataset.FieldByName('ETCode').asstring = 'P');

      close;
      sql.Clear;
      sql.Add('select * from [#1Prod] where [unit] = ' +
        quotedStr(ProductDataset.FieldByName('PurUnit').asstring));
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
        sql.Add(quotedStr(ProductDataset.FieldByName('PurUnit').asstring) + ', 0,');
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

  lblPrep.Visible := isPrepItem;
  if isPrepItem then
  begin
    lblProd.Color := clBlack;
    lblProd.Font.Color := clYellow;
    lblProd.Font.Style := [fsBold];
  end
  else
  begin
    lblProd.Color := clBlue;
    lblProd.Font.Color := clWhite;
    lblProd.Font.Style := [];
  end;
end; // procedure..


procedure TfPCWasteEdit.ADOQuery1BeforePost(DataSet: TDataSet);
begin
  adoquery1.FieldByName('TotQ').AsFloat :=
    data1.dozGallStrToFloat(adoquery1Unit.Value, adoquery1.FieldByName('q1').asstring);
end;

procedure TfPCWasteEdit.wwDBGrid1RowChanged(Sender: TObject);
begin
  wwdbgrid1.PictureMasks.Strings[0] := 'q1' + data1.setGridMask(adoquery1Unit.Value,'');
end;

procedure TfPCWasteEdit.BitBtn3Click(Sender: TObject);
begin
  if adoquery1.state = dsEdit then adoquery1.Post;

  if editmode then
  begin
    //Do nothing
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
        sql.Add('select max(grp) as thegrp from #PCWaste');
        open;

        thegrp := FieldByName('thegrp').asinteger + 1;
        close;

        // now insert the quantities wherever totq > 0...
        close;
        sql.Clear;
        sql.Add('declare @wastedt datetime');
        sql.Add('set @wastedt = getdate()');
        sql.Add('insert #PCWaste ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr], [note], [WasteDT], Etcode)');
        sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
        sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
        sql.Add('    (' + quotedStr(lblDesc.Caption) + '), ' + QuotedStr(MemoNote.Text) +',@wastedt,');
        if isPrepItem then
          sql.Add('    (' + quotedStr('P') + ')')
        else
          sql.Add('    (' + quotedStr('M') + ')');
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
        sql.Add('update #PCWaste set recid = recid2');
        execSQL;

        WasteDataset.DisableControls;
        WasteDataset.Requery;
        WasteDataset.EnableControls;
      end;
      close;
    end;
  end;

  if ProductDataset.RecNo > 1 then
    ProductDataset.RecNo :=ProductDataset.RecNo - 1;

  adoquery1.close;
  buildunits;
  adoquery1.open;
end;

procedure TfPCWasteEdit.BitBtn4Click(Sender: TObject);
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
        sql.Add('select max(grp) as thegrp from #PCWaste');
        open;

        thegrp := FieldByName('thegrp').asinteger + 1;
        close;

        // now insert the quantities wherever totq > 0...
        close;
        sql.Clear;
        sql.Add('declare @wastedt datetime');
        sql.Add('set @wastedt = getdate()');
        sql.Add('insert #PCWaste ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr], [note], [WasteDT], Etcode)');
        sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
        sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
        sql.Add('    (' + quotedStr(lblDesc.Caption) + '), ' + QuotedStr(MemoNote.Text) +',@wastedt,');
        if isPrepItem then
          sql.Add('    (' + quotedStr('P') + ')')
        else
          sql.Add('    (' + quotedStr('M') + ')');
        sql.Add('  from [#1prod] where totq > 0');
        execSQL;

        // renumber the list table...
        close;
        sql.Clear;
        sql.Add('select * from #PCWaste order by grp, recid');
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
        sql.Add('update #PCWaste set recid = recid2');
        execSQL;

        WasteDataset.DisableControls;
        WasteDataset.Requery;
        WasteDataset.EnableControls;
      end;
      close;
    end;
  end;

  ProductDataset.RecNo := ProductDataset.RecNo + 1;

  adoquery1.close;
  buildunits;
  adoquery1.open;
end;

procedure TfPCWasteEdit.BitBtnOKClick(Sender: TObject);
var
  SavedRecID: Integer;
  OldParamCheck: Boolean;
begin
  if adoquery1.state = dsEdit then adoquery1.Post;

  if editmode then
  begin
    OldParamCheck := False;
    data1.adoqRun.ParamCheck := False;
    try
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
          sql.Add('delete from #PCWaste ');
          sql.Add('where [EntityCode] = ' + floattostr(theEnt));
          sql.Add('and [grp] = ' + inttostr(thegrp));
          sql.Add('');
          sql.Add('declare @wastedt datetime');
          sql.Add('set @wastedt = getdate()');
          sql.Add('insert #PCWaste ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr], [note], [WasteDT], EtCode)');
          sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
          sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
          sql.Add('    (' + quotedStr(lblDesc.Caption) + '), ' + QuotedStr(MemoNote.Text) +',@wastedt,');
          if isPrepItem then
            sql.Add('    (' + quotedStr('P') + ')')
          else
            sql.Add('    (' + quotedStr('M') + ')');
          sql.Add('  from [#1prod] where totq > 0');
          execSQL;
        end
        else
        begin
          // delete only
          close;
          sql.Clear;
          sql.Add('delete from #PCWaste ');
          sql.Add('where [EntityCode] = ' + floattostr(theEnt));
          sql.Add('and [grp] = ' + inttostr(thegrp));
          execSQL;

          Close;
          SQL.Clear;
          SQL.Add('IF NOT EXISTS(SELECT TOP 1 * FROM #PCWaste WHERE grp = ' + inttostr(theGrp) + ')');
          SQL.Add(' UPDATE #PCWaste SET grp = grp - 1 WHERE grp > ' + inttostr(theGrp));
          ExecSQL;
        end;
        close;

        // renumber the list table...
        close;
        sql.Clear;
        sql.Add('select * from #PCWaste order by grp, recid');
        open;

        while not eof do
        begin
          edit;
          FieldByName('recid2').asinteger := recno;
          post;
          next;
        end;

        close;
        sql.Clear;
        sql.Add('update #PCWaste set recid = recid2');
        execSQL;

        WasteDataset.DisableControls;
        try
          WasteDataset.Requery;
        finally
          WasteDataset.EnableControls;
        end;
        close;
      end;
    finally
      data1.adoqRun.ParamCheck := OldParamCheck;
    end;
  end
  else  // insert
  begin
    OldParamCheck := data1.adoqRun.ParamCheck;
    data1.adoqRun.ParamCheck := False;
    try
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
          sql.Add('select max(grp) as thegrp from #PCWaste');
          open;

          thegrp := FieldByName('thegrp').asinteger + 1;
          close;

          // now insert the quantities wherever totq > 0...
          close;
          sql.Clear;
          sql.Add('declare @wastedt datetime');
          sql.Add('set @wastedt = getdate()');
          sql.Add('insert #PCWaste ([RecID], [EntityCode], [Sub], [PurN], [Qty], [Unit], [BaseUnits], [grp], [descr], [note], [WasteDT], Etcode)');
          sql.Add('  select recid, (' + floattostr(theEnt) + '), (' + quotedStr(lblSub.Caption) + '), ');
          sql.Add('    (' + quotedStr(lblProd.Caption) + '), totq, unit, ratio, (' + inttostr(thegrp) + '),');
          sql.Add('    (' + quotedStr(lblDesc.Caption) + '), ' + QuotedStr(MemoNote.Text) +',@wastedt,');
          if isPrepItem then
            sql.Add('    (' + quotedStr('P') + ')')
          else
            sql.Add('    (' + quotedStr('M') + ')');
          sql.Add('  from [#1prod] where totq > 0');
          execSQL;

          SavedRecID := WasteDataset.FieldByName('RecID').AsInteger;

          // renumber the list table...
          close;
          sql.Clear;
          sql.Add('select * from #PCWaste order by grp, recid');
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
          sql.Add('update #PCWaste set recid = recid2');
          execSQL;

          WasteDataset.DisableControls;
          try
            WasteDataset.Requery;
          finally
            WasteDataset.Locate('RecID', SavedRecID, []);
            WasteDataset.EnableControls;
          end;
        end;
        close;
      end;
    finally
      data1.adoqRun.ParamCheck := OldParamCheck;
    end;
  end;
end;

procedure TfPCWasteEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    BitBtnOKClick(Sender);
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
