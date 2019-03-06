unit umodulo_emitente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, BufDataset, db, FileUtil;

type

  { Tmodulo_emitente }

  Tmodulo_emitente = class(TDataModule)
    dsemitente: TDataSource;
    dstemp: TDataSource;
    qremitente: TSQLQuery;
    qrtemp: TBufDataset;
    qrtempccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_emitente: Tmodulo_emitente;

implementation
      uses umodulo_conexaodb, ufuncao_conexaodb;
{$R *.lfm}

      { Tmodulo_emitente }

      procedure Tmodulo_emitente.DataModuleCreate(Sender: TObject);
      begin


        with qrtemp.fieldDefs do
           begin
                 Add('cemi', ftInteger, 0, True);
           end;

        qrtemp.CreateDataset;

        qrtemp.Open;

        qrtemp.Append;



      end;

end.

