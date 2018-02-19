unit ufuncao_cria_ini;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

procedure GravarINIBD(Ip, CaminhoDB, Porta, Pass, Userx,
  Protoc: String);

function DataDirectory: string;

implementation


function DataDirectory: string;
begin
  Result := ExtractFilePath(ParamStr(0));
  Result := ExpandFileName(Result );
end;


//funcoes INI
//Primeiro verifica se tem o arquivo ini de conexão com o banco
//se não tiver precisa perguntar se vai ser local o remoto
procedure GravarINIBD(Ip, CaminhoDB, Porta, Pass, Userx,
  Protoc: String);
var
  Arq: TIniFile;
  NovoNome: string;
begin
  (* Cria arquivo ini *)
  NovoNome := DataDirectory + 'ConexaoBanco.ini';
  if not FileExists(NovoNome) then
  begin
    Arq := TIniFile.Create(NovoNome);
    try
      Arq.WriteString('ConexaoBanco', 'HostName', IP);
      Arq.WriteString('ConexaoBanco', 'Database', CaminhoDB);
      Arq.WriteString('ConexaoBanco', 'Port', Porta);
      Arq.WriteString('ConexaoBanco', 'Password', Pass);
      Arq.WriteString('ConexaoBanco', 'User', Userx);
      Arq.WriteString('ConexaoBanco', 'Protocol', Protoc);
      //Autor: Adriano
      //Data: 22/04/2011
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
end;


end.

