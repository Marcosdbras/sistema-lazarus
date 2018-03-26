unit utela_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ComCtrls, XMLRead, XMLWrite, DOM;

type

  { Tfrmtela_principal }

  Tfrmtela_principal = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    pnlsuperior: TPanel;
    pnlsuperior1: TPanel;
    pnlsuperior2: TPanel;
    pnlsuperior3: TPanel;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private

  public

  end;

var
  frmtela_principal: Tfrmtela_principal;

implementation
         uses uconfig_banco;
{$R *.lfm}

{ Tfrmtela_principal }

procedure Tfrmtela_principal.MenuItem1Click(Sender: TObject);
begin

end;

procedure Tfrmtela_principal.FormCreate(Sender: TObject);
//var
//xml : TXmlDocument;

var
   Documento: TXMLDocument;
   Child: TDOMNode;

begin

end;

procedure Tfrmtela_principal.MenuItem3Click(Sender: TObject);
begin

end;

procedure Tfrmtela_principal.MenuItem4Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmtela_principal.MenuItem5Click(Sender: TObject);
begin

//if frmconfig_banco=nil then
//  frmconfig_banco:=Tfrmconfig_banco.Create(application)
//else
//  frmconfig_banco.Show;

frmconfig_banco := tfrmconfig_banco.create(self);
frmconfig_banco.showmodal;
frmconfig_banco.free;
end;

end.

