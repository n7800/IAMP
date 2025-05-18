object frmAlign: TfrmAlign
  Left = 94
  Top = 218
  BorderStyle = bsDialog
  Caption = 'Alignment'
  ClientHeight = 176
  ClientWidth = 300
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
  object rgrHorizontal: TRadioGroup
    Left = 8
    Top = 4
    Width = 137
    Height = 129
    Caption = 'Horizontal'
    ItemIndex = 0
    Items.Strings = (
      '&No change'
      '&Left sides'
      '&Centers'
      '&Right sides'
      '&Space equally'
      'Center in &window')
    TabOrder = 0
  end
  object rgrVertical: TRadioGroup
    Left = 156
    Top = 4
    Width = 137
    Height = 129
    Caption = 'Vertical'
    ItemIndex = 0
    Items.Strings = (
      'No chan&ge'
      '&Tops'
      'C&enters'
      '&Bottoms'
      'Space e&qually'
      'Center &in &window')
    TabOrder = 1
  end
  object btnOk: TButton
    Left = 132
    Top = 144
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 216
    Top = 144
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
