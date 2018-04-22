unit ulogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tfrmlogin }

  Tfrmlogin = class(TForm)
    btnlogin: TButton;
    btncancelar: TButton;
    edtusuario: TEdit;
    edtsenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    procedure btncancelarClick(Sender: TObject);
    procedure btnloginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmlogin: Tfrmlogin;

implementation
         uses ufuncao_arq_ini, uconfig_banco, ufuncao_geral, ufuncao_conexaodb, umodulo_conexaodb;
{$R *.lfm}

         { Tfrmlogin }

         procedure Tfrmlogin.FormCreate(Sender: TObject);
         begin

            edtusuario.Text:= '';
            edtsenha.Text:='';


         end;

procedure Tfrmlogin.btncancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrmlogin.btnloginClick(Sender: TObject);
begin
  with modulo_conexaodb do
     begin

       qrconsulta_base.Close;
       qrconsulta_base.SQL.Clear;
       qrconsulta_base.SQL.Add('select t.controle, t.login, m.codigo, m.senha from tusuario t inner join master_usuario m on t.controle = m.codigo');
       qrconsulta_base.SQL.Add(' where (t.login = :login) and (m.senha = :senha);');
       qrconsulta_base.ParamByName('login').AsString:=edtusuario.Text;
       qrconsulta_base.ParamByName('senha').AsString:=edtsenha.Text;
       qrconsulta_base.Open;
       if qrconsulta_base.RecordCount = 0 then
          begin

            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select t.controle, t.login from tusuario t where t.login = :login');
            qrconsulta_base.ParamByName('login').AsString:= edtusuario.Text;
            qrconsulta_base.Open;
            if qrconsulta_base.RecordCount = 0 then
               begin
                 Application.MessageBox('Usuário não cadastrado, por gentileza cadastre o usuário no módulo principal e tente novamente!','Atenção',MB_OK);
                 Appli
               end;

          end;

       //endi




     end;


end;

end.

