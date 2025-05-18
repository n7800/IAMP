object frmPicture: TfrmPicture
  Left = 69
  Top = 135
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Picture Editor'
  ClientHeight = 251
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 256
    Top = 188
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 256
    Top = 220
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object pnlImage: TPanel
    Left = 8
    Top = 8
    Width = 237
    Height = 237
    BevelOuter = bvNone
    BorderWidth = 5
    BorderStyle = bsSingle
    Color = clWindow
    TabOrder = 0
    object pntImage: TPaintBox
      Left = 5
      Top = 5
      Width = 223
      Height = 223
      Align = alClient
      OnPaint = pntImagePaint
    end
  end
  object btnLoad: TButton
    Left = 256
    Top = 8
    Width = 77
    Height = 25
    Caption = '&Load...'
    TabOrder = 1
    OnClick = btnLoadClick
  end
  object btnSave: TButton
    Left = 256
    Top = 40
    Width = 77
    Height = 25
    Caption = '&Save...'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnClear: TButton
    Left = 256
    Top = 72
    Width = 77
    Height = 25
    Caption = '&Clear'
    TabOrder = 3
    OnClick = btnClearClick
  end
  object opdImage: TOpenPictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf,*.jpg)|*.bmp;*.ico;*.emf;*.wmf;*.jp' +
      'g;*.jpeg|Bitmaps (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Meta' +
      'files (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf|JPEG Images (*.jpg)|' +
      '*.jpg;*.jpeg'
    Left = 256
    Top = 128
  end
  object svdImage: TSavePictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf;*.jpg)|*.bmp;*.ico;*.emf;*.wmf;*.jp' +
      'g|Bitmaps (*.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (' +
      '*.emf)|*.emf|Metafiles (*.wmf)|*.wmf|JPEG Images (*.jpg)|*.jpg'
    Options = [ofOverwritePrompt]
    Left = 300
    Top = 128
  end
end
