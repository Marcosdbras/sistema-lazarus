unit ufuncao_conexaodb;

{$mode objfpc}{$H+}

interface

 uses
      Classes, SysUtils, IniFiles, Dialogs, StdCtrls, LCLType;

 function conectarBanco:boolean;
 function DataDirectory: string;


implementation
    uses umodulo_conexaodb;

    function DataDirectory: string;
      begin
           Result := ExtractFilePath(ParamStr(0));
           Result := ExpandFileName(Result );
      end;




    function conectarBanco:boolean;
     var
       Ini: TIniFile;
       NovoNome: string;
     begin

       result := false;

       NovoNome := DataDirectory + 'ConexaoBanco.ini';

       Ini := TIniFile.Create(NovoNome);
       try



           with modulo_conexaodb do
           begin

             Conexaodb.Connected       := False;
             Conexaodb.HostName        := Ini.ReadString('ConexaoBanco', 'Hostname', '');
             Conexaodb.Port            := Ini.ReadInteger('ConexaoBanco', 'Port', 0);
             Conexaodb.Protocol        := Ini.ReadString('ConexaoBanco', 'Protocol', '');
             Conexaodb.LibraryLocation := Ini.ReadString('ConexaoBanco', 'LibraryLocation', '');
             Conexaodb.User            := Ini.ReadString('ConexaoBanco', 'User', '');
             Conexaodb.Password        := Ini.ReadString('ConexaoBanco', 'Password', '');
             Conexaodb.Database        := Ini.ReadString('ConexaoBanco', 'Database', '');
             Conexaodb.ClientCodepage  := Ini.ReadString('ConexaoBanco', 'Charset', '');

             result := true;



           end;


       except
           on E:Exception do
           MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);

       end;




     end;
end.

