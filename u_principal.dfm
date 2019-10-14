object frm_principal: Tfrm_principal
  Left = 0
  Top = 0
  Caption = 'TInject whatsapp component (Beta)'
  ClientHeight = 577
  ClientWidth = 1020
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AddressPnl: TPanel
    Left = 0
    Top = 0
    Width = 1020
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    Visible = False
    object AddressEdt: TEdit
      Left = 5
      Top = 5
      Width = 979
      Height = 20
      Margins.Right = 5
      Align = alClient
      TabOrder = 0
      Text = 'https://web.whatsapp.com/'
      ExplicitHeight = 21
    end
    object GoBtn: TButton
      Left = 984
      Top = 5
      Width = 31
      Height = 20
      Margins.Left = 5
      Align = alRight
      Caption = 'Go'
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 30
    Width = 1020
    Height = 171
    Align = alTop
    TabOrder = 1
    DesignSize = (
      1020
      171)
    object Label1: TLabel
      Left = 13
      Top = 64
      Width = 99
      Height = 13
      Caption = 'N'#250'mero de destino 1'
    end
    object Label2: TLabel
      Left = 13
      Top = 18
      Width = 72
      Height = 13
      Caption = 'Sua mensagem'
    end
    object Label4: TLabel
      Left = 13
      Top = 111
      Width = 243
      Height = 13
      Caption = 'String base64 (Por enquanto apenas imagens png)'
    end
    object Label5: TLabel
      Left = 157
      Top = 64
      Width = 99
      Height = 13
      Caption = 'N'#250'mero de destino 2'
    end
    object Label6: TLabel
      Left = 301
      Top = 64
      Width = 99
      Height = 13
      Caption = 'N'#250'mero de destino 3'
    end
    object Button2: TButton
      Left = 917
      Top = 35
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Enviar texto'
      TabOrder = 0
      OnClick = Button2Click
    end
    object memo_js: TMemo
      Left = 866
      Top = 66
      Width = 118
      Height = 33
      TabOrder = 1
      Visible = False
    end
    object Edit1: TEdit
      Left = 13
      Top = 81
      Width = 121
      Height = 21
      TabOrder = 2
      TextHint = 'ddd+n'#250'mero'
    end
    object Edit2: TEdit
      Left = 13
      Top = 37
      Width = 899
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      TextHint = 'Mensagem de texto'
    end
    object Button3: TButton
      Left = 917
      Top = 126
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Enviar imagem'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button1: TButton
      Left = 917
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Sair'
      TabOrder = 5
    end
    object Edit3: TEdit
      Left = 13
      Top = 128
      Width = 899
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
      Text = 
        'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFc' +
        'SJAAAADUlEQVR42mP8z8DwBwAFAgH9XSO6wwAAAABJRU5ErkJggg=='
      TextHint = 'Mensagem de texto'
    end
    object Edit4: TEdit
      Left = 157
      Top = 81
      Width = 121
      Height = 21
      TabOrder = 7
      TextHint = 'ddd+n'#250'mero'
    end
    object Edit5: TEdit
      Left = 301
      Top = 81
      Width = 121
      Height = 21
      TabOrder = 8
      TextHint = 'ddd+n'#250'mero'
    end
    object Button4: TButton
      Left = 428
      Top = 79
      Width = 75
      Height = 25
      Caption = 'Injetar JS1'
      TabOrder = 9
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 509
      Top = 79
      Width = 75
      Height = 25
      Caption = 'Injetar JS2'
      TabOrder = 10
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 590
      Top = 79
      Width = 75
      Height = 25
      Caption = 'Injetar JS3'
      TabOrder = 11
      OnClick = Button6Click
    end
  end
  object CEFWindowParent1: TCEFWindowParent
    Left = 0
    Top = 201
    Width = 917
    Height = 376
    Align = alClient
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 917
    Top = 201
    Width = 103
    Height = 376
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 136
    Top = 40
  end
  object Timer2: TTimer
    Interval = 4000
    OnTimer = Timer2Timer
    Left = 296
    Top = 40
  end
  object Chromium1: TChromium
    OnLoadEnd = Chromium1LoadEnd
    OnTitleChange = Chromium1TitleChange
    OnConsoleMessage = Chromium1ConsoleMessage
    OnBeforePopup = Chromium1BeforePopup
    OnAfterCreated = Chromium1AfterCreated
    OnBeforeClose = Chromium1BeforeClose
    OnClose = Chromium1Close
    OnOpenUrlFromTab = Chromium1OpenUrlFromTab
    Left = 216
    Top = 176
  end
end
