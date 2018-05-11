program mastersys;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uorcamento_pesquisa, umodulo_orcamento, zcomponent, umodulo_conexaodb,
  ufuncao_arq_ini, uconfig_banco, utela_principal, ufuncao_conexaodb,
  ufuncao_geral, usplash, ulogin, ucadastrar_senha, umodulo_cliente, umodulo_funcionario
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;

  frmsplash := tfrmsplash.Create(application);
  frmsplash.Show;
  frmsplash.Update;

  Application.CreateForm(Tmodulo_conexaodb, modulo_conexaodb);
  Application.CreateForm(Tmodulo_orcamento, modulo_orcamento);
  Application.CreateForm(Tmodulo_cliente, modulo_cliente);
  Application.CreateForm(Tmodulo_funcionario, modulo_funcionario);


  Application.CreateForm(Tfrmtela_principal, frmtela_principal);

  frmsplash.Hide;
  frmsplash.Free;

  Application.Run;
end.

