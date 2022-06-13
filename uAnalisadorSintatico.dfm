object fAnalisadorSintatico: TfAnalisadorSintatico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Analisador Sint'#225'tico'
  ClientHeight = 632
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object lbl_sentenca: TLabel
    Left = 54
    Top = 155
    Width = 58
    Height = 16
    Caption = 'Senten'#231'a:'
  end
  object lbl_gramatica: TLabel
    Left = 8
    Top = 4
    Width = 63
    Height = 16
    Caption = 'Gram'#225'tica:'
  end
  object Label1: TLabel
    Left = 407
    Top = 4
    Width = 108
    Height = 16
    Caption = 'Tabela de Parsing:'
  end
  object lbl_resposta: TLabel
    Left = 452
    Top = 211
    Width = 102
    Height = 23
    Caption = 'RESPOSTA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 213
    Width = 210
    Height = 16
    Caption = 'Velocidade de Gera'#231#227'o (Segundos) :'
  end
  object edt_sentenca: TEdit
    Left = 54
    Top = 174
    Width = 722
    Height = 24
    TabOrder = 0
    OnChange = edt_sentencaChange
    OnKeyPress = edt_sentencaKeyPress
  end
  object stg_gramatica: TStringGrid
    Left = 8
    Top = 22
    Width = 393
    Height = 131
    TabStop = False
    BevelInner = bvNone
    ColCount = 9
    Enabled = False
    FixedCols = 0
    FixedRows = 0
    GradientEndColor = clWindow
    Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect]
    ScrollBars = ssNone
    TabOrder = 6
    OnDrawCell = stg_gramaticaDrawCell
    ColWidths = (
      64
      130
      128
      64
      64
      64
      64
      64
      64)
  end
  object btn_total: TButton
    Left = 570
    Top = 204
    Width = 100
    Height = 37
    Caption = 'Total'
    Enabled = False
    TabOrder = 2
    OnClick = btn_totalClick
  end
  object btn_passo_a_passo: TButton
    Left = 676
    Top = 204
    Width = 100
    Height = 37
    Caption = '&Passo a Passo'
    Enabled = False
    TabOrder = 3
    OnClick = btn_passo_a_passoClick
  end
  object stg_principal: TStringGrid
    Left = 8
    Top = 247
    Width = 768
    Height = 377
    TabStop = False
    ColCount = 4
    DefaultColWidth = 190
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 7
    OnDrawCell = stg_principalDrawCell
    ColWidths = (
      30
      190
      190
      190)
  end
  object dbg_parsing: TDBGrid
    Left = 407
    Top = 22
    Width = 369
    Height = 131
    DataSource = src_tabparsing
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbg_parsingCellClick
    OnExit = dbg_parsingExit
    OnMouseUp = dbg_parsingMouseUp
    Columns = <
      item
        Expanded = False
        FieldName = 'info_1'
        Title.Caption = '      '
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'info_2'
        Title.Caption = 'a'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'info_3'
        Title.Caption = 'b'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'info_4'
        Title.Caption = 'c'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'info_5'
        Title.Caption = 'd'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'info_6'
        Title.Caption = '$'
        Width = 57
        Visible = True
      end>
  end
  object nmb_velocidade: TNumberBox
    Left = 214
    Top = 210
    Width = 121
    Height = 24
    Mode = nbmFloat
    MinValue = 0.100000000000000000
    MaxValue = 10.000000000000000000
    TabOrder = 1
    Value = 1.000000000000000000
  end
  object btn_gerar: TBitBtn
    Left = 8
    Top = 171
    Width = 40
    Height = 31
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      08000000000040020000C40E0000C40E00000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6086C6B6B6C08FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF608746C6C6C6B636BB408FFFFFFFFFFFFFFFFFFFFFFF608
      746C6C6C6C6C6B63AD6C6B6C08FFFFFFFFFFFFFFFF08746C6C6C6C6C6C6C6B63
      07F7636B6B7408FFFFFFFFFFB574BE7474746C6C6CB46B63ADAC63636B6B6B08
      FFFFFFFF7408F6B57474747474B56B63636363636307B5B5FFFFFFFF74080874
      B574747474B56B62636363AC6307B5B5FFFFFFFF747474B5FF08747474B56B62
      6262AC076C6363B5FFFFFFFF747474B5F6B575B574B56C22AC6363F7636363B5
      FFFFFFFF747474747574F6FF75BE6C6307F76262636363B5FFFFFFFF74747474
      7474F60874BE6C62F7AC226262F7ACB5FFFFFFFF7474747474747575B508B563
      22222222630707B5FFFFFFFF747474747475BD08080808BEB56B622262A463AD
      FFFFFFFF747474B5BE0808BEBEBDBDBDB5B5B56C6322226CFFFFFFFFB5BE0808
      08BEBEBEBEBDBDB5B5B5B5B5AC6B63ACFFFFFFFFF6080808BEBEBEBEBE0808BD
      B5B5757575746CF6FFFFFFFFFFF608BEBEBEBEBE08F6F6BEB575757575BEF6FF
      FFFFFFFFFFFFFFF608BEBEBDBDB5B5B5B575BD08FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFF608BDB5B5B5BEF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF60808F6
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 5
    OnClick = btn_gerarClick
  end
  object tmr: TTimer
    Enabled = False
    OnTimer = tmrTimer
    Left = 536
    Top = 72
  end
  object cds_tabparsing: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'info_1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'info_2'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'info_3'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'info_4'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'info_5'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'info_6'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 416
    Top = 72
    object cds_tabparsinginfo_1: TStringField
      FieldName = 'info_1'
    end
    object cds_tabparsinginfo_2: TStringField
      FieldName = 'info_2'
    end
    object cds_tabparsinginfo_3: TStringField
      FieldName = 'info_3'
    end
    object cds_tabparsinginfo_4: TStringField
      FieldName = 'info_4'
    end
    object cds_tabparsinginfo_5: TStringField
      FieldName = 'info_5'
    end
    object cds_tabparsinginfo_6: TStringField
      FieldName = 'info_6'
    end
  end
  object src_tabparsing: TDataSource
    DataSet = cds_tabparsing
    Left = 480
    Top = 72
  end
end
