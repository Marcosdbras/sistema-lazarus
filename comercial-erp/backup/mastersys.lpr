program mastersys;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, upedido_pesquisa, upedido_modulo, zcomponent, uprincipal_conexao,
  ufuncao_cria_ini, uconfig_banco, uprincipal_tela
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
   Application.CreateForm(Tfrmprincipal, frmprincipal);
   //Application.CreateForm(Tfrmconfig_banco, frmconfig_banco);
  Application.CreateForm(Tfrmpedidos, frmpedidos);
  Application.CreateForm(Tfrmpedido_modulo, frmpedido_modulo);
  Application.CreateForm(Tfrmprincipal_conexao, frmprincipal_conexao);

  Application.Run;
end.

