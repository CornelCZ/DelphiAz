inherited dmADO: TdmADO
  OldCreateOrder = True
  Left = 213
  Top = 230
  Height = 234
  Width = 322
  object cmdPrunePurchase: TADOCommand
    CommandText = 'DelArchivedPurchases;1'
    CommandType = cmdStoredProc
    Connection = AztecConn
    Parameters = <>
    Left = 104
    Top = 80
  end
  object qryLastStockDate: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'select min(MaxEnd) as LastStock'
      'from (select s.Division, max(s.[EDate]) as MaxEnd'
      '         from Stocks s, Threads t'
      '         where s.TID = t.TID'
      '         and ISNULL(t.NoPurAcc,'#39#39') <> '#39'Y'#39
      '         group by s.Division) a')
    Left = 176
    Top = 80
  end
  object qryUnstockedDiv: TADOQuery
    Connection = AztecConn
    Parameters = <>
    SQL.Strings = (
      'select [Division Name]'
      'from Division'
      'where [Division Name] in'
      '  (select s.[Division]'
      '   from Stocks s, Threads t'
      '   where s.TID = t.TID'
      '   and ISNULL(t.NoPurAcc,'#39#39') = '#39'Y'#39')'
      'or [Division Name] not in'
      '  (select s.[Division]'
      '   from Stocks s, Threads t'
      '   where s.TID = t.TID'
      '   and ISNULL(t.NoPurAcc,'#39#39') <> '#39'Y'#39')')
    Left = 29
    Top = 131
  end
  object adoSupplierMask: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 128
    Top = 128
  end
end
