object fCashDetail: TfCashDetail
  Left = 600
  Top = 361
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103
  ClientHeight = 257
  ClientWidth = 363
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
  object pDetail: TPanel
    Left = 0
    Top = 0
    Width = 363
    Height = 225
    Align = alTop
    Color = clGradientInactiveCaption
    TabOrder = 0
    object lDate: TLabel
      Left = 30
      Top = 24
      Width = 31
      Height = 17
      Caption = #1044#1072#1090#1072
    end
    object lSumma: TLabel
      Left = 176
      Top = 24
      Width = 44
      Height = 17
      Caption = #1057#1091#1084#1084#1072
    end
    object lKateg: TLabel
      Left = 30
      Top = 56
      Width = 106
      Height = 17
      Caption = #1057#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072
    end
    object lKoshel: TLabel
      Left = 30
      Top = 120
      Width = 55
      Height = 17
      Caption = #1050#1086#1096#1077#1083#1077#1082
    end
    object lKomment: TLabel
      Left = 30
      Top = 152
      Width = 85
      Height = 17
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object lKol: TLabel
      Left = 30
      Top = 88
      Width = 73
      Height = 17
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    end
    object deDate: TDateEdit
      Left = 72
      Top = 16
      Width = 96
      Height = 25
      NumGlyphs = 2
      TabOrder = 6
    end
    object ceSumma: TRxCalcEdit
      Left = 232
      Top = 16
      Width = 97
      Height = 25
      AutoSize = False
      NumGlyphs = 2
      TabOrder = 0
    end
    object cobKateg: TComboBox
      Left = 144
      Top = 48
      Width = 185
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 1
    end
    object cobKoshel: TComboBox
      Left = 144
      Top = 112
      Width = 185
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 2
    end
    object eKoment: TEdit
      Left = 144
      Top = 144
      Width = 185
      Height = 25
      TabOrder = 3
    end
    object bOK: TButton
      Left = 80
      Top = 184
      Width = 90
      Height = 30
      Caption = #1054#1050
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = bOKClick
    end
    object bCancel: TButton
      Left = 192
      Top = 184
      Width = 90
      Height = 30
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = bCancelClick
    end
    object eKol: TEdit
      Left = 144
      Top = 80
      Width = 185
      Height = 25
      TabOrder = 7
    end
  end
  object pDetail_but: TPanel
    Left = 0
    Top = 225
    Width = 363
    Height = 32
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 1
  end
end
