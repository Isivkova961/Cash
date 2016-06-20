object fSpisokPokup: TfSpisokPokup
  Left = 315
  Top = 221
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
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pSpisok: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 356
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 0
    object dbgSpisok: TDBGridEh
      Left = 1
      Top = 1
      Width = 282
      Height = 354
      Align = alClient
      AllowedOperations = [alopInsertEh, alopUpdateEh]
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
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          EditButtons = <>
          FieldName = 'name_pokup'
          Footers = <>
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 200
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
    Top = 356
    Width = 284
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 1
  end
end
