unit umodulo_pagar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, sqldb, FileUtil;

type

  { Tmodulo_pagar }

  Tmodulo_pagar = class(TDataModule)
    BufDataset1: TBufDataset;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    SQLQuery1: TSQLQuery;
  private

  public

  end;

var
  modulo_pagar: Tmodulo_pagar;

implementation

{$R *.lfm}

end.

