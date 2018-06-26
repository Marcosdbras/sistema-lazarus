unit umodulo_vendaorc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_vendaorc }

  Tmodulo_vendaorc = class(TDataModule)
    dsvenda: TDataSource;
    dsvenda_itemproduto: TDataSource;
    qrvenda: TSQLQuery;
    qrvenda_itemproduto: TSQLQuery;
    procedure qrvendaAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_vendaorc: Tmodulo_vendaorc;

implementation

{$R *.lfm}

{ Tmodulo_vendaorc }

procedure Tmodulo_vendaorc.qrvendaAfterScroll(DataSet: TDataSet);
begin
     with modulo_vendaorc do
     begin

       qrvenda_itemproduto.close;
       qrvenda_itemproduto.SQL.Clear;
       qrvenda_itemproduto.SQL.Add('select d.codigo, d.cpro, d.prve, d.qtde, p.codigo as codprod from dvenda d left join dprodutos p on d.cpro = p.codigo where d.codsvenda = :codsvenda');
       qrvenda_itemproduto.ParamByName('codsvenda').AsInteger:= qrvenda.FieldByName('codigo').AsInteger;
       qrvenda_itemproduto.Open;

     end;
   //end

end;

end.

