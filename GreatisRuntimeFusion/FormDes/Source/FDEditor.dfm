object frmFDEditor: TfrmFDEditor
  Left = 66
  Top = 172
  BorderStyle = bsDialog
  ClientHeight = 177
  ClientWidth = 364
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
  object lsbLocked: TListBox
    Left = 8
    Top = 48
    Width = 261
    Height = 121
    IntegralHeight = True
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
  object lsbTransparent: TListBox
    Left = 8
    Top = 48
    Width = 261
    Height = 121
    IntegralHeight = True
    ItemHeight = 13
    Sorted = True
    TabOrder = 8
  end
  object lsbProtected: TListBox
    Left = 8
    Top = 48
    Width = 261
    Height = 121
    IntegralHeight = True
    ItemHeight = 13
    Sorted = True
    TabOrder = 2
    OnClick = lsbProtectedClick
  end
  object btnAdd: TButton
    Left = 280
    Top = 8
    Width = 77
    Height = 25
    Caption = '&Add...'
    TabOrder = 3
    OnClick = btnAddClick
  end
  object btnDelete: TButton
    Left = 280
    Top = 36
    Width = 77
    Height = 25
    Caption = '&Delete'
    TabOrder = 4
    OnClick = btnDeleteClick
  end
  object btnOk: TButton
    Left = 280
    Top = 116
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object btnCancel: TButton
    Left = 280
    Top = 144
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object btnClear: TButton
    Left = 280
    Top = 64
    Width = 77
    Height = 25
    Caption = '&Clear'
    TabOrder = 5
    OnClick = btnClearClick
  end
  object rgrControls: TRadioGroup
    Left = 8
    Top = 4
    Width = 261
    Height = 37
    Caption = 'Controls'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Locked'
      'Protected'
      'Transparent')
    TabOrder = 0
    OnClick = rgrControlsClick
  end
end
