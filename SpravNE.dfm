object fSpravNE: TfSpravNE
  Left = 561
  Top = 435
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1082#1085#1086' '#1088#1077#1076#1072#1082#1090#1086#1088#1072
  ClientHeight = 165
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pSpravNE: TPanel
    Left = 0
    Top = 0
    Width = 277
    Height = 136
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 0
    object lKateg: TLabel
      Left = 16
      Top = 16
      Width = 65
      Height = 17
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
    end
    object lName: TLabel
      Left = 16
      Top = 48
      Width = 91
      Height = 17
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    end
    object cobKateg: TComboBox
      Left = 112
      Top = 8
      Width = 145
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 0
      OnChange = cobKategChange
      OnKeyDown = cobKategKeyDown
    end
    object eName: TEdit
      Left = 112
      Top = 40
      Width = 145
      Height = 25
      TabOrder = 1
    end
    object bSave: TButton
      Left = 32
      Top = 96
      Width = 90
      Height = 30
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 2
      OnClick = bSaveClick
    end
    object bCancel: TButton
      Left = 136
      Top = 96
      Width = 90
      Height = 30
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 3
      OnClick = bCancelClick
    end
    object cebMed: TCheckBox
      Left = 16
      Top = 72
      Width = 113
      Height = 17
      Caption = #1052#1077#1076#1080#1082#1072#1084#1077#1085#1090#1099
      TabOrder = 4
    end
    object cebSpPokup: TCheckBox
      Left = 136
      Top = 72
      Width = 129
      Height = 17
      Caption = #1057#1087#1080#1089#1086#1082' '#1087#1086#1082#1091#1087#1086#1082
      TabOrder = 5
    end
  end
  object pSpravNE1: TPanel
    Left = 0
    Top = 136
    Width = 277
    Height = 29
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 1
  end
end
