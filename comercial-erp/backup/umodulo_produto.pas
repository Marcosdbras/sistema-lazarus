unit umodulo_produto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_produto }

  Tmodulo_produto = class(TDataModule)
    dstempProduto: TDataSource;
    dsproduto: TDataSource;
    qrtempProduto: TBufDataset;
    qrtempProdutocund: TLongintField;
    qrproduto: TSQLQuery;
  private

  public

  end;

var
  modulo_produto: Tmodulo_produto;

implementation

{$R *.lfm}

end.

