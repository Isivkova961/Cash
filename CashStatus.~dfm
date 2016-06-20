object fStatus: TfStatus
  Left = 430
  Top = 268
  Width = 729
  Height = 504
  BorderIcons = [biSystemMenu]
  Caption = #1057#1090#1072#1090#1091#1089' '#1087#1086#1082#1091#1087#1086#1082
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pStatus: TPanel
    Left = 0
    Top = 0
    Width = 713
    Height = 73
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
    object cebDatePokup: TCheckBox
      Left = 8
      Top = 16
      Width = 129
      Height = 17
      Caption = #1055#1086' '#1076#1072#1090#1077' '#1087#1086#1082#1091#1087#1082#1080
      TabOrder = 0
      OnClick = cebDatePokupClick
    end
    object deDatePokup: TDateEdit
      Left = 144
      Top = 8
      Width = 97
      Height = 25
      NumGlyphs = 2
      TabOrder = 1
      OnChange = deDatePokupChange
    end
    object cebStatus: TCheckBox
      Left = 304
      Top = 40
      Width = 97
      Height = 17
      Caption = #1057#1090#1072#1090#1091#1089
      TabOrder = 2
      OnClick = cebStatusClick
    end
    object cebYesStatus: TCheckBox
      Left = 376
      Top = 40
      Width = 49
      Height = 17
      Caption = #1044#1072
      TabOrder = 3
      OnClick = cebYesStatusClick
    end
    object cebOpen: TCheckBox
      Left = 304
      Top = 16
      Width = 201
      Height = 17
      Caption = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1089#1082#1088#1099#1090#1099#1077
      TabOrder = 4
      OnClick = cebOpenClick
    end
    object cebName: TCheckBox
      Left = 8
      Top = 40
      Width = 161
      Height = 17
      Caption = #1055#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
      TabOrder = 5
      OnClick = cebNameClick
    end
    object cobName: TComboBox
      Left = 144
      Top = 32
      Width = 145
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 6
      OnChange = cobNameChange
    end
  end
  object pStatus1: TPanel
    Left = 0
    Top = 425
    Width = 713
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 1
  end
  object pData: TPanel
    Left = 0
    Top = 73
    Width = 713
    Height = 352
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 201
      Top = 1
      Height = 350
      Color = clGradientActiveCaption
      ParentColor = False
    end
    object dbgStatus: TDBGridEh
      Left = 204
      Top = 1
      Width = 508
      Height = 350
      Align = alClient
      DataSource = dmCash.dsStatus
      EvenRowColor = clWhite
      FixedColor = clGradientActiveCaption
      Flat = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      FooterColor = clWhite
      FooterFont.Charset = RUSSIAN_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = 'Times New Roman'
      FooterFont.Style = []
      OddRowColor = clWhite
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      Columns = <
        item
          EditButtons = <>
          FieldName = 'date_pokup'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1082#1091#1087#1082#1080
        end
        item
          EditButtons = <>
          FieldName = 'name_pokup'
          Footers = <>
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'the_end'
          Footers = <>
          Title.Caption = #1047#1072#1082#1086#1085#1095#1080#1083#1086#1089#1100' | '#1057#1090#1072#1090#1091#1089
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'date_end'
          Footers = <>
          Title.Caption = #1047#1072#1082#1086#1085#1095#1080#1083#1086#1089#1100' | '#1044#1072#1090#1072
        end
        item
          EditButtons = <>
          FieldName = 'f_show'
          Footers = <>
          Title.Caption = #1057#1082#1088#1099#1090#1100
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'kol'
          Footers = <>
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 75
        end>
    end
    object vsgStatus: TVirtualStringTree
      Left = 1
      Top = 1
      Width = 200
      Height = 350
      Align = alLeft
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'MS Sans Serif'
      Header.Font.Style = []
      Header.MainColumn = -1
      TabOrder = 1
      OnFreeNode = vsgStatusFreeNode
      OnGetText = vsgStatusGetText
      Columns = <>
    end
  end
end
