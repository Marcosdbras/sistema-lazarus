unit ulogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, LCLType;

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
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmlogin: Tfrmlogin;

implementation
         uses ufuncao_arq_ini, uconfig_banco, ufuncao_geral, ufuncao_conexaodb, umodulo_conexaodb, ucadastrar_senha;
{$R *.lfm}

         { Tfrmlogin }

         procedure Tfrmlogin.FormCreate(Sender: TObject);
         begin

            edtusuario.Text:= '';
            edtsenha.Text:='';


         end;

procedure Tfrmlogin.FormShow(Sender: TObject);
begin

end;

procedure Tfrmlogin.btncancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrmlogin.btnloginClick(Sender: TObject);
var
  icontrole:integer;

begin
  if edtusuario.Text = '' then
     begin
       Application.MessageBox('Por gentileza digite pelo menos usuário válido','Atenção',MB_OK);

       ModalResult := mrCancel;


     end
  else
     begin




       with modulo_conexaodb do

            begin

              qrconsulta_base.Close;
              qrconsulta_base.SQL.Clear;
              qrconsulta_base.SQL.Add('select t.controle, t.login, m.controle_tusuario, m.senha from tusuario t inner join master_usuario m on t.controle = m.controle_tusuario');
              qrconsulta_base.SQL.Add(' where (t.login = :login) and (m.senha = :senha);');
              qrconsulta_base.ParamByName('login').AsString:=edtusuario.Text;
              qrconsulta_base.ParamByName('senha').AsString:=edtsenha.Text;
              qrconsulta_base.Open;
              if qrconsulta_base.RecordCount = 0 then
                 begin

                   qrconsulta_base.Close;
                   qrconsulta_base.SQL.Clear;
                   qrconsulta_base.SQL.Add('select t.controle as controle, t.login as login, m.controle_tusuario as controle_tusuario, m.senha as senha from tusuario t left join master_usuario m on t.controle = controle_tusuario');
                   qrconsulta_base.SQL.Add(' where (t.login = :login);');
                   qrconsulta_base.ParamByName('login').AsString:= edtusuario.Text;
                   qrconsulta_base.Open;
                   if qrconsulta_base.RecordCount = 0 then
                      begin
                        Application.MessageBox('Usuário não cadastrado, por gentileza cadastre o usuário no módulo principal e tente novamente!','Atenção',MB_OK);
                        Application.Terminate;
                      end
                   else
                      begin

                        icontrole := qrconsulta_base.FieldByName('controle_tusuario').AsInteger;


                        qrconsulta_base.Close;
                        qrconsulta_base.SQL.Clear;
                        qrconsulta_base.SQL.Add('select m.controle_tusuario, m.senha as senha, m.codigo from master_usuario m where m.controle_tusuario = :controle');
                        qrconsulta_base.ParamByName('controle').AsInteger:=icontrole;
                        qrconsulta_base.Open;
                        if qrconsulta_base.RecordCount = 0 then
                           begin
                             if Application.MessageBox('Usuário não tem senha cadastrada, você deseja cadastrar agora?','Atenção',MB_ICONQUESTION+MB_YESNO) = ID_YES then
                                begin

                                  //chama form cadastrar senha
                                  frmcadastrar_senha := tfrmcadastrar_senha.Create(self);
                                  frmcadastrar_senha.ShowModal;
                                  frmcadastrar_senha.Free;

                                  if frmcadastrar_senha.ModalResult = mrOK then
                                     begin
                                       Application.MessageBox('O programa será fechado, por gentiliza abra-o novamente e acesse-o com o usuário e a senha cadastrada','Atenção',MB_OK);
                                       Application.Terminate;
                                     end
                                  else
                                     begin
                                       Application.MessageBox('Operação cancelada!','Atençao',MB_OK);

                                     end;
                                  //endi

                                end
                             else
                                begin
                                  ModalResult := mrCancel;

                                end;
                             //endi
                           end
                        else
                           begin
                             if qrconsulta_base.FieldByName('senha').AsString <> '' then
                                begin

                                  //Usuário existe porém a senha não confere, caso o usuário tenha esquecido a senha pode-se regravar a senha.
                                  Application.MessageBox('Senha incorreta, por favor entre em contato com o administrador','Atenção',MB_OK);
                                  Application.Terminate;

                                end;
                             //endi


                           end;
                        //endi

                      end;
                   //endi

                 end;
              //endi




            end;
            //endw





     end;
  //endi



end;

end.

