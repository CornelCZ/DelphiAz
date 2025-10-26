inherited ProductTagsFrame: TProductTagsFrame
  object adoqProductTags: TADODataSet
    CommandText = 
      'SELECT t.Id AS TagId, Coalesce(t2.Name, t.Name) AS ParentName'#13#10'F' +
      'ROM ac_Tag t LEFT OUTER JOIN ac_Tag t2 ON t.ParentTagId = t2.Id'#13 +
      #10'WHERE t.Id IN (SELECT TagId FROM ProductTag WHERE EntityCode = ' +
      ':ProductId)'
    Parameters = <
      item
        Name = 'ProductId'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Left = 40
    Top = 8
  end
  object adocSaveProductTags: TADOCommand
    CommandText = 
      'DECLARE @ProductID bigint'#13#10'SET @ProductID = :ProductId'#13#10#13#10'IF EXI' +
      'STS(SELECT * FROM Products WHERE EntityCode = @ProductID)'#13#10'BEGIN' +
      ' TRY'#13#10'  DELETE ProductTag'#13#10'  WHERE EntityCode = @ProductID AND T' +
      'agId NOT IN (SELECT TagId FROM #Tags)'#13#10'  '#13#10'  INSERT ProductTag (' +
      'EntityCode, TagId)'#13#10'  SELECT @ProductID, TagId'#13#10'  FROM #Tags t'#13#10 +
      '  WHERE NOT EXISTS (SELECT * FROM ProductTag pt WHERE pt.EntityC' +
      'ode = @ProductID AND pt.TagId = t.TagId)'#13#10'END TRY'#13#10'BEGIN CATCH'#13#10 +
      '  EXEC ac_spRethrowError'#13#10'END CATCH'#13#10
    Parameters = <
      item
        Name = 'ProductId'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Left = 8
    Top = 72
  end
end
