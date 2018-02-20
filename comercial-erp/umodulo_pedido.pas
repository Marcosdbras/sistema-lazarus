unit umodulo_pedido;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset;

type

  { Tmodulo_pedido }

  Tmodulo_pedido = class(TDataModule)
    ZQuery1: TZQuery;
  private

  public

  end;

var
  modulo_pedido: Tmodulo_pedido;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

end.

