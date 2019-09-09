unit umodulo_receber;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_receber }

  Tmodulo_receber = class(TDataModule)
    dsReceber: TDataSource;
    dsMasterReceber: TDataSource;
    dstempReceber: TDataSource;
    dstempMasterReceber: TDataSource;
    qrReceber: TSQLQuery;
    qrMasterReceber: TSQLQuery;
    qrtempReceber: TBufDataset;
    qrtempMasterReceber: TBufDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure dstempMasterReceberDataChange(Sender: TObject; Field: TField);
    procedure qrReceberAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_receber: Tmodulo_receber;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_receber }

      procedure Tmodulo_receber.DataModuleCreate(Sender: TObject);
      begin

        with qrtempReceber.fieldDefs do
           begin
                 Add('creceber', ftInteger, 0, True);
           end;

        qrtempReceber.CreateDataset;

        qrtempReceber.Open;

        qrtempReceber.Append;




        with qrtempMasterReceber.fieldDefs do
           begin
                 Add('cmasterreceber', ftInteger, 0, True);
           end;

        qrtempMasterReceber.CreateDataset;

        qrtempMasterReceber.Open;

        qrtempMasterReceber.Append;








      end;

procedure Tmodulo_receber.dstempMasterReceberDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure Tmodulo_receber.qrReceberAfterScroll(DataSet: TDataSet);
begin
end;

end.

