unit upedido_modulo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset;

type

  { Tfrmpedido_modulo }

  Tfrmpedido_modulo = class(TDataModule)
    ZQuery1: TZQuery;
  private

  public

  end;

var
  frmpedido_modulo: Tfrmpedido_modulo;

implementation
       uses uprincipal_conexao;
{$R *.lfm}

end.

