object dmRunSP: TdmRunSP
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 502
  Top = 252
  Height = 150
  Width = 215
  object SPconn: TADOConnection
    CommandTimeout = 0
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object adoqRunSP: TADOQuery
    Connection = SPconn
    CommandTimeout = 0
    Parameters = <>
    Left = 112
    Top = 48
  end
end
