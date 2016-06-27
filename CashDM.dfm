object dmCash: TdmCash
  OldCreateOrder = False
  Left = 597
  Top = 211
  Height = 390
  Width = 480
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
  object adoqSpisok: TADOQuery
    Connection = adocCash
    AfterInsert = adoqSpisokAfterInsert
    Parameters = <>
    Left = 328
    Top = 152
  end
  object adoqStatus: TADOQuery
    Connection = adocCash
    CursorType = ctStatic
    AfterInsert = adoqStatusAfterInsert
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM status_pokup')
    Left = 328
    Top = 200
  end
  object adoqSpravoch: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 328
    Top = 40
  end
  object dsStatus: TDataSource
    DataSet = adoqStatus
    Left = 376
    Top = 200
  end
  object adoqDetail1: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 176
    Top = 40
  end
  object dsSpisok: TDataSource
    DataSet = adoqSpisok
    Left = 376
    Top = 152
  end
  object adoqLekar: TADOQuery
    Active = True
    Connection = adocCash
    CursorType = ctStatic
    AfterInsert = adoqLekarAfterInsert
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM spisok_lekar')
    Left = 328
    Top = 96
  end
  object dsLekar: TDataSource
    DataSet = adoqLekar
    Left = 376
    Top = 96
  end
  object adoqDrevo2: TADOQuery
    Connection = adocCash
    Parameters = <>
    Left = 136
    Top = 264
  end
  object adoqItog: TADOQuery
    Active = True
    Connection = adocCash
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM itog')
    Left = 16
    Top = 256
  end
  object dsItog: TDataSource
    DataSet = adoqItog
    Left = 64
    Top = 256
  end
  object adoqSpisokBlud: TADOQuery
    Active = True
    Connection = adocCash
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM itog')
    Left = 328
    Top = 256
  end
  object dsSpisokBlud: TDataSource
    DataSet = adoqSpisokBlud
    Left = 376
    Top = 256
  end
  object adoqBludoPr: TADOQuery
    Active = True
    Connection = adocCash
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT Bludo_pr.*, spisok_blud.name_bludo'
      'FROM Bludo_pr,spisok_blud'
      'WHERE Bludo_pr.id_bludo=spisok_blud.id')
    Left = 328
    Top = 304
  end
  object dsBludoPr: TDataSource
    DataSet = adoqBludoPr
    Left = 376
    Top = 304
  end
  object adoqAddBludo: TADOQuery
    Connection = adocCash
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 256
    Top = 256
  end
end
