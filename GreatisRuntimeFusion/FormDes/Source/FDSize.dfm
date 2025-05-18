object frmSize: TfrmSize
  Left = 97
  Top = 180
  BorderStyle = bsDialog
  Caption = 'Size'
  ClientHeight = 157
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grbWidth: TGroupBox
    Left = 8
    Top = 4
    Width = 161
    Height = 109
    Caption = 'Width'
    TabOrder = 0
    object rbtWNoChange: TRadioButton
      Left = 8
      Top = 16
      Width = 137
      Height = 17
      Caption = '&No change'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbtClick
    end
    object rbtWToSmallest: TRadioButton
      Left = 8
      Top = 36
      Width = 137
      Height = 17
      Caption = '&Shrink to smallest'
      TabOrder = 1
      OnClick = rbtClick
    end
    object rbtWToLargest: TRadioButton
      Left = 8
      Top = 56
      Width = 137
      Height = 17
      Caption = '&Grow to largest'
      TabOrder = 2
      OnClick = rbtClick
    end
    object rbtWidth: TRadioButton
      Left = 8
      Top = 76
      Width = 65
      Height = 17
      Caption = 'Width:'
      TabOrder = 3
      OnClick = rbtClick
    end
    object edtWidth: TEdit
      Left = 76
      Top = 76
      Width = 73
      Height = 21
      Enabled = False
      MaxLength = 9
      TabOrder = 4
      OnKeyPress = edtKeyPress
    end
  end
  object grbHeight: TGroupBox
    Left = 180
    Top = 4
    Width = 161
    Height = 109
    Caption = 'Height'
    TabOrder = 1
    object rbtHNoChange: TRadioButton
      Left = 8
      Top = 16
      Width = 137
      Height = 17
      Caption = 'No &change'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbtClick
    end
    object rbtHToSmallest: TRadioButton
      Left = 8
      Top = 36
      Width = 137
      Height = 17
      Caption = 'Shrin&k to smallest'
      TabOrder = 1
      OnClick = rbtClick
    end
    object rbtHToLargest: TRadioButton
      Left = 8
      Top = 56
      Width = 137
      Height = 17
      Caption = 'Grow to &largest'
      TabOrder = 2
      OnClick = rbtClick
    end
    object rbtHeight: TRadioButton
      Left = 8
      Top = 76
      Width = 65
      Height = 17
      Caption = 'Heigh&t:'
      TabOrder = 3
      OnClick = rbtClick
    end
    object edtHeight: TEdit
      Left = 76
      Top = 76
      Width = 73
      Height = 21
      Enabled = False
      MaxLength = 9
      TabOrder = 4
      OnKeyPress = edtKeyPress
    end
  end
  object btnOk: TButton
    Left = 180
    Top = 124
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 264
    Top = 124
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
