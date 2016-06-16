object fSprav: TfSprav
  Left = 498
  Top = 238
  Width = 487
  Height = 438
  BorderIcons = [biSystemMenu]
  Caption = #1057#1090#1072#1090#1100#1080' '#1073#1102#1076#1078#1077#1090#1072
  Color = clGradientActiveCaption
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object tbSprav: TToolBar
    Left = 0
    Top = 0
    Width = 471
    Height = 29
    ButtonHeight = 26
    ButtonWidth = 26
    Flat = True
    Images = ilSprav
    TabOrder = 0
    Transparent = True
    object tbNew: TToolButton
      Left = 0
      Top = 0
      Caption = 'tbNew'
      ImageIndex = 1
      OnClick = tbNewClick
    end
    object tbEdit: TToolButton
      Left = 26
      Top = 0
      Caption = 'tbEdit'
      ImageIndex = 2
      OnClick = tbEditClick
    end
    object tbSepar: TToolButton
      Left = 52
      Top = 0
      Width = 8
      Caption = 'tbSepar'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbDelete: TToolButton
      Left = 60
      Top = 0
      Caption = 'tbDelete'
      ImageIndex = 0
      OnClick = tbDeleteClick
    end
  end
  object pSprav: TPanel
    Left = 0
    Top = 29
    Width = 471
    Height = 339
    Align = alClient
    TabOrder = 1
    object pcSprav: TPageControl
      Left = 1
      Top = 1
      Width = 469
      Height = 337
      ActivePage = tsRashod
      Align = alClient
      HotTrack = True
      TabOrder = 0
      OnChange = pcSpravChange
      object tsDohod: TTabSheet
        Caption = #1044#1086#1093#1086#1076#1099
        object vstDohod: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 461
          Height = 305
          Align = alClient
          ButtonFillMode = fmWindowColor
          Color = clHighlightText
          Colors.BorderColor = clGradientActiveCaption
          Colors.GridLineColor = clGray
          Colors.UnfocusedSelectionBorderColor = clBlue
          DefaultNodeHeight = 17
          Header.AutoSizeIndex = -1
          Header.Background = clGradientActiveCaption
          Header.Font.Charset = RUSSIAN_CHARSET
          Header.Font.Color = clBlue
          Header.Font.Height = -13
          Header.Font.Name = 'Times New Roman'
          Header.Font.Style = [fsBold]
          Header.Height = 21
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
          ScrollBarOptions.ScrollBars = ssVertical
          TabOrder = 0
          TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnFreeNode = vstDohodFreeNode
          OnGetText = vstDohodGetText
          Columns = <
            item
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment]
              Position = 0
              Width = 457
              WideText = #1057#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072
            end>
          WideDefaultText = ''
        end
      end
      object tsRashod: TTabSheet
        Caption = #1056#1072#1089#1093#1086#1076#1099
        ImageIndex = 1
        object vstRashod: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 461
          Height = 305
          Align = alClient
          ButtonFillMode = fmWindowColor
          Color = clHighlightText
          Colors.BorderColor = clGradientActiveCaption
          Colors.GridLineColor = clGray
          Colors.UnfocusedSelectionBorderColor = clBlue
          DefaultNodeHeight = 17
          Header.AutoSizeIndex = -1
          Header.Background = clGradientActiveCaption
          Header.Font.Charset = RUSSIAN_CHARSET
          Header.Font.Color = clBlue
          Header.Font.Height = -13
          Header.Font.Name = 'Times New Roman'
          Header.Font.Style = [fsBold]
          Header.Height = 21
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
          ScrollBarOptions.ScrollBars = ssVertical
          TabOrder = 0
          TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
          TreeOptions.StringOptions = [toAutoAcceptEditChange]
          OnFreeNode = vstRashodFreeNode
          OnGetText = vstRashodGetText
          Columns = <
            item
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment]
              Position = 0
              Width = 457
              WideText = #1057#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072
            end>
          WideDefaultText = ''
        end
      end
    end
  end
  object pSprav_but: TPanel
    Left = 0
    Top = 368
    Width = 471
    Height = 32
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
  object ilSprav: TImageList
    Left = 184
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000607EEFF5C5CC2FF0000000000000000000000007A4E0DFF7C4D
      08FF7B4D08FF7B4D08FF7B4D08FF7B4D08FF7B4D08FF7B4D08FF7B4D08FF7B4D
      08FF7A4C07FF764708FF764708FF00000000163598FF5B73C2FF677BC7FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003357FFFF2E51FFFF233E
      FFFF3633FAFF0000000000000000000000000000000000000000000000000000
      0000706EDBFF0B13FFFF5A5AC1FF0000000000000000000000007F5314FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF2EEE4FF7F5314FF000000006A82CAFF000567FF61BDF1FF4FCA
      FEFF1D77DCFF6F82CAFF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000325BFFFF2C4FFFFF233F
      FFFF1628FFFF0000000000000000000000000000000000000000000000000000
      00000200EAFF0509EFFF0000000000000000000000000000000090682AFFFFFF
      FFFFF2F0E8FFF2EFE3FFF2EFE5FFF2EFE5FFF2EFE5FFECE2DAFFEDE5DBFFF0E9
      E0FFE8DFCFFFE4DBCCFF835410FF00000000000000FF91CEF2FFAAEAFFFF71D5
      FFFF60D6FFFF0E5FCDFF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007190FFFF284BFFFF233D
      FFFF1F3AFFFF0000000000000000000000000000000000000000000000000500
      FFFF100CFFFF4948BDFF000000000000000000000000000000009E7B41FFFFFF
      FFFFF5F3EDFFF5F2EDFFF5F2EDFFF5F2EDFFF5F2EDFFF5F2EBFFF4F2E7FFF5F2
      EDFFF2EFE4FFE3D9CAFF845611FF00000000000000FF90C3E9FFDBF5FFFF33D3
      FEFF00B7F8FF0E78DAFF0977DAFF5F7DCDFF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004248FFFF5275FFFF233D
      FFFF1F39FFFF0B10FBFF00000000000000000000000000000000000000000F07
      FFFF100CFFFF00000000000000000000000000000000000000009E7B41FFFFFF
      FFFFF5F3EDFFF5F2EDFFF5F2EDFFF5F2EDFFF5F2EDFFF6F2EEFFF6F3EEFFF6F4
      F0FFF3F2E7FFE3D9CAFF845611FF00000000000000FF5080D1FFFFFFFFFF01CF
      F9FF00C5FAFF1B83DCFF0E78DAFF1482E0FF617DCFFF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000400FFFF213D
      FFFF1E38FFFF192CFFFF0C15FFFF00000000000000000601FBFF0F09FFFF0F08
      FFFF0400CEFF00000000000000000000000000000000000000009E7B41FFFFFF
      FFFFF5F3EDFFF5F2EDFFF5F2EDFFF5F1ECFFF9F7F2FFF8F4F0FFFCF6F4FFFDF6
      F4FFF5EEECFFE3D9C9FF845611FF00000000000000FF000000FF6FA1DDFF05F2
      F7FF01E7F6FF00C5FAFF03B8F8FF0E78DAFF0975D8FF6281D2FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007591
      FFFF1D38FFFF192BFFFF1824FFFF0000000000000000110DFFFF0F09FFFF0500
      F8FF706ED6FF00000000000000000000000000000000000000009E7B41FFFFFF
      FFFFF5F3EDFFF5F2EDFFF5F2EDFFF5F2ECFFF7F5EFFFFCF9F2FFFAF7F1FFFCF7
      F6FFF4ECE1FFE3DACBFF845612FF00000000000000FF000000FF000000FF3CFF
      FDFF05F2F7FF00CAF8FF00C5FAFF1B83DCFF0E78DAFF1482E1FF6283D5FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B58
      FAFF414AFFFF1728FFFF1825FFFF1317FFFF1616FFFF120EFFFF120CFFFF0000
      00000000000000000000000000000000000000000000000000009C7D4EFFFFFF
      FFFFF7F4ECFFF5F2ECFFF7F4F0FFFAF4F3FFFAFAF3FFFBFAF9FFFCF7F6FFF4ED
      E9FFE9E0D4FFE2D3C4FF855915FF00000000000000FF000000FF000000FF0000
      00FF489EDBFF05F2F7FF01E7F6FF00C5FAFF03B8F8FF0E78DAFF0975D8FF6386
      D7FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000201EF6FF5568FFFF1723FFFF171CFFFF1616FFFF1211FFFF0803EBFF0000
      0000000000000000000000000000000000000000000000000000A08659FFFFFF
      FFFFFBFAF4FFF8F8EFFFFAF8F6FFFAF9F8FFFAFBF6FFF9F8F9FFF5F4EEFFEDE9
      E3FFE3DBCEFFDACAB6FF875B17FF00000000000000FF000000FF000000FF0000
      00FF000000FF3CFFFDFF05F2F6FF00CAF8FF00C5FAFF1B83DCFF0E78DAFF1582
      E1FF6488D8FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008D88FBFF2638FFFF1B25FFFF1B1FFFFF1C1CFFFF0D09E9FF000000000000
      0000000000000000000000000000000000000000000000000000B1946EFFFFFF
      FFFFFCFCFBFFFAFAFBFFFAFAFBFFFAFAFBFFFCFCFAFFF2EFE5FFEEEAE3FFE4DD
      D1FFDCCDBDFFC7B695FF8A5E1DFF00000000000000FF000000FF000000FF0000
      00FF000000FF000000FF4BA0DEFF04F1F6FF01E7F6FF00C5FAFF03B8F8FF0E78
      DAFF0A77D9FF6087DBFF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000545B
      FFFF637AFFFF5F70FFFF5F6CFFFF4B4FFFFF4142FFFF2624FFFF130DEAFF0000
      0000000000000000000000000000000000000000000000000000B89E75FFFFFF
      FFFFFCFCFCFFFAFAFAFFFAFAFBFFFAFCF9FFF8F9F5FFF1EDE3FFECE8E0FFE5D8
      CFFFDAC8B7FFC1AE8FFF8B6220FF00000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF33F9FAFF04F1F6FF00CAF8FF00C5FAFF1B84
      DCFF0E7DE1FF3D5B81FF638EDCFF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006F83FFFF7894FFFF6F85
      FFFF6C81FFFF6373FFFF7D8AFFFF6059EFFF5B54EFFF8F8DFFFF5B55FFFF514B
      F8FF000000000000000000000000000000000000000000000000BCA682FFFFFF
      FFFFF7FCFCFFFAFBFBFFFAFCFAFFF4F1E6FFF1EBE2FFE0D4C3FFBDA178FFF3F1
      F0FFF2EEE4FFB89D74FF90682AFF00000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF57A6E0FF04F1F6FF01E8F6FF009A
      DEFF4E717FFFFFFEF3FF5D6493FF82A1E3FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AAA5FFFF809CFFFF7B94FFFF7389
      FFFF6F84FFFF95A3FFFF8989FCFF0000000000000000807DF7FFAAA6FFFF5C56
      FFFF5754FFFF0000000000000000000000000000000000000000BCA584FFFFFF
      FFFFF9FCFCFFFCFCFCFFF8F9F4FFEFE9E0FFEEE3DAFFD1C1A9FFBDA178FFF2EE
      E4FFDCCEBDFF9E7B41FF0000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF32F9FAFF04F7FCFF4F7A
      87FFFFF7F3FF596293FF0001D0FF1238DDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009093FFFF839FFFFF8098FFFF95A5
      FFFFA9B3FFFF0000000000000000000000000000000000000000000000007873
      EDFFA19BFDFF979DFFFF7680FBFF000000000000000000000000BEAB89FFFFFF
      FFFFFAFAFCFFF9F0E9FFF4E8E0FFE3DBD0FFDED0BDFFCAB28FFFAC9467FFB599
      6FFF9E7B41FF000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF9CB4CCFFFFFF
      FFFF627791FF0920F6FF0613F2FF2546E2FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007871FFFFBCCDFFFFB4C5FFFF979C
      FDFF6F69FBFF0000000000000000000000000000000000000000000000000000
      00006B68DEFF8C8DF2FF9FA7FAFF797EE6FF0000000000000000BEAB89FFFFFF
      FFFFFFFFFFFFF8F5F4FFF5EDE7FFE0D7CBFFDACCB4FFC3AD86FF997B41FF9E7B
      41FF00000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF7688
      94FF115CD8FF1041F5FF081DF2FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C0AE8CFFBFA9
      87FFBEA886FFBFA988FFC0AA89FFBEA27BFFBEA47EFFA78D5CFF9A723AFF0000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF378FE7FF3476E5FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFF9C0011FFF000087F1C00103FF0000
      87F3C00183FF000087E3C00180FF000083E7C001807F0000C187C001C03F0000
      E187C001E01F0000E01FC001F00F0000F01FC001F8070000F03FC001FC030000
      E01FC001FE010000800FC001FF0000000187C003FF80000007E1C007FFC00000
      07F0C00FFFE10000FFFFC01FFFF3000000000000000000000000000000000000
      000000000000}
  end
end
