object Form1: TForm1
  Left = 284
  Top = 191
  BorderStyle = bsSingle
  Caption = 'Chat Server       By: Mohammad Shams'
  ClientHeight = 463
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 86
    Height = 13
    Caption = 'Server Listen port:'
  end
  object Label5: TLabel
    Left = 312
    Top = 50
    Width = 64
    Height = 13
    Caption = 'List of clients:'
  end
  object Label3: TLabel
    Left = 8
    Top = 50
    Width = 100
    Height = 13
    Caption = 'Received Messages:'
  end
  object Label2: TLabel
    Left = 8
    Top = 326
    Width = 25
    Height = 13
    Caption = 'Help:'
  end
  object ListBox1: TListBox
    Left = 312
    Top = 69
    Width = 142
    Height = 220
    ItemHeight = 13
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 105
    Height = 21
    TabOrder = 1
    Text = '9999'
  end
  object Button1: TButton
    Left = 119
    Top = 16
    Width = 91
    Height = 28
    Caption = 'Enable'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 16
    Width = 90
    Height = 28
    Caption = 'Disable'
    Enabled = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 69
    Width = 298
    Height = 220
    Color = clCream
    ReadOnly = True
    TabOrder = 4
  end
  object Edit2: TEdit
    Left = 8
    Top = 295
    Width = 298
    Height = 21
    TabOrder = 5
    Text = 'Type your message here ...'
  end
  object Button3: TButton
    Left = 312
    Top = 295
    Width = 142
    Height = 25
    Caption = 'Send Server Message'
    Enabled = False
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button5: TButton
    Left = 312
    Top = 16
    Width = 142
    Height = 28
    Caption = 'Kill This Client'
    Enabled = False
    TabOrder = 7
    OnClick = Button5Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 344
    Width = 446
    Height = 105
    Color = 13434828
    Lines.Strings = (
      'Note:'
      '1. Server must be enabled, before any using.'
      ''
      'Tips:'
      
        '1. You can kill, every connected client, selecting his Nickname ' +
        'in right list and press Kill'
      
        '2. You can send server message to every connected client, select' +
        'ing his Nickname in right '
      'list and press Send')
    TabOrder = 8
  end
  object Button4: TButton
    Left = 366
    Top = 352
    Width = 81
    Height = 33
    Caption = 'About'
    TabOrder = 9
    OnClick = Button4Click
  end
  object TCP: TIdTCPServer
    Bindings = <>
    DefaultPort = 9999
    OnConnect = TCPConnect
    OnDisconnect = TCPDisconnect
    OnExecute = TCPExecute
    Left = 328
    Top = 248
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 360
    Top = 248
  end
end
