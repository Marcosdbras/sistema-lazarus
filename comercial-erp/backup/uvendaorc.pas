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
  controle, codigocstorigem, codigocst:integer;
  scodigocstpis, scodigocstcofins,  scodigocstipi:string;

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
                    qrexec_base.ParamByName('controle').AsInteger:=modulo_vendaorc.qrvenda.FieldByName('cfunc').AsInteger;
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
                                     qrexec_base.SQL.Add('insert into tunidademedida (descricao, dataehoracadastro) values (:descricao, :dataehoracadastro)');
                                     qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('und').AsString;
                                     qrexec_base.ParamByName('dataehoracadastro').AsDateTime := now();
                                     qrexec_base.ExecSQL;

                                     atualizaBanco;

                                  end;
                               //endi




                               // CST Origem
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from tcstoriem where codigoorigem = :codigoorigem');
                               codigocstorigem := StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('codcstorigem').AsString,0);
                               qrconsulta_base.ParamByName('codigoorigem').AsInteger:= codigocstorigem;
                               qrconsulta_base.Open;

                               //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                               if (qrconsulta_base.RecordCount = 0) then
                                   begin
                                     qrexec_base.Close;
                                     qrexec_base.SQL.Clear;
                                     qrexec_base.SQL.Add('insert into tcstoriem (codigoorigem, descricaoorigem) values (:codigoorigem, :descricaoorigem)');
                                     qrexec_base.ParamByName('codigodescricao').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('codcstorigem').AsString;
                                     qrexec_base.ParamByName('descricaoorigem').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('codcstorigem').AsString;
                                     qrexec_base.ExecSQL;

                                     atualizaBanco;

                                   end;
                               //endi



                               // Grupo
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from tgrupoestoque where grupo = :grupo');
                               qrconsulta_base.ParamByName('grupo').AsString:= modulo_vendaorc.qrvenda_itemproduto.FieldByName('descricaogrupo').AsString;
                               qrconsulta_base.Open;

                               //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                               if (qrconsulta_base.RecordCount = 0) then
                                   begin
                                     qrexec_base.Close;
                                     qrexec_base.SQL.Clear;
                                     qrexec_base.SQL.Add('insert into tgrupoestoque (grupo) values (:grupo)');
                                     qrexec_base.ParamByName('grupo').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('descricaogrupo').AsString;
                                     qrexec_base.ExecSQL;

                                     atualizaBanco;

                                   end;
                               //endi



                               // IPI
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from tcstipi where codcstipi = :codcstipi');
                               scodigocstipi := formatfloat('00',  StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglaipi').AsString,53));
                               qrconsulta_base.ParamByName('codcstipi').AsString:= scodigocstipi;
                               qrconsulta_base.Open;

                               //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                               if (qrconsulta_base.RecordCount = 0) then
                                  begin
                                    qrexec_base.Close;
                                    qrexec_base.SQL.Clear;
                                    qrexec_base.SQL.Add('insert into tcstipi (codcstipi, descricao) values (:codcstipi, :descricao)');
                                    qrexec_base.ParamByName('codcstipi').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglaipi').AsString;
                                    qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglaipi').AsString;
                                    qrexec_base.ExecSQL;

                                    atualizaBanco;
                                  end;
                               //endi


                               // PIS
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from tcstpis where codigocst = :codigocst');
                               scodigocstpis := formatfloat('00',StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglapis').AsString,7));
                               qrconsulta_base.ParamByName('codigocst').AsString:= scodigocstpis;
                               qrconsulta_base.Open;

                               //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                               if (qrconsulta_base.RecordCount = 0) then
                                  begin
                                    qrexec_base.Close;
                                    qrexec_base.SQL.Clear;
                                    qrexec_base.SQL.Add('insert into tcstpis (codigocst, descricao) values (:codigocst, :descricao)');
                                    qrexec_base.ParamByName('codigocst').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglapis').AsString;
                                    qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglapis').AsString;
                                    qrexec_base.ExecSQL;

                                    atualizaBanco;
                                  end;
                               //endi





                               // COFINS
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from tcstcofins where codigocstcofins = :codigocstcofins');
                               scodigocstcofins := formatfloat('00',StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglacofins').AsString,7));
                               qrconsulta_base.ParamByName('codigocstcofins').Asstring:= scodigocstcofins;
                               qrconsulta_base.Open;

                               //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                               if (qrconsulta_base.RecordCount = 0) then
                                  begin
                                    qrexec_base.Close;
                                    qrexec_base.SQL.Clear;
                                    qrexec_base.SQL.Add('insert into tcstcofins (codigocstcofins, descricao) values (:codigocstcofins, :descricao)');
                                    qrexec_base.ParamByName('codigocstcofins').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglacofins').AsString;
                                    qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglacofins').AsString;
                                    qrexec_base.ExecSQL;

                                    atualizaBanco;
                                  end;
                               //endi


                               //  CSOSN
                               qrconsulta_base.Close;
                               qrconsulta_base.SQL.Clear;
                               qrconsulta_base.SQL.Add('select * from tcsticms where codigocst = :codigocst');
                               codigocst := StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('csosn').AsString,500);
                               qrconsulta_base.ParamByName('codigocst').AsInteger:= codigocst;
                               qrconsulta_base.Open;

                               //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                               if (qrconsulta_base.RecordCount = 0) then
                                  begin
                                    qrexec_base.Close;
                                    qrexec_base.SQL.Clear;
                                    qrexec_base.SQL.Add('insert into tcsticms (codigocst, descricao) values (:codigocst, :descricao)');
                                    qrexec_base.ParamByName('codigocst').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('csosn').AsString;
                                    qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('csosn').AsString;
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
                                    qrexec_base.SQL.Add('insert into testoque (controle,   origem,  grupo,  produto,  unidade,  precocusto,  perclucro,  precovenda,  IAT,  IPPT,  tributado,  pesado,  codunidademedida,  codcstorigem,  codigocstorigem,  fatorconversao,  controlarvalidade,  codgrupo,  ncm,  codbarras,  tipobarra,  ativo,  referencia,  customedio,  datahoracadastro,  usagrade,  usaserial,  codtributacaoipi,  tributacaoipi,  codtributacaopis,  tributacaopis,  codtributacaocofins,  tributacaocofins,  possuiicmsst,  isento,  csosn,  descricaocsosn,  codaplicacaoproduto,  aplicacaoproduto,  codemitente,  cest  ) values ');
                                    qrexec_base.SQL.Add('                     (:controle, :origem, :grupo, :produto, :unidade, :precocusto, :perclucro, :precovenda, :IAT, :IPPT, :tributado, :pesado, :codunidademedida, :codcstorigem, :codigocstorigem, :fatorconversao, :controlarvalidade, :codgrupo, :ncm, :codbarras, :tipobarra, :ativo, :referencia, :customedio, :datahoracadastro, :usagrade, :usaserial, :codtributacaoipi, :tributacaoipi, :codtributacaopis, :tributacaopis, :codtributacaocofins, :tributacaocofins, :possuiicmsst, :isento, :csosn, :descricaocsosn, :codaplicacaoproduto, :aplicacaoproduto, :codemitente, :cest  )');

                                    qrexec_base.ParamByName('controle').AsInteger:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('cpro').AsInteger;
                                    qrexec_base.ParamByName('produto').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('descricao').AsString;;
                                    qrexec_base.ParamByName('unidade').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('und').AsString;
                                    qrexec_base.ParamByName('cest').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('cest').AsString;


                                    qrexec_base.ParamByName('usagrade').AsString:= 'NÃO';
                                    qrexec_base.ParamByName('usaserial').AsString:= 'NÃO';
                                    qrexec_base.ParamByName('datahoracadastro').AsDate:= now();
                                    qrexec_base.ParamByName('possuiicmsst').AsString:= 'SIM';
                                    qrexec_base.ParamByName('isento').AsString:= 'NÃO';
                                    qrexec_base.ParamByName('codaplicacaoproduto').AsString:= '00';
                                    qrexec_base.ParamByName('aplicacaoproduto').AsString:= 'MERCADORIA PARA REVENDA';
                                    qrexec_base.ParamByName('codemitente').AsInteger:= 1;
                                    qrexec_base.ParamByName('valorconversao').Asfloat:= 1;

                                    // Consulta Unidade Medida
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
                                    qrconsulta_base.ParamByName('descricao').AsString:= modulo_vendaorc.qrvenda_itemproduto.FieldByName('und').AsString;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('codunidademedida').AsInteger :=    qrconsulta_base.FieldByName('controle').AsInteger;


                                    //Consulta origem
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tcstoriem where codigoorigem = :codigoorigem');
                                    codigocstorigem := StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('codcstorigem').AsString,0);
                                    qrconsulta_base.ParamByName('codigoorigem').AsInteger:= codigocstorigem;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('codcstorigem').AsInteger :=  qrconsulta_base.FieldByName('controle').AsInteger  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                                    qrexec_base.ParamByName('origem').AsString:= qrconsulta_base.FieldByName('codigoorigem').AsString+' - '+qrconsulta_base.FieldByName('descricaoorigem').AsString ;




                                    //Consulta IPI
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tcstipi where codcstipi = :codcstipi');
                                    scodigocstipi := formatfloat('00',StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglaipi').AsString,53));
                                    qrconsulta_base.ParamByName('codcstipi').AsString:= scodigocstipi;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('codtributacaoipi').Asstring :=  qrconsulta_base.FieldByName('codcstipi').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                                    qrexec_base.ParamByName('tributacaoipi').AsString:= qrconsulta_base.FieldByName('descricao').AsString;



                                    //Consulta PIS
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tcstpis where codigocst = :codigocst');
                                    scodigocstpis :=  formatfloat('00',  StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglapis').AsString,7));
                                    qrconsulta_base.ParamByName('codigocst').AsString:= scodigocstpis;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('codtributacaopis').AsString :=  qrconsulta_base.FieldByName('codigocst').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                                    qrexec_base.ParamByName('tributacaopis').AsString:= qrconsulta_base.FieldByName('descricao').AsString;


                                    //Consulta Cofins
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tcstcofins where codigocstcofins = :codigocstcofins');
                                    scodigocstcofins :=  formatfloat('00',  StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('siglacofins').AsString,7));
                                    qrconsulta_base.ParamByName('codigocstcofins').AsString:= scodigocstcofins;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('codtributacaocofins').AsString :=  qrconsulta_base.FieldByName('codigocstcofins').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                                    qrexec_base.ParamByName('tributacaocofins').AsString:= qrconsulta_base.FieldByName('descricao').AsString;




                                    //Consulta CSOSN
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tcsticms where codigocst = :codigocst');
                                    codigocst :=  StrToIntDef(modulo_vendaorc.qrvenda_itemproduto.FieldByName('csosn').AsString,500);
                                    qrconsulta_base.ParamByName('codigocst').AsInteger:= codigocst;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('csosn').AsString :=  qrconsulta_base.FieldByName('codigocst').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                                    qrexec_base.ParamByName('descricaocsosn').AsString:= qrconsulta_base.FieldByName('descricao').AsString;




                                    //Consulta Grupo
                                    qrconsulta_base.Close;
                                    qrconsulta_base.SQL.Clear;
                                    qrconsulta_base.SQL.Add('select * from tgrupoestoque where grupo = :grupo');
                                    qrconsulta_base.ParamByName('grupo').AsString:= modulo_vendaorc.qrvenda_itemproduto.FieldByName('descricaogrupo').AsString;
                                    qrconsulta_base.Open;

                                    qrexec_base.ParamByName('codgrupo').AsInteger :=  qrconsulta_base.FieldByName('controle').AsInteger  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                                    qrexec_base.ParamByName('grupo').AsString :=   modulo_vendaorc.qrvenda_itemproduto.FieldByName('descricaogrupo').AsString;

                                    qrexec_base.ParamByName('precocusto').Asfloat:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('precocusto').Asfloat;
                                    qrexec_base.ParamByName('perclucro').Asfloat:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('perclucro').Asfloat;
                                    qrexec_base.ParamByName('precovenda').Asfloat:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('precovenda').Asfloat;


                                    qrexec_base.ParamByName('codbarras').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('codbarras').AsString;
                                    qrexec_base.ParamByName('referencia').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('referencia').AsString;
                                    qrexec_base.ParamByName('ncm').AsString:=modulo_vendaorc.qrvenda_itemproduto.FieldByName('ncm').AsString;

                                    qrexec_base.ParamByName('IAT').AsString:='A';
                                    qrexec_base.ParamByName('IPPT').AsString:='T';
                                    qrexec_base.ParamByName('tributado').AsString:='SIM';
                                    qrexec_base.ParamByName('pesado').AsString:='NÃO';
                                    qrexec_base.ParamByName('fatorconversao').AsString:='*';
                                    qrexec_base.ParamByName('controlarvalidade').AsString:='NÃO';
                                    qrexec_base.ParamByName('ativo').AsString:='SIM';

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
                               qrexec_base.SQL.Add('insert into TITEMPEDIDOVENDA(  codpedidovenda,   datahoracadastro,  codproduto,   produto,   qtde,   un,   valorunitario,   valordesconto,    valoracrescimo,    percdesconto,    percacrescimo,  situacaotributaria,  aliquota,  cancelado,     decimaisqtde,   decimaisvalorunitario,  coditem,    valordescontounitario,    valoracrescimounitario,    controleorigemmesclagem,  numerodav,   md5dav,   mesclar,  status,  qtdeconvertida,  unconvertida,   obs  ) ');
                               qrexec_base.SQL.Add('                     values(:codpedidovenda,   :datahoracadastro, :codproduto,  :produto,  :qtde,  :un,  :valorunitario,  :valordesconto,   :valoracrescimo,   :percdesconto,   :percacrescimo, :situacaotributaria, :aliquota, :cancelado,    :decimaisqtde,  :decimaisvalorunitario, :coditem,   :valordescontounitario,   :valoracrescimounitario,   :controleorigemmesclagem, :numerodav,  :md5dav,  :mesclar, :status, :qtdeconvertida, :unconvertida,  :obs ) ');


                               qrexec_base.ParamByName('codpedidovenda').AsInteger := icodigo_controle;
                               qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
                               qrexec_base.ParamByName('codproduto').AsInteger :=  qrvenda_itemproduto.FieldByName('cpro').AsInteger;
                               qrexec_base.ParamByName('produto').AsString:=  qrvenda_itemproduto.FieldByName('descricao').AsString;
                               qrexec_base.ParamByName('qtde').Asfloat := qrvenda_itemproduto.FieldByName('qtde').Asfloat;
                               qrexec_base.ParamByName('un').AsString:= qrvenda_itemproduto.FieldByName('und').AsString;
                               qrexec_base.ParamByName('valorunitario').Asfloat := qrvenda_itemproduto.FieldByName('prve').Asfloat;
                               qrexec_base.ParamByName('valordesconto').Asfloat:= 0;
                               qrexec_base.ParamByName('valoracrescimo').Asfloat:= 0;
                               qrexec_base.ParamByName('percdesconto').Asfloat:= 0;
                               qrexec_base.ParamByName('percacrescimo').Asfloat:= 0;
                               qrexec_base.ParamByName('situacaotributaria').AsString:= 'F';
                               qrexec_base.ParamByName('aliquota').Asfloat:= 0;
                               qrexec_base.ParamByName('cancelado').AsString:= 'N';
                               qrexec_base.ParamByName('decimaisqtde').AsInteger:= 2;
                               qrexec_base.ParamByName('decimaisvalorunitario').AsInteger:= 2;
                               qrexec_base.ParamByName('coditem').AsInteger:=sequencia_num;
                               qrexec_base.ParamByName('valordescontounitario').Asfloat:= 0;
                               qrexec_base.ParamByName('valoracrescimounitario').Asfloat:= 0;
                               qrexec_base.ParamByName('numerodav').AsString := numDav;
                               qrexec_base.ParamByName('status').AsString := 'ABERTO';


                               //qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle_item;
                               //qrexec_base.ParamByName('indicadorcancelamento').AsString:= 'N';
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
       qrvenda.SQL.Add('select c.responsavelent, c.fantasia, c.telefones, c.contato, c.dddeent, c.endent, c.cpf, c.ie, c.complent, c.bairroent, c.cidadeent, c.cepent, c.telefoneent, c.estadoent, c.observacao, c.referencia_end, ctipocli, c.nroent,   v.cfun as cfunc, f.nome as nfunc,  v.codigo, v.nped, v.ccli, v.total, c.nome from svenda v right join clientes c on v.ccli = c.codigo   right join funcionarios f on v.cfun = f.codigo    where coalesce(v.nped, 0) > 0');
       qrvenda.Open;

     end;
   //end
end;

end.

