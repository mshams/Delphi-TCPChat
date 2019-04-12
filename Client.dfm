object Form1: TForm1
  Left = 225
  Top = 177
  BorderStyle = bsSingle
  Caption = 'Chat Client       By: Mohammad Shams'
  ClientHeight = 401
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Server IP:'
  end
  object Label2: TLabel
    Left = 128
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Server Port:'
  end
  object Label3: TLabel
    Left = 8
    Top = 54
    Width = 100
    Height = 13
    Caption = 'Received Messages:'
  end
  object Label4: TLabel
    Left = 224
    Top = 8
    Width = 76
    Height = 13
    Caption = 'Your Nickname:'
  end
  object Label5: TLabel
    Left = 351
    Top = 54
    Width = 64
    Height = 13
    Caption = 'List of clients:'
  end
  object Label6: TLabel
    Left = 8
    Top = 270
    Width = 25
    Height = 13
    Caption = 'Help:'
  end
  object Memo1: TMemo
    Left = 8
    Top = 70
    Width = 337
    Height = 153
    Color = clCream
    ReadOnly = True
    TabOrder = 0
    OnDblClick = Memo1DblClick
  end
  object Edit1: TEdit
    Left = 9
    Top = 24
    Width = 113
    Height = 21
    MaxLength = 15
    TabOrder = 1
    Text = '127.0.0.1'
  end
  object Edit2: TEdit
    Left = 128
    Top = 24
    Width = 81
    Height = 21
    MaxLength = 5
    TabOrder = 2
    Text = '9999'
  end
  object Button1: TButton
    Left = 351
    Top = 8
    Width = 66
    Height = 37
    Caption = 'Connect'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 417
    Top = 8
    Width = 66
    Height = 37
    Caption = 'Disconnect'
    Enabled = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit3: TEdit
    Left = 8
    Top = 229
    Width = 233
    Height = 31
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'Type your message here ...'
  end
  object Button3: TButton
    Left = 247
    Top = 229
    Width = 98
    Height = 31
    Caption = 'Send'
    Enabled = False
    TabOrder = 6
    OnClick = Button3Click
  end
  object Edit4: TEdit
    Left = 224
    Top = 24
    Width = 121
    Height = 21
    MaxLength = 15
    TabOrder = 7
    Text = 'Client1'
    OnKeyPress = Edit4KeyPress
  end
  object ListBox1: TListBox
    Left = 351
    Top = 70
    Width = 132
    Height = 153
    ItemHeight = 13
    TabOrder = 8
  end
  object Button4: TButton
    Left = 351
    Top = 229
    Width = 132
    Height = 31
    Caption = 'Get Clients List'
    Enabled = False
    TabOrder = 9
    OnClick = Button4Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 284
    Width = 475
    Height = 105
    Color = 13434828
    Lines.Strings = (
      'Note:'
      '1. Client  must be connected, before any using.'
      ''
      'Tips:'
      '1. You can get clients list by pressing GetClientList buttom.'
      
        '2. You can send message to every connected client, selecting his' +
        ' Nickname in right '
      'list and press Send')
    TabOrder = 10
  end
  object Button5: TButton
    Left = 392
    Top = 296
    Width = 81
    Height = 33
    Caption = 'About'
    TabOrder = 11
    OnClick = Button5Click
  end
  object Tcp: TIdTCPClient
    OnDisconnected = TcpDisconnected
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    OnConnected = TcpConnected
    Port = 9999
    ReadTimeout = 0
    Left = 48
    Top = 120
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 96
    Top = 120
  end
end
