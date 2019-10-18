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
  umodulo_emitente, umodulo_tabpreco, ucotacao_cadastro, umodulo_fornecedor,
  umodulo_cotacao, umodulo_pedidovenda, uorcamento_cadastro, umodulo_planoconta,
  umodulo_centrocusto, umodulo_caixa, umodulo_receber, umodulo_especie,
  ufechapedidovenda, umodulo_parcelapredefinida, umodulo_master_indice,
  ucadastro_parcelafinanceiro, umodulo_pagar, umodulo_consulta, umodulo_usuario,
  uusuario_pesquisa, uususario_permissao;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;

  frmsplash := tfrmsplash.Create(application);
  frmsplash.Show;
  frmsplash.Update;

  // 1-Realiza conexao com base de dados
  Application.CreateForm(Tmodulo_conexaodb, modulo_conexaodb);
  Application.CreateForm(Tmodulo_usuario, modulo_usuario);


  // 3-Cria tela principal para atualizar base de dados
  Application.CreateForm(Tfrmtela_principal, frmtela_principal);
  Application.CreateForm(Tmodulo_fornecedor, modulo_fornecedor);
  Application.CreateForm(Tmodulo_emitente, modulo_emitente);
  Application.CreateForm(Tmodulo_tabpreco, modulo_tabpreco);
  Application.CreateForm(Tmodulo_cliente, modulo_cliente);
  Application.CreateForm(Tmodulo_especie, modulo_especie);
  Application.CreateForm(Tmodulo_planoconta, modulo_planoconta);
  Application.CreateForm(Tmodulo_pagar, modulo_pagar);
  Application.CreateForm(Tmodulo_caixa, modulo_caixa);
  Application.CreateForm(Tmodulo_receber, modulo_receber);
  Application.CreateForm(Tmodulo_centrocusto, modulo_centrocusto);
  Application.CreateForm(Tmodulo_funcionario, modulo_funcionario);
  Application.CreateForm(Tmodulo_orcamento, modulo_orcamento);
  Application.CreateForm(Tmodulo_pedidovenda, modulo_pedidovenda);
  Application.CreateForm(Tmodulo_unidade, modulo_unidade);
  Application.CreateForm(Tmodulo_produto, modulo_produto);
  Application.CreateForm(Tmodulo_vendaorc, modulo_vendaorc);
  Application.CreateForm(Tmodulo_temp, modulo_temp);
  Application.CreateForm(Tmodulo_geral, modulo_geral);
  Application.CreateForm(Tmodulo_cotacao, modulo_cotacao);
  Application.CreateForm(Tmodulo_master_indice, modulo_master_indice);
  Application.CreateForm(Tmodulo_parcelapredefinida, modulo_parcelapredefinida);
  Application.CreateForm(Tmodulo_consulta, modulo_consulta);



  // 2-Cria módulo conexao com a tabela remota para sincronismo com base
  Application.CreateForm(Tmodulo_remoto, modulo_remoto);


  //Application.CreateForm(Tfrmvendaorc, frmvendaorc);
  //Application.CreateForm(Tfrmajusteprodutos, frmajusteprodutos);
  //Application.CreateForm(Tmodulo_temp, modulo_temp);
  //Application.CreateForm(Tfrmorcamento_impressao, frmorcamento_impressao);
  //Application.CreateForm(Tfrmcotacao_cadastro, frmcotacao_cadastro);
  //Application.CreateForm(Tfrmfechapedidovenda, frmfechapedidovenda);
  //Application.CreateForm(Tfrmcadastro_parcelafinanceiro, frmcadastro_parcelafinanceiro);
  //Application.CreateForm(Tfrmmostratroco, frmmostratroco);
  // Application.CreateForm(Tfrmusuario_pesquisa, frmusuario_pesquisa);
  //Application.CreateForm(Tfrmusuario_permissao, frmusuario_permissao);

  frmsplash.Hide;
  frmsplash.Free;

  Application.Run;
end.

