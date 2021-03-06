object fSpisokPokup: TfSpisokPokup
  Left = 511
  Top = 353
  Width = 300
  Height = 435
  BorderIcons = [biSystemMenu]
  Caption = #1057#1087#1080#1089#1086#1082' '#1087#1086#1082#1091#1087#1086#1082
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  Menu = mmSpisok
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pSpisok: TPanel
    Left = 0
    Top = 33
    Width = 284
    Height = 307
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 0
    object dbgSpisok: TDBGridEh
      Left = 1
      Top = 1
      Width = 282
      Height = 305
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh]
      DataSource = dmCash.dsSpisok
      FixedColor = clGradientActiveCaption
      Flat = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = RUSSIAN_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = 'Times New Roman'
      FooterFont.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      OnKeyDown = dbgSpisokKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'name_pokup'
          Footers = <>
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 205
        end
        item
          EditButtons = <>
          FieldName = 'status'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 51
        end>
    end
  end
  object pSpisok1: TPanel
    Left = 0
    Top = 340
    Width = 284
    Height = 37
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 1
  end
  object pSpisok2: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 33
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 2
    object cebOpen: TCheckBox
      Left = 8
      Top = 8
      Width = 193
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1089#1082#1088#1099#1090#1099#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cebOpenClick
    end
  end
  object mmSpisok: TMainMenu
    Left = 216
    object nExcel: TMenuItem
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      OnClick = nExcelClick
    end
  end
end
