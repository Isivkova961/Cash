object fCashImport: TfCashImport
  Left = 467
  Top = 371
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 393
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pButton: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 41
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
  end
  object pData: TPanel
    Left = 0
    Top = 41
    Width = 384
    Height = 311
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object lSpisok: TLabel
      Left = 1
      Top = 1
      Width = 382
      Height = 19
      Align = alTop
      Alignment = taCenter
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1087#1080#1089#1086#1082' '#1080#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084#1099#1093' '#1090#1072#1073#1083#1080#1094':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object cebReal: TCheckBox
      Left = 16
      Top = 32
      Width = 97
      Height = 17
      Caption = #1056#1072#1089#1093#1086#1076#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cebRealClick
    end
    object cebVirtual: TCheckBox
      Left = 16
      Top = 64
      Width = 97
      Height = 17
      Caption = #1055#1088#1086#1075#1085#1086#1079#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cebRealClick
    end
    object cebSprav: TCheckBox
      Left = 16
      Top = 224
      Width = 137
      Height = 17
      Caption = #1057#1090#1072#1090#1100#1080' '#1073#1102#1076#1078#1077#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object cebSpisokPokup: TCheckBox
      Left = 16
      Top = 192
      Width = 129
      Height = 17
      Caption = #1057#1087#1080#1089#1086#1082' '#1087#1086#1082#1091#1087#1086#1082
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object cebLekar: TCheckBox
      Left = 160
      Top = 192
      Width = 137
      Height = 17
      Caption = #1057#1087#1080#1089#1086#1082' '#1083#1077#1082#1072#1088#1089#1090#1074
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object cebSpisokBlud: TCheckBox
      Left = 16
      Top = 96
      Width = 113
      Height = 17
      Caption = #1057#1087#1080#1089#1086#1082' '#1073#1083#1102#1076
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = cebRealClick
    end
    object cebStatus: TCheckBox
      Left = 16
      Top = 128
      Width = 153
      Height = 17
      Caption = #1055#1086#1082#1091#1087#1082#1080' '#1074' '#1085#1072#1083#1080#1095#1080#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = cebRealClick
    end
    object cebZKH: TCheckBox
      Left = 160
      Top = 224
      Width = 129
      Height = 17
      Caption = #1054#1087#1083#1072#1090#1072' '#1046#1050#1061
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object cebCar: TCheckBox
      Left = 16
      Top = 160
      Width = 145
      Height = 17
      Caption = #1056#1077#1084#1086#1085#1090' '#1084#1072#1096#1080#1085#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = cebRealClick
    end
    object deRealS: TDateEdit
      Left = 160
      Top = 24
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 9
    end
    object deRealPo: TDateEdit
      Left = 264
      Top = 24
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 10
    end
    object deVirtualS: TDateEdit
      Left = 160
      Top = 56
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 11
    end
    object deVirtualPo: TDateEdit
      Left = 264
      Top = 56
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 12
    end
    object deSpBlS: TDateEdit
      Left = 160
      Top = 88
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 13
    end
    object deSpBlPo: TDateEdit
      Left = 264
      Top = 88
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 14
    end
    object deStatusS: TDateEdit
      Left = 160
      Top = 120
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 15
    end
    object deStatusPo: TDateEdit
      Left = 264
      Top = 120
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 16
    end
    object bCancel: TButton
      Left = 184
      Top = 264
      Width = 90
      Height = 30
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      OnClick = bCancelClick
    end
    object bOK: TButton
      Left = 72
      Top = 264
      Width = 90
      Height = 30
      Caption = #1054#1050
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      OnClick = bOKClick
    end
    object deCarS: TDateEdit
      Left = 160
      Top = 152
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 19
    end
    object deCarPo: TDateEdit
      Left = 264
      Top = 152
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 20
    end
    object cebGoal: TCheckBox
      Left = 296
      Top = 192
      Width = 89
      Height = 17
      Caption = #1062#1077#1083#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
    end
  end
  object pMessage: TPanel
    Left = 0
    Top = 352
    Width = 384
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
end
