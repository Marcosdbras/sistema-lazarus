unit umodulo_funcionario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_funcionario }

  Tmodulo_funcionario = class(TDataModule)
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
  private

  public

  end;

var
  modulo_funcionario: Tmodulo_funcionario;

implementation
        uses umodulo_conexaodb;
{$R *.lfm}

end.

