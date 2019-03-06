unit umodulo_remoto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, FileUtil;

type

  { Tmodulo_remoto }

  Tmodulo_remoto = class(TDataModule)
    qrconsulta_base_remoto: TSQLQuery;
    qrexec_base_remoto: TSQLQuery;


    procedure atualizaBaseRemotaFun;


  private


  public

  end;

var
  modulo_remoto: Tmodulo_remoto;

implementation
      uses umodulo_conexaodb,umodulo_orcamento, umodulo_funcionario;
{$R *.lfm}

      { Tmodulo_remoto }

      procedure Tmodulo_remoto.atualizaBaseRemotaFun;
      begin


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
                          modulo_remoto.qrexec_base_remoto.ParamByName('datanascimento').AsdateTime:=modulo_funcionario.qrfuncionario.FieldByName('datanascimento').AsdateTime;
                          modulo_remoto.qrexec_base_remoto.ParamByName('datahoracadastro').AsDateTime := modulo_funcionario.qrfuncionario.FieldByName('datahoracadastro').AsDateTime;
                          modulo_remoto.qrexec_base_remoto.ParamByName('ativo').AsString:=modulo_funcionario.qrfuncionario.FieldByName('ativo').AsString;
                          modulo_remoto.qrexec_base_remoto.ExecSQL;

                        end;
                     //endi


                   end;
                //endi




      end;



end.

