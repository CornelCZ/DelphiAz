unit uSumDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, DBTables, Wwquery, Db, Wwdatsrc, Grids,
  Wwdbigrd, Wwdbgrid, ADODB;

type
  Tfsumdlg = class(TForm)
    wwDBGrid1: TwwDBGrid;
    wwDataSource1: TwwDataSource;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    wwDBGrid2: TwwDBGrid;
    wwDataSource2: TwwDataSource;
    wwDBGrid3: TwwDBGrid;
    wwDataSource3: TwwDataSource;
    wwDataSource4: TwwDataSource;
    wwDBGrid4: TwwDBGrid;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    wwqByCtg: TADOQuery;
    wwqBySub: TADOQuery;
    wwtSummary: TADOTable;
    wwqGetsubs: TADOQuery;
    wwqTotal: TADOQuery;
    wwqByDiv: TADOQuery;
    wwqByCtgctg: TStringField;
    wwqByCtgRecCount: TIntegerField;
    wwqByCtgUCount: TFloatField;
    wwqByCtgICost: TBCDField;
    wwqByCtgTax: TBCDField;
    wwqByCtgCTGCost: TBCDField;
    wwqBySubsubctg: TStringField;
    wwqBySubRecCount: TIntegerField;
    wwqBySubUCount: TFloatField;
    wwqBySubICost: TBCDField;
    wwqBySubTax: TBCDField;
    wwqBySubCTGCost: TBCDField;
    wwqTotalRecCount: TIntegerField;
    wwqTotalUCount: TFloatField;
    wwqTotalICost: TBCDField;
    wwqTotalTax: TBCDField;
    wwqTotalCTGCost: TBCDField;
    procedure GetData;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid4CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure wwDBGrid3CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    { Private declarations }
  public
    { Public declarations }
    viewCostPrices: boolean;
    procedure CalculateUKSubCatTax;
  end;

var
  fsumdlg: Tfsumdlg;

implementation

uses
  uInvFrm, uADO, uGlobals, uLog;

{$R *.DFM}

procedure Tfsumdlg.GetData;
begin
  try
    with wwqGetsubs do
    begin
       close;
       sql.clear;
       sql.add('select distinct i.recno, c.[division name], c.[category name], ');
       sql.add('s.[sub-category name], i.qty, i.itemcost, i.tax');
       sql.add('from invoice i, Category c, ');
       sql.add('subcateg s, entity e ');
       sql.add('where e.[entity code] = i.itemid ');
       sql.add('and e.[sub-category name] = s.[sub-category name] ');
       sql.add('and s.[category name] = c.[category name] ');
       sql.add('and i.PurchaseItemType = 0 ');
       sql.add('union ');
       sql.add('select distinct i.recno, c.[division name], c.[category name], ');
       sql.add('s.[sub-category name], i.IngredQty, i.IngredItemCost, i.tax ');
       sql.add('from invoice i, Category c, ');
       sql.add('subcateg s, entity e ');
       sql.add('where e.[entity code] = i.itemid ');
       sql.add('and e.[sub-category name] = s.[sub-category name] ');
       sql.add('and s.[category name] = c.[category name] ');
       sql.add('and i.PurchaseItemType = 2 ');
       open;
       wwtsummary.close;
       dmADO.EmptySQLTable('Summary');
       wwtsummary.open;
       first;
       while not eof do
       begin
          wwtsummary.insert;
          wwtsummary.FieldByName('recno').asfloat := FieldByName('recno').asfloat;
          wwtsummary.FieldByName('div').asstring :=
                                           FieldByName('division name').asstring;
          wwtsummary.FieldByName('ctg').asstring :=
                                           FieldByName('category name').asstring;
          wwtsummary.FieldByName('subctg').asstring :=
                                       FieldByName('sub-category name').asstring;
          wwtsummary.FieldByName('ucount').asfloat :=
                                           FieldByName('qty').asfloat;
          wwtsummary.FieldByName('icost').asfloat :=
                                           FieldByName('itemcost').asfloat;
          if (FieldByName('tax').asstring = 'Y') then
             wwtsummary.FieldByName('tax').asfloat := -1.0
          else
             wwtsummary.FieldByName('tax').asfloat := 0.0;

          wwtsummary.post;
          next;
       end; // while not eof
       close;
    end; // with

    with wwtsummary do
    begin
       first;
       while not eof do
       begin
         if FieldByName('tax').asfloat = -1.0 then
         begin
            edit;
            FieldByName('tax').asfloat := GetLocalisedItemTax(FieldByName('icost').asfloat,
              finvfrm.theTax, False);
            FieldByName('ctgcost').asfloat := FieldByName('icost').asfloat + FieldByName('tax').asfloat;
            post;
         end
         else
         begin
            edit;
            FieldByName('ctgcost').asfloat := FieldByName('icost').asfloat;
            post;
         end;

         next;
       end; // while...
       first;
    end; // with...
  except
    on E: Exception do
    begin
      Log.Event('fsumdlg; GetData: ' + E.Message + '; '+ wwqGetsubs.SQL.Text);
      raise;
    end;
  end;
end; // proc GetData


procedure Tfsumdlg.SpeedButton2Click(Sender: TObject);
begin
  wwdbgrid2.visible := true;
  wwdbgrid1.Visible := false;
  wwdbgrid2.RefreshDisplay;
  wwDBGrid2.Columns[4].DisplayLabel := GetLocalisedName(lsSalesTax);
  wwDBGrid2.Columns[5].DisplayLabel := 'Cost + ' + GetLocalisedName(lsSalesTax);
end;

procedure Tfsumdlg.FormShow(Sender: TObject);
begin
  Log.Event('fsumdlg; FormShow');
  fSumDlg.Caption := GetLocalisedName(lsInvoice) + ' Summary';
  Label1.Caption := GetLocalisedName(lsInvoice) + ' Totals:';

  getdata;

  try
    wwqByDiv.open;
  except
    on E: Exception do
    begin
      Log.Event('fsumdlg; FormShow: ' + E.Message + '; ' + wwqByDiv.SQL.Text);
      raise;
    end;
  end;

  if UKUSMode = 'UK' then
    CalculateUKSubCatTax;

  try
    wwqByCtg.open;
    wwdbgrid1.Visible := true;
    wwdbgrid2.Visible := false;
    wwqBySub.open;
    wwqTotal.open;
    wwDBGrid1.Columns[4].DisplayLabel := GetLocalisedName(lsSalesTax);
    // there is no room on the printed report for 'Cost + Sales Tax' (US mode)
    // so for the sake of consistency, the summary dialog and the report will both
    // have the heading 'Cost + Tax' in US mode.
    if UKUSMode = 'UK' then
      wwDBGrid1.Columns[5].DisplayLabel := 'Cost + ' + GetLocalisedName(lsSalesTax)
    else
      wwDBGrid1.Columns[5].DisplayLabel := 'Cost + Tax';
  except
    on E: Exception do
    begin
      Log.Event('fsumdlg; FormShow : ' + E.Message);
      raise;
    end;
  end;
end;

procedure Tfsumdlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f5 : begin
              SpeedButton1.Down := true;
              SpeedButton1click(sender);
            end;
    vk_f6 :begin
              SpeedButton2.Down := true;
              SpeedButton2click(sender);
            end;
  end; // case
  key := 0;
  Application.ProcessMessages;
end;

procedure Tfsumdlg.SpeedButton1Click(Sender: TObject);
begin
  wwdbgrid1.visible := true;
  wwdbgrid2.Visible := false;
  wwdbgrid1.RefreshDisplay;
  wwDBGrid1.Columns[4].DisplayLabel := GetLocalisedName(lsSalesTax);
  wwDBGrid1.Columns[5].DisplayLabel := 'Cost + ' + GetLocalisedName(lsSalesTax);
end;

procedure Tfsumdlg.FormCreate(Sender: TObject);
begin
  log.event('fsumdlg; FormCreate');
  if purchHelpExists then
    setHelpContextID(self, HLP_DELIVERY_NOTE_SUMMARY);
end;

procedure Tfsumdlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('fsumdlg; FormClose');
end;

procedure Tfsumdlg.wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  try
    if not viewCostPrices then
    begin
      with finvfrm do
      begin
        wwqGeneric.close;
        wwqGeneric.sql.Clear;
        wwqGeneric.sql.Add('SELECT [View Cost Prices] FROM vwSupplier WHERE [Supplier Name] = '+ QuotedStr(finvfrm.thesupplier));
        wwqGeneric.open;

        if ((wwqGeneric.fieldbyName('View Cost Prices').asString = 'N') OR
            (wwqGeneric.fieldbyName('View Cost Prices').asString = '')) and
           ((field.FieldName = 'ICost') or (field.FieldName = 'Tax') or
            (field.FieldName = 'CTGCost')) then
        begin
          Abrush.Color := clBtnFace;
          AFont.Color := clBtnFace;
        end;

        close;
      end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fsumdlg; wwDBGrid2CalcCellColors : ' + E.Message + '; ' + finvfrm.wwqGeneric.SQL.Text);
      raise;
    end;
  end;
end;

procedure Tfsumdlg.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  wwDBGrid2CalcCellColors(Sender, Field, State, Highlight, AFont, ABrush);
end;

procedure Tfsumdlg.wwDBGrid4CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  wwDBGrid2CalcCellColors(Sender, Field, State, Highlight, AFont, ABrush);
end;

procedure Tfsumdlg.wwDBGrid3CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  try
    if not viewCostPrices then
    begin
      with finvfrm do
      begin
        wwqGeneric.close;
        wwqGeneric.sql.Clear;
        wwqGeneric.sql.Add('SELECT [View Cost Prices] FROM vwSupplier WHERE [Supplier Name] = '+ QuotedStr(finvfrm.thesupplier));
        wwqGeneric.open;

        if ((wwqGeneric.fieldbyName('View Cost Prices').asString = 'N') OR
            (wwqGeneric.fieldbyName('View Cost Prices').asString = '')) and
           (field.FieldName = 'CTGCost') then
        begin
          Abrush.Color := clBtnFace;
          AFont.Color := clBtnFace;
        end;

        close;
      end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fsumdlg; wwDBGrid3CalcCellColors : ' + E.Message + '; ' + finvfrm.wwqGeneric.SQL.Text);
      raise;
    end;
  end;
end;

// Job 19619 - added RecNo to nested Select .. Union .. Select statements
// because if there are no multi purchase ingredients, the query didn't return
// all instances of duplicate items that have different flavours but the same quantity.
procedure TfSumDlg.CalculateUKSubCatTax;
begin
  try
    with finvfrm.wwqGeneric do
    begin
      Close;
      SQL.Text :=
        'SELECT SUM((i.ItemCost * t.[On-Sale Rate]) / 100) AS Tax, i.[SubCat Name] ' + #13#10 +
        'FROM ' + #13#10 +
        '  (SELECT ItemCost, ItemID, [SubCat Name], RecNo ' + #13#10 +
        '   FROM Invoice ' + #13#10 +
        '   WHERE PurchaseItemType = 0 ' + #13#10 +
        '   UNION ' + #13#10 +
        '   SELECT IngredItemCost, ItemID, [SubCat Name], RecNo ' + #13#10 +
        '   FROM Invoice ' + #13#10 +
        '   WHERE PurchaseItemType = 2) i ' + #13#10 +
        'JOIN Products p ON i.ItemID = p.EntityCode ' + #13#10 +
        'JOIN ProductTaxRules ptr ON p.EntityCode = ptr.EntityCode ' + #13#10 +
        'JOIN ' + #13#10 +
        '  (SELECT [Index No], ' + #13#10 +
        '     CASE PurchasedGoods ' + #13#10 +
        '       WHEN 1 THEN [On-Sale Rate] ' + #13#10 +
        '     ELSE 0 ' + #13#10 +
        '     END AS [On-Sale Rate] ' + #13#10 +
        '   FROM TaxRules)  t ON ptr.TaxRule1 = t.[Index No] ' + #13#10 +
        'GROUP BY  i.[SubCat Name] ';
      Open;

      while not EOF do
      begin
        wwtSummary.Locate('SubCtg', FieldByName('SubCat Name').AsString, []);
        wwtSummary.Edit;
        wwtSummary.FieldByName('Tax').AsFloat := FieldByName('Tax').AsFloat;
        wwtSummary.FieldByName('ctgCost').AsFloat :=
          wwtSummary.FieldByName('ctgCost').AsFloat + FieldByName('Tax').AsFloat;
        wwtSummary.Post;

        Next;
      end;

      Close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fSumDlg; CalculateUKSubCatTax: ' + E.Message + '; ' + finvfrm.wwqGeneric.SQL.Text);
      raise;
    end;
  end;
end;

end.
