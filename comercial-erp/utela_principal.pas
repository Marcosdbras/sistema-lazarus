unit utela_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus;

type

  { Tfrmprincipal_tela }

  Tfrmprincipal_tela = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private

  public

  end;

var
  frmprincipal_tela: Tfrmprincipal_tela;

implementation
         uses uconfig_banco;
{$R *.lfm}

{ Tfrmprincipal_tela }

procedure Tfrmprincipal_tela.MenuItem1Click(Sender: TObject);
begin

end;

procedure Tfrmprincipal_tela.FormCreate(Sender: TObject);
begin

end;

procedure Tfrmprincipal_tela.MenuItem3Click(Sender: TObject);
begin

end;

procedure Tfrmprincipal_tela.MenuItem4Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmprincipal_tela.MenuItem5Click(Sender: TObject);
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

