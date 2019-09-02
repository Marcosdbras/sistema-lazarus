unit umodulo_receber;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_receber }

  Tmodulo_receber = class(TDataModule)
    dsReceber: TDataSource;
    dstempReceber: TDataSource;
    qrReceber: TSQLQuery;
    qrtempReceber: TBufDataset;
    qrtempReceberccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
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
                 Add('cplanoconta', ftInteger, 0, True);
           end;

        qrtempReceber.CreateDataset;

        qrtempReceber.Open;

        qrtempReceber.Append;




      end;

procedure Tmodulo_receber.qrReceberAfterScroll(DataSet: TDataSet);
begin
end;

end.

