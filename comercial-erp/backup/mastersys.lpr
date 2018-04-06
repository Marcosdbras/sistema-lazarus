program mastersys;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uorcamento_pesquisa, umodulo_orcamento, zcomponent, umodulo_conexaodb,
  ufuncao_arq_ini, uconfig_banco, utela_principal, ufuncao_conexaodb, ufuncao_geral
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;



  Application.CreateForm(Tmodulo_conexaodb, modulo_conexaodb);
   Application.CreateForm(Tfrmtela_principal, frmtela_principal);


   Application.CreateForm(Tmodulo_orcamento, modulo_orcamento);


  //Application.CreateForm(Tfrmorcamento_pesquisa, frmorcamento_pesquisa);


  Application.Run;
end.

