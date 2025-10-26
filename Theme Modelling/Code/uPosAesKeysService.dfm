object PosAesKeysService: TPosAesKeysService
  OldCreateOrder = False
  Left = 772
  Top = 436
  Height = 149
  Width = 167
  object SoapClient: THTTPRIO
    OnBeforeExecute = SoapClientBeforeExecute
    HTTPWebNode.Agent = 'Borland SOAP 1.1'
    HTTPWebNode.UseUTF8InHeader = False
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody]
    Left = 48
    Top = 32
  end
end
