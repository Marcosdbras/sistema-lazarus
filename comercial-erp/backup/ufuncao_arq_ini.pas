unit ufuncao_arq_ini;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

function GravarINIBD(Ip, CaminhoDB, Porta, Pass, Userx,
  Protoc, charset, CaminhoDB2, Ipremoto, CaminhoDBremoto: String):boolean;

procedure GravarLog(mensagemlog: String);
procedure LerINIBD;



implementation
       uses ufuncao_geral, ufuncao_conexaodb;

procedure LerINIBD;
var
  Ini: TIniFile;
  NovoNome:String;

begin

  NovoNome := DataDirectory + 'ConexaoBanco.ini';

  Ini := TIniFile.Create(NovoNome);


  sHostName        := Ini.ReadString('ConexaoBanco', 'Hostname', '');
  sPort            := Ini.ReadString('ConexaoBanco', 'Port', '0');
  sProtocol        := Ini.ReadString('ConexaoBanco', 'Protocol', '');
  sLibraryLocation := Ini.ReadString('ConexaoBanco', 'LibraryLocation', '');
  sUser            := Ini.ReadString('ConexaoBanco', 'User', '');
  sPassword        := Ini.ReadString('ConexaoBanco', 'Password', '');
  sDatabase        := Ini.ReadString('ConexaoBanco', 'Database', '');
  sClientCodepage  := Ini.ReadString('ConexaoBanco', 'Charset', '');
  sCaminhoDB2      := Ini.ReadString('ConexaoBanco', 'Database_2', '');

  sHostNameRemoto        := Ini.ReadString('ConexaoBanco', 'HostnameRemoto', '');
  sDatabaseRemoto        := Ini.ReadString('ConexaoBanco', 'DatabaseRemoto', '');
end;

//funcoes INI
//Primeiro verifica se tem o arquivo ini de conexão com o banco
//se não tiver precisa perguntar se vai ser local o remoto
function GravarINIBD(Ip, CaminhoDB, Porta, Pass, Userx,
  Protoc, charset, CaminhoDB2, Ipremoto, CaminhoDBremoto: String):boolean;
var
  Arq: TIniFile;
  NovoNome: string;
begin
  (* Cria arquivo ini *)
  NovoNome := DataDirectory + 'ConexaoBanco.ini';
  //if not FileExists(NovoNome) then
  //begin

    try

      Arq := TIniFile.Create(NovoNome);

      try
        Arq.WriteString('ConexaoBanco', 'HostName', IP);
        Arq.WriteString('ConexaoBanco', 'Database', CaminhoDB);
        Arq.WriteString('ConexaoBanco', 'Database_2', CaminhoDB2);
        Arq.WriteString('ConexaoBanco', 'Port', Porta);
        Arq.WriteString('ConexaoBanco', 'Password', Pass);
        Arq.WriteString('ConexaoBanco', 'User', Userx);
        Arq.WriteString('ConexaoBanco', 'Charset', charset); //ISO8859_1
        Arq.WriteString('ConexaoBanco', 'Protocol', Protoc);
        //Arq.WriteString('ConexaoBanco', 'LibraryLocation', 'fbclient.dll');

        Arq.WriteString('ConexaoBanco', 'HostNameRemoto', IPremoto);
        Arq.WriteString('ConexaoBanco', 'DatabaseRemoto', CaminhoDBremoto);

        //Não ha mais necessidade da linha abaixo.
        {
        if frmParametrizarBanco.bTipoConnection = True then
           Arq.WriteString('ConexaoBanco', 'Tipo Conexão', RetornaVersaoFirebird)
         else
           Arq.WriteString('ConexaoBanco', 'Tipo Conexão', RetornaVersaoFirebird);
         }

         result := true;
       finally
         FreeAndNil(Arq);

       end;



    except

        result := false;

    end;
  //end;
end;



procedure GravarLog(mensagemlog: String);
var
  Arq: TIniFile;
  NovoNome: string;
begin
  (* Cria arquivo ini *)
  NovoNome := DataDirectory + 'mensagem.log';
  //if not FileExists(NovoNome) then
  //begin


      Arq := TIniFile.Create(NovoNome);

      try
        Arq.WriteString('DadosLog', 'DataHoraLog', datetimetostr( now() ) );
        Arq.WriteString('DadosLog', 'Mensagem', mensagemlog);

        //Não ha mais necessidade da linha abaixo.
        {
        if frmParametrizarBanco.bTipoConnection = True then
           Arq.WriteString('ConexaoBanco', 'Tipo Conexão', RetornaVersaoFirebird)
         else
           Arq.WriteString('ConexaoBanco', 'Tipo Conexão', RetornaVersaoFirebird);
         }


       finally
         FreeAndNil(Arq);

       end;




end;




end.

