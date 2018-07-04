unit uvendaorc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, Types, LCLType;

type

  { Tfrmvendaorc }

  Tfrmvendaorc = class(TForm)
    btnexportar: TButton;
    btncancelar: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    procedure btncancelarClick(Sender: TObject);
    procedure btnexportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    icodigo_controle, icodigo_controle_item, codaplicacaoproduto, sequencia_num:integer;
    opcao_item, cfop, referencia, fatorconversao, codbarras, descricaoun, nomeprod, numDav:string;
    qtdeconvertida, valorconversao:real;


  public

  end;

var
  frmvendaorc: Tfrmvendaorc;

implementation
    uses umodulo_conexaodb, umodulo_vendaorc, ufuncao_geral;
{$R *.lfm}

    { Tfrmvendaorc }

    procedure Tfrmvendaorc.btncancelarClick(Sender: TObject);
    begin
      close;
    end;

procedure Tfrmvendaorc.btnexportarClick(Sender: TObject);
var
  controle:integer;

begin
   if Application.MessageBox('Tem certeza que deseja exportar este pedido para NF-e?','Atenção',MB_YESNO) = 6  then
      begin

        //Atualiza tabelas auxiliares do sistema
        with modulo_conexaodb do
             begin

               // Cliente
               qrconsulta_base.Close;
               qrconsulta_base.SQL.Clear;
               qrconsulta_base.SQL.Add('select * from tcliente where controle = :controle');
               qrconsulta_base.ParamByName('controle').AsInteger:= modulo_vendaorc.qrvenda.FieldByName('ccli').AsInteger;
               qrconsulta_base.Open;
               if qrconsulta_base.RecordCount = 0 then
                  begin

                    qrexec_base.Close;
                    qrexec_base.SQL.Clear;
                    qrexec_base.SQL.Add('insert into tcliente (controle, cliente, datahoracadastro, ativo) values (:controle, :cliente, :datahoracadastro, :ativo)');
                    qrexec_base.ParamByName('controle').AsInteger:=modulo_vendaorc.qrvenda.FieldByName('ccli').AsInteger;
                    qrexec_base.ParamByName('cliente').AsString:=modulo_vendaorc.qrvenda.FieldByName('nome').AsString;;
                    qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
                    qrexec_base.ParamByName('ativo').AsString:='SIM';


                    qrexec_base.ExecSQL;

                    atualizaBanco;

                  end;
               //endi


               // Funcionário
               qrconsulta_base.Close;
               qrconsulta_base.SQL.Clear;
               qrconsulta_base.SQL.Add('select * from tfuncionario where controle = :controle');
               qrconsulta_base.ParamByName('controle').AsInteger:= modulo_vendaorc.qrvenda.FieldByName('cfunc').AsInteger;
               qrconsulta_base.Open;
               if qrconsulta_base.RecordCount = 0 then
                  begin

                    qrexec_base.Close;
                    qrexec_base.SQL.Clear;
                    qrexec_base.SQL.Add('insert into tfuncionario (controle, funcionario, datanascimento, datahoracadastro, ativo ) values (:controle, :funcionario, :datanascimento, :datahoracadastro, :ativo)');
                    qrexec_base.ParamByName('controle').AsInteger:=modulo_vendaorc.qrvenda.FieldByName('cfun').AsInteger;
                    qrexec_base.ParamByName('funcionario').AsString:=modulo_vendaorc.qrvenda.FieldByName('nfunc').AsString;;
                    qrexec_base.ParamByName('datanascimento').Asdate:=strtodate('01/01/1900');
                    qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
                    qrexec_base.ParamByName('ativo').AsString:='SIM';

                    qrexec_base.ExecSQL;

                    atualizaBanco;

                  end;
               //endi

               qrsequencia.Close;
               qrsequencia.SQL.Clear;
               qrsequencia.SQL.Add('update tsequencia set controlevarchar = controlevarchar + 1');
               qrsequencia.ExecSQL;

               atualizaBanco;

               qrsequencia.Close;
               qrsequencia.SQL.Clear;
               qrsequencia.SQL.Add('select * from tsequencia');
               qrsequencia.Open;

               qrexec_base.Close;
               qrexec_base.SQL.Clear;
               qrexec_base.SQL.Add('select GEN_ID(GEN_TPEDIDOVENDA_ID,1) as prox_codigo FROM RDB$DATABASE;');
               qrexec_base.Open;

               icodigo_controle := qrexec_base.FieldByName('prox_codigo').AsInteger;

               qrexec_base.Close;
               qrexec_base.SQL.Clear;
               qrexec_base.SQL.Add('insert into TPEDIDOVENDA(controle, codcliente,  cliente,  codfuncionario,  funcionario,  codvendedor, vendedor,  controlevarchar,    datahoracadastro,  titulodav,  cancelado,  status, observacao,  dataprevisaoentrega, valordesconto, totalprodutos, totalliquido  ) ');
               qrexec_base.SQL.Add('                values(:controle, :codcliente, :cliente, :codfuncionario, :funcionario, :codvendedor, :vendedor,  :controlevarchar,  :datahoracadastro,  :titulodav, :cancelado, :status, :observacao,  :dataprevisaoentrega, :valordesconto, :totalprodutos, :totalliquido  )');
               qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle;


               numDav := formatfloat('0000000000',qrsequencia.FieldByName('controlevarchar').AsInteger);
               qrexec_base.ParamByName('controlevarchar').AsString:=numDav;
               qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
               qrexec_base.ParamByName('titulodav').AsString:='PEDIDO DE VENDA';
               qrexec_base.ParamByName('cancelado').AsString:='NÃO';
               qrexec_base.ParamByName('status').AsString:='ABERTO';
               qrexec_base.ParamByName('dataprevisaoentrega').AsDate:=date;
               qrexec_base.ParamByName('valordesconto').Asfloat:=0;
               qrexec_base.ParamByName('totalprodutos').Asfloat:=0;
               qrexec_base.ParamByName('totalliquido').Asfloat:=0;

               qrexec_base.ParamByName('codcliente').AsInteger := modulo_vendaorc.qrvenda.FieldByName('ccli').AsInteger;
               qrexec_base.ParamByName('cliente').AsString:= modulo_vendaorc.qrvenda.FieldByName('nome').AsString;
               qrexec_base.ParamByName('codfuncionario').AsInteger := modulo_vendaorc.qrvenda.FieldByName('cfunc').AsInteger;
               qrexec_base.ParamByName('funcionario').AsString:=  modulo_vendaorc.qrvenda.FieldByName('nfunc').AsString;
               qrexec_base.ParamByName('codvendedor').AsInteger := modulo_vendaorc.qrvenda.FieldByName('cfunc').AsInteger;;
               qrexec_base.ParamByName('vendedor').AsString:= modulo_vendaorc.qrvenda.FieldByName('nfunc').AsString;



               //qrexec_base.ParamByName('observacao').AsString:=;
               //qrexec_base.ParamByName('data').AsDate:=date;
               //qrexec_base.ParamByName('hora').AsString := formatdatetime('HH:mm:ss',time);
               //qrexec_base.ParamByName('tipodesconto').AsString:='R$';

               qrexec_base.ExecSQL;

               atualizaBanco;


               with  modulo_vendaorc do
                  begin

                    qrvenda_itemproduto.First;

                    while not qrvenda_itemproduto.EOF do
                      begin


                        //Atualiza tabelas auxiliares do sistema
                        with modulo_conexaodb do
                             begin

                               // Unidade Medida
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
                               qrconsulta_base.ParamByName('descricao').AsString:= modulo_vendaorc.qrvenda_itemproduto.FieldByName('und').AsString;
                               qrconsulta_base.Open;

                               //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                               if (qrconsulta_base.RecordCount = 0) then
                                  begin

                                     qrexec_base.Close;
                                     qrexec_base.SQL.Clear;
                                     qrexec_base.SQL.Add('insert into tunidademedida (controle, descricao, dataehoracadastro) values (:controle, :descricao, :dataehoracadastro)');
                                     qrexec_base.ParamByName('controle').AsInteger:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger;
                                     qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('und').AsString;
                                     qrexec_base.ParamByName('dataehoracadastro').AsDateTime := now();
                                     qrexec_base.ExecSQL;

                                     atualizaBanco;

                                  end;
                               //endi




                               // Produto
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from testoque where controle = :controle');
                               qrconsulta_base.ParamByName('controle').AsInteger:= modulo_vendaorc.qrvenda_itemproduto.FieldByName('cpro').AsInteger;
                               qrconsulta_base.Open;
                               if qrconsulta_base.RecordCount = 0 then
                                  begin

                                    qrexec_base.Close;
                                    qrexec_base.SQL.Clear;
                                    qrexec_base.SQL.Add('insert into testoque (controle, produto, unidade, precocusto, perclucro, precovenda, IAT, IPPT, tributado, pesado, codunidademedida, codcstorigem, codigocstorigem, fatorconversao, controlarvalidade) values (:controle, :produto, :unidade, :precocusto, :perclucro, :precovenda, :IAT, :IPPT, :tributado, :pesado, :codunidademedida, :codcstorigem, :codigocstorigem, :fatorconversao, :controlarvalidade)');
                                    qrexec_base.ParamByName('controle').AsInteger:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('cpro').AsInteger;
                                    qrexec_base.ParamByName('produto').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('descricao').AsString;;
                                    qrexec_base.ParamByName('unidade').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('und').AsString;

                                    // Consulta Unidade Medida
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
                                    qrconsulta_base.ParamByName('descricao').AsString:= modulo_vendaorc.qrvenda_itemproduto.FieldByName('und').AsString;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('codunidademedida').AsInteger :=    qrconsulta_base.FieldByName('controle').AsInteger;



                                    qrexec_base.ParamByName('codigocstorigem').AsInteger:= 1; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;


                                    qrexec_base.ParamByName('precocusto').Asfloat:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('precocusto').Asfloat;
                                    qrexec_base.ParamByName('perclucro').Asfloat:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('perclucro').Asfloat;
                                    qrexec_base.ParamByName('precovenda').Asfloat:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('precovenda').Asfloat;
                                    qrexec_base.ParamByName('codcstorigem').AsString:='1';    //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codcstorigem').AsString;


                                    qrexec_base.ParamByName('IAT').AsString:='A';
                                    qrexec_base.ParamByName('IPPT').AsString:='T';
                                    qrexec_base.ParamByName('tributado').AsString:='SIM';
                                    qrexec_base.ParamByName('pesado').AsString:='NÃO';
                                    qrexec_base.ParamByName('fatorconversao').AsString:='*';
                                    qrexec_base.ParamByName('controlarvalidade').AsString:='NÃO';

                                    qrexec_base.ExecSQL;

                                    atualizaBanco;

                                  end;
                               //endi

                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select COALESCE(max(coditem),0)+1 as sequencia from TITENSORCAMENTO where CODORCAMENTO = :CODORCAMENTO');
                               qrconsulta_base.ParamByName('codorcamento').AsInteger:=icodigo_controle;
                               qrconsulta_base.Open;

                               sequencia_num := qrconsulta_base.FieldByName('sequencia').AsInteger;

                               qrexec_base.Close;
                               qrexec_base.SQL.Clear;
                               qrexec_base.SQL.Add('select GEN_ID(GEN_TITEMPEDIDOVENDA_ID,1) as prox_codigo FROM RDB$DATABASE;');
                               qrexec_base.Open;

                               icodigo_controle_item := qrexec_base.FieldByName('prox_codigo').AsInteger;

                               qrexec_base.Close;
                               qrexec_base.SQL.Clear;
                               qrexec_base.SQL.Add('insert into TITEMPEDIDOVENDA( controle,  codpedidovenda,  codproduto,  produto,  datahoracadastro,  coditem,  un,    valordescontounitario,  percdescontounitario,  valoracrescimounitario,  percacrescimounitario,   indicadorcancelamento,  decimaisqtde,  decimaisvalorunitario, totaldesconto,  numerodav,  totalacrescimo,   qtdeconvertida,  unconvertida,     qtde,   valorunitario, numerodav, status ) ');
                               qrexec_base.SQL.Add('                     values(:controle, :codpedidopedido, :codproduto, :produto, :datahoracadastro, :coditem, :un,   :valordescontounitario, :percdescontounitario, :valoracrescimounitario, :percacrescimounitario,  :indicadorcancelamento, :decimaisqtde, :decimaisvalorunitario,  :totaldesconto, :numerodav,  :totalacrescimo,  :qtdeconvertida, :unconvertida,   :qtde,  :valorunitario, :numerodav, :status ) ');


                               qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
                               qrexec_base.ParamByName('coditem').AsInteger:=sequencia_num;
                               qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle_item;
                               qrexec_base.ParamByName('codpedidovenda').AsInteger := icodigo_controle;
                               qrexec_base.ParamByName('numerodav').AsString := numDav;
                               qrexec_base.ParamByName('status').AsString := 'ABERTO';

                               qrexec_base.Params.ParamByName('codproduto').AsInteger :=  qrvenda_itemproduto.FieldByName('cpro').AsInteger;
                               qrexec_base.ParamByName('produto').AsString:=  qrvenda_itemproduto.FieldByName('descricao').AsString;
                               qrexec_base.ParamByName('un').AsString:= qrvenda_itemproduto.FieldByName('und').AsString;
                               qrexec_base.ParamByName('valordescontounitario').Asfloat:= 0;
                               qrexec_base.ParamByName('percdescontounitario').Asfloat:= 0;
                               qrexec_base.ParamByName('valoracrescimounitario').Asfloat:= 0;
                               qrexec_base.ParamByName('percacrescimounitario').Asfloat:= 0;
                               qrexec_base.ParamByName('indicadorcancelamento').AsString:= 'N';
                               qrexec_base.ParamByName('decimaisqtde').AsInteger:= 2;
                               qrexec_base.ParamByName('decimaisvalorunitario').AsInteger:= 2;
                               qrexec_base.ParamByName('qtde').Asfloat := qrvenda_itemproduto.FieldByName('qtde').Asfloat;
                               qrexec_base.ParamByName('valorunitario').Asfloat := qrvenda_itemproduto.FieldByName('prve').Asfloat;

                               //Analisar no SGBr como esta informação é persistida
                               //qrexec_base.ParamByName('qtdeconvertida').Asfloat := 1; //fatorconversao;  //valorconversao;

                               qrexec_base.ExecSQL;

                               atualizaBanco;

                             end;
                        //endth








                        qrvenda_itemproduto.Next;
                      end;
                    //endw


                  end;
               //endth


             end;
        //endth

        Application.MessageBox('Pedido exportado com sucesso!','Atenção',MB_OK);

      end;
   //endi
end;

procedure Tfrmvendaorc.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
   modulo_conexaodb.conexaodb_Aux.Connected:=false;
end;

procedure Tfrmvendaorc.FormCreate(Sender: TObject);
begin
   with modulo_vendaorc do
     begin

       qrvenda.close;
       qrvenda.SQL.Clear;
       qrvenda.SQL.Add('select  v.cfun as cfunc, f.nome as nfunc,  v.codigo, v.nped, v.ccli, v.total, c.nome, c.cepent from svenda v left join clientes c on v.ccli = c.codigo   left join funcionarios f on v.cfun = f.codigo    where coalesce(v.nped, 0) > 0');
       qrvenda.Open;

     end;
   //end
end;

end.

