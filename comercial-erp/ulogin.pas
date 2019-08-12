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
    procedure edtsenhaKeyPress(Sender: TObject; var Key: char);
    procedure edtusuarioKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmlogin: Tfrmlogin;

implementation

uses ufuncao_arq_ini, uconfig_banco, ufuncao_geral, ufuncao_conexaodb,
  umodulo_conexaodb, ucadastrar_senha;

{$R *.lfm}

{ Tfrmlogin }

procedure Tfrmlogin.FormCreate(Sender: TObject);
begin

  edtusuario.Text := '';
  edtsenha.Text := '';

end;

procedure Tfrmlogin.FormShow(Sender: TObject);
begin

end;

procedure Tfrmlogin.btncancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrmlogin.btnloginClick(Sender: TObject);
begin
  if edtusuario.Text = '' then
  begin
    Application.MessageBox('Por gentileza digite pelo menos usuário válido',
      'Atenção', MB_OK);

    Application.Terminate;

  end
  else
  begin

    with modulo_conexaodb do
    begin

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add(
        'select t.controle as controle, t.login as login, m.controle_tusuario, m.senha as senha from tusuario t inner join tmaster_usuario m on t.controle = m.controle_tusuario');
      qrconsulta_base.SQL.Add(
        ' where (t.login = :login) and (m.senha = :senha);');
      qrconsulta_base.ParamByName('login').AsString := edtusuario.Text;
      qrconsulta_base.ParamByName('senha').AsString := edtsenha.Text;
      qrconsulta_base.Open;
      if qrconsulta_base.RecordCount = 0 then
      begin

        qrconsulta_base.Close;
        qrconsulta_base.SQL.Clear;
        qrconsulta_base.SQL.Add(
          'select t.controle as controle, t.login as login, m.controle_tusuario as controle_tusuario, m.senha as senha from tusuario t left join tmaster_usuario m on t.controle = controle_tusuario');
        qrconsulta_base.SQL.Add(' where (t.login = :login);');
        qrconsulta_base.ParamByName('login').AsString := edtusuario.Text;
        qrconsulta_base.Open;
        if qrconsulta_base.RecordCount = 0 then
        begin

          Application.MessageBox(
            'Usuário não cadastrado, por gentileza cadastre o usuário no módulo principal e tente novamente!',
            'Atenção', MB_OK);
          Application.Terminate;

        end
        else
        begin

          icontrole :=
            qrconsulta_base.FieldByName('controle').AsInteger;

          susuario := qrconsulta_base.FieldByName('login').AsString;

          qrconsulta_base.Close;
          qrconsulta_base.SQL.Clear;
          qrconsulta_base.SQL.Add(
            'select m.controle_tusuario, m.senha as senha, m.codigo from tmaster_usuario m where m.controle_tusuario = :controle');
          qrconsulta_base.ParamByName('controle').AsInteger := icontrole;
          qrconsulta_base.Open;
          if qrconsulta_base.RecordCount = 0 then
          begin
            if Application.MessageBox(
              'Usuário não tem senha cadastrada, você deseja cadastrar agora?',
              'Atenção', MB_ICONQUESTION + MB_YESNO) = ID_YES then
            begin

              //chama form cadastrar senha
              frmcadastrar_senha := tfrmcadastrar_senha.Create(self);
              frmcadastrar_senha.ShowModal;
              frmcadastrar_senha.Free;

            end
            else
            begin
              Application.MessageBox(
                'Operação cancelada pelo usuário, o programa será encerrado!',
                'Atençao', MB_OK);

            end;
            //endi


            Application.Terminate;

          end
          else
          begin

            if qrconsulta_base.FieldByName('senha').AsString <> '' then
            begin

              //Usuário existe porém a senha não confere, caso o usuário tenha esquecido a senha pode-se regravar a senha.
              Application.MessageBox(
                'Senha não confere, por favor entre em contato com o administrador. O programa será encerrado!',
                'Atenção', MB_OK);
              Application.Terminate;

            end;
            //endi

          end;

        end;

      end
      else
      begin

        //if qrconsulta_base.FieldByName('senha').AsString <> edtsenha.Text then
        //begin

        //Usuário existe porém a senha não confere, caso o usuário tenha esquecido a senha pode-se regravar a senha.
        //Application.MessageBox(
        //  'Senha incorreta, por favor entre em contato com o administrador. O programa será encerrado!',
        //  'Atenção', MB_OK);
        //Application.Terminate;

        //end;
        //endi

        susuario := qrconsulta_base.FieldByName('login').AsString;
        icontrole := qrconsulta_base.FieldByName('controle').AsInteger;

      end;
      //endi


    end;
    //endw

  end;

end;

procedure Tfrmlogin.edtsenhaKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
//endi
end;

procedure Tfrmlogin.edtusuarioKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
//endi
end;

end.
