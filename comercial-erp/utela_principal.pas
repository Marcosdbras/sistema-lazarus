unit utela_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ComCtrls, DBGrids, XMLRead, XMLWrite, DOM, db;

type

  { Tfrmtela_principal }

  Tfrmtela_principal = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
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
    procedure FormShow(Sender: TObject);
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


         uses ufuncao_arq_ini, uconfig_banco, ufuncao_geral, ufuncao_conexaodb, uorcamento_pesquisa, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmtela_principal }

procedure Tfrmtela_principal.MenuItem1Click(Sender: TObject);
begin

end;

procedure Tfrmtela_principal.FormCreate(Sender: TObject);
var
   Documento: TXMLDocument;
   Child: TDOMNode;

begin

   //Carrega dados de conexão do banco na variáveis globais
   LerINIBD;

   // Carrega Variáveis globais nos textbox
   //cbxhostname.Text := sHostName;
   //ediporta.Text := sPort;
   //cbxversaosgdb.Text := sProtocol;
   //ediusuario.Text := sUser;
   //edisenha.Text := sPassword;
   //edibancodados.Text := sDatabase;

  if not conectarBanco then
     begin

        frmconfig_banco := tfrmconfig_banco.create(self);
        frmconfig_banco.showmodal;
        frmconfig_banco.free;


     end;


  //showmessage(inttostr(existe_tabela('TUSUARIO')));

  mostrar_inf_campo('TUSUARIO','LOGIN');

end;

procedure Tfrmtela_principal.FormShow(Sender: TObject);
begin





end;

procedure Tfrmtela_principal.MenuItem3Click(Sender: TObject);
begin
  frmorcamento_pesquisa := tfrmorcamento_pesquisa.create(self);
  frmorcamento_pesquisa.showmodal;
  frmorcamento_pesquisa.free;
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

