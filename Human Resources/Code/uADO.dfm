inherited dmADO: TdmADO
  OldCreateOrder = True
  Left = 772
  Top = 553
  Height = 211
  Width = 324
  inherited AztecConn: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI.1;Integrated Security=SSPI;Persist Security Inf' +
      'o=False;Initial Catalog=Aztec;Data Source=(local)'
    Provider = 'SQLNCLI.1'
  end
  object cmdCreateTempTables: TADOCommand
    CommandTimeout = 0
    Connection = AztecConn
    Parameters = <>
    ParamCheck = False
    Left = 168
    Top = 72
  end
end
