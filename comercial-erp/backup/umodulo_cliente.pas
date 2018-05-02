unit umodulo_cliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_cliente }

  Tmodulo_cliente = class(TDataModule)
    dscliente: TDataSource;
    qrcliente: TSQLQuery;
  private

  public

  end;

var
  modulo_cliente: Tmodulo_cliente;

implementation
      uses umodulo_conexaodb;
{$R *.lfm}

end.

