unit umodulo_funcionario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_funcionario }

  Tmodulo_funcionario = class(TDataModule)
    dsfuncionario: TDataSource;
    dstempFuncionario: TDataSource;
    dstempVendedor: TDataSource;
    qrfuncionario: TSQLQuery;
    qrtempFuncionario: TBufDataset;
    qrtempVendedor: TBufDataset;
    qrtempFuncionariocfun: TLongintField;
    qrtempcfun1: TLongintField;
    qrtempFuncionariocven: TLongintField;
    qrtempcven1: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_funcionario: Tmodulo_funcionario;

implementation
        uses umodulo_conexaodb;
{$R *.lfm}

        { Tmodulo_funcionario }

        procedure Tmodulo_funcionario.DataModuleCreate(Sender: TObject);
        begin

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

end.

