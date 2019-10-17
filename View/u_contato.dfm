object fr_contato: Tfr_contato
  Left = 0
  Top = 0
  Width = 189
  Height = 76
  TabOrder = 0
  object CardPanel1: TCardPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 183
    Height = 70
    Align = alClient
    ActiveCard = WinControlForm.Card1
    BevelOuter = bvNone
    Caption = 'CardPanel1'
    Color = 16764622
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 24
    ExplicitTop = 16
    ExplicitWidth = 167
    ExplicitHeight = 73
    object Card1: TCard
      Left = 0
      Top = 0
      Width = 183
      Height = 70
      Caption = 'Card1'
      CardIndex = 0
      TabOrder = 0
      ExplicitWidth = 185
      ExplicitHeight = 41
      object Image1: TImage
        Left = 5
        Top = 6
        Width = 43
        Height = 48
      end
      object lbl_contato: TLabel
        Left = 58
        Top = 6
        Width = 39
        Height = 13
        Caption = 'Contato'
      end
    end
  end
end
