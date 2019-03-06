unit umodulo_unidade;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_unidade }

  Tmodulo_unidade = class(TDataModule)
    dsunidade: TDataSource;
    dstempUnidade: TDataSource;
    qrtempUnidadecund: TLongintField;
    qrunidade: TSQLQuery;
    qrtempcven1: TLongintField;
    qrtempUnidade: TBufDataset;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_unidade: Tmodulo_unidade;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

       { Tmodulo_unidade }

       procedure Tmodulo_unidade.DataModuleCreate(Sender: TObject);
       begin

         with qrtempUnidade.fieldDefs do
              begin
                Add('cund', ftInteger, 0, True);
              end;

         qrtempUnidade.CreateDataset;

         qrtempUnidade.Open;

         qrtempUnidade.Append;




       end;

end.

