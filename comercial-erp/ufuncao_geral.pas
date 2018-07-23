unit ufuncao_geral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


const versao:string =  'v.0.0.0';

var
         //Variável global de conexão ao banco
         sHostName, sPort, sProtocol, sLibraryLocation, sUser,   sPassword,
         sDatabase,   sClientCodepage, sCaminhoDB2: string;

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





implementation
        uses umodulo_conexaodb, umodulo_produto;


procedure atualiza_base;

begin



try

//Tabela MASTER_UNIDADE existe?
if existe_tabela('MASTER_UNIDADE') = 0 then
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


//Campo DESCRICAOCOMPLETA existe?
if existe_campo('MASTER_UNIDADE','DESCRICAOCOMPLETA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE MASTER_UNIDADE  ADD DESCRICAOCOMPLETA VARCHAR(120);   ');
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



//Campo CONTROLE_TUNIDADEMEDIDA existe?
if existe_campo('MASTER_UNIDADE','CONTROLE_TUNIDADEMEDIDA') = 0 then
   begin

         with modulo_conexaodb do
           begin

              Script.Script.Clear;
              Script.Terminator:=';';
              Script.Script.Add('ALTER TABLE MASTER_UNIDADE  ADD CONTROLE_TUNIDADEMEDIDA integer;   ');
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

end.

