object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Main Controllo Formale di Validit'#224
  ClientHeight = 169
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 33
    Top = 18
    Width = 139
    Height = 15
    Caption = 'CodiceFiscale da Verificare'
  end
  object Label2: TLabel
    Left = 276
    Top = 18
    Width = 88
    Height = 15
    Caption = 'Codice controllo'
  end
  object Label3: TLabel
    Left = 33
    Top = 81
    Width = 131
    Height = 15
    Caption = 'Partita I.V.A. da Verificare'
  end
  object Label4: TLabel
    Left = 276
    Top = 81
    Width = 88
    Height = 15
    Caption = 'Codice controllo'
  end
  object edtCodiceFiscale: TEdit
    Left = 33
    Top = 39
    Width = 151
    Height = 23
    TabOrder = 0
  end
  object btnControlloCF: TButton
    Left = 190
    Top = 38
    Width = 75
    Height = 25
    Caption = 'Controllo'
    TabOrder = 1
    OnClick = btnControlloCFClick
  end
  object edtCFControllo: TEdit
    Left = 276
    Top = 39
    Width = 34
    Height = 23
    TabOrder = 2
  end
  object edtPartitaIVA: TEdit
    Left = 33
    Top = 102
    Width = 151
    Height = 23
    TabOrder = 3
  end
  object bntControlloPI: TButton
    Left = 190
    Top = 101
    Width = 75
    Height = 25
    Caption = 'Controllo'
    TabOrder = 4
    OnClick = bntControlloPIClick
  end
  object edtPIVAControllo: TEdit
    Left = 276
    Top = 102
    Width = 34
    Height = 23
    TabOrder = 5
  end
  object edtPIVA: TEdit
    Left = 276
    Top = 131
    Width = 151
    Height = 23
    TabOrder = 6
  end
end
