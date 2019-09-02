unit umodulo_planoconta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_planoconta }

  Tmodulo_planoconta = class(TDataModule)
    dsPlanoConta: TDataSource;
    dstempPlanoconta: TDataSource;
    qrPlanoConta: TSQLQuery;
    qrtempPlanoConta: TBufDataset;
    qrtempPlanoContaccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrPlanoContaAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_planoconta: Tmodulo_planoconta;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_planoconta }

      procedure Tmodulo_planoconta.DataModuleCreate(Sender: TObject);
      begin

        with qrtempPlanoConta.fieldDefs do
           begin
                 Add('cplanoconta', ftInteger, 0, True);
           end;

        qrtempPlanoConta.CreateDataset;

        qrtempPlanoConta.Open;

        qrtempPlanoConta.Append;




      end;

procedure Tmodulo_planoconta.qrPlanoContaAfterScroll(DataSet: TDataSet);
begin
end;

end.

