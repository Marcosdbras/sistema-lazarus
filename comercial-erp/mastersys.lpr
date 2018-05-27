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

  // 1-Realiza conexao com base de dados
  Application.CreateForm(Tmodulo_conexaodb, modulo_conexaodb);

  // 2-Cria tela principal para atualizar base de dados
  Application.CreateForm(Tfrmtela_principal, frmtela_principal);

  // 3-Cria módulos de conexao com as tabelas
  Application.CreateForm(Tmodulo_cliente, modulo_cliente);
  Application.CreateForm(Tmodulo_funcionario, modulo_funcionario);
  Application.CreateForm(Tmodulo_orcamento, modulo_orcamento);



  frmsplash.Hide;
  frmsplash.Free;

  Application.Run;
end.

