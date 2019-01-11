unit usincbaseremota;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmsincbaseremota }

  Tfrmsincbaseremota = class(TForm)
    btncancelar: TButton;
    btnok: TButton;
    lblmensagem: TLabel;

    procedure atualizaBaseRemotaFun;
    procedure btnokClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  frmsincbaseremota: Tfrmsincbaseremota;

implementation
      uses umodulo_funcionario, umodulo_conexaodb, ufuncao_conexaodb, umodulo_remoto, ufuncao_geral;
{$R *.lfm}

{ Tfrmsincbaseremota }

procedure Tfrmsincbaseremota.atualizaBaseRemotaFun;
      begin

        lblmensagem.caption := 'Abrindo base de dados...';
        lblmensagem.Update;


        if conectarBanco_remoto then
           begin

             //cemp = código da empresa
             // este código estará vinculado ao cnpj da empresa na tabela empresa do banco de dados remoto

             lblmensagem.caption := 'Sincronizando informações dos funcionários...';
             lblmensagem.Update;

             modulo_funcionario.qrfuncionario.Close;
             modulo_funcionario.qrfuncionario.SQL.Clear;
             modulo_funcionario.qrfuncionario.SQL.Add('select * from tfuncionario order by controle');
             modulo_funcionario.qrfuncionario.Open;
             while not modulo_funcionario.qrfuncionario.EOF do
               begin

                 modulo_remoto.qrconsulta_base_remoto.Close;
                 modulo_remoto.qrconsulta_base_remoto.SQL.Clear;
                 modulo_remoto.qrconsulta_base_remoto.SQL.Add('select * from tfuncionario where ( codfunemp= :codfunemp) and (cemp = :cemp)');
                 modulo_remoto.qrconsulta_base_remoto.Params.ParamByName('codfunemp').AsInteger  := modulo_funcionario.qrfuncionario.FieldByName('controle').AsInteger;
                 modulo_remoto.qrconsulta_base_remoto.Params.ParamByName('cemp').AsInteger  :=  icemp;
                 modulo_remoto.qrconsulta_base_remoto.Open;

                 if modulo_remoto.qrconsulta_base_remoto.RecordCount = 0 then
                    begin

                      modulo_remoto.qrexec_base_remoto.Close;
                      modulo_remoto.qrexec_base_remoto.SQL.Clear;
                      modulo_remoto.qrexec_base_remoto.SQL.Add('insert into tfuncionario( funcionario, datanascimento, datahoracadastro, ativo, cemp, codfunemp ) values (:funcionario, :datanascimento, :datahoracadastro, :ativo, :cemp, :codfunemp) ');
                      modulo_remoto.qrexec_base_remoto.ParamByName('funcionario').AsString:=modulo_funcionario.qrfuncionario.FieldByName('funcionario').AsString;
                      modulo_remoto.qrexec_base_remoto.ParamByName('datanascimento').AsdateTime:=modulo_funcionario.qrfuncionario.FieldByName('datanascimento').AsdateTime;
                      modulo_remoto.qrexec_base_remoto.ParamByName('datahoracadastro').AsDateTime := modulo_funcionario.qrfuncionario.FieldByName('datahoracadastro').AsDateTime;
                      modulo_remoto.qrexec_base_remoto.ParamByName('ativo').AsString:=modulo_funcionario.qrfuncionario.FieldByName('ativo').AsString;
                      modulo_remoto.qrexec_base_remoto.ParamByName('codfunemp').AsInteger:=modulo_funcionario.qrfuncionario.FieldByName('controle').AsInteger;
                      modulo_remoto.qrexec_base_remoto.ParamByName('cemp').AsInteger:=icemp;
                      modulo_remoto.qrexec_base_remoto.ExecSQL;

                    end
                 else
                    begin

                      modulo_remoto.qrexec_base_remoto.Close;
                      modulo_remoto.qrexec_base_remoto.SQL.Clear;
                      modulo_remoto.qrexec_base_remoto.SQL.Add('update tfuncionario  set funcionario = :funcionario, datanascimento = :datanascimento, datahoracadastro  = :datahoracadastro, ativo = :ativo where controle = :controle ');        //,cemp = :cemp, codfunemp = :codfunemp

                      modulo_remoto.qrexec_base_remoto.ParamByName('controle').AsInteger:=modulo_remoto.qrconsulta_base_remoto.FieldByName('controle').AsInteger;
                      modulo_remoto.qrexec_base_remoto.ParamByName('funcionario').AsString:=modulo_funcionario.qrfuncionario.FieldByName('funcionario').AsString;
                      modulo_remoto.qrexec_base_remoto.ParamByName('datanascimento').AsdateTime:=modulo_funcionario.qrfuncionario.FieldByName('datanascimento').AsdateTime;
                      modulo_remoto.qrexec_base_remoto.ParamByName('datahoracadastro').AsDateTime := modulo_funcionario.qrfuncionario.FieldByName('datahoracadastro').AsDateTime;
                      modulo_remoto.qrexec_base_remoto.ParamByName('ativo').AsString:=modulo_funcionario.qrfuncionario.FieldByName('ativo').AsString;
                      //modulo_remoto.qrexec_base_remoto.ParamByName('codfunemp').AsInteger:=modulo_funcionario.qrfuncionario.FieldByName('controle').AsInteger;
                      //modulo_remoto.qrexec_base_remoto.ParamByName('cemp').AsInteger:=icemp;
                      modulo_remoto.qrexec_base_remoto.ExecSQL;







                    end;
                 //endi

                 lblmensagem.caption := 'Sincronizando registro funcionário de número.: '+modulo_funcionario.qrfuncionario.FieldByName('controle').AsString;
                 lblmensagem.Update;

                 modulo_funcionario.qrfuncionario.Next;
               end;
             //endw

             modulo_conexaodb.atualizaBancoRemotoFechaTransacao;

             modulo_conexaodb.desconectarBancoRemoto;

           end
           else
           begin


                   showmessage('Falha na conexão!');


           end;

           lblmensagem.caption := 'Finalizando conexão...';
           lblmensagem.Update;










      end;

procedure Tfrmsincbaseremota.btnokClick(Sender: TObject);
begin

  atualizaBaseRemotaFun;

end;

procedure Tfrmsincbaseremota.FormCreate(Sender: TObject);
begin
  lblmensagem.Caption:='';
end;

end.

