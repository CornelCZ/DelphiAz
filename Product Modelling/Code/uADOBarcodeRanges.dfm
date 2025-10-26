inherited dmBarcodeRanges: TdmBarcodeRanges
  Left = 550
  Top = 181
  Height = 526
  Width = 563
  object qSeedID: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 208
    Top = 72
  end
  object qAllBarcodeRanges: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    SQL.Strings = (
      'select * from ThemeBarcodeRange'
      '')
    Left = 56
    Top = 144
    object qAllBarcodeRangesBarcodeRangeID: TLargeintField
      FieldName = 'BarcodeRangeID'
    end
    object qAllBarcodeRangesDescription: TStringField
      FieldName = 'Description'
    end
    object qAllBarcodeRangesStartValue: TStringField
      FieldName = 'StartValue'
      Size = 23
    end
    object qAllBarcodeRangesEndValue: TStringField
      FieldName = 'EndValue'
      Size = 23
    end
    object qAllBarcodeRangesSource: TSmallintField
      FieldName = 'Source'
    end
  end
  object dsBarcodeRanges: TDataSource
    DataSet = qAllBarcodeRanges
    Left = 128
    Top = 120
  end
  object qGenerateRanges: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'DECLARE @BarcodeRangeID bigint'
      'SET @BarcodeRangeID = :BarcodeRangeID -- IDParam'
      ''
      'DECLARE @TableName varchar(50)'
      'DECLARE @IdField varchar(20)'
      'DECLARE @RangeMin bigint'
      'DECLARE @RangeMax bigint'
      'DECLARE @NextID bigint'
      ''
      'SET @TableName = '#39'ThemeBarcodeExceptionRange_repl'#39
      'SET @IdField = '#39'RangeID'#39
      'SET @RangeMin = 1'
      'SET @RangeMax = 9223372036854775807'
      ''
      
        'DECLARE @ActualRanges TABLE (IDNum int IDENTITY(1,1), [BarcodeRa' +
        'ngeID] int, StartValue numeric(23,0), EndValue numeric(23,0))'
      
        'DECLARE @Exceptions TABLE (ExceptionID int IDENTITY(1,1), Except' +
        'ionValue numeric(23,0))'
      ''
      'DECLARE '
      
        '  @ExceptionID int, @ExceptionValue numeric(23,0), @LastExceptio' +
        'nValue numeric(23,0), '
      '  @NewStartValue numeric(23,0), @EndValue numeric(23,0)'
      ''
      
        'SET @NewStartValue = (SELECT CONVERT(numeric(23,0), StartValue) ' +
        'FROM ThemeBarcodeRange WHERE [BarcodeRangeID] = @BarcodeRangeID)'
      
        'SET @EndValue = (SELECT CONVERT(numeric(23,0), EndValue) FROM Th' +
        'emeBarcodeRange WHERE [BarcodeRangeID] = @BarcodeRangeID)'
      ''
      'INSERT @Exceptions(ExceptionValue)'
      
        'SELECT Value FROM ThemeBarcodeException WHERE BarcodeRangeID = @' +
        'BarcodeRangeID'
      'ORDER BY CAST(Value AS numeric(23,0))'
      ''
      'IF (SELECT COUNT(*) FROM @Exceptions) = 0'
      'BEGIN'
      '  INSERT @ActualRanges'
      '  SELECT @BarcodeRangeID, @NewStartValue, @EndValue'
      'END'
      'ELSE'
      'BEGIN'
      '  SET @ExceptionID = (SELECT MIN(ExceptionID) FROM @Exceptions)'
      
        '  SET @ExceptionValue = (SELECT ExceptionValue FROM @Exceptions ' +
        'WHERE ExceptionID = @ExceptionID)'
      '     '
      '  WHILE @ExceptionID IS NOT NULL'
      '  BEGIN'
      '    SET @LastExceptionValue = @ExceptionValue'
      '    '
      
        '    IF (@ExceptionValue > @NewStartValue) AND (@ExceptionValue <' +
        ' @EndValue)'
      '      INSERT @ActualRanges'
      '      SELECT @BarcodeRangeID,@NewStartValue,@ExceptionValue - 1'
      '    '
      '    IF (@ExceptionValue + 1) <= @EndValue'
      '      SET @NewStartValue = @ExceptionValue + 1'
      ''
      
        '    SET @ExceptionID = (SELECT MIN(ExceptionID) FROM @Exceptions' +
        ' WHERE ExceptionID > @ExceptionID)'
      
        '    SET @ExceptionValue = (SELECT ExceptionValue FROM @Exception' +
        's WHERE ExceptionID = @ExceptionID)'
      '  END'
      '    '
      '  -- ENSURE THAT EXCEPTIONS NEAR THE END OF THE RANGE ARE ADDED'
      
        '  SELECT @LastExceptionValue as LastExceptionValue, @NewStartVal' +
        'ue as NewStartValue, @EndValue as EndValue'
      ''
      '  IF @LastExceptionValue < @EndValue'
      '    INSERT @ActualRanges'
      '    SELECT @BarcodeRangeID, @LastExceptionValue + 1, @EndValue'
      '  ELSE'
      
        '    IF (@LastExceptionValue = @EndValue) AND (@LastExceptionValu' +
        'e <> @NewStartValue)'
      '      INSERT @ActualRanges'
      '      SELECT @BarcodeRangeID, @NewStartValue, @EndValue - 1'
      'END'
      '  '
      ''
      '-- SAVE TO AZTEC DB'
      'BEGIN TRANSACTION'
      '  DECLARE @IDNum int, @Error int'
      '  '
      
        '  DELETE ThemeBarcodeExceptionRange WHERE BarcodeRangeID = @Barc' +
        'odeRangeID'
      '  '
      '  IF @@ERROR <> 0 GOTO OnError'
      '    '
      '  SET @IDNum = (SELECT MIN(IDNum) FROM @ActualRanges)'
      
        '  SET @NewStartValue = (SELECT StartValue FROM @ActualRanges WHE' +
        'RE IDNum = @IDNum)'
      
        '  SET @EndValue = (SELECT EndValue FROM @ActualRanges WHERE IDNu' +
        'm = @IDNum)'
      
        '  EXEC GetNextUniqueID @TableName, @IdField, @RangeMin, @RangeMa' +
        'x, @NextID OUTPUT'
      '  '
      '  IF @@ERROR <> 0 GOTO OnError'
      ''
      '  SET @Error = 0'
      ''
      '  WHILE @IDNum IS NOT NULL'
      '  BEGIN'
      
        '    INSERT ThemeBarcodeExceptionRange (RangeID, BarcodeRangeID, ' +
        'StartValue, EndValue)'
      '    VALUES(@NextID, @BarcodeRangeID, @NewStartValue, @EndValue)'
      '    '
      '    SET @Error = @Error + @@ERROR'
      '    '
      
        '    SET @IDNum = (SELECT MIN(IDNum) FROM @ActualRanges WHERE IDN' +
        'um > @IDNum)'
      
        '    SET @NewStartValue = (SELECT StartValue FROM @ActualRanges W' +
        'HERE IDNum = @IDNum)'
      
        '    SET @EndValue = (SELECT EndValue FROM @ActualRanges WHERE ID' +
        'Num = @IDNum)'
      '    '
      '    IF @IDNum IS NOT NULL'
      
        '      EXEC GetNextUniqueID @TableName, @IdField, @RangeMin, @Ran' +
        'geMax, @NextID OUTPUT'
      '  END'
      '   '
      '  IF @Error <> 0 GOTO OnError'
      '  '
      'COMMIT TRANSACTION'
      'GOTO EndTag'
      ''
      'OnError:'
      'ROLLBACK TRANSACTION'
      'GOTO EndTag'
      ''
      'EndTag:'
      '')
    Left = 296
    Top = 96
  end
  object dsBarcodeExceptions: TDataSource
    DataSet = dstBarcodeExceptions
    Left = 48
    Top = 320
  end
  object dstBarcodeExceptions: TADODataSet
    Connection = AztecConn
    CursorType = ctStatic
    CommandText = 
      'SELECT ExceptionID, BarcoderangeID, Value'#13#10'FROM ThemeBarcodeExce' +
      'ption'#13#10'ORDER BY BarcodeRangeID, Cast(Value AS numeric(23,0))'#13#10
    CommandTimeout = 0
    DataSource = dsBarcodeRanges
    IndexFieldNames = 'BarcoderangeID'
    MasterFields = 'BarcodeRangeID'
    Parameters = <>
    Left = 48
    Top = 384
  end
  object qProductBarcodeRanges: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'EntityCode'
        DataType = ftFloat
        Size = -1
        Value = 10000000011
      end>
    SQL.Strings = (
      'select * from ThemeBarcodeRange'
      'where [Source] = 1'
      'and BarcodeRangeID in'
      '  (select BarcodeRangeID from ProductBarcodeRange'
      '   where EntityCode = :EntityCode)'
      ''
      '')
    Left = 192
    Top = 144
    object LargeintField1: TLargeintField
      FieldName = 'BarcodeRangeID'
    end
    object StringField1: TStringField
      FieldName = 'Description'
    end
    object StringField2: TStringField
      FieldName = 'StartValue'
      Size = 23
    end
    object StringField3: TStringField
      FieldName = 'EndValue'
      Size = 23
    end
    object qProductBarcodeRangesSource: TSmallintField
      FieldName = 'Source'
    end
  end
  object qInsertProductBarcodeRange: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'entityCode'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'barcodeRangeID'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'INSERT ProductBarcodeRange(EntityCode,BarcodeRangeID)'
      'VALUES(:entityCode, :barcodeRangeID)')
    Left = 192
    Top = 240
  end
  object qInsertBarcodeRange: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'barcodeRangeID'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'description'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'startValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 23
        Value = Null
      end
      item
        Name = 'endValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 23
        Value = Null
      end
      item
        Name = 'source'
        Attributes = [paSigned]
        DataType = ftSmallint
        Precision = 5
        Size = 2
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT [ThemeBarcodeRange] ([BarcodeRangeID],[Description],[Star' +
        'tValue],[EndValue],[Source])'
      
        'VALUES (:barcodeRangeID, :description, :startValue, :endValue, :' +
        'source)'
      ''
      '')
    Left = 64
    Top = 208
    object LargeintField2: TLargeintField
      FieldName = 'BarcodeRangeID'
    end
    object StringField4: TStringField
      FieldName = 'Description'
    end
    object StringField5: TStringField
      FieldName = 'StartValue'
      Size = 23
    end
    object StringField6: TStringField
      FieldName = 'EndValue'
      Size = 23
    end
    object SmallintField1: TSmallintField
      FieldName = 'Source'
    end
  end
  object qDeleteSelectedBarcodeRange: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'barcodeRangeID'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'Delete ProductBarcodeRange'
      'where BarcodeRangeID = :barcodeRangeID')
    Left = 256
    Top = 296
  end
  object qDeleteProductBarcodeRanges: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <
      item
        Name = 'EntityCode'
        DataType = ftFloat
        Size = -1
        Value = 10000000011
      end>
    SQL.Strings = (
      'Delete ProductBarcodeRange'
      'where EntityCode = :EntityCode')
    Left = 168
    Top = 360
  end
end
