unit umodulo_tabpreco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil;

type

  { Tmodulo_tabpreco }

  Tmodulo_tabpreco = class(TDataModule)
    dstabpreco: TDataSource;
    qrtabpreco: TSQLQuery;
  private

  public

  end;

var
  modulo_tabpreco: Tmodulo_tabpreco;

implementation

{$R *.lfm}

end.

