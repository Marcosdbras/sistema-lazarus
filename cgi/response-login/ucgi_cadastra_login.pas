unit ucgi_cadastra_login;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb, IBConnection, sqldb;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    IBConnection1: TIBConnection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure cadloginRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure IBConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.IBConnection1AfterConnect(Sender: TObject);
begin

end;

procedure TFPWebModule1.DataModuleCreate(Sender: TObject);
begin
  //shortDateFormat := 'dd/mm/yyyy';
  //DateSeparator := '/';
  //IBconnection1.Connected:= true;
end;

procedure TFPWebModule1.cadloginRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; var Handled: Boolean);
begin
   AResponse.ContentType := 'text/html;charset=utf-8';
   AResponse.Content := '<html><body>Hello World!</body></html>';


  //AResponse.Contents.Add('texto exemplo');
  Handled := true;
end;

procedure TFPWebModule1.DataModuleDestroy(Sender: TObject);
begin
  //IBconnection1.Connected:= false;
end;

initialization

  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

