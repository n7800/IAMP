object frmStrings: TfrmStrings
  Left = 68
  Top = 135
  BorderStyle = bsDialog
  Caption = 'String List Editor'
  ClientHeight = 259
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    411
    259)
  PixelsPerInch = 96
  TextHeight = 13
  object lblCount: TLabel
    Left = 8
    Top = 4
    Width = 30
    Height = 13
    Caption = '0 lines'
  end
  object btnOK: TButton
    Left = 244
    Top = 228
    Width = 77
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 328
    Top = 228
    Width = 77
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnClear: TButton
    Left = 161
    Top = 228
    Width = 77
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Clear'
    TabOrder = 0
    OnClick = btnClearClick
  end
  object mmoStrings: TMemo
    Left = 8
    Top = 23
    Width = 395
    Height = 199
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    OnChange = mmoStringsChange
  end
end
