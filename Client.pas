unit Client;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,strutils,
  IdTCPConnection, IdTCPClient, StdCtrls, IdCmdTCPClient, IdMessage, about;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit3: TEdit;
    Button3: TButton;
    Tcp: TIdTCPClient;
    IdAntiFreeze1: TIdAntiFreeze;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    ListBox1: TListBox;
    Button4: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Memo2: TMemo;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    Function connect: Boolean;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure TcpDisconnected(Sender: TObject);
    procedure TcpConnected(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TClientHandleThread = Class(TThread)          //Class Thread
  Private
     Msg:string[100];
     Procedure HandleInput;   //Input of Transfer data
  Protected
     Procedure Execute; Override;  //Excute the client
  End;

var
  Form1: TForm1;
  CHThread : TClientHandleThread;
implementation

{$R *.dfm}

Procedure TClientHandleThread.HandleInput;
var  s,t:string;
begin
t:=MidStr(msg,1,5);
s:=RightStr(msg, length(msg)-5);

if t='list:' then
  begin
  form1.listbox1.Items.Delimiter:=':';
  form1.listbox1.Items.DelimitedText:=s
  end
else
  form1.Memo1.Lines.Add(msg);
end;

procedure TClientHandleThread.Execute;
begin
While Not Terminated Do
 Begin
  IF Not form1.tcp.Connected Then
    Terminate
  Else
  Try
    msg:=form1.Tcp.IOHandler.ReadLn;
    Synchronize(HandleInput);
  Except
  End;
End;
end;


function TForm1.Connect: Boolean;
begin
Try
  Tcp.Host:=edit1.Text;
  Tcp.Port:=StrToInt(Edit2.text);
  Tcp.Connect;
  CHThread := TClientHandleThread.Create(True);
  CHThread.FreeOnTerminate:=True;
  CHThread.Resume;
  Result := True;
Except
  Result := False;
End;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
if key=' ' then key:=#0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if connect then
  begin
  Button2.Enabled:=true;
  Button3.Enabled:=true;
  Button4.Enabled:=true;
  form1.Memo1.Lines.Add('Connected.');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
tcp.Disconnect;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if ListBox1.ItemIndex>-1 then
  tcp.IOHandler.WriteLn(listbox1.Items.Strings[listbox1.ItemIndex]+'>'+edit4.text+': '+edit3.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
tcp.IOHandler.WriteLn('list:');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
form2.Show;
end;

procedure TForm1.Memo1DblClick(Sender: TObject);
begin
memo1.Clear;
end;

procedure TForm1.TcpConnected(Sender: TObject);
begin
tcp.IOHandler.WriteLn('nick:'+edit4.Text);
end;

procedure TForm1.TcpDisconnected(Sender: TObject);
begin
Button2.Enabled:=false;
Button3.Enabled:=false;
Button4.Enabled:=false;
form1.Memo1.Lines.Add('Disconnected.');
end;

end.
