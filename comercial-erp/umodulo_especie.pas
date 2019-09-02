unit umodulo_especie;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_especie }

  Tmodulo_especie = class(TDataModule)
    dsEspecie: TDataSource;
    dstempEspecie: TDataSource;
    qrEspecie: TSQLQuery;
    qrtempEspecie: TBufDataset;
    qrtempEspecieccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrEspecieAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_especie: Tmodulo_especie;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_especie }

      procedure Tmodulo_especie.DataModuleCreate(Sender: TObject);
      begin

        with qrtempEspecie.fieldDefs do
           begin
                 Add('ccentrocusto', ftInteger, 0, True);
           end;

        qrtempEspecie.CreateDataset;

        qrtempEspecie.Open;

        qrtempEspecie.Append;




      end;

procedure Tmodulo_especie.qrEspecieAfterScroll(DataSet: TDataSet);
begin
end;

end.

