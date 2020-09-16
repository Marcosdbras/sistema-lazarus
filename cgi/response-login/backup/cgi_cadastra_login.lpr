program cgi_cadastra_login;

{$mode objfpc}{$H+}

uses
  fpCGI, ucgi_cadastra_login;

begin

  Application.LegacyRouting: = true;

  Application.Initialize;
  Application.Run;
end.

