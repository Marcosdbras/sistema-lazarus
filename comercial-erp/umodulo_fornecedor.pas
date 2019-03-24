unit umodulo_fornecedor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_fornecedor }

  Tmodulo_fornecedor = class(TDataModule)
    dsfornecedor: TDataSource;
    dstempFornecedor: TDataSource;
    qrfornecedor: TSQLQuery;
    qrtempFornecedor: TBufDataset;
    qrtempFornecedorcfor: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_fornecedor: Tmodulo_fornecedor;

implementation
      uses umodulo_conexaodb;
{$R *.lfm}

      { Tmodulo_fornecedor }

      procedure Tmodulo_fornecedor.DataModuleCreate(Sender: TObject);
      begin

        with qrtempFornecedor.fieldDefs do
           begin
                 Add('cfor', ftInteger, 0, True);
           end;

        qrtempFornecedor.CreateDataset;

        qrtempFornecedor.Open;

        qrtempFornecedor.Append;



      end;

end.

