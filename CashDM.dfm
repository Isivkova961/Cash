object dmCash: TdmCash
  OldCreateOrder = False
  Left = 487
  Top = 324
  Height = 329
  Width = 436
  object adocCash: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;User ID=Admin;Data Source=data' +
      '.mdb;Mode=Share Deny None;Persist Security Info=False;Jet OLEDB:' +
      'System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database' +
      ' Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking ' +
      'Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk' +
      ' Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Cre' +
      'ate System Database=False;Jet OLEDB:Encrypt Database=False;Jet O' +
      'LEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Withou' +
      't Replica Repair=False;Jet OLEDB:SFP=False;Jet OLEDB:Support Com' +
      'plex Data=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 16
  end
  object adoqReal: TADOQuery
    Active = True
    Connection = adocCash
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM real_pokup')
    Left = 16
    Top = 48
  end
  object dsReal: TDataSource
    DataSet = adoqReal
    Left = 64
    Top = 48
  end
  object adoqVirtual: TADOQuery
    Active = True
    Connection = adocCash
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM virtual_pokup')
    Left = 16
    Top = 96
  end
  object dsVirtual: TDataSource
    DataSet = adoqVirtual
    Left = 64
    Top = 96
  end
  object adoqData: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 16
    Top = 152
  end
  object adoqSprav: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 16
    Top = 208
  end
  object adoqDetail: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 136
    Top = 40
  end
  object adoqSumDate: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 136
    Top = 96
  end
  object adoqDrevo: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 136
    Top = 152
  end
  object adoqSumRV: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 136
    Top = 208
  end
  object adoqDrevo1: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 256
    Top = 40
  end
  object adoqDohod: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 256
    Top = 96
  end
  object adoqRashod: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 256
    Top = 152
  end
  object adoqSpravData: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 256
    Top = 200
  end
end
