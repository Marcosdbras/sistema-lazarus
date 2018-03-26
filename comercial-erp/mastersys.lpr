program mastersys;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, upedido_pesquisa, umodulo_pedido, zcomponent, umodulo_conexaodb,
  ufuncao_arq_ini, uconfig_banco, utela_principal, ufuncao_conexaodb, ufuncao_geral
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tfrmtela_principal, frmtela_principal);

  Application.CreateForm(Tfrmpedidos, frmpedidos);
  Application.CreateForm(Tmodulo_pedido, modulo_pedido);
  Application.CreateForm(Tmodulo_conexaodb, modulo_conexaodb);

  Application.Run;
end.

