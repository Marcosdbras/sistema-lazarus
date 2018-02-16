program mastersys;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, upedido_pesquisa, upedido_modulo, zcomponent
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tfrmpedidos, frmpedidos);
  Application.CreateForm(Tfrmpedido_modulo, frmpedido_modulo);
  Application.Run;
end.

