object InvoiceManager: TInvoiceManager
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 458
  Top = 135
  Height = 132
  Width = 313
  object wwqGetInvoice: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 48
    Top = 16
  end
  object wwtSysVar: TADOTable
    Connection = dmADO.AztecConn
    TableName = 'PurSysVar'
    Left = 120
    Top = 16
  end
  object qryRun: TADOQuery
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 184
    Top = 16
  end
end
