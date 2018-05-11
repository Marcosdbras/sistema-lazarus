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
    qrorcamento: TSQLQuery;
    qrorcamento_itemproduto: TSQLQuery;
    qrtempccli: TLongintField;
    qrtempcfun: TLongintField;
    qrtempcontrole: TAutoIncField;
    qrtempcven: TLongintField;
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




       end;

procedure Tmodulo_orcamento.qrorcamentoAfterScroll(DataSet: TDataSet);
begin



end;

end.

