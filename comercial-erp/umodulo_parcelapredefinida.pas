unit umodulo_parcelapredefinida;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_parcelapredefinida }

  Tmodulo_parcelapredefinida = class(TDataModule)
    dsParcelaPredefinida: TDataSource;
    dstempParcelaPredefinida: TDataSource;
    qrParcelaPredefinida: TSQLQuery;
    qrtempParcelaPredefinida: TBufDataset;
    qrtempParcelaPredefinidaccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrParcelaPredefinidaAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_parcelapredefinida: Tmodulo_parcelapredefinida;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_parcelapredefinida }

      procedure Tmodulo_parcelapredefinida.DataModuleCreate(Sender: TObject);
      begin

        with qrtempParcelaPredefinida.fieldDefs do
           begin
                 Add('cparcelapredefinida', ftInteger, 0, True);
           end;

        qrtempParcelaPredefinida.CreateDataset;

        qrtempParcelaPredefinida.Open;

        qrtempParcelaPredefinida.Append;




      end;

procedure Tmodulo_parcelapredefinida.qrParcelaPredefinidaAfterScroll(DataSet: TDataSet);
begin
end;

end.

