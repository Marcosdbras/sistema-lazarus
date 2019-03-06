unit umodulo_tabpreco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, sqldb, FileUtil;

type

  { Tmodulo_tabpreco }

  Tmodulo_tabpreco = class(TDataModule)
    dstabpreco: TDataSource;
    dstempTabPreco: TDataSource;
    qrtabpreco: TSQLQuery;
    qrtempTabPreco: TBufDataset;
    qrtempTabPrecoctabp: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_tabpreco: Tmodulo_tabpreco;

implementation

{$R *.lfm}

{ Tmodulo_tabpreco }

procedure Tmodulo_tabpreco.DataModuleCreate(Sender: TObject);
begin
          with qrtempTabPreco.fieldDefs do
           begin
                 Add('ctabp', ftInteger, 0, True);
           end;

        qrtempTabPreco.CreateDataset;

        qrtempTabPreco.open;

        qrtempTabPreco.Append;

end;

end.

