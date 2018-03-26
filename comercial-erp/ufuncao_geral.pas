unit ufuncao_geral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

var
         //Variável global de conexão ao banco
         sHostName, sPort, sProtocol, sLibraryLocation, sUser,   sPassword,
         sDatabase,   sClientCodepage: string;


function DataDirectory: string;

implementation

function DataDirectory: string;
      begin
           Result := ExtractFilePath(ParamStr(0));
           Result := ExpandFileName(Result );
      end;

end.

