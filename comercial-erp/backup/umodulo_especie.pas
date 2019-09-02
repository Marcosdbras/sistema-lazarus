unit umodulo_especie;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_centrocuto }

  Tmodulo_centrocuto = class(TDataModule)
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
  modulo_centrocuto: Tmodulo_centrocuto;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_centrocuto }

      procedure Tmodulo_centrocuto.DataModuleCreate(Sender: TObject);
      begin

        with qrtempCentroCusto.fieldDefs do
           begin
                 Add('ccentrocusto', ftInteger, 0, True);
           end;

        qrtempCentroCusto.CreateDataset;

        qrtempCentroCusto.Open;

        qrtempCentroCusto.Append;




      end;

procedure Tmodulo_centrocuto.qrCentroCustoAfterScroll(DataSet: TDataSet);
begin
end;

end.

