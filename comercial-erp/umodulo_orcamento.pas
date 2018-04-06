unit umodulo_orcamento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, db, sqldb;

type

  { Tmodulo_orcamento }

  Tmodulo_orcamento = class(TDataModule)
    dsorcamento: TDataSource;
    qrorcamento: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
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

       end;

end.

