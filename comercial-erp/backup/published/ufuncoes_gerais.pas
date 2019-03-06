unit ufuncoes_gerais;

{$mode objfpc}{$H+}

interface

 uses
      Classes, SysUtils, IniFiles, Dialogs, StdCtrls, LCLType;

 function conectarBanco:boolean;
 function DataDirectory: string;


implementation
    uses uprincipal_conexao;

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
       NovoNome := DataDirectory + 'ConexaoBanco.ini';

       Ini := TIniFile.Create(NovoNome);
       try

           with frmprincipal_conexao do
           begin

             Conexaodb.Connected       := False;
             Conexaodb.HostName        := Ini.ReadString('Conexao_ZEOS', 'Hostname', '');
             Conexaodb.Port            := Ini.ReadInteger('Conexao_ZEOS', 'Port', 0);
             Conexaodb.Protocol        := Ini.ReadString('Conexao_ZEOS', 'Protocol', '');
             Conexaodb.LibraryLocation := Ini.ReadString('Conexao_ZEOS', 'LibraryLocation', '');
             Conexaodb.User            := Ini.ReadString('Conexao_ZEOS', 'User', '');
             Conexaodb.Password        := Ini.ReadString('Conexao_ZEOS', 'Password', '');
             Conexaodb.Database        := Ini.ReadString('Conexao_ZEOS', 'Database', '');
             Conexaodb.ClientCodepage  := Ini.ReadString('Conexao_ZEOS', 'Charset', '');





           end;


       except
           on E:Exception do
           MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);
       end;



       result := true;
     end;
end.

