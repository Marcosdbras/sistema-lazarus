unit utela_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ComCtrls, DBGrids, StdCtrls, XMLRead, XMLWrite, DOM, db;

type

  { Tfrmtela_principal }

  Tfrmtela_principal = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    Ajustes: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    pnlsuperior: TPanel;
    pnlsuperior1: TPanel;
    pnlsuperior2: TPanel;
    pnlsuperior3: TPanel;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  frmtela_principal: Tfrmtela_principal;

implementation


         uses ufuncao_arq_ini, uconfig_banco, ufuncao_geral, ufuncao_conexaodb,
           uorcamento_pesquisa, umodulo_conexaodb, ulogin, uvendaorc;
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


//Se não consegue conectar banco abre tela config banco
if not conectarBanco then
   begin
     frmconfig_banco := tfrmconfig_banco.create(self);
     frmconfig_banco.showmodal;
     frmconfig_banco.free;
   end;
//endi

 atualiza_base;

 frmlogin := tfrmlogin.Create(self);
 frmlogin.ShowModal;
 frmlogin.Free;

 if frmlogin.ModalResult <> mrOK then
    begin

      Application.Terminate;

    end;



  //showmessage(inttostr(existe_tabela('TUSUARIO')));

  //mostrar_inf_campo('TUSUARIO','LOGIN');


  //execscript;


  //atualiza_base;

end;

procedure Tfrmtela_principal.Button2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmtela_principal.Button1Click(Sender: TObject);
begin
  MenuItem6Click(Sender);
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

procedure Tfrmtela_principal.MenuItem6Click(Sender: TObject);
begin
  if conectarBanco_Aux then
     begin

       frmvendaorc := tfrmvendaorc.create(self);
       frmvendaorc.showmodal;
       frmvendaorc.free;

     end;
  //endi
end;

procedure Tfrmtela_principal.MenuItem9Click(Sender: TObject);
begin
  frmajusteprodutos := tfrmajusteprodutos.create(self);
  frmajusteprodutos.showmodal;
  frmajusteprodutos.free;
end;

end.

