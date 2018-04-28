unit ucadastrar_senha;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmcadastrar_senha }

  Tfrmcadastrar_senha = class(TForm)
    btnsalvar: TButton;
    btncancelar: TButton;
    edtsenha: TEdit;
    edtconfirma_senha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblusuario: TLabel;
    procedure btnsalvarClick(Sender: TObject);
  private

  public

  end;

var
  frmcadastrar_senha: Tfrmcadastrar_senha;

implementation
        uses ufuncao_arq_ini, ufuncao_geral, ufuncao_conexaodb, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmcadastrar_senha }

procedure Tfrmcadastrar_senha.btnsalvarClick(Sender: TObject);
begin

end;

end.

