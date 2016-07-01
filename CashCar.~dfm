object fCarExpen: TfCarExpen
  Left = 261
  Top = 194
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1093#1086#1076#1099' '#1085#1072' '#1088#1077#1084#1086#1085#1090' '#1084#1072#1096#1080#1085#1099
  ClientHeight = 399
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  Menu = mmCar
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pCar1: TPanel
    Left = 0
    Top = 0
    Width = 414
    Height = 49
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
    object cebDateRep: TCheckBox
      Left = 8
      Top = 16
      Width = 137
      Height = 17
      Caption = #1055#1086' '#1076#1072#1090#1077' '#1079#1072#1084#1077#1085#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cebDateRepClick
    end
    object deDateRep: TDateEdit
      Left = 144
      Top = 8
      Width = 105
      Height = 25
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object pCar2: TPanel
    Left = 0
    Top = 49
    Width = 414
    Height = 309
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object dbgCar: TDBGridEh
      Left = 1
      Top = 1
      Width = 412
      Height = 307
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh]
      DataSource = dmCash.dsCarExpen
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
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      OnKeyDown = dbgCarKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'replaced'
          Footers = <>
          Title.Caption = #1047#1072#1084#1077#1085#1077#1085#1086
          Width = 207
        end
        item
          EditButtons = <>
          FieldName = 'date_rep'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1084#1077#1085#1099
          Width = 90
        end
        item
          EditButtons = <>
          FieldName = 'cost'
          Footers = <>
          Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
          Width = 86
        end>
    end
  end
  object pCar3: TPanel
    Left = 0
    Top = 358
    Width = 414
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
  object mmCar: TMainMenu
    Left = 352
    Top = 8
    object nOtchet: TMenuItem
      Caption = #1054#1090#1095#1077#1090
      OnClick = nOtchetClick
    end
  end
end
