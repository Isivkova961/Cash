object fCashNewDate: TfCashNewDate
  Left = 430
  Top = 345
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088' '#1076#1072#1090#1099
  ClientHeight = 114
  ClientWidth = 221
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clBlue
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 17
  object pNewDate: TPanel
    Left = 0
    Top = 0
    Width = 221
    Height = 85
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 0
    object lNewDate: TLabel
      Left = 24
      Top = 16
      Width = 72
      Height = 17
      Caption = #1053#1086#1074#1072#1103' '#1076#1072#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object deNewDate: TDateEdit
      Left = 104
      Top = 8
      Width = 105
      Height = 25
      NumGlyphs = 2
      TabOrder = 0
    end
    object bOk: TButton
      Left = 24
      Top = 48
      Width = 80
      Height = 30
      Caption = #1054#1050
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = bOkClick
    end
    object bCancel: TButton
      Left = 120
      Top = 48
      Width = 80
      Height = 30
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 2
      OnClick = bCancelClick
    end
  end
  object pNewDate1: TPanel
    Left = 0
    Top = 85
    Width = 221
    Height = 29
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 1
  end
end
