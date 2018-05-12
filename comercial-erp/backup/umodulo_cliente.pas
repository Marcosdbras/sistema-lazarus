unit umodulo_cliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_cliente }

  Tmodulo_cliente = class(TDataModule)
    dscliente: TDataSource;
    dstemp: TDataSource;
    qrcliente: TSQLQuery;
    qrtemp: TBufDataset;
    qrtempccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
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

        with qrtemp.fieldDefs do
           begin
                 Add('ccli', ftInteger, 0, True);
           end;

        qrtemp.CreateDataset;

        qrtemp.Open;

        qrtemp.Append;




      end;

end.

