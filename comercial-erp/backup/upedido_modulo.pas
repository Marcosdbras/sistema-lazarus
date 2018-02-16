unit upedido_modulo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection;

type

  { Tfrmpedido_modulo }

  Tfrmpedido_modulo = class(TDataModule)
    ZConnection1: TZConnection;
  private

  public

  end;

var
  frmpedido_modulo: Tfrmpedido_modulo;

implementation

{$R *.lfm}

end.

