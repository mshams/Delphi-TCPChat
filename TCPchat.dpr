program TCPchat;

uses
  Forms,
  Client in 'Client.pas' {Form1},
  about in 'about.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
