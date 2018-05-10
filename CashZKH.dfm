object fCashZKH: TfCashZKH
  Left = 227
  Top = 209
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1087#1083#1072#1090#1072' '#1046#1050#1061
  ClientHeight = 546
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  Menu = mmZKH
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pZKH1: TPanel
    Left = 0
    Top = 0
    Width = 643
    Height = 41
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
    object cebViewNow: TCheckBox
      Left = 8
      Top = 8
      Width = 225
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1079#1072' '#1101#1090#1086#1090' '#1084#1077#1089#1103#1094
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cebViewNowClick
    end
  end
  object pZKH2: TPanel
    Left = 0
    Top = 41
    Width = 643
    Height = 464
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object dbgZKH: TDBGridEh
      Left = 1
      Top = 1
      Width = 641
      Height = 462
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh]
      DataSource = dmCash.dsZKH
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
      OnKeyDown = dbgZKHKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'kateg'
          Footers = <>
          PickList.Strings = (
            #1050#1074#1072#1088#1087#1083#1072#1090#1072
            #1050#1072#1087'. '#1088#1077#1084#1086#1085#1090
            #1069#1083#1077#1082#1090#1088#1086#1101#1085#1077#1088#1075#1080#1103
            #1043#1072#1079
            #1048#1085#1090#1077#1088#1085#1077#1090
            #1042#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077)
          Title.Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
          Width = 182
        end
        item
          EditButtons = <>
          FieldName = 'date_pay'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1086#1087#1083#1072#1090#1099
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'mean_before'
          Footers = <>
          Title.Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103
          Width = 81
        end
        item
          EditButtons = <>
          FieldName = 'mean_new'
          Footers = <>
          Title.Caption = #1053#1086#1074#1099#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1103
          Width = 78
        end
        item
          EditButtons = <>
          FieldName = 'itogo'
          Footers = <>
          Title.Caption = #1053#1072#1073#1077#1078#1072#1083#1086
          Width = 76
        end
        item
          EditButtons = <>
          FieldName = 'summa'
          Footers = <>
          Title.Caption = #1057#1091#1084#1084#1072' '#1086#1087#1083#1072#1090#1099
          Width = 110
        end>
    end
  end
  object pZKH3: TPanel
    Left = 0
    Top = 505
    Width = 643
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
  object mmZKH: TMainMenu
    Left = 576
    Top = 8
    object nOtchet: TMenuItem
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1087#1083#1072#1090#1077' '#1046#1050#1061
      OnClick = nOtchetClick
    end
  end
end
