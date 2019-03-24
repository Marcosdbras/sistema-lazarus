unit umodulo_fornecedores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_fornecedores }

  Tmodulo_fornecedores = class(TDataModule)
    dsfornecedores: TDataSource;
    qrfornecedores: TSQLQuery;
  private

  public

  end;

var
  modulo_fornecedores: Tmodulo_fornecedores;

implementation
      uses umodulo_conexaodb;
{$R *.lfm}

end.

