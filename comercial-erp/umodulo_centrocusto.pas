unit umodulo_centrocusto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_centrocusto }

  Tmodulo_centrocusto = class(TDataModule)
    dsCentroCusto: TDataSource;
    dstempCentroCusto: TDataSource;
    qrCentroCusto: TSQLQuery;
    qrtempCentroCusto: TBufDataset;
    qrtempCentroCustoccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrCentroCustoAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_centrocusto: Tmodulo_centrocusto;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_centrocusto }

      procedure Tmodulo_centrocusto.DataModuleCreate(Sender: TObject);
      begin

        with qrtempCentroCusto.fieldDefs do
           begin
                 Add('ccentrocusto', ftInteger, 0, True);
           end;

        qrtempCentroCusto.CreateDataset;

        qrtempCentroCusto.Open;

        qrtempCentroCusto.Append;




      end;

procedure Tmodulo_centrocusto.qrCentroCustoAfterScroll(DataSet: TDataSet);
begin
end;

end.

