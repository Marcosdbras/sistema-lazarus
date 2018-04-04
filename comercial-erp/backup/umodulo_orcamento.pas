unit umodulo_orcamento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, db;

type

  { Tmodulo_orcamento }

  Tmodulo_orcamento = class(TDataModule)
    dsorcamento: TDataSource;
    qrorcamento: TZQuery;
  private

  public

  end;

var
  modulo_orcamento: Tmodulo_orcamento;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

end.

