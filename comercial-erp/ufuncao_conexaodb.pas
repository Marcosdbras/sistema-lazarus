unit ufuncao_conexaodb;

{$mode objfpc}{$H+}

interface

 uses
      Classes, SysUtils, IniFiles, Dialogs, StdCtrls, LCLType;

 function conectarBanco:boolean;



implementation
    uses    ufuncao_geral, umodulo_conexaodb;


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
             //Conexaodb.Port            := Ini.ReadInteger('ConexaoBanco', 'Port', 0);
             //Conexaodb.Protocol        := Ini.ReadString('ConexaoBanco', 'Protocol', '');
             //Conexaodb.LibraryLocation := Ini.ReadString('ConexaoBanco', 'LibraryLocation', '');
             Conexaodb.UserName            := Ini.ReadString('ConexaoBanco', 'User', '');
             Conexaodb.Password        := Ini.ReadString('ConexaoBanco', 'Password', '');
             Conexaodb.DatabaseName        := Ini.ReadString('ConexaoBanco', 'Database', '');
             Conexaodb.CharSet  := Ini.ReadString('ConexaoBanco', 'Charset', '');
             Conexaodb.Connected       := True;

             result := true;



           end;


       except
           on E:Exception do
           MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);

       end;




     end;
end.

