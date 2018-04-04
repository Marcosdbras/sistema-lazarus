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
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
  private

  public

  end;

var
  modulo_orcamento: Tmodulo_orcamento;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

end.

