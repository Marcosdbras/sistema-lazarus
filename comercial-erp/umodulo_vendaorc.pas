unit umodulo_vendaorc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_vendaorc }

  Tmodulo_vendaorc = class(TDataModule)
    dsvenda: TDataSource;
    dsvenda_itemproduto: TDataSource;
    qrvenda: TSQLQuery;
    qrvenda_itemproduto: TSQLQuery;
  private

  public

  end;

var
  modulo_vendaorc: Tmodulo_vendaorc;

implementation

{$R *.lfm}

end.

