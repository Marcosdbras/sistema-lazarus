unit ufuncao_cria_ini;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

function GravarINIBD(Ip, CaminhoDB, Porta, Pass, Userx,
  Protoc: String):boolean;



implementation
       uses ufuncao_conexaodb;



//funcoes INI
//Primeiro verifica se tem o arquivo ini de conexão com o banco
//se não tiver precisa perguntar se vai ser local o remoto
function GravarINIBD(Ip, CaminhoDB, Porta, Pass, Userx,
  Protoc: String):boolean;
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
        Arq.WriteString('ConexaoBanco', 'Port', Porta);
        Arq.WriteString('ConexaoBanco', 'Password', Pass);
        Arq.WriteString('ConexaoBanco', 'User', Userx);
        Arq.WriteString('ConexaoBanco', 'Protocol', Protoc);
        Arq.ReadString('ConexaoBanco', 'LibraryLocation', 'fbclient.dll');



        //Autor: Adriano
        //Data: 22/04/2011
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


end.

