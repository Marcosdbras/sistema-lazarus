unit ufuncao_geral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


const versao:string =  'v.0.0.0';

var
         //Variável global de conexão ao banco
         sHostName, sPort, sProtocol, sLibraryLocation, sUser,   sPassword,
         sDatabase,   sClientCodepage: string;

         //Variáveil global
         icontrole: integer;

         //Variável global
         susuario, ssenha:string;



procedure arq_execscript;
procedure atualiza_base;
function DataDirectory: string;
function existe_tabela(nome:string):integer;
function existe_campo(tabela,campo:string):integer;
function mostrar_inf_campo(tabela,campo:string):integer;

implementation
        uses umodulo_conexaodb;


procedure atualiza_base;

begin


try

//Tabela MASTER_UNIDADE existe?
if existe_tabela('MASTER_UNIDADE') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE MASTER_UNIDADE (CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_MASTER_UNIDADE_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE MASTER_UNIDADE ADD CONSTRAINT PK_MASTER_UNIDADE  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger master_unidade_bi for master_unidade');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_master_unidade_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif


//Campo DESCRICAO existe?
if existe_campo('MASTER_UNIDADE','DESCRICAO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE MASTER_UNIDADE  ADD DESCRICAO VARCHAR(40);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi


//Campo SIGLA existe?
if existe_campo('MASTER_UNIDADE','SIGLA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE MASTER_UNIDADE  ADD SIGLA VARCHAR(6);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi






//Tabela MASTER_USUARIO existe?
if existe_tabela('MASTER_USUARIO') = 0 then
   begin

     with modulo_conexaodb do
     begin

       Script.Terminator:=';';

       Script.Script.Clear;
       Script.Script.Add('CREATE TABLE MASTER_USUARIO (CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_MASTER_USUARIO_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE MASTER_USUARIO ADD CONSTRAINT PK_MASTER_USUARIO  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger master_usuario_bi for master_usuario');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_master_usuario_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');

       Script.Execute;


     end;

   end;
//endif

//Campo SENHA existe?
if existe_campo('MASTER_USUARIO','SENHA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE MASTER_USUARIO  ADD SENHA VARCHAR(20);   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi

//Campo CONTROLE_TUSUARIO existe?
if existe_campo('MASTER_USUARIO','CONTROLE_TUSUARIO') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE MASTER_USUARIO  ADD CONTROLE_TUSUARIO INTEGER;   ');
              Script.Script.Add('COMMIT;');
              Script.Execute;

           end;
         //endth
  end;
//endi



//Tabela MASTER_OS existe?
if existe_tabela('MASTER_OS') = 0 then
   begin



     with modulo_conexaodb do
     begin


       Script.Script.Clear;
       Script.Terminator:=';';
       Script.Script.Add('CREATE TABLE MASTER_OS (CODIGO INTEGER NOT NULL);');
       Script.Script.Add('CREATE SEQUENCE GEN_MASTER_OS_ID;');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Script.Add('ALTER TABLE MASTER_OS ADD CONSTRAINT PK_MASTER_OS  PRIMARY KEY (CODIGO);');
       Script.Script.Add('COMMIT;');
       Script.Execute;

       Script.Script.Clear;
       Script.Terminator:='^';
       Script.Script.Add('create trigger MASTER_OS_bi for MASTER_OS');
       Script.Script.Add('active before insert position 0');
       Script.Script.Add('as');
       Script.Script.Add('begin');
       Script.Script.Add('if (new.codigo is null) then');
       Script.Script.Add('    new.codigo = gen_id(gen_MASTER_OS_id,1);');
       Script.Script.Add('end^');
       Script.Script.Add('COMMIT^');
       Script.Execute;

     end;


   end;
//endif










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

end.

