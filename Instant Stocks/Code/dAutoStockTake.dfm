object dmAutoStockTake: TdmAutoStockTake
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 472
  Top = 57
  Height = 590
  Width = 711
  object adoqThreads: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Threads'
      'where [active] = '#39'Y'#39
      '')
    Left = 32
    Top = 16
  end
end
