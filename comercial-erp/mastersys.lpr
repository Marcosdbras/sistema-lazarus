program mastersys;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, uorcamento_pesquisa, umodulo_orcamento, umodulo_conexaodb,
  ufuncao_arq_ini, uconfig_banco, utela_principal, ufuncao_conexaodb,
  ufuncao_geral, usplash, ulogin, ucadastrar_senha, umodulo_cliente,
  umodulo_funcionario, umodulo_unidade, umodulo_produto, uproduto_consulta,
  uimporc, umodulo_vendaorc, uvendaorc, uindice, umodulo_temp, umodulo_geral,
  uorcamento_impressao, usincorc, umodulo_remoto, usincbaseremota,
  umodulo_emitente, umodulo_tabpreco

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

  // 3-Cria tela principal para atualizar base de dados
  Application.CreateForm(Tfrmtela_principal, frmtela_principal);

  // 4-Cria módulos de conexao com as tabelas
  Application.CreateForm(Tmodulo_emitente, modulo_emitente);
  Application.CreateForm(Tmodulo_tabpreco, modulo_tabpreco);
  Application.CreateForm(Tmodulo_cliente, modulo_cliente);
  Application.CreateForm(Tmodulo_funcionario, modulo_funcionario);
  Application.CreateForm(Tmodulo_orcamento, modulo_orcamento);
  Application.CreateForm(Tmodulo_unidade, modulo_unidade);
  Application.CreateForm(Tmodulo_produto, modulo_produto);
  Application.CreateForm(Tmodulo_vendaorc, modulo_vendaorc);
  Application.CreateForm(Tmodulo_temp, modulo_temp);
  Application.CreateForm(Tmodulo_geral, modulo_geral);

  // 2-Cria módulo conexao com a tabela remota para sincronismo com base
  Application.CreateForm(Tmodulo_remoto, modulo_remoto);


  //Application.CreateForm(Tfrmvendaorc, frmvendaorc);
  //Application.CreateForm(Tfrmajusteprodutos, frmajusteprodutos);
  //Application.CreateForm(Tmodulo_temp, modulo_temp);
  //Application.CreateForm(Tfrmorcamento_impressao, frmorcamento_impressao);

  frmsplash.Hide;
  frmsplash.Free;

  Application.Run;
end.

