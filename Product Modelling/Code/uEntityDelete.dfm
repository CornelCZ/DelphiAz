object EntityDelete: TEntityDelete
  OldCreateOrder = False
  Left = 427
  Top = 344
  Height = 133
  Width = 310
  object EntityIngredientOrMenuItemQuery: TADOQuery
    Connection = dmADO.AztecConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ecode'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'declare @entitycode float'
      'set @entitycode = :ecode'
      ''
      'SELECT p.[EntityCode] AS ParentCode,'
      '       p.[Extended RTL Name] AS Name,'
      '       p.[Retail Description] As Description'
      '--       '#39#39' as Effective'
      
        'FROM Products p JOIN Portions po ON p.[EntityCode] = po.[EntityC' +
        'ode]'
      
        '                JOIN PortionIngredients pg ON po.[PortionID] = p' +
        'g.[PortionID]'
      'WHERE p.[EntityCode] <> @entitycode AND'
      
        '              pg.[IngredientCode] = @entitycode AND (p.[Deleted]' +
        ' <> '#39'Y'#39' OR p.[Deleted] IS NULL)'
      ''
      'UNION'
      ''
      'SELECT p.[EntityCode] AS ParentCode,'
      '       p.[Extended RTL Name] AS Name,'
      '       p.[Retail Description] As Description'
      
        '--       '#39'(Eff. as of '#39' +convert(varchar(10),pof.[effectivedate]' +
        ',103) + '#39')'#39' As Effective'
      
        'FROM Products p JOIN PortionsFuture pof ON p.[EntityCode] = pof.' +
        '[EntityCode]'
      
        '                JOIN PortionIngredientsFuture pgf ON pof.[Portio' +
        'nID] = pgf.[PortionID]'
      
        '                                                 AND pof.[Effect' +
        'iveDate] = pgf.[EffectiveDate]'
      'WHERE p.[EntityCode] <> @entitycode AND'
      
        '              pgf.[IngredientCode] = @entitycode AND (p.[Deleted' +
        '] <> '#39'Y'#39' OR p.[Deleted] IS NULL)'
      '')
    Left = 184
    Top = 16
  end
  object ADOCommand: TADOCommand
    Connection = dmADO.AztecConn
    Parameters = <>
    Left = 40
    Top = 16
  end
end
