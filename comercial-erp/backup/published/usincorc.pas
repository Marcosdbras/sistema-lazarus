unit usincorc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmsincorc }

  { th }

  th = class(tthread)
       public
         constructor create(CreateSuspended:boolean);
         procedure atualizaform;

       protected
         procedure execute; override;


  end;


  Tfrmsincorc = class(TForm)
    btnok: TButton;
    btncancelar: TButton;
    lblmensagem: TLabel;
    procedure btnokClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmsincorc: Tfrmsincorc;

implementation
      uses umodulo_conexaodb,ufuncao_conexaodb, ufuncao_geral,umodulo_orcamento, umodulo_remoto, umodulo_cliente, umodulo_funcionario;
{$R *.lfm}

{ Tfrmsincorc }

procedure Tfrmsincorc.btnokClick(Sender: TObject);
//var
  //t:th;
begin
  //t.create(true);
  //t.Start;

    lblmensagem.caption := 'Iniciando conexão...';
    lblmensagem.Update;

    with modulo_orcamento do
      begin

        lblmensagem.caption := 'Sincronizando principais informações...';
        lblmensagem.Update;

        //Tabela Funcionário
        modulo_remoto.qrconsulta_base_remoto.Close;
        modulo_remoto.qrconsulta_base_remoto.SQL.Clear;
        modulo_remoto.qrconsulta_base_remoto.SQL.Add('select * from tfuncionario where controle = :controle');
        modulo_remoto.qrconsulta_base_remoto.Params.ParamByName('controle').AsInteger  := modulo_orcamento.qrorcamento.FieldByName('codfuncionario').AsInteger;
        modulo_remoto.qrconsulta_base_remoto.Open;

        if modulo_remoto.qrconsulta_base_remoto.RecordCount = 0 then
           begin

             modulo_funcionario.qrfuncionario.Close;
             modulo_funcionario.qrfuncionario.SQL.Clear;
             modulo_funcionario.qrfuncionario.SQL.Add('select controle, funcionario, datanascimento, datahoracadastro, ativo from tfuncionarios where controle = :constrole');
             modulo_funcionario.qrfuncionario.Params.ParamByName('controle').AsInteger:=modulo_orcamento.qrorcamento.FieldByName('codfuncionario').AsInteger;
             modulo_funcionario.qrfuncionario.Open;

             if modulo_funcionario.qrfuncionario.RecordCount <> 0 then
                begin

                  modulo_remoto.qrexec_base_remoto.Close;
                  modulo_remoto.qrexec_base_remoto.SQL.Clear;
                  modulo_remoto.qrexec_base_remoto.SQL.Add('insert into tfuncionario( controle, funcionario, datanascimento, datahoracadastro, ativo ) values (:controle, :funcionario, :datanascimento, :datahoracadastro, :ativo) ');
                  modulo_remoto.qrexec_base_remoto.ParamByName('controle').AsInteger:=modulo_funcionario.qrfuncionario.FieldByName('controle').AsInteger;
                  modulo_remoto.qrexec_base_remoto.ParamByName('funcionario').AsString:=modulo_funcionario.qrfuncionario.FieldByName('funcionario').AsString;
                  modulo_remoto.qrexec_base_remoto.ParamByName('datanascimento').Asdatetime:=modulo_funcionario.qrfuncionario.FieldByName('datanascimento').Asdatetime;
                  modulo_remoto.qrexec_base_remoto.ParamByName('datahoracadastro').AsDateTime := modulo_funcionario.qrfuncionario.FieldByName('datahoracadastro').AsDateTime;
                  modulo_remoto.qrexec_base_remoto.ParamByName('ativo').AsString:=modulo_funcionario.qrfuncionario.FieldByName('ativo').AsString;
                  modulo_remoto.qrexec_base_remoto.ExecSQL;

                end;
             //endi


           end;
        //endi






        lblmensagem.caption := 'Abrindo tabela de produtos...';
        lblmensagem.Update;

        qrorcamento_itemproduto.Close;
        qrorcamento_itemproduto.SQL.Clear;
        qrorcamento_itemproduto.SQL.Add('select * from TITENSORCAMENTO where codorcamento = :codorcamento order by coditem');
        qrorcamento_itemproduto.ParamByName('codorcamento').AsInteger:= modulo_orcamento.qrorcamento.FieldByName('controle').AsInteger;
        qrorcamento_itemproduto.Open;

        while not qrorcamento_itemproduto.EOF do
           begin

              lblmensagem.caption := 'Sincronizando registro n.o '+qrorcamento_itemproduto.FieldByName('controle').AsString;
              lblmensagem.Update;







              qrorcamento_itemproduto.Next;
           end;
        //endw

      end;



    if conectarBanco_remoto then
     begin




       modulo_conexaodb.desconectarBancoRemoto;

     end
     else
     begin


       showmessage('Falha na conexão!');


     end;

     lblmensagem.caption := 'Finalizando conexão...';
     lblmensagem.Update;


end;

procedure Tfrmsincorc.FormCreate(Sender: TObject);
begin
  lblmensagem.caption := '';
end;

{ th }

constructor th.create(CreateSuspended: boolean);
begin
  FreeOnTerminate := true;
  Inherited create(CreateSuspended);

end;

procedure th.atualizaform;
begin
  frmsincorc.lblmensagem.Caption:='';
end;

procedure th.execute;
begin
  Synchronize(@atualizaform);
end;

end.

