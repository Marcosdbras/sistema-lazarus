unit umodulo_caixa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_caixa }

  Tmodulo_caixa = class(TDataModule)
    dsCaixa: TDataSource;
    dstempCaixa: TDataSource;
    qrCaixa: TSQLQuery;
    qrtempCaixa: TBufDataset;
    qrtempCaixaccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrCaixaAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_caixa: Tmodulo_caixa;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_caixa }

      procedure Tmodulo_caixa.DataModuleCreate(Sender: TObject);
      begin

        with qrtempCaixa.fieldDefs do
           begin
                 Add('ccaixa', ftInteger, 0, True);
           end;

        qrtempCaixa.CreateDataset;

        qrtempCaixa.Open;

        qrtempCaixa.Append;




      end;

procedure Tmodulo_caixa.qrCaixaAfterScroll(DataSet: TDataSet);
begin
end;

end.

