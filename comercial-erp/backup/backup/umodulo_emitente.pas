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
  private

  public

  end;

var
  modulo_emitente: Tmodulo_emitente;

implementation
      uses umodulo_conexaodb, ufuncao_conexaodb;
{$R *.lfm}

end.

