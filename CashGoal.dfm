object fCashGoal: TfCashGoal
  Left = 388
  Top = 270
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1062#1077#1083#1080
  ClientHeight = 291
  ClientWidth = 320
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
  object pGoal1: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 41
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
    object cebOpenExe: TCheckBox
      Left = 8
      Top = 8
      Width = 209
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1099#1077' '#1094#1077#1083#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cebOpenExeClick
    end
  end
  object pGoal2: TPanel
    Left = 0
    Top = 41
    Width = 320
    Height = 209
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object dbgGoal: TDBGridEh
      Left = 1
      Top = 1
      Width = 318
      Height = 207
      Align = alClient
      AllowedOperations = [alopUpdateEh, alopDeleteEh]
      DataSource = dmCash.dsGoal
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
      OnKeyDown = dbgGoalKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'goal'
          Footers = <>
          Title.Caption = #1062#1077#1083#1100
          Width = 172
        end
        item
          EditButtons = <>
          FieldName = 'cost'
          Footers = <>
          Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
          Width = 72
        end
        item
          EditButtons = <>
          FieldName = 'execution'
          Footers = <>
          Title.Caption = #1042#1099#1087#1086#1083' '#1085#1077#1085#1072
          Width = 51
        end>
    end
  end
  object pGoal3: TPanel
    Left = 0
    Top = 250
    Width = 320
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
end
