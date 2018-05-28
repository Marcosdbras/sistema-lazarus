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
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_produto: Tmodulo_produto;

implementation

{$R *.lfm}

{ Tmodulo_produto }

procedure Tmodulo_produto.DataModuleCreate(Sender: TObject);
begin
           with qrtempProduto.fieldDefs do
              begin
                Add('cprod', ftInteger, 0, True);
              end;

         qrtempProduto.CreateDataset;

         qrtempProduto.Open;

         qrtempProduto.Append;

end;

end.

