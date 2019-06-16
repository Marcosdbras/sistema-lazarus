unit ufuncao_conexaodb;

{$mode objfpc}{$H+}

interface

 uses
      Classes, SysUtils, IniFiles, Dialogs, StdCtrls, LCLType;

 function conectarBanco:boolean;
 function conectarBanco_aux:boolean;
 function conectarBanco_remoto:boolean;

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
             Conexaodb.CharSet  := Ini.ReadString('ConexaoBanco', 'Charset', 'UTF8');
             Conexaodb.Connected       := True;

             result := true;



           end;


       except
           on E:Exception do
           MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);

       end;




     end;



    function conectarBanco_aux:boolean;
         var
           Ini: TIniFile;
           NovoNome, error: string;
         begin

           result := false;

           NovoNome := DataDirectory + 'ConexaoBanco.ini';

           Ini := TIniFile.Create(NovoNome);
           try



               with modulo_conexaodb do
               begin

                 Conexaodb_aux.Connected       := False;
                 Conexaodb_aux.HostName        := Ini.ReadString('ConexaoBanco', 'Hostname', '');

                 Conexaodb_aux.UserName            := Ini.ReadString('ConexaoBanco', 'User', '');
                 Conexaodb_aux.Password        := Ini.ReadString('ConexaoBanco', 'Password', '');
                 Conexaodb_aux.DatabaseName        := Ini.ReadString('ConexaoBanco', 'Database_2', '');
                 //Conexaodb_aux.CharSet  := 'WIN1252';

                 Conexaodb_aux.CharSet  := Ini.ReadString('ConexaoBanco', 'Charset', 'UTF8');
                 //Conexaodb_aux.Port            := Ini.ReadInteger('ConexaoBanco', 'Port', 0);
                 //Conexaodb_aux.Protocol        := Ini.ReadString('ConexaoBanco', 'Protocol', '');
                 //Conexaodb_aux.LibraryLocation := Ini.ReadString('ConexaoBanco', 'LibraryLocation', '');

                 Conexaodb_aux.Connected       := True;

                 result := true;



               end;


           except
               on E:Exception do
               error := 'Erro ao conectar!'#13'Erro: ';

           end;




         end;




    function conectarBanco_remoto:boolean;
             var
               Ini: TIniFile;
               NovoNome, error: string;
             begin

               result := false;

               NovoNome := DataDirectory + 'ConexaoBanco.ini';

               Ini := TIniFile.Create(NovoNome);
               try



                   with modulo_conexaodb do
                   begin

                     Conexaodb_remoto.Connected       := False;
                     Conexaodb_remoto.HostName        := Ini.ReadString('ConexaoBanco', 'HostNameRemoto', '');

                     Conexaodb_remoto.UserName            := Ini.ReadString('ConexaoBanco', 'User', '');
                     Conexaodb_remoto.Password        := Ini.ReadString('ConexaoBanco', 'Password', '');
                     Conexaodb_remoto.DatabaseName        := Ini.ReadString('ConexaoBanco', 'DatabaseRemoto', '');
                     //Conexaodb_remoto.CharSet  := 'WIN1252';

                     Conexaodb_remoto.CharSet  := Ini.ReadString('ConexaoBanco', 'Charset', 'UTF8');
                     //Conexaodb_remoto.Port            := Ini.ReadInteger('ConexaoBanco', 'Port', 0);
                     //Conexaodb_remoto.Protocol        := Ini.ReadString('ConexaoBanco', 'Protocol', '');
                     //Conexaodb_remoto.LibraryLocation := Ini.ReadString('ConexaoBanco', 'LibraryLocation', '');

                     //Conexaodb_remoto.Connected       := True;

                     result := false;



                   end;


               except
                   on E:Exception do
                   error := 'Erro ao conectar!'#13'Erro: ';

               end;




             end;




end.

