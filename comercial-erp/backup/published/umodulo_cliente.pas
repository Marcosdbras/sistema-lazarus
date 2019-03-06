unit umodulo_cliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_cliente }

  Tmodulo_cliente = class(TDataModule)
    dscliente: TDataSource;
    dstempCliente: TDataSource;
    qrcliente: TSQLQuery;
    qrtempCliente: TBufDataset;
    qrtempClienteccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dstempClienteDataChange(Sender: TObject; Field: TField);
  private

  public

  end;

var
  modulo_cliente: Tmodulo_cliente;

implementation
      uses umodulo_conexaodb;
{$R *.lfm}

      { Tmodulo_cliente }

      procedure Tmodulo_cliente.DataModuleCreate(Sender: TObject);
      begin

        with qrtempCliente.fieldDefs do
           begin
                 Add('ccli', ftInteger, 0, True);
           end;

        qrtempCliente.CreateDataset;

        qrtempCliente.Open;

        qrtempCliente.Append;




      end;

procedure Tmodulo_cliente.dstempClienteDataChange(Sender: TObject; Field: TField);
begin

end;

end.

