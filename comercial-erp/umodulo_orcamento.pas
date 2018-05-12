unit umodulo_orcamento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, db, BufDataset, sqldb;

type

  { Tmodulo_orcamento }

  Tmodulo_orcamento = class(TDataModule)
    dsorcamento_itemproduto: TDataSource;
    dsorcamento: TDataSource;
    dstempCliente: TDataSource;
    dstempFuncionario: TDataSource;
    dstempVendedor: TDataSource;
    qrorcamento: TSQLQuery;
    qrorcamento_itemproduto: TSQLQuery;
    qrtempccli: TLongintField;
    qrtempcfun: TLongintField;
    qrtempCliente: TBufDataset;
    qrtempClienteccli: TLongintField;
    qrtempcontrole: TAutoIncField;
    qrtempcven: TLongintField;
    qrtempcven1: TLongintField;
    qrtempFuncionario: TBufDataset;
    qrtempFuncionariocfun: TLongintField;
    qrtempVendedor: TBufDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrorcamentoAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_orcamento: Tmodulo_orcamento;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

       { Tmodulo_orcamento }

       procedure Tmodulo_orcamento.DataModuleCreate(Sender: TObject);
       begin

         with qrtempCliente.fieldDefs do
            begin
                  Add('ccli', ftInteger, 0, True);
            end;

         qrtempCliente.CreateDataset;

         qrtempCliente.Open;

         qrtempCliente.Append;


         with qrtempFuncionario.fieldDefs do
            begin
                  Add('cfun', ftInteger, 0, True);

            end;

         qrtempFuncionario.CreateDataset;

         qrtempFuncionario.Open;

         qrtempFuncionario.Append;



         with qrtempVendedor.fieldDefs do
            begin
                  Add('cven', ftInteger, 0, True);
            end;

         qrtempVendedor.CreateDataset;

         qrtempVendedor.Open;

         qrtempVendedor.Append;






       end;

procedure Tmodulo_orcamento.qrorcamentoAfterScroll(DataSet: TDataSet);
begin



end;

end.

