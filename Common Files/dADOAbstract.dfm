object dmADOAbstract: TdmADOAbstract
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 561
  Top = 214
  Height = 153
  Width = 282
  object adocRun: TADOCommand
    CommandTimeout = 0
    Connection = AztecConn
    Parameters = <>
    Left = 80
    Top = 24
  end
  object adoqRun: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 152
    Top = 24
  end
  object adoTRun: TADOTable
    Connection = AztecConn
    CommandTimeout = 0
    Left = 216
    Top = 24
  end
  object AztecConn: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    AfterConnect = AztecConnAfterConnect
    OnWillExecute = AztecConnWillExecute
    Left = 24
    Top = 24
  end
  object AztecConnSysAdmin: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    AfterConnect = AztecConnAfterConnect
    OnWillExecute = AztecConnWillExecute
    Left = 40
    Top = 72
  end
end
