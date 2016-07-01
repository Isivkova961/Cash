object fCashEvent: TfCashEvent
  Left = 405
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1089#1086#1073#1099#1090#1080#1081
  ClientHeight = 442
  ClientWidth = 712
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
  object pEvent1: TPanel
    Left = 0
    Top = 0
    Width = 712
    Height = 41
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
  end
  object pEvent2: TPanel
    Left = 0
    Top = 41
    Width = 712
    Height = 360
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object dbgEvent: TDBGridEh
      Left = 1
      Top = 1
      Width = 710
      Height = 358
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh, alopAppendEh]
      DataSource = dmCash.dsEvent
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
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      OnKeyDown = dbgEventKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'event'
          Footers = <>
          Title.Caption = #1057#1086#1073#1099#1090#1080#1077
          Width = 166
        end
        item
          EditButtons = <>
          FieldName = 'date_exe'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
          Width = 93
        end
        item
          EditButtons = <>
          FieldName = 'date_recall'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1085#1072#1087#1086#1084#1080#1085#1072#1085#1080#1103
          Width = 87
        end
        item
          EditButtons = <>
          FieldName = 'repet'
          Footers = <>
          Title.Caption = #1055#1086#1074#1090#1086#1088#1103#1090#1100' '#1082#1072#1078#1076#1099#1077' N '#1076#1085#1077#1081
        end
        item
          EditButtons = <>
          FieldName = 'message'
          Footers = <>
          Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
          Width = 265
        end>
    end
  end
  object pEvent3: TPanel
    Left = 0
    Top = 401
    Width = 712
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
end
