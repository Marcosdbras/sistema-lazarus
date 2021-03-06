unit ufuncao_geral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


const versao:string =  'v.0.0.0';

var
         //Variável global de conexão ao banco
         sHostName, sPort, sProtocol, sLibraryLocation, sUser,   sPassword,
         sDatabase,   sClientCodepage, sCaminhoDB2, sHostNameRemoto, sDataBaseRemoto: string;

         //Variáveil global
         icontrole_usuario: integer;

         //Variável global
         susuario, ssenha:string;
         icemp:integer;




procedure arq_execscript;
procedure atualiza_base;
procedure verificaInf;
procedure transf_dados;
function DataDirectory: string;
function existe_tabela(nome:string):integer;
function existe_campo(tabela,campo:string):integer;
function mostrar_inf_campo(tabela,campo:string):integer;

function tira(pValor:string; retira:pchar):string;
function tirapontos(pValor:string):string;
function tiratracos(pValor:string):string;
function tirabarras(pValor:string):string;
function tirafimarq(pValor:string):string;
function Cript(senha,chave,operacao: string) : string;
Function Extenso(mNum:Currency):String;

Function MesExtenso(mDt:tDateTime):String;
Function DataPorExtenso(mDt:tDateTime):String;
Function Arred0dec(pValor:real):real;
Function Arre1Dec(pValor:real):real;
function FormataCNPJ(CNPJ: string): string;
function FormataCPF(CPF: string): string;
function proc_cest(ncm:string):string;
function proc_cestDescricao(ncm:string):string;
function RemoveAcentoTexto(aText : string) : string;
function RemoveAcento(const pText: string): string;






implementation
        uses umodulo_conexaodb, umodulo_produto, umodulo_remoto, umodulo_emitente, ufuncao_conexaodb;


procedure verificaInf;
begin

  if conectarBanco_remoto then
     begin

       modulo_emitente.qremitente.Close;
       modulo_emitente.qremitente.SQL.Clear;
       modulo_emitente.qremitente.SQL.Add('select * from temitente');
       modulo_emitente.qremitente.Open;
       if modulo_emitente.qremitente.RecordCount > 0 then
          begin

            modulo_remoto.qrconsulta_base_remoto.Close;
            modulo_remoto.qrconsulta_base_remoto.SQL.Clear;
            modulo_remoto.qrconsulta_base_remoto.SQL.Add('select * from temitente where cnpj = :cnpj;');
            modulo_remoto.qrconsulta_base_remoto.Params.ParamByName('cnpj').AsString  := modulo_emitente.qremitente.FieldByName('cnpj').AsString;
            modulo_remoto.qrconsulta_base_remoto.Open;

            if modulo_remoto.qrconsulta_base_remoto.RecordCount = 0 then
               begin

                 modulo_remoto.qrexec_base_remoto.Close;
                 modulo_remoto.qrexec_base_remoto.SQL.Clear;
                 modulo_remoto.qrexec_base_remoto.SQL.Add('insert into temitente( codcidade,  nomefantasia,  razaosocial,  cnpj,  codicms,  endereco,  bairro,  cidade,  uf,  cep,  pais,  codcidadeibge,  datahoracadastro,  verificadorfb,  autorizadouso,  atualizarestoque,  comparando,  numero,  telefone,  email) values '+
                                                                               '(:codcidade, :nomefantasia, :razaosocial, :cnpj, :codicms, :endereco, :bairro, :cidade, :uf, :cep, :pais, :codcidadeibge, :datahoracadastro, :verificadorfb, :autorizadouso, :atualizarestoque, :comparando, :numero, :telefone, :email)');


                 if modulo_emitente.qremitente.FieldByName('codcidade').AsInteger > 0 then
                    modulo_remoto.qrexec_base_remoto.Params.ParamByName('codcidade').AsInteger := modulo_emitente.qremitente.FieldByName('codcidade').AsInteger;
                 //endi

                 if modulo_emitente.qremitente.FieldByName('codicms').AsInteger > 0 then
                    modulo_remoto.qrexec_base_remoto.Params.ParamByName('codicms').AsInteger := modulo_emitente.qremitente.FieldByName('codicms').AsInteger;
                 //endi


                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('nomefantasia').AsString := modulo_emitente.qremitente.FieldByName('nomefantasia').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('razaosocial').AsString := modulo_emitente.qremitente.FieldByName('razaosocial').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('cnpj').AsString := modulo_emitente.qremitente.FieldByName('cnpj').AsString;

                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('endereco').AsString := modulo_emitente.qremitente.FieldByName('endereco').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('bairro').AsString := modulo_emitente.qremitente.FieldByName('bairro').AsString;


                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('cidade').AsString := modulo_emitente.qremitente.FieldByName('cidade').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('uf').AsString := modulo_emitente.qremitente.FieldByName('uf').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('cep').AsString := modulo_emitente.qremitente.FieldByName('cep').AsString;

                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('pais').AsString := modulo_emitente.qremitente.FieldByName('pais').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('codcidadeibge').AsString := modulo_emitente.qremitente.FieldByName('codcidadeibge').AsString;

                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('verificadorfb').AsString := modulo_emitente.qremitente.FieldByName('verificadorfb').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('autorizadouso').AsString := modulo_emitente.qremitente.FieldByName('autorizadouso').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('atualizarestoque').AsString := modulo_emitente.qremitente.FieldByName('atualizarestoque').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('comparando').AsString := modulo_emitente.qremitente.FieldByName('comparando').AsString;

                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('numero').AsString := modulo_emitente.qremitente.FieldByName('numero').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('telefone').AsString := modulo_emitente.qremitente.FieldByName('telefone').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('email').AsString := modulo_emitente.qremitente.FieldByName('email').AsString;



                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('datahoracadastro').AsDateTime := modulo_emitente.qremitente.FieldByName('datahoracadastro').AsDateTime;


                 modulo_remoto.qrexec_base_remoto.ExecSQL;

                 modulo_conexaodb.atualizaBancoRemotoFechaTransacao;

                 modulo_remoto.qrconsulta_base_remoto.Close;
                 modulo_remoto.qrconsulta_base_remoto.SQL.Clear;
                 modulo_remoto.qrconsulta_base_remoto.SQL.Add('select * from temitente where (cnpj = :cnpj)');
                 modulo_remoto.qrconsulta_base_remoto.Params.ParamByName('cnpj').AsString  := modulo_emitente.qremitente.FieldByName('cnpj').AsString;
                 modulo_remoto.qrconsulta_base_remoto.Open;

                   icemp :=  modulo_remoto.qrconsulta_base_remoto.FieldByName('controle').Asinteger;

               end
            else
               begin

                 modulo_remoto.qrexec_base_remoto.Close;
                 modulo_remoto.qrexec_base_remoto.SQL.Clear;
                 modulo_remoto.qrexec_base_remoto.SQL.Add('update temitente set codcidade = :codcidade, nomefantasia = :nomefantasia, razaosocial = :razaosocial, codicms = :codicms where cnpj = :cnpj');

                 if modulo_emitente.qremitente.FieldByName('codcidade').AsInteger > 0 then
                    modulo_remoto.qrexec_base_remoto.Params.ParamByName('codcidade').AsInteger := modulo_emitente.qremitente.FieldByName('codcidade').AsInteger;
                 //endi

                 if  modulo_emitente.qremitente.FieldByName('codicms').AsInteger > 0 then
                     modulo_remoto.qrexec_base_remoto.Params.ParamByName('codicms').AsInteger := modulo_emitente.qremitente.FieldByName('codicms').AsInteger;
                 //endi

                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('nomefantasia').AsString := modulo_emitente.qremitente.FieldByName('nomefantasia').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('razaosocial').AsString := modulo_emitente.qremitente.FieldByName('razaosocial').AsString;
                 modulo_remoto.qrexec_base_remoto.Params.ParamByName('cnpj').AsString := modulo_emitente.qremitente.FieldByName('cnpj').AsString;

                 modulo_remoto.qrexec_base_remoto.ExecSQL;

                 icemp :=  modulo_remoto.qrconsulta_base_remoto.FieldByName('controle').AsInteger;

               end;
            //endi

          end;
       //endi

       modulo_conexaodb.desconectarBancoRemoto;

     end;
  //endi




end;

procedure transf_dados;
begin
   //-------
   with modulo_conexaodb do
     begin


     end;
   //endth
end;

procedure atualiza_base;
var
  f:string;

begin

try



//Tabela TMASTER_ATU existe?
if existe_tabela('TMASTER_ATU') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_ATU(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_ATU_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_ATU ADD CONSTRAINT PK_TMASTER_ATU  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_ATU_bi for tmaster_ATU');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_ATU_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif



//Tabela TMASTER_CAIXA existe?
if existe_tabela('TMASTER_CAIXA') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_CAIXA(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_CAIXA_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CONSTRAINT PK_TMASTER_CAIXA  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_caixa_bi for tmaster_caixa');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_caixa_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif


//Tabela TMASTER_RECEBER existe?
if existe_tabela('TMASTER_RECEBER') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_RECEBER(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_RECEBER_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD CONSTRAINT PK_TMASTER_RECEBER  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_receber_bi for tmaster_receber');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_receber_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif




//Tabela TMASTER_EXT_RECEBER existe?
if existe_tabela('TMASTER_EXT_RECEBER') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_EXT_RECEBER(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_EXT_RECEBER_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_EXT_RECEBER ADD CONSTRAINT PK_TMASTER_EXT_RECEBER  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_ext_receber_bi for tmaster_ext_receber');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_ext_receber_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif






//Tabela TMASTER_COTACAO_ITEM existe?
if existe_tabela('TMASTER_COTACAO_ITEM') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_COTACAO_ITEM(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_COTACAO_ITEM_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM ADD CONSTRAINT PK_TMASTER_COTACAO_ITEM  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_cotacao_item_bi for tmaster_cotacao_item');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_cotacao_item_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif


//Tabela TMASTER_ITEMPEDIDOVENDA existe?
if existe_tabela('TMASTER_ITEMPEDIDOVENDA') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_ITEMPEDIDOVENDA(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_ITEMPEDIDOVENDA_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_ITEMPEDIDOVENDA ADD CONSTRAINT PK_TMASTER_ITEMPEDIDOVENDA  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger TMASTER_ITEMPEDIDOVENDA_bi for TMASTER_ITEMPEDIDOVENDA');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(GEN_TMASTER_ITEMPEDIDOVENDA_ID,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif





//Tabela TMASTER_ITENSORCAMENTO existe?
if existe_tabela('TMASTER_ITENSORCAMENTO') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_ITENSORCAMENTO(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_ITENSORCAMENTO_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_ITENSORCAMENTO ADD CONSTRAINT PK_TMASTER_ITENSORCAMENTO  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_itensorcamento_bi for tmaster_itensorcamento');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_itensorcamento_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif





//MarcosBras
//24.07.2019
//Tabela TMASTER_PEDIDOVENDA existe?
if existe_tabela('TMASTER_PEDIDOVENDA') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_PEDIDOVENDA(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_PEDIDOVENDA_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA ADD CONSTRAINT PK_TMASTER_PEDIDOVENDA  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_pedidovenda_bi for tmaster_pedidovenda');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_pedidovenda_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif








//Tabela TMASTER_ORCAMENTO existe?
if existe_tabela('TMASTER_ORCAMENTO') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_ORCAMENTO(CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_ORCAMENTO_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_ORCAMENTO ADD CONSTRAINT PK_TMASTER_ORCAMENTO  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_orcamento_bi for tmaster_orcamento');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_orcamento_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif






//Tabela TMASTER_INDICE existe?
if existe_tabela('TMASTER_INDICE') = 0 then
   begin

     with modulo_conexaodb do
     begin


        //Script.Terminator:=';';
        //Script.Script.Clear;
        //Script.Script.Add('execute procedure sptotalizaorcamento(10);');
        //Script.Script.Add('commit work;');
        //Script.Script.Add('SET AUTODDL ON;');
        //Script.Execute;




       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_INDICE (CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_INDICE_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_INDICE ADD CONSTRAINT PK_TMASTER_INDICE  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_indice_bi for tmaster_indice');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_indice_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif


//Campo ATUALIZABASE existe?
if existe_campo('TMASTER_ATU','ATUALIZABASE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ATU  ADD  ATUALIZABASE  VARCHAR(100);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Campo CODPEDIDOVENDA existe?
if existe_campo('TMASTER_RECEBER','CODPEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  CODPEDIDOVENDA  INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo DESCRICAOLANCAMENTO existe?
if existe_campo('TMASTER_RECEBER','DESCRICAOLANCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  DESCRICAOLANCAMENTO    VARCHAR(100) COLLATE PT_BR;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo QTDEPARCELA existe?
if existe_campo('TMASTER_RECEBER','QTDEPARCELA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  QTDEPARCELA   INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo NPARCELA existe?
if existe_campo('TMASTER_RECEBER','NPARCELA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  NPARCELA  INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CODCLIENTE existe?
if existe_campo('TMASTER_RECEBER','CODCLIENTE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  CODCLIENTE  INTEGER NOT NULL;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo CLIENTE  existe?
if existe_campo('TMASTER_RECEBER','CLIENTE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  CLIENTE  VARCHAR(100) COLLATE PT_BR;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CODESPECIE  existe?
if existe_campo('TMASTER_RECEBER','CODESPECIE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  CODESPECIE  INTEGER NOT NULL;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo ESPECIE   existe?
if existe_campo('TMASTER_RECEBER','ESPECIE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD ESPECIE VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo DATAHORACADASTRO  existe?
if existe_campo('TMASTER_RECEBER','DATAHORACADASTRO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD DATAHORACADASTRO TIMESTAMP;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo DATAVENCIMENTO existe?
if existe_campo('TMASTER_RECEBER','DATAVENCIMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD DATAVENCIMENTO  DATE;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CODPLANOCONTA   existe?
if existe_campo('TMASTER_RECEBER','CODPLANOCONTA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD CODPLANOCONTA INTEGER NOT NULL;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo PLANOCONTA existe?
if existe_campo('TMASTER_RECEBER','PLANOCONTA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD PLANOCONTA VARCHAR(100) NOT NULL COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo DOCUMENTO existe?
if existe_campo('TMASTER_RECEBER','DOCUMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD DOCUMENTO VARCHAR(20) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo ORIGEM existe?
if existe_campo('TMASTER_RECEBER','ORIGEM') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD ORIGEM  VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo VALORORIGINAL  existe?
if existe_campo('TMASTER_RECEBER','VALORORIGINAL') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD VALORORIGINAL DECIMAL(15,2);');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo OBS existe?
if existe_campo('TMASTER_RECEBER','OBS') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD OBS BLOB SUB_TYPE 1 SEGMENT SIZE 80;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CODFUNCIONARIO existe?
if existe_campo('TMASTER_RECEBER','CODFUNCIONARIO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD CODFUNCIONARIO INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo FUNCIONARIO existe?
if existe_campo('TMASTER_RECEBER','FUNCIONARIO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD FUNCIONARIO VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CODVENDEDOR existe?
if existe_campo('TMASTER_RECEBER','CODVENDEDOR') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD CODVENDEDOR INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo VENDEDOR  existe?
if existe_campo('TMASTER_RECEBER','VENDEDOR') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD VENDEDOR VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CODBARRA existe?
if existe_campo('TMASTER_RECEBER','CODBARRA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD CODBARRA VARCHAR(500) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo REPLICADA existe?
if existe_campo('TMASTER_RECEBER','REPLICADA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD REPLICADA VARCHAR(3) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo STATUS existe?
if existe_campo('TMASTER_RECEBER','STATUS') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD STATUS VARCHAR(10) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo PRAZO existe?
if existe_campo('TMASTER_RECEBER','PRAZO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER  ADD  PRAZO  INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CODCENTROCUSTO   existe?
if existe_campo('TMASTER_RECEBER','CODCENTROCUSTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD CODCENTROCUSTO INTEGER NOT NULL;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CENTROCUSTO existe?
if existe_campo('TMASTER_RECEBER','CENTROCUSTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD CENTROCUSTO VARCHAR(100) NOT NULL COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo DATAFEC existe?
if existe_campo('TMASTER_RECEBER','DATAFEC') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_RECEBER ADD DATAFEC DATE;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo DATAHORACADASTRO existe?
if existe_campo('TMASTER_CAIXA','DATAHORACADASTRO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD DATAHORACADASTRO  TIMESTAMP;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo ORIGEM existe?
if existe_campo('TMASTER_CAIXA','ORIGEM') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD ORIGEM VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo DOCUMENTO existe?
if existe_campo('TMASTER_CAIXA','DOCUMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD DOCUMENTO  VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo DESCRICAOLANCAMENTO existe?
if existe_campo('TMASTER_CAIXA','DESCRICAOLANCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD DESCRICAOLANCAMENTO  VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CODCLIENTE existe?
if existe_campo('TMASTER_CAIXA','CODCLIENTE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODCLIENTE INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CLIENTE existe?
if existe_campo('TMASTER_CAIXA','CLIENTE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CLIENTE  VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo CODFORNECEDOR   existe?
if existe_campo('TMASTER_CAIXA','CODFORNECEDOR') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODFORNECEDOR INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo CONTROLE_TRECEBER existe?
if existe_campo('TMASTER_EXT_RECEBER','CONTROLE_TRECEBER') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_EXT_RECEBER  ADD  CONTROLE_TRECEBER  INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo CODPEDIDOVENDA existe?
if existe_campo('TMASTER_EXT_RECEBER','CODPEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_EXT_RECEBER  ADD  CODPEDIDOVENDA  INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Campo FORNECEDOR  existe?
if existe_campo('TMASTER_CAIXA','FORNECEDOR') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD FORNECEDOR VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CODTRANSPORTADORA existe?
if existe_campo('TMASTER_CAIXA','CODTRANSPORTADORA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODTRANSPORTADORA INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo TRANSPORTADORA existe?
if existe_campo('TMASTER_CAIXA','TRANSPORTADORA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD TRANSPORTADORA VARCHAR(50) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CODCENTROCUSTO  existe?
if existe_campo('TMASTER_CAIXA','CODCENTROCUSTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODCENTROCUSTO  INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CENTROCUSTO existe?
if existe_campo('TMASTER_CAIXA','CENTROCUSTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CENTROCUSTO VARCHAR(100) NOT NULL COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CODESPECIE   existe?
if existe_campo('TMASTER_CAIXA','CODESPECIE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODESPECIE  INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo ESPECIE   existe?
if existe_campo('TMASTER_CAIXA','ESPECIE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD ESPECIE VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CENTROCUSTO existe?
if existe_campo('TMASTER_CAIXA','CODPLANCONTA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODPLANCONTA INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo PLANCONTA  existe?
if existe_campo('TMASTER_CAIXA','PLANCONTA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD PLANCONTA  VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CODFUNCIONARIO existe?
if existe_campo('TMASTER_CAIXA','CODFUNCIONARIO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODFUNCIONARIO INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo FUNCIONARIO  existe?
if existe_campo('TMASTER_CAIXA','FUNCIONARIO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD FUNCIONARIO  VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Campo CODFUNCIONARIOVALE  existe?
if existe_campo('TMASTER_CAIXA','CODFUNCIONARIOVALE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODFUNCIONARIOVALE   INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Campo FUNCIONARIOVALE   existe?
if existe_campo('TMASTER_CAIXA','FUNCIONARIOVALE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD FUNCIONARIOVALE      VARCHAR(100) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo VALORENTRADA  existe?
if existe_campo('TMASTER_CAIXA','VALORENTRADA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD VALORENTRADA DECIMAL(15,4);');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Campo VALORSAIDA  existe?
if existe_campo('TMASTER_CAIXA','VALORSAIDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD VALORSAIDA  DECIMAL(15,4);');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Campo SALDO  existe?
if existe_campo('TMASTER_CAIXA','SALDO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD SALDO DECIMAL(15,4);');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo OBS  existe?
if existe_campo('TMASTER_CAIXA','OBS') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD OBS BLOB SUB_TYPE 1 SEGMENT SIZE 80;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo STATUS  existe?
if existe_campo('TMASTER_CAIXA','STATUS') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD STATUS  VARCHAR(10) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo CODMODULO  existe?
if existe_campo('TMASTER_CAIXA','CODMODULO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODMODULO  INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo COOCCFPDV  existe?
if existe_campo('TMASTER_CAIXA','COOCCFPDV') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD COOCCFPDV  VARCHAR(12) COLLATE PT_BR;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo CODCOMPRA  existe?
if existe_campo('TMASTER_CAIXA','CODCOMPRA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODCOMPRA INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi







//Campo CODNFE  existe?
if existe_campo('TMASTER_CAIXA','CODNFE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODNFE INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Campo CODNFCE  existe?
if existe_campo('TMASTER_CAIXA','CODNFCE') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODNFCE INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Campo CODOS  existe?
if existe_campo('TMASTER_CAIXA','CODOS') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODOS INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi







//Campo CODPAGAR  existe?
if existe_campo('TMASTER_CAIXA','CODPAGAR') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODPAGAR INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo CODPDV   existe?
if existe_campo('TMASTER_CAIXA','CODPDV') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODPDV  INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Campo CODRECEBER existe?
if existe_campo('TMASTER_CAIXA','CODRECEBER') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CODRECEBER INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Campo CONTROLENOPDV existe?
if existe_campo('TMASTER_CAIXA','CONTROLENOPDV') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_CAIXA ADD CONTROLENOPDV  INTEGER;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//---------------------------------------





//Campo dif_prazo existe?
if existe_campo('TMASTER_COTACAO_ITEM','dif_prazo') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD dif_prazo integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo prazo existe?
if existe_campo('TMASTER_COTACAO_ITEM','prazo') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD prazo integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo escolhido existe?
if existe_campo('TMASTER_COTACAO_ITEM','escolhido') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD escolhido char(1) default ''N'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo margem_lucro existe?
if existe_campo('TMASTER_COTACAO_ITEM','margem_lucro') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD margem_lucro decimal(15,2);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo ndanfe existe?
if existe_campo('TMASTER_COTACAO_ITEM','ndanfe') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD ndanfe integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo valor existe?
if existe_campo('TMASTER_COTACAO_ITEM','valor') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD valor decimal(15,2);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo cforn existe?
if existe_campo('TMASTER_COTACAO_ITEM','cforn') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD cforn integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo data existe?
if existe_campo('TMASTER_COTACAO_ITEM','data') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD data date ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo ccotacao existe?
if existe_campo('TMASTER_COTACAO_ITEM','ccotacao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_COTACAO_ITEM  ADD ccotacao integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Campo ccotacao no itensorcamento existe?
if existe_campo('TMASTER_ITENSORCAMENTO','ccotacao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITENSORCAMENTO ADD ccotacao integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('CREATE SEQUENCE GEN_TCCOTACAO_ID;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo controle_titensorcamento existe?
if existe_campo('TMASTER_ITENSORCAMENTO','controle_titensorcamento') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITENSORCAMENTO  ADD controle_titensorcamento integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;


              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITENSORCAMENTO ');
              Script.Script.Add('ADD CONSTRAINT FK_TMASTER_ITENSORCAMENTO_EXCL ');
              Script.Script.Add('FOREIGN KEY (CONTROLE_TITENSORCAMENTO) ');
              Script.Script.Add('REFERENCES TITENSORCAMENTO(CONTROLE) ');
              Script.Script.Add('ON DELETE CASCADE;');
              Script.Script.Add('COMMIT;');
              Script.Execute;


           end;
         //endth
  end;
//endi

//Campo ctabp no itensorcamento existe?
if existe_campo('TMASTER_ITENSORCAMENTO','ctabp') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITENSORCAMENTO ADD ctabp integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Marcos Bras
//25.07.2019
//Campo ccotacao no ITEMPEDIDOVENDA existe?
if existe_campo('TMASTER_ITEMPEDIDOVENDA','ccotacao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITEMPEDIDOVENDA ADD ccotacao integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;



              //Script.Script.Clear;
              //Script.Terminator:=';';
              //Script.Script.Add('CREATE SEQUENCE gen_TCCOTACAO_ID;');
              //Script.Script.Add('COMMIT;');
              //Script.Execute;

           end;
         //endth
  end;
//endi

//Campo controle_tITEMPEDIDOVENDA existe?
if existe_campo('TMASTER_ITEMPEDIDOVENDA','controle_tITEMPEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITEMPEDIDOVENDA  ADD controle_titempedidovenda integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITEMPEDIDOVENDA ');
              Script.Script.Add('ADD CONSTRAINT FK_TMASTER_ITEMPEDIDOVENDA_EXCL ');
              Script.Script.Add('FOREIGN KEY (CONTROLE_TITEMPEDIDOVENDA) ');
              Script.Script.Add('REFERENCES TITEMPEDIDOVENDA(CONTROLE) ');
              Script.Script.Add('ON DELETE CASCADE;');
              Script.Script.Add('COMMIT;');
              Script.Execute;



           end;
         //endth
  end;
//endi

//Campo ctabp no ITEMPEDIDOVENDA existe?
if existe_campo('TMASTER_ITEMPEDIDOVENDA','ctabp') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ITEMPEDIDOVENDA ADD ctabp integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi





//Campo controle_torcamento existe?
if existe_campo('TMASTER_ORCAMENTO','controle_torcamento') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ORCAMENTO  ADD controle_torcamento integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ORCAMENTO ');
              Script.Script.Add('ADD CONSTRAINT FK_TMASTER_ORCAMENTO_EXCL ');
              Script.Script.Add('FOREIGN KEY (CONTROLE_TORCAMENTO) ');
              Script.Script.Add('REFERENCES TORCAMENTO(CONTROLE) ');
              Script.Script.Add('ON DELETE CASCADE;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo prazo existe?
if existe_campo('TMASTER_ORCAMENTO','prazo') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ORCAMENTO  ADD prazo integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo ctabp existe?
if existe_campo('TMASTER_ORCAMENTO','ctabp') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_ORCAMENTO  ADD ctabp integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Marcos Brás
//25.07.2019

//Campo controle_tpedidovenda existe?
if existe_campo('TMASTER_PEDIDOVENDA','controle_tpedidovenda') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD controle_tpedidovenda integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA ');
              Script.Script.Add('ADD CONSTRAINT FK_TMASTER_PEDIDOVENDA_EXCL ');
              Script.Script.Add('FOREIGN KEY (CONTROLE_TPEDIDOVENDA) ');
              Script.Script.Add('REFERENCES TPEDIDOVENDA(CONTROLE) ');
              Script.Script.Add('ON DELETE CASCADE;');
              Script.Script.Add('COMMIT;');
              Script.Execute;



           end;
         //endth
  end;
//endi

//Campo prazo existe?
if existe_campo('TMASTER_PEDIDOVENDA','prazo') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD prazo integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo ctabp existe?
if existe_campo('TMASTER_PEDIDOVENDA','ctabp') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD ctabp integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Campo cparc_pred existe?
if existe_campo('TMASTER_PEDIDOVENDA','cparc_pred') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD cparc_pred integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo descricao_parc_pred existe?
if existe_campo('TMASTER_PEDIDOVENDA','descricao_parc_pred') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD descricao_parc_pred varchar(100) ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo totalproduto existe?
if existe_campo('TMASTER_PEDIDOVENDA','totalproduto') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD totalproduto decimal(15,2) ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo percdesconto existe?
if existe_campo('TMASTER_PEDIDOVENDA','percdesconto') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD percdesconto decimal(15,2) ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Campo percdesconto existe?
if existe_campo('TMASTER_PEDIDOVENDA','vlrdesconto') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD vlrdesconto decimal(15,2) ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Campo vlrpagar existe?
if existe_campo('TMASTER_PEDIDOVENDA','vlrpagar') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD vlrpagar decimal(15,2) ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo vlrrecebido ou valor à vista existe?
if existe_campo('TMASTER_PEDIDOVENDA','vlrrecebido') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD vlrrecebido decimal(15,2) ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo vlrrecebido ou valor à vista existe?
if existe_campo('TMASTER_PEDIDOVENDA','vlrtroco') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD vlrtroco decimal(15,2) ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo nparc existe?
if existe_campo('TMASTER_PEDIDOVENDA','nparc') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD nparc integer ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo statuspedido existe?
if existe_campo('TMASTER_PEDIDOVENDA','statuspedido') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD statuspedido varchar(1) default ''A'' ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo DATAFEC existe?
if existe_campo('TMASTER_PEDIDOVENDA','DATAFEC') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD DATAFEC DATE;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo vlrpagoavista ou valor à vista existe?
//if existe_campo('TMASTER_PEDIDOVENDA','vlrpagoavista') = 0 then
//   begin

//         with modulo_conexaodb do
//           begin

//              Script.Script.Clear;
//              Script.Terminator:=';';
//              Script.Script.Add('ALTER TABLE TMASTER_PEDIDOVENDA  ADD vlrpagoavista decimal(15,2) ;   ');
//              Script.Script.Add('COMMIT;');
//              Script.Execute;

//           end;
         //endth
//  end;
//endi

//Campo cplanocontaaprazopadrao existe?
if existe_campo('TMASTER_INDICE','cplanocontaaprazopadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD cplanocontaaprazopadrao integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo cplanocontaavistapadrao existe?
if existe_campo('TMASTER_INDICE','cplanocontaavistapadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD cplanocontaavistapadrao integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo cpagamentoaprazopadrao existe?
if existe_campo('TMASTER_INDICE','cpagamentoaprazopadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD cpagamentoaprazopadrao integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo cpagamentoavistapadrao existe?
if existe_campo('TMASTER_INDICE','cpagamentoavistapadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD cpagamentoavistapadrao integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo ccentrocustopadrao existe?
if existe_campo('TMASTER_INDICE','ccentrocustopadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD ccentrocustopadrao integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo AdmSN existe?
if existe_campo('TMASTER_INDICE','AdmSN') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD AdmSN varchar(1) default ''N'' ;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo logotipo existe?
if existe_campo('TMASTER_INDICE','logotipo') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD logotipo varchar(200);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo caminhopadraopdf existe?
if existe_campo('TMASTER_INDICE','caminhopadraopdf') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD caminhopadraopdf varchar(200);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CSTPIS padrão existe?
if existe_campo('TMASTER_INDICE','codcstpispadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD codcstpispadrao integer default 11;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CSTORIEM padrão existe?
if existe_campo('TMASTER_INDICE','codcstoriempadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD codcstoriempadrao integer default 1;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CSTIPI padrão existe?
if existe_campo('TMASTER_INDICE','codcstipipadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD codcstipipadrao integer default 7;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CST padrão existe?
if existe_campo('TMASTER_INDICE','codcstpadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD codcstpadrao integer default 1;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo Cofinspadrao padrão existe?
if existe_campo('TMASTER_INDICE','codcstcofinspadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD codcstcofinspadrao integer default 7;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CSOSN padrão existe?
if existe_campo('TMASTER_INDICE','codcsosnpadrao') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD codcsosnpadrao integer default 1;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo Slogan padrão existe?
if existe_campo('TMASTER_INDICE','slogan') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD slogan varchar(100) default '+quotedstr('O mercado certo para sua obra está aqui')+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;


              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('update TMASTER_INDICE set slogan = '+quotedstr('O mercado certo para sua obra')+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;



           end;
         //endth
  end;
//endi

//Campo agradcdtesp padrão existe?
if existe_campo('TMASTER_INDICE','agradcdtesp') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD agradcdtesp varchar(100) default '+quotedstr('Agradecemos a preferência, volte sempre!')+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('update TMASTER_INDICE set agradcdtesp = '+quotedstr('Agradecemos a preferência, volte sempre!')+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo PADRAOOS padrão existe?
//ALTER TABLE TMASTER_INDICE  ADD PADRAOOS BLOB SUB_TYPE 1 SEGMENT SIZE 80
if existe_campo('TMASTER_INDICE','PADRAOOS') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD PADRAOOS BLOB SUB_TYPE 1 SEGMENT SIZE 80;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('update TMASTER_INDICE set PADRAOOS = '+quotedstr(''+chr(13)+
                                                                                 ''+chr(13)+
                                                                                 ''+chr(13)+
                                                                                 ''+chr(13)+chr(13)+
                                                                                 '_____________________________________________'+chr(13)+
                                                                                 'Departamento Comercial'
              )+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo PADRAOORCAMENTO padrão existe?
//ALTER TABLE TMASTER_INDICE  ADD PADRAOORCAMENTO BLOB SUB_TYPE 1 SEGMENT SIZE 80
if existe_campo('TMASTER_INDICE','PADRAOORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD PADRAOORCAMENTO BLOB SUB_TYPE 1 SEGMENT SIZE 80;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('update TMASTER_INDICE set PADRAOORCAMENTO = '+quotedstr('Condições de pagamento: 28 dias'+chr(13)+
                                                                                        'Prazo de entrega: 2 dias'+chr(13)+
                                                                                        'Frete: ( )CIF / ( )FOB'+chr(13)+
                                                                                        'Validade deste orçamento: 20 dias'+chr(13)+chr(13)+
                                                                                        '_____________________________________________'+chr(13)+
                                                                                        'Departamento Comercial'
              )+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Marcos Bras
//25.07.2019
//Campo PADRAOPEDIDOVENDA padrão existe?
//ALTER TABLE TMASTER_INDICE  ADD PADRAOPEDIDOVENDA BLOB SUB_TYPE 1 SEGMENT SIZE 80
if existe_campo('TMASTER_INDICE','PADRAOPEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD PADRAOPEDIDOVENDA BLOB SUB_TYPE 1 SEGMENT SIZE 80;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('update TMASTER_INDICE set PADRAOPEDIDOVENDA = '+quotedstr('Condições de pagamento: 28 dias'+chr(13)+
                                                                                        'Prazo de entrega: 2 dias'+chr(13)+
                                                                                        'Frete: ( )CIF / ( )FOB'+chr(13)+
                                                                                        'Garantia para troca: 3 dias sem violação de embalagem ou remoção de etiqueta'+chr(13)+chr(13)+
                                                                                        '_____________________________________________'+chr(13)+
                                                                                        'Departamento Comercial'
              )+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi








//Campo PADRAOPEDIDO padrão existe?
//ALTER TABLE TMASTER_INDICE  ADD PADRAOPEDIDO BLOB SUB_TYPE 1 SEGMENT SIZE 80
if existe_campo('TMASTER_INDICE','PADRAOPEDIDO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_INDICE  ADD PADRAOPEDIDO BLOB SUB_TYPE 1 SEGMENT SIZE 80;');
              Script.Script.Add('COMMIT;');
              Script.Execute;

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('update TMASTER_INDICE set PADRAOPEDIDO = '+quotedstr(''+chr(13)+
                                                                                        ''+chr(13)+
                                                                                        ''+chr(13)+
                                                                                        ''+chr(13)+chr(13)+
                                                                                        '_____________________________________________'+chr(13)+
                                                                                        'Departamento Comercial'
              )+';');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Tabela TMASTER_UNIDADE existe?
if existe_tabela('TMASTER_UNIDADE') = 0 then
   begin

     with modulo_conexaodb do
     begin


        //Script.Terminator:=';';
        //Script.Script.Clear;
        //Script.Script.Add('execute procedure sptotalizaorcamento(10);');
        //Script.Script.Add('commit work;');
        //Script.Script.Add('SET AUTODDL ON;');
        //Script.Execute;




       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_UNIDADE (CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_UNIDADE_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_UNIDADE ADD CONSTRAINT PK_TMASTER_UNIDADE  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_unidade_bi for tmaster_unidade');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_unidade_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif

//Campo DESCRICAOCOMPLETA existe?
if existe_campo('TMASTER_UNIDADE','DESCRICAOCOMPLETA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_UNIDADE  ADD DESCRICAOCOMPLETA VARCHAR(120);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo SIGLA existe?
if existe_campo('TMASTER_UNIDADE','SIGLA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_UNIDADE  ADD SIGLA VARCHAR(6);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CONTROLE_TUNIDADEMEDIDA existe?
if existe_campo('TMASTER_UNIDADE','CONTROLE_TUNIDADEMEDIDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_UNIDADE  ADD CONTROLE_TUNIDADEMEDIDA integer;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Tabela TMASTER_USUARIO existe?
if existe_tabela('TMASTER_USUARIO') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE TMASTER_USUARIO (CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_USUARIO_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_USUARIO ADD CONSTRAINT PK_TMASTER_USUARIO  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger tmaster_usuario_bi for tmaster_usuario');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_usuario_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif

//Campo SENHA existe?
if existe_campo('TMASTER_USUARIO','SENHA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD SENHA VARCHAR(20);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CONTROLE_TUSUARIO existe?
if existe_campo('TMASTER_USUARIO','CONTROLE_TUSUARIO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD CONTROLE_TUSUARIO INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//-----Permissao-------------------------------------------------------------------

//Campo EXCLUIR_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','EXCLUIR_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD EXCLUIR_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo ALTERAR_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','ALTERAR_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD ALTERAR_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo INCLUIR_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','INCLUIR_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD INCLUIR_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CONSULTA_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','CONSULTA_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD CONSULTA_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo IMPRESSAO_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','IMPRESSAO_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD IMPRESSAO_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo LIMPARFILTRO_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','LIMPARFILTRO_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD LIMPARFILTRO_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo TRANSFORCPED_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','TRANSFORCPED_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD TRANSFORCPED_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo PESQCLI_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','PESQCLI_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQCLI_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo PESQVEND_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','PESQVEND_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQVEND_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo PESQFUNC_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','PESQFUNC_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQFUNC_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo PESQDATAI_ORCAMENTO existe?
//if existe_campo('TMASTER_USUARIO','PESQDATAI_ORCAMENTO') = 0 then
//   begin

//         with modulo_conexaodb do
//           begin

//              Script.Script.Clear;
//              Script.Terminator:=';';
//              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQDATAI_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
//              Script.Script.Add('COMMIT;');
//              Script.Execute;

//           end;
         //endth
//  end;
//endi



//Campo PESQDATAF_ORCAMENTO existe?
//if existe_campo('TMASTER_USUARIO','PESQDATAF_ORCAMENTO') = 0 then
//   begin

//         with modulo_conexaodb do
//           begin

//              Script.Script.Clear;
//              Script.Terminator:=';';
//              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQDATAF_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
//              Script.Script.Add('COMMIT;');
//              Script.Execute;

//           end;
         //endth
//  end;
//endi



//Campo PESQPERIODO_ORCAMENTO existe?
if existe_campo('TMASTER_USUARIO','PESQPERIODO_ORCAMENTO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQPERIODO_ORCAMENTO VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//------------------------------------------------------------------


//Campo EXCLUIR_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','EXCLUIR_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD EXCLUIR_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo ALTERAR_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','ALTERAR_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD ALTERAR_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo INCLUIR_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','INCLUIR_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD INCLUIR_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo CONSULTA_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','CONSULTA_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD CONSULTA_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo IMPRESSAO_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','IMPRESSAO_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD IMPRESSAO_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo LIMPARFILTRO_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','LIMPARFILTRO_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD LIMPARFILTRO_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo LANCA_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','LANCA_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD LANCA_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo ESTORNA_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','ESTORNA_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD ESTORNA_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo PESQCLI_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','PESQCLI_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQCLI_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo PESQVEND_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','PESQVEND_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQVEND_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo PESQFUNC_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','PESQFUNC_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQFUNC_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Campo PESQDATAI_PEDIDOVENDA existe?
//if existe_campo('TMASTER_USUARIO','PESQDATAI_PEDIDOVENDA') = 0 then
//   begin

//         with modulo_conexaodb do
//           begin

//              Script.Script.Clear;
//              Script.Terminator:=';';
//              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQDATAI_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
//              Script.Script.Add('COMMIT;');
//              Script.Execute;

//           end;
         //endth
//  end;
//endi



//Campo PESQDATAF_PEDIDOVENDA existe?
//if existe_campo('TMASTER_USUARIO','PESQDATAF_PEDIDOVENDA') = 0 then
//   begin

//         with modulo_conexaodb do
//           begin

//              Script.Script.Clear;
//              Script.Terminator:=';';
//              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQDATAF_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
//              Script.Script.Add('COMMIT;');
//              Script.Execute;

//           end;
         //endth
//  end;
//endi



//Campo PESQPERIODO_PEDIDOVENDA existe?
if existe_campo('TMASTER_USUARIO','PESQPERIODO_PEDIDOVENDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQPERIODO_PEDIDOVENDA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//-------------------------------------------------------------------


//Campo PESQDATAI_MOVCAIXA existe?
//if existe_campo('TMASTER_USUARIO','PESQDATAI_MOVCAIXA') = 0 then
//   begin

//         with modulo_conexaodb do
//           begin

//              Script.Script.Clear;
//              Script.Terminator:=';';
//              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQDATAI_MOVCAIXA VARCHAR(3) DEFAULT ''SIM'';   ');
//              Script.Script.Add('COMMIT;');
//              Script.Execute;

//           end;
         //endth
//  end;
//endi



//Campo PESQDATAF_MOVCAIXA existe?
//if existe_campo('TMASTER_USUARIO','PESQDATAF_MOVCAIXA') = 0 then
//   begin

//         with modulo_conexaodb do
//           begin

//              Script.Script.Clear;
//              Script.Terminator:=';';
//              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQDATAF_MOVCAIXA VARCHAR(3) DEFAULT ''SIM'';   ');
//              Script.Script.Add('COMMIT;');
//              Script.Execute;

//           end;
         //endth
//  end;
//endi



//Campo PESQPERIODO_MOVCAIXA existe?
if existe_campo('TMASTER_USUARIO','PESQPERIODO_MOVCAIXA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE TMASTER_USUARIO  ADD PESQPERIODO_MOVCAIXA VARCHAR(3) DEFAULT ''SIM'';   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi




//Tabela TMASTER_OS existe?
if existe_tabela('TMASTER_OS') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Script.Clear;
       Script.Terminator:=';';
       Script.Script.Add('CREATE TABLE TMASTER_OS (CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_TMASTER_OS_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE TMASTER_OS ADD CONSTRAINT PK_TMASTER_OS  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger TMASTER_OS_bi for TMASTER_OS');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_tmaster_os_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');
       Script.Execute;

     end;


   end;
//endif

// Atualiza procedure
with modulo_conexaodb do
     begin

       f := DataDirectory+'\atualizacao\sparetucest.sql';
       if fileexists(f) then
          begin
            Script.Script.Clear;
            Script.Terminator:='^';
            Script.Script.LoadFromFile(f);
            Script.Execute;
          end;
       //endi

       f := DataDirectory+'\atualizacao\spatualizacest.sql';
       if fileexists(f) then
          begin
            Script.Script.Clear;
            Script.Terminator:='^';
            Script.Script.LoadFromFile(f);
            Script.Execute;
          end;
       //endi

       f := DataDirectory+'\atualizacao\vendanfe.sql';
       if fileexists(f) then
          begin
            Script.Script.Clear;
            Script.Terminator:='^';
            Script.Script.LoadFromFile(f);
            Script.Execute;
          end;
       //endi

       f := DataDirectory+'\atualizacao\zerar_tabela_nivel4.sql';
       if fileexists(f) then
          begin
            Script.Script.Clear;
            Script.Terminator:=';';
            Script.Script.LoadFromFile(f);
            Script.Execute;

            deletefile(f);

          end;
       //endi

       f := DataDirectory+'\atualizacao\zerar_tabela_nivel3.sql';
       if fileexists(f) then
          begin
            Script.Script.Clear;
            Script.Terminator:=';';
            Script.Script.LoadFromFile(f);
            Script.Execute;

            deletefile(f);

          end;
       //endi


       f := DataDirectory+'\atualizacao\zerar_tabela_nivel2.sql';
       if fileexists(f) then
          begin
            Script.Script.Clear;
            Script.Terminator:=';';
            Script.Script.LoadFromFile(f);
            Script.Execute;

            deletefile(f);

          end;
       //endi



       f := DataDirectory+'\atualizacao\zerar_tabela_nivel1.sql';
       if fileexists(f) then
          begin
            Script.Script.Clear;
            Script.Terminator:=';';
            Script.Script.LoadFromFile(f);
            Script.Execute;

            deletefile(f);

          end;
       //endi

       qrconsulta_base.Close;
       qrconsulta_base.SQL.Clear;
       qrconsulta_base.SQL.Add('select atualizabase from tmaster_atu;');
       qrconsulta_base.Open;

       if not qrconsulta_base.Locate('atualizabase','sparetucest',[])then
          begin

            Script.Script.Clear;
            Script.Script.Add('/*Retorna dados*/');
            Script.Terminator:='^';
            Script.Script.Add('CREATE OR ALTER procedure sparetucest (ncm varchar(8)) returns (cest varchar(10)) ');
            Script.Script.Add(' as ');
            Script.Script.Add('begin');
            Script.Script.Add('  for');
            Script.Script.Add('    select tcest.ncm,  tcest.cest from tcest where tcest.ncm = :ncm into :ncm, :cest');
            Script.Script.Add('  do');
            Script.Script.Add('  begin');
            Script.Script.Add('     suspend;');
            Script.Script.Add('  end');
            Script.Script.Add('end^');
            Script.Script.Add('');
            Script.Script.Add('COMMIT^');
            Script.Execute;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''sparetucest'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif

       if not qrconsulta_base.Locate('atualizabase','sparetucest',[])then
          begin

            Script.Script.Clear;
            Script.Script.Add('/*Retorna dados*/');
            Script.Terminator:='^';
            Script.Script.Add('CREATE OR ALTER procedure sparetucest (ncm varchar(8)) returns (cest varchar(10)) ');
            Script.Script.Add(' as ');
            Script.Script.Add('begin');
            Script.Script.Add('  for');
            Script.Script.Add('    select tcest.ncm,  tcest.cest from tcest where tcest.ncm = :ncm into :ncm, :cest');
            Script.Script.Add('  do');
            Script.Script.Add('  begin');
            Script.Script.Add('     suspend;');
            Script.Script.Add('  end');
            Script.Script.Add('end^');
            Script.Script.Add('');
            Script.Script.Add('COMMIT^');
            Script.Execute;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''sparetucest'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif





       if not qrconsulta_base.Locate('atualizabase','spatualizacest',[])then
          begin


            Script.Script.Clear;
            Script.Terminator:='^';
            Script.Script.Add('/*Atualiza  dados*/');
            Script.Script.Add('CREATE OR ALTER procedure spatualizacest (');
            Script.Script.Add('    codnfe integer)');
            Script.Script.Add('as');
            Script.Script.Add('declare variable codproduto integer;');
            Script.Script.Add('declare variable cest varchar(10);');
            Script.Script.Add('declare variable controle integer;');
            Script.Script.Add('declare variable ncm varchar(8);');
            Script.Script.Add('declare variable codbarra varchar(60);');
            Script.Script.Add('declare variable codigo_barra varchar(60);');
            Script.Script.Add('begin');
            Script.Script.Add('  for');
            Script.Script.Add('    select titensvendanfe.controle, titensvendanfe.ncm, titensvendanfe.codproduto, titensvendanfe.codbarra  from titensvendanfe where titensvendanfe.codnfe = :codnfe  into :controle, :ncm, :codproduto, :codigo_barra');
            Script.Script.Add('  do');
            Script.Script.Add('  begin');
            Script.Script.Add('    if (:codigo_barra is null) then');
            Script.Script.Add('      begin');
            Script.Script.Add('        select testoque.codbarras from testoque where testoque.controle = :codproduto  into :codbarra;');
            Script.Script.Add('        update titensvendanfe set titensvendanfe.codbarra = :codbarra where  titensvendanfe.controle = :controle;');
            Script.Script.Add('      end');
            Script.Script.Add('    execute procedure sparetucest(:ncm) returning_values :cest;');
            Script.Script.Add('    update titensvendanfe set titensvendanfe.cest = :cest where  titensvendanfe.controle = :controle;');
            Script.Script.Add('  end');
            Script.Script.Add('  suspend;');
            Script.Script.Add('end^');
            Script.Script.Add('COMMIT^');
            Script.Execute;



            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''spatualizacest'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif



       if not qrconsulta_base.Locate('atualizabase','tvendanfe_au1',[])then
          begin


            Script.Script.Clear;
            Script.Terminator:='^';
            Script.Script.Add('/*Atualiza dados*/');
            Script.Script.Add('CREATE OR ALTER trigger tvendanfe_au1 for tvendanfe');
            Script.Script.Add('active after update position 1');
            Script.Script.Add('AS');
            Script.Script.Add('begin');
            Script.Script.Add('  execute procedure spatualizacest(old.controle);');
            Script.Script.Add('end^');
            Script.Script.Add('');
            Script.Script.Add('');
            Script.Script.Add('');
            Script.Script.Add('COMMIT^');
            Script.Execute;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''tvendanfe_au1'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif


       if not qrconsulta_base.Locate('atualizabase','spcaixatdinheiro',[])then
          begin


            Script.Script.Clear;
            Script.Script.Add('/*Caixa Dinheiro*/');
            Script.Terminator:='^';
            Script.Script.Add('create or alter procedure spcaixatdinheiro (');
            Script.Script.Add('   datainicio date,');
            Script.Script.Add('   datafinal date)');
            Script.Script.Add('returns (');
            Script.Script.Add('   tdinheiro decimal(15,2))');
            Script.Script.Add('as');
            Script.Script.Add('   declare variable vlrpagar decimal(15,2);');
            Script.Script.Add('   declare variable vlrrecebido decimal(15,2);');
            Script.Script.Add('   declare variable datafec date;');
            Script.Script.Add('   declare variable controle integer;');
            Script.Script.Add('   declare variable statuspedido varchar(10);');
            Script.Script.Add('begin');
            Script.Script.Add('   tdinheiro = 0;');
            Script.Script.Add('for select p.controle, m.datafec, coalesce(m.vlrrecebido,0), coalesce(m.vlrpagar,0), m.statuspedido from tpedidovenda p inner join tmaster_pedidovenda m on  p.controle = m.controle_tpedidovenda where (m.datafec >= :datainicio) and  (m.datafec <= :datafinal) and (m.statuspedido ='+quotedstr('F')+ ')   into :controle,  :datafec, :vlrrecebido, :vlrpagar, :statuspedido do');
            Script.Script.Add('   begin');
            Script.Script.Add('     if (vlrrecebido > vlrpagar) then');
            Script.Script.Add('     begin');
            Script.Script.Add('       tdinheiro = tdinheiro + vlrpagar;');
            Script.Script.Add('     end');
            Script.Script.Add('     else');
            Script.Script.Add('     begin');
            Script.Script.Add('       tdinheiro = tdinheiro + vlrrecebido;');
            Script.Script.Add('     end');
            Script.Script.Add('   end');
            Script.Script.Add('   suspend;');
            Script.Script.Add('end^');
            Script.Script.Add('COMMIT^');
            Script.Execute;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''spcaixatdinheiro'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif


       if not qrconsulta_base.Locate('atualizabase','TOTALPORESPECIE',[])then
          begin

            Script.Script.Clear;
            Script.Terminator:=';';
            Script.Script.Add('CREATE OR ALTER VIEW TOTALPORESPECIE(');
            Script.Script.Add('CONTROLE,');
            Script.Script.Add('ESPECIE, ');
            Script.Script.Add(' DATAFEC,');
            Script.Script.Add('STATUSPEDIDO,');
            Script.Script.Add('CODEPECIE,');
            Script.Script.Add('TOTALTIPOPGTO)');
            Script.Script.Add('AS');
            Script.Script.Add('select e.controle, e.especie, r.datafec,   p.statuspedido ,   r.codespecie, sum( r.valororiginal ) as totaltipopgto  from   tmaster_receber r  right join tespecie e on r.codespecie = e.controle left join tmaster_pedidovenda p on p.controle_tpedidovenda = r.codpedidovenda group by p.statuspedido, r.datafec, e.controle, r.codespecie, e.especie;');
            Script.Script.Add('/*Fim*/');
            Script.Execute;


            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''TOTALPORESPECIE'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif


       if not qrconsulta_base.Locate('atualizabase','spvlrtotalportipopagto',[])then
          begin


            Script.Script.Clear;
            Script.Script.Add('/*Valor total tipo pagto*/');
            Script.Terminator:='^';
            Script.Script.Add('create or alter procedure spvlrtotalportipopagto (');
            Script.Script.Add('   datainicio date,');
            Script.Script.Add('   datafinal date)');
            Script.Script.Add('returns (');
            Script.Script.Add('   tipopgto varchar(100),');
            Script.Script.Add('   vlrtotaltipopagto decimal(15,2))');
            Script.Script.Add('as');
            Script.Script.Add('   declare variable datahoracadastro timestamp;');
            Script.Script.Add('   declare variable controle integer;');
            Script.Script.Add('begin');
            Script.Script.Add('   suspend;');
            Script.Script.Add('end^');
            Script.Script.Add('COMMIT^');
            Script.Execute;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''spvlrtotalportipopagto'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif


       if not qrconsulta_base.Locate('atualizabase','spexcluirrec1',[])then
          begin

            Script.Script.Clear;
            Script.Script.Add('/*Excluir receber apos emitir nota fiscal*/');
            Script.Terminator:='^';
            Script.Script.Add('create or alter procedure spexcluirrec1 (');
            Script.Script.Add('    stpedvendanovo varchar(40),');
            Script.Script.Add('    cpedvenda integer,');
            Script.Script.Add('    stpedvendaantigo varchar(40))');
            Script.Script.Add('as');
            Script.Script.Add('  declare variable codigo integer;');
            Script.Script.Add('  declare variable controle_treceber integer;');
            Script.Script.Add('  declare variable codpedidovenda integer;');
            Script.Script.Add('begin');
            Script.Script.Add('  if ((stpedvendaantigo = ''IMPORTADO'')  and (stpedvendanovo = ''NF-E EMITIDA'')) then');
            Script.Script.Add('       begin');
            Script.Script.Add('          for select t.codigo, t.controle_treceber, t.codpedidovenda from tmaster_ext_receber t where t.codpedidovenda = :cpedvenda into :codigo, :controle_treceber, :codpedidovenda do ');
            Script.Script.Add('              begin');
            Script.Script.Add('                delete from treceber r where r.controle = :controle_treceber;');
            Script.Script.Add('              end');
            Script.Script.Add('          delete from tmaster_ext_receber r where r.codpedidovenda = :cpedvenda;');
            Script.Script.Add('       end');
            Script.Script.Add('end^');
            Script.Script.Add('COMMIT^');
            Script.Execute;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''spexcluirrec1'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif







       if not qrconsulta_base.Locate('atualizabase','TPEDIDOVENDA_BI1',[])then
          begin


            Script.Script.Clear;
            Script.Script.Add('/*Gatilho excluir receber apos emitir nota fiscal*/');
            Script.Terminator:='^';
            Script.Script.Add('CREATE OR ALTER TRIGGER TPEDIDOVENDA_BI1 FOR TPEDIDOVENDA');
            Script.Script.Add('  ACTIVE AFTER UPDATE POSITION 0');
            Script.Script.Add('  AS');
            Script.Script.Add('begin');
            Script.Script.Add('   execute procedure spexcluirrec1(new.status,new.controle,old.status);');
            Script.Script.Add('end^');
            Script.Script.Add('COMMIT^');
            Script.Execute;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tmaster_atu(atualizabase) values (''TPEDIDOVENDA_BI1'')');
            qrexec_base.ExecSQL;

            atualizabanco;
          end;
       //endif







       Script.Script.Clear;
       Script.Script.Add('/*     */');
       Script.Terminator:='^';
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('');
       Script.Script.Add('COMMIT^');
       //Script.Execute;

     end;
//endth


except

end;

end;



procedure arq_execscript;
var sarquivo:string;
begin


try

//compilação windows
sarquivo := DataDirectory+'\atualizacao\' + versao + '.sql';

if fileexists(sarquivo) then
   begin


     with modulo_conexaodb do
     begin
       Script.Script.LoadFromFile(sarquivo);
       Script.Execute;

     end;


   end;

except

end;

end;



function DataDirectory: string;
      begin
           Result := ExtractFilePath(ParamStr(0));
           Result := ExpandFileName(Result );
      end;


function existe_campo(tabela,campo:string):integer;
begin
  with modulo_conexaodb do
     begin
       qrconsulta_base.close;
       qrconsulta_base.SQL.Clear;
       qrconsulta_base.SQL.Add('SELECT'+
                                ' RDB$FIELD_NAME NOME_DO_CAMPO '+
                                'FROM '+
                                'RDB$RELATION_FIELDS '+
                                'WHERE '+
                                '(RDB$RELATION_NAME = :tabela ) and'+
                                '(RDB$FIELD_NAME = :campo)'+
                                'ORDER BY '+
                                'RDB$FIELD_POSITION');


       qrconsulta_base.ParamByName('tabela').AsString :=  uppercase(tabela);
       qrconsulta_base.ParamByName('campo').AsString :=  uppercase(campo);
       qrconsulta_base.Open;

       result := qrconsulta_base.RecordCount;
     end;


end;



function existe_tabela(nome:string):integer;
begin
with modulo_conexaodb do
  begin


    qrconsulta_base.Close;
    qrconsulta_base.SQL.Clear;
    qrconsulta_base.SQL.Add('SELECT'+
                               ' RDB$RELATION_NAME NOME_DA_TABELA'+
                            ' FROM '+
                               'RDB$RELATIONS'+
                            ' WHERE '+
                                '((RDB$SYSTEM_FLAG IS NULL)OR'+
                                ' (RDB$SYSTEM_FLAG <> 1))AND'+
                                ' (RDB$VIEW_BLR IS NULL) AND'+
                                ' (RDB$RELATION_NAME = :tabela)'+
                                'ORDER BY  RDB$RELATION_NAME');

    qrconsulta_base.ParamByName('tabela').AsString :=  uppercase(nome);
    qrconsulta_base.Open;

  result := qrconsulta_base.RecordCount;

  end;




end;


function mostrar_inf_campo(tabela,campo:string):integer;
begin

    with modulo_conexaodb do
      begin
         qrconsulta_base.Close;
         qrconsulta_base.SQL.Clear;

          qrconsulta_base.SQL.Add('SELECT '+
                                      'A.RDB$FIELD_NAME NOME_DO_CAMPO,'+
                                      'C.RDB$TYPE_NAME TIPO,'+
                                      'B.RDB$FIELD_SUB_TYPE SUBTIPO,'+
                                      'B.RDB$FIELD_LENGTH TAMANHO,'+
                                      'B.RDB$SEGMENT_LENGTH SEGMENTO,'+
                                      'B.RDB$FIELD_PRECISION PRECISAO,'+
                                      'B.RDB$FIELD_SCALE CASAS_DECIMAIS,'+
                                      'A.RDB$DEFAULT_SOURCE VALOR_PADRAO,'+
                                      'A.RDB$NULL_FLAG OBRIGATORIO'+
                                  ' FROM  '+
                                      'RDB$RELATION_FIELDS A, '+
                                      'RDB$FIELDS B, '+
                                      'RDB$TYPES C'+
                                   ' WHERE '+

                                       '(A.RDB$FIELD_NAME = :campo) AND '+
                                       '(A.RDB$RELATION_NAME = :tabela) AND '+
                                       '(B.RDB$FIELD_NAME = A.RDB$FIELD_SOURCE) AND '+
                                       '(C.RDB$TYPE = B.RDB$FIELD_TYPE) AND '+
                                       '(C.RDB$FIELD_NAME = ''RDB$FIELD_TYPE'')');



         qrconsulta_base.ParamByName('tabela').AsString :=  uppercase(tabela);
         qrconsulta_base.ParamByName('campo').AsString :=  uppercase(campo);
         qrconsulta_base.Open;


         result := qrconsulta_base.RecordCount;
      end;


end;

//------------------------------------------------------------------------------
function tira(pValor:string; retira:pchar):string;
var pPosI:integer;
var pPosF:integer;
var pNovoValor:string;
begin
   result := '';
   pNovoValor:='';
   pPosI:=1;
   while true do
     begin
       pPosF := pos(retira,pValor);
       if pPosF > 0 then
          begin
            pNovoValor:=pNovoValor+copy(pValor,pPosI,pPosF - 1);
            pValor:=copy(pValor,pPosF+1,length(pValor));
          end
       else
          begin
            result:=pNovoValor+pValor;
            exit;
          end;
     end;
 //endw
end;

//------------------------------------------------------------------------------
function tirapontos(pValor:string):string;
var pPosI:integer;
var pPosF:integer;
var pNovoValor:string;
begin
   result := '';
   pNovoValor:='';
   pPosI:=1;
   while true do
     begin
       pPosF := pos('.',pValor);
       if pPosF > 0 then
          begin
            pNovoValor:=pNovoValor+copy(pValor,pPosI,pPosF - 1);
            pValor:=copy(pValor,pPosF+1,length(pValor));
          end
       else
          begin
            result:=pNovoValor+pValor;
            exit;
          end;
     end;
 //endw
end;

//------------------------------------------------------------------------------
function tiratracos(pValor:string):string;
var pPosI:integer;
var pPosF:integer;
var pNovoValor:string;
begin
   result := '';
   pNovoValor:='';
   pPosI:=1;
   while true do
     begin
       pPosF := pos('-',pValor);
       if pPosF > 0 then
          begin
            pNovoValor:=pNovoValor+copy(pValor,pPosI,pPosF - 1);
            pValor:=copy(pValor,pPosF+1,length(pValor));
          end
       else
          begin
            result:=pNovoValor+pValor;
            exit;
          end;
     end;
 //endw
end;

//------------------------------------------------------------------------------
function tirabarras(pValor:string):string;
var pPosI:integer;
var pPosF:integer;
var pNovoValor:string;
begin
   result := '';
   pNovoValor:='';
   pPosI:=1;
   while true do
     begin
       pPosF := pos('/',pValor);
       if pPosF > 0 then
          begin
            pNovoValor:=pNovoValor+copy(pValor,pPosI,pPosF - 1);
            pValor:=copy(pValor,pPosF+1,length(pValor));
          end
       else
          begin
            result:=pNovoValor+pValor;
            exit;
          end;
     end;
 //endw
end;


//------------------------------------------------------------------------------
function tirafimarq(pValor:string):string;
var pPosI:integer;
var pPosF:integer;
var pNovoValor:string;
begin
   result := '';
   pNovoValor:='';
   pPosI:=1;
   while true do
     begin
       pPosF := pos(#3,pValor);
       if pPosF > 0 then
          begin
            pNovoValor:=pNovoValor+copy(pValor,pPosI,pPosF - 1);
            pValor:=copy(pValor,pPosF+1,length(pValor));
          end
       else
          begin
            result:=pNovoValor+pValor;
            exit;
          end;
     end;
 //endw
end;

//------------------------------------------------------------------------------
function Cript(senha,chave,operacao: string) : string;
var
   i, tamanhostring, pos, posletra, tamanhochave : integer;
begin
   result := '';
   result := senha;
   tamanhostring := length(senha);
   tamanhochave  := length(chave);
   for i := 1 to tamanhostring do
      begin
         pos := (i mod tamanhochave);
         if pos = 0 then pos := tamanhochave;
         pos := pos + 7;
         if operacao = 'descript' then
            begin
               posLetra := ord(result[i]) + pos;
            end
         else
            begin
               posLetra := ord(result[i]) - pos;
            end;
         //endif
         result[i] := chr(posletra);
      end;
   //endfor
end;

//------------------------------------------------------------------------------
Function Extenso(mNum:Currency):String;

  Function NrBaixos(mNumB:Integer):String;
    Const mStrNumB : Array[0..18] of pChar = ('um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete',
          'oito', 'nove', 'dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito',
          'dezenove');
    begin
      result := '';
      result := mStrNumb[mNumb -1]+' ';
    end;
  //endfunction

  Function NrMedios(mNumM:Integer):String;
    Var
      mStrNumM,
      mStrDig : String;
    begin
      mStrNumM := '';
      mStrDig := '';
      result := '';

      if mNumM < 20 then
         Result := NrBaixos(mNumM)
      else
         begin
           Result := '';
           mStrDig := '00'+IntToStr(mNumM);
           mStrDig := Copy (mStrDig,length(mStrDig)-1,2);
           mStrNumM := 'vinte    trinta   quarenta '+'cinquenta sessenta setenta  '+'oitenta  noventa  ';
           Result := TrimRight( Copy( mStrNumM,((StrToInt(mStrDig[1])-2)*9)+1,9))+' ';
           if StrtoInt(mStrDig[2]) > 0 then
              Result := Result + 'e '+NrBaixos(StrtoInt(mStrDig[2]));
           //endi
         end;
      //endi
    end;
  //endfunction

  Function NrAltos(mNumA:Integer):String;
    Var
      mStrNumA,
      mStrDig:String;
    begin

      mStrNumA := '';
      mStrDig := '';
      result := '';

      if mNumA = 100 then
         Result := 'Cem '
      else
         begin
           Result := '';
           mStrDig := '00'+IntToStr(mNumA);
           mStrDig := Copy(mStrDig,length(mStrDig)-2,3);
           mStrNumA := 'cento        duzentos   '+'trezentos   quatrocentos '+'quinhetos  seiscentos  setecentos  '+'oitocentos  novecentos  ';
           if StrtoInt(mStrDig[1]) > 0 then
              Result := TrimRight(Copy(mStrNumA,((StrToInt(mStrDig[1])-1)*12)+1,12))+' ';
           //endi
           if StrToInt(Copy(mStrDig,2,2)) > 0 then
              begin
                if Length(Result) > 0 then
                   Result := Result + 'e ';
                //endi
                Result := Result + NrMedios(StrToInt(Copy(mStrDig,2,2)));
              end;
           //endi
         end;
      //endi
    end;
  //endfunction

  var
    mStrNomes, StrPart, mNumString : String;
    i, numpart, mPos: Integer; partDec:Real;
  begin
    mStrNomes := '';
    StrPart := '';
    mNumString := '';
    result := '';
    i := 0;
    numpart := 0;
    mPos := 0;
    partDec := 0;

    mNumString := FormatFloat('00000000000000',mNum*100);
    mStrNomes := 'bilhão  bilhões milhão  milhões '+'mil     mil     ';
    for i := 1 to 4 do
       begin
         strPart := Copy(mNumString,((i-1)*3)+1,3);
         numPart := StrToInt(StrPart);
         if NumPart = 1 then
            mPos := 1
         else
            mPos := 8;
         //endi
         if NumPart > 0 then
            begin
              if length(Result) > 0 then
                 Result := Result + ', ';
              //endi
              Result := Result + NrAltos(NumPart);
              Result := Result + TrimRight( Copy ( mStrNomes,( (i - 1) * 16) + mPos,8) );
              if not i = 4 then
                 Result := Result + ' ';
              //endi
            end;
         //endi
       end;
    //endf
    if length(Result) > 0 then
       begin
         if int(mNum) = 1 then
            Result := Result + ' real'
         else
            Result := Result + ' reais ';
         //endi
       end;
    //endi
    if frac(mNum) > 0 then
      begin
        if Length(Result) > 0 then
           Result := Result + 'e ';
        //endi
        PartDec := (mNum - int(mNum))*100;
        NumPart := trunc(PartDec);
        if PartDec = 1 then
           Result := Result + 'um centavo'
        else
           Result := Result + NrMedios(NumPart)+'centavos';
        //endi
      end;
    //endi
  end;



//------------------------------------------------------------------------------
Function MesExtenso(mDt:tDateTime):String;
var ano, mes, dia :word;
const meses : array [0..11] of pchar = ('Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');
begin
  DecodeDate(mDt,ano,mes,dia);
  result := meses[mes-1];
end;

//------------------------------------------------------------------------------
Function DataPorExtenso(mDt:tDateTime):String;
var ano, mes, dia :word;
begin
  DecodeDate(mDt,ano,mes,dia);
  result := Inttostr(dia)+' de '+MesExtenso(mDt)+' de '+InttoStr(ano);
end;

//------------------------------------------------------------------------------
Function Arred0dec(pValor:real):real;
var pMult:real;
begin
  pMult := Round(pValor*100);
  result := Round(pMult/100);
end;

//------------------------------------------------------------------------------
Function Arre1Dec(pValor:real):real;
begin
  Result := strtofloat(formatfloat('0.0',pValor));
end;



function FormataCNPJ(CNPJ: string): string;
 var
   scnpj:string;
begin

  scnpj:=cnpj;

  scnpj := tirapontos(Tiratracos(tirabarras(scnpj)));

  //scnpj  :=  formatfloat('00000000000000',strtointdef(scnpj,0));

  Result :=Copy(scnpj,1,2)+'.'+Copy(scnpj,3,3)+'.'+Copy(scnpj,6,3)+'/'+

           Copy(scnpj,9,4)+'-'+Copy(scnpj,13,2);

end;




function FormataCPF(CPF: string): string;
 var
   sCPF:string;
begin

  sCPF:= CPF;

  sCPF := tirapontos(Tiratracos(sCPF));

  //sCPF  :=  formatfloat('00000000000',strtointdef(sCPF,0));

  Result :=Copy(sCPF,1,3)+'.'+Copy(sCPF,4,3)+'.'+Copy(sCPF,7,3)+'-'+

           Copy(sCPF,10,2);

end;


function proc_cest(ncm:string):string;
begin

  modulo_produto.qrcest.Close;
  modulo_produto.qrcest.SQL.Clear;
  modulo_produto.qrcest.SQL.Add('select cest, ncm from tcesttemp where ncm = :ncm');
  modulo_produto.qrcest.ParamByName('ncm').AsString:=ncm;
  modulo_produto.qrcest.Open;

  if modulo_produto.qrcest.RecordCount > 0 then
     begin

       result := modulo_produto.qrcest.FieldByName('cest').AsString;

     end
  else
     begin

        modulo_produto.qrcest.Close;
        modulo_produto.qrcest.SQL.Clear;
        modulo_produto.qrcest.SQL.Add('select cest, ncm from tcesttemp where ncm = :ncm');
        modulo_produto.qrcest.ParamByName('ncm').AsString:=copy(ncm,1,6);
        modulo_produto.qrcest.Open;
        if modulo_produto.qrcest.RecordCount > 0 then
           begin

              result := modulo_produto.qrcest.FieldByName('cest').AsString;

           end
        else
           begin
              modulo_produto.qrcest.Close;
              modulo_produto.qrcest.SQL.Clear;
              modulo_produto.qrcest.SQL.Add('select cest, ncm from tcesttemp where ncm = :ncm');
              modulo_produto.qrcest.ParamByName('ncm').AsString:=copy(ncm,1,4);
              modulo_produto.qrcest.Open;
              if modulo_produto.qrcest.RecordCount > 0 then
                 begin
                   result := modulo_produto.qrcest.FieldByName('cest').AsString;
                 end
              else
                 begin
                   result := '';
                 end;
              //endi
           end;
        //endi
     end;
  //endi





end;





function proc_cestDescricao(ncm:string):string;
begin

  modulo_produto.qrcest.Close;
  modulo_produto.qrcest.SQL.Clear;
  modulo_produto.qrcest.SQL.Add('select cest, ncm, descricao from tcesttemp where ncm = :ncm');
  modulo_produto.qrcest.ParamByName('ncm').AsString:=ncm;
  modulo_produto.qrcest.Open;

  if modulo_produto.qrcest.RecordCount > 0 then
     begin

       result := modulo_produto.qrcest.FieldByName('descricao').AsString;

     end
  else
     begin

        modulo_produto.qrcest.Close;
        modulo_produto.qrcest.SQL.Clear;
        modulo_produto.qrcest.SQL.Add('select cest, ncm, descricao from tcesttemp where ncm = :ncm');
        modulo_produto.qrcest.ParamByName('ncm').AsString:=copy(ncm,1,6);
        modulo_produto.qrcest.Open;
        if modulo_produto.qrcest.RecordCount > 0 then
           begin

              result := modulo_produto.qrcest.FieldByName('descricao').AsString;

           end
        else
           begin
              modulo_produto.qrcest.Close;
              modulo_produto.qrcest.SQL.Clear;
              modulo_produto.qrcest.SQL.Add('select cest, ncm, descricao from tcesttemp where ncm = :ncm');
              modulo_produto.qrcest.ParamByName('ncm').AsString:=copy(ncm,1,4);
              modulo_produto.qrcest.Open;
              if modulo_produto.qrcest.RecordCount > 0 then
                 begin
                   result := modulo_produto.qrcest.FieldByName('descricao').AsString;
                 end
              else
                 begin
                   result := '';
                 end;
              //endi
           end;
        //endi
     end;
  //endi
end;

 function RemoveAcentoTexto(aText : string) : string;
const
  ComAcento = 'àâêôûãõáéíóúçüñýÀÂÊÔÛÃÕÁÉÍÓÚÇÜÑÝ';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
begin;
  for x := 1 to Length(aText) do
  try
    if (Pos(aText[x], ComAcento) <> 0) then
      aText[x] := SemAcento[ Pos(aText[x], ComAcento) ];
  except on E: Exception do
    raise Exception.Create('Erro no processo.');
  end;

  Result := aText;
end;





function RemoveAcento(const pText: string): string;
type
  USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
end;


end.

