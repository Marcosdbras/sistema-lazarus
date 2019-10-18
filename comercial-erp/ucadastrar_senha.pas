unit ucadastrar_senha;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType;

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
    procedure btncancelarClick(Sender: TObject);
    procedure btnsalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

  if (edtsenha.Text <> '') and  (edtconfirma_senha.Text = edtsenha.Text) then
  begin

    with modulo_conexaodb do
    begin

      qrexec_base.Close;
      qrexec_base.SQL.Clear;
      qrexec_base.SQL.Add(
        'insert into tmaster_usuario (controle_tusuario, senha) values (:controle, :senha)');

      qrexec_base.ParamByName(
        'controle').AsInteger := icontrole_usuario;
      qrexec_base.ParamByName('senha').AsString := edtsenha.Text;


      qrexec_base.ExecSQL;
      tzcontrole.Commit;


      Application.MessageBox(
        'O programa será encerrado, por gentiliza abra-o novamente e acesse-o com o usuário e a senha cadastrada',
        'Atenção', MB_OK);
    end;

  end
  else
  begin

    Application.MessageBox(
      'O programa será encerrado, pois a senha não confere ou está em branco, por gentiliza abra-o novamente e tenta cadastrar a senha novamente',
      'Atenção', MB_OK);
  end;
  //endi



end;

procedure Tfrmcadastrar_senha.FormCreate(Sender: TObject);
begin
  lblusuario.Caption:=susuario;

  edtsenha.Text:='';
  edtconfirma_senha.Text:='';
end;

procedure Tfrmcadastrar_senha.btncancelarClick(Sender: TObject);
begin

  Application.MessageBox(
    'Operação cancelada pelo usuário, o programa será encerrado!',
    'Atençao', MB_OK);




end;

end.
