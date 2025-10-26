object dmShiftMatch: TdmShiftMatch
  OldCreateOrder = False
  OnCreate = dmMainCreate
  Left = 539
  Top = 182
  Height = 479
  Width = 741
  object SchdlTable: TADOTable
    Connection = dmADO.AztecConn
    BeforePost = SchdlTableBeforePost
    OnNewRecord = SchdlTableNewRecord
    TableName = 'Schedule'
    Left = 24
    Top = 12
  end
  object wwtRun: TADOTable
    Connection = dmADO.AztecConn
    Left = 104
    Top = 64
  end
  object wwtRun3: TADOTable
    Connection = dmADO.AztecConn
    Left = 220
    Top = 64
  end
  object wwtRun2: TADOTable
    Connection = dmADO.AztecConn
    Left = 161
    Top = 64
  end
  object wwqRun: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 104
    Top = 12
  end
  object wwqRun2: TADOQuery
    Connection = dmADO.AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 160
    Top = 12
  end
end
