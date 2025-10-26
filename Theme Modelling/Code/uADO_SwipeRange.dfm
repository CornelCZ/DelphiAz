inherited dmADO_SwipeRange: TdmADO_SwipeRange
  OldCreateOrder = True
  Left = 248
  Top = 212
  Height = 311
  Width = 479
  inherited adocRun: TADOCommand
    Left = 116
  end
  inherited adoqRun: TADOQuery
    Left = 220
  end
  inherited adoTRun: TADOTable
    Left = 276
  end
  inherited AztecConn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=0049356GNHsxkzi26TYMF;Persist Secur' +
      'ity Info=True;User ID=zonalsysadmin;Initial Catalog=Aztec;Data S' +
      'ource=192.168.81.131'
    Provider = 'SQLOLEDB.1'
  end
  object qRun: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    Parameters = <>
    Left = 364
    Top = 16
  end
  object qGenerateRanges: TADOQuery
    Connection = AztecConn
    CommandTimeout = 0
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'DECLARE @SwipeCardRangeID bigint'
      'SET @SwipeCardRangeID = :SwipeCardRangeID -- IDParam'
      ''
      'DECLARE @TableName varchar(50)'
      'DECLARE @IdField varchar(20)'
      'DECLARE @RangeMin bigint'
      'DECLARE @RangeMax bigint'
      'DECLARE @NextID bigint'
      ''
      'SET @TableName = '#39'ThemeSwipeCardExceptionRange_repl'#39
      'SET @IdField = '#39'RangeID'#39
      'SET @RangeMin = 1'
      'SET @RangeMax = 9223372036854775807'
      ''
      
        'DECLARE @ActualRanges TABLE (IDNum int IDENTITY(1,1), [SwipeCard' +
        'RangeID] int, StartValue numeric(25,0), EndValue numeric(25,0))'
      
        'DECLARE @Exceptions TABLE (ExceptionID int IDENTITY(1,1), Except' +
        'ionValue numeric(25,0))'
      ''
      'DECLARE '
      
        '  @ExceptionID int, @ExceptionValue numeric(25,0), @LastExceptio' +
        'nValue numeric(25,0), '
      '  @NewStartValue numeric(25,0), @EndValue numeric(25,0)'
      ''
      
        'SET @NewStartValue = (SELECT CONVERT(numeric(25,0), StartValue) ' +
        'FROM ThemeSwipeCardRange WHERE [SwipeCardRangeID] = @SwipeCardRa' +
        'ngeID)'
      
        'SET @EndValue = (SELECT CONVERT(numeric(25,0), EndValue) FROM Th' +
        'emeSwipeCardRange WHERE [SwipeCardRangeID] = @SwipeCardRangeID)'
      ''
      'INSERT @Exceptions(ExceptionValue)'
      
        'SELECT Value FROM ThemeSwipeCardExceptions WHERE SwipeCardRangeI' +
        'D = @SwipeCardRangeID'
      'ORDER BY CAST(Value AS numeric(25,0))'
      ''
      'IF (SELECT COUNT(*) FROM @Exceptions) = 0'
      'BEGIN'
      '  INSERT @ActualRanges'
      '  SELECT @SwipeCardRangeID, @NewStartValue, @EndValue'
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
      
        '      SELECT @SwipeCardRangeID,@NewStartValue,@ExceptionValue - ' +
        '1'
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
      '  IF @LastExceptionValue < @EndValue'
      '    INSERT @ActualRanges'
      '    SELECT @SwipeCardRangeID, @LastExceptionValue + 1, @EndValue'
      '  ELSE'
      
        '    IF (@LastExceptionValue = @EndValue) AND (@LastExceptionValu' +
        'e <> @NewStartValue)'
      '      INSERT @ActualRanges'
      '      SELECT @SwipeCardRangeID, @NewStartValue, @EndValue - 1'
      'END'
      '  '
      ''
      '-- SAVE TO AZTEC DB'
      'BEGIN TRANSACTION'
      '  DECLARE @IDNum int, @Error int'
      '  '
      
        '  DELETE ThemeSwipeCardExceptionRange WHERE SwipeCardRangeID = @' +
        'SwipeCardRangeID'
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
      
        '    INSERT ThemeSwipeCardExceptionRange (RangeID, SwipeCardRange' +
        'ID, StartValue, EndValue)'
      
        '    VALUES(@NextID, @SwipeCardRangeID, @NewStartValue, @EndValue' +
        ')'
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
    Left = 176
    Top = 96
  end
end
