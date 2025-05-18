object frmTabOrder: TfrmTabOrder
  Left = 150
  Top = 172
  HelpContext = 1638
  BorderStyle = bsDialog
  Caption = 'Edit Tab Order'
  ClientHeight = 241
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblControls: TLabel
    Left = 10
    Top = 2
    Width = 131
    Height = 13
    Caption = '&Controls listed in tab order:'
    FocusControl = lsbControls
  end
  object lsbControls: TListBox
    Left = 10
    Top = 18
    Width = 227
    Height = 173
    DragMode = dmAutomatic
    ItemHeight = 13
    TabOrder = 0
    OnDragDrop = lsbControlsDragDrop
    OnDragOver = lsbControlsDragOver
    OnStartDrag = lsbControlsStartDrag
  end
  object bbtMoveUp: TBitBtn
    Left = 8
    Top = 208
    Width = 25
    Height = 24
    TabOrder = 1
    OnClick = bbtMoveUpClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333338888833333333334444483333333333CCCC483
      333333333CCCC483333333333CCCC483333333333CCCC483333333333CCCC488
      8333333CCCCCCCCC33333333CCCCCCC3333333333CCCCC333333333333CCC333
      33333333333C3333333333333333333333333333333333333333}
    Spacing = -1
  end
  object bbtMoveDown: TBitBtn
    Left = 40
    Top = 208
    Width = 25
    Height = 24
    TabOrder = 2
    OnClick = bbtMoveDownClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333833333333333333488333333333333CC4883333333333CCCC488
      33333333CCCCCC488333333CCCCCC444333333333CCCC483333333333CCCC483
      333333333CCCC483333333333CCCC483333333333CCCC483333333333CCCC433
      3333333333333333333333333333333333333333333333333333}
    Spacing = 0
  end
  object btnOK: TButton
    Left = 76
    Top = 208
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 160
    Top = 208
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
