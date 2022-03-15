object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 276
  Width = 378
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\BD\CURSOMVC.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 152
    Top = 112
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 264
    Top = 104
  end
end
