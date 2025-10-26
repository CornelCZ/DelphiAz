inherited dmADO: TdmADO
  OldCreateOrder = True
  Left = 330
  Top = 167
  inherited AztecConn: TADOConnection
    CommandTimeout = 800
  end
  object adoqRun2: TADOQuery
    Connection = AztecConn
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 160
    Top = 96
  end
end
