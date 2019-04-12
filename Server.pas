unit Server;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, IdAntiFreezeBase, IdContext, strutils,
  IdAntiFreeze, IdTCPServer,idsockethandle,
  about, StdCtrls, IdCustomTCPServer, IdBaseComponent, IdComponent;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Edit2: TEdit;
    Button3: TButton;
    TCP: TIdTCPServer;
    IdAntiFreeze1: TIdAntiFreeze;
    Label1: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Button5: TButton;
    Memo2: TMemo;
    Label2: TLabel;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateBindings;
    procedure TCPConnect(AThread: TIdContext);
    procedure TCPDisconnect(AThread: TIdContext);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TCPExecute(AThread: TIdContext);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TClientThread = class(TObject)
    IP    : String;
    Index    : Integer;
    Thread      : Pointer;
  end;


var
  Form1: TForm1;
  Clients  : TList;
  ClientList : array[0..49]of string;

implementation

{$R *.dfm}

procedure TForm1.UpdateBindings;
var Binding : TIdSocketHandle;
begin
  tcp.DefaultPort := StrToInt(edit1.text);
  tcp.Bindings.Clear;
  Binding := tcp.Bindings.Add;
  Binding.Port := tcp.DefaultPort;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
tcp.Active:=true;
Button2.Enabled:=true;
Button3.Enabled:=true;
Button5.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
listbox1.Clear;
Clients := TList.Create;
UpdateBindings;
end;

procedure TForm1.TCPConnect(AThread: TIdContext);
var  Client : TClientThread;
begin
  Client := TClientThread.Create;
  Client.IP := athread.Connection.Socket.Binding.PeerIP;
  Client.Index := ListBox1.Count;
  Client.Thread := AThread;
  AThread.Data := Client;
  Clients.Add(Client);
  listbox1.Items.Add(Client.IP+' '+inttostr(ListBox1.Count));
end;

procedure TForm1.TCPDisconnect(AThread: TIdContext);
var  Client : TClientThread;
begin
  Client := Pointer(AThread.Data);
  if ListBox1.Items.IndexOf(ClientList[Client.index])>-1 then
    listbox1.Items.Delete(ListBox1.Items.IndexOf(ClientList[Client.index]))
  else
    listbox1.Items.Delete(Client.index);
  Clients.Delete(Client.index);
  Client.Free;
  AThread.Data := nil;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Clients.Free; tcp.Active:=false;
end;

procedure TForm1.TCPExecute(AThread: TIdContext);
var  s,t:string; Client : TClientThread;
begin
s:= AThread.Connection.IOHandler.ReadLn;
t:=MidStr(s,1,5);
if t='nick:' then
  begin
  if ListBox1.Items.IndexOf(MidStr(s,6,255))<0 then
    begin
    listbox1.Items.Strings[listbox1.Count-1]:=MidStr(s,6,255);
    ClientList[listbox1.Count-1]:=MidStr(s,6,255);
    end
  else
    begin
    Client := Clients.Items[ListBox1.Count-1];
    TIdContext(Client.Thread).Connection.IOHandler.WriteLn('Nickname allready in list! select another!');
    TIdContext(Client.Thread).Connection.Disconnect;
    end
  end
else if t='list:' then
  begin
  listbox1.Items.Delimiter:=':';
  AThread.Connection.IOHandler.WriteLn('list:'+listbox1.Items.DelimitedText);
  end
else
  begin
  t:=MidStr(s,1,pos('>',s)-1);
  s:=MidStr(s,pos('>',s)+1,255);
  ListBox1.Selected[listbox1.Items.IndexOf(t)]:=true;
  Client := Clients.Items[ListBox1.ItemIndex];
  TIdContext(Client.Thread).Connection.IOHandler.WriteLn(s);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var  Client : TClientThread;
begin
if listbox1.ItemIndex < 0 then exit;
Client := Clients.Items[listbox1.ItemIndex];
TIdContext(Client.Thread).Connection.IOHandler.WriteLn(Edit2.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
form2.Show;
end;

procedure TForm1.Button5Click(Sender: TObject);
var  Client : TClientThread;
begin
if listbox1.ItemIndex < 0 then exit;
Client := Clients.Items[listbox1.itemIndex];
TIdContext(Client.Thread).Connection.Disconnect;
//in onDisconnect item deleted from listbox & Clients
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if listbox1.Count > 0 then
  begin
  if MessageDlg('Killing all threads',mtWarning,[mbYes,mbNo],0)= mrYes then
    while(listbox1.Count >0) do
      begin
      listbox1.Selected[0]:=true;
      Button5.Click;
      end
  end
Else
  begin
  tcp.Active:=False;
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  Button5.Enabled:=false;
  end;
end;

end.
