object fSpisokLekar: TfSpisokLekar
  Left = 441
  Top = 291
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1087#1080#1089#1086#1082' '#1083#1077#1082#1072#1088#1089#1090#1074
  ClientHeight = 386
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  Menu = mmLekar
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pSpisok1: TPanel
    Left = 0
    Top = 0
    Width = 634
    Height = 41
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
    object sbAddLek: TSpeedButton
      Left = 456
      Top = 8
      Width = 145
      Height = 22
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1083#1077#1082#1072#1088#1089#1090#1074#1086
      Flat = True
      OnClick = sbAddLekClick
    end
    object cebOpen: TCheckBox
      Left = 8
      Top = 16
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
  object pSpisok2: TPanel
    Left = 0
    Top = 41
    Width = 634
    Height = 304
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object dbgLekar: TDBGridEh
      Left = 1
      Top = 1
      Width = 632
      Height = 302
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh]
      DataSource = dmCash.dsLekar
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
      OnCellClick = dbgLekarCellClick
      OnKeyDown = dbgLekarKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'name_lek'
          Footers = <>
          ReadOnly = False
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 138
        end
        item
          EditButtons = <>
          FieldName = 'kol'
          Footers = <>
          ReadOnly = False
          Title.Caption = #1050#1086#1083'-'#1074#1086
          Width = 54
        end
        item
          EditButtons = <>
          FieldName = 'function'
          Footers = <>
          PickList.Strings = (
            #1055#1088#1086#1090#1080#1074#1086#1074#1080#1088#1091#1089#1085#1086#1077
            #1055#1088#1086#1090#1080#1074#1086#1084#1080#1082#1088#1086#1073#1085#1086#1077
            #1042#1080#1090#1072#1084#1080#1085#1099
            #1054#1090' '#1087#1088#1086#1089#1090#1091#1076#1099
            #1054#1090' '#1075#1088#1080#1087#1087#1072
            #1054#1090' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1099
            #1054#1090' '#1076#1072#1074#1083#1077#1085#1080#1103
            #1054#1090' '#1085#1072#1089#1084#1086#1088#1082#1072
            #1044#1083#1103' '#1075#1086#1088#1083#1072
            #1054#1090' '#1089#1087#1072#1079#1084#1072
            #1054#1073#1077#1079#1073#1086#1083#1080#1074#1072#1102#1097#1077#1077
            #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1088#1072#1085
            #1054#1090' '#1087#1072#1088#1072#1079#1080#1090#1086#1074
            #1043#1086#1088#1084#1086#1085#1072#1083#1100#1085#1099#1077
            #1055#1077#1088#1077#1074#1103#1079#1082#1072
            #1054#1090' '#1072#1083#1083#1077#1088#1075#1080#1080
            #1054#1090' '#1086#1078#1086#1075#1086#1074
            #1044#1083#1103' '#1075#1083#1072#1079
            #1044#1083#1103' '#1091#1096#1077#1081
            #1041#1086#1083#1077#1079#1085#1080' '#1078#1077#1083#1091#1076#1082#1072', '#1087#1077#1095#1077#1085#1080
            #1044#1083#1103' '#1087#1086#1083#1086#1089#1090#1080' '#1088#1090#1072
            #1044#1083#1103' '#1082#1086#1078#1080
            #1044#1083#1103' '#1089#1077#1088#1076#1094#1072
            #1044#1083#1103' '#1091#1084#1072)
          Title.Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077
          Width = 114
        end
        item
          EditButtons = <>
          FieldName = 'date_srok_god'
          Footers = <>
          Title.Caption = #1057#1088#1086#1082' '#1075#1086#1076#1085#1086#1089#1090#1080
          Width = 82
        end
        item
          EditButtons = <>
          FieldName = 'the_end'
          Footers = <>
          Title.Caption = #1047#1072#1082#1086#1085#1095#1080#1083#1086#1089#1100' | '#1057#1090#1072#1090#1091#1089
          Width = 61
        end
        item
          EditButtons = <>
          FieldName = 'date_end'
          Footers = <>
          Title.Caption = #1047#1072#1082#1086#1085#1095#1080#1083#1086#1089#1100' | '#1044#1072#1090#1072
          Width = 85
        end
        item
          EditButtons = <>
          FieldName = 'f_show'
          Footers = <>
          Title.Caption = #1057#1082#1088#1099#1090#1100
          Width = 61
        end>
    end
  end
  object pSpisok3: TPanel
    Left = 0
    Top = 345
    Width = 634
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
  object mmLekar: TMainMenu
    Left = 360
    Top = 8
    object nExcel: TMenuItem
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      OnClick = nExcelClick
    end
  end
end
