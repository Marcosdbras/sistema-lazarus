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
    qrvendaCCLI: TLongintField;
    qrvendaCODIGO: TLongintField;
    qrvendaNOME: TStringField;
    qrvendaNPED: TLongintField;
    qrvendaTOTAL: TBCDField;
    qrvenda_itemproduto: TSQLQuery;
    qrvenda_itemprodutoCODIGO: TLongintField;
    qrvenda_itemprodutoCODPROD: TLongintField;
    qrvenda_itemprodutoCPRO: TLongintField;
    qrvenda_itemprodutoDESCRICAO: TStringField;
    qrvenda_itemprodutoPRVE: TBCDField;
    qrvenda_itemprodutoQTDE: TBCDField;
    qrvenda_itemprodutoSUBTOTAL: TBCDField;
    procedure qrvendaAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_vendaorc: Tmodulo_vendaorc;

implementation
     uses uvendaorc;
{$R *.lfm}

{ Tmodulo_vendaorc }

procedure Tmodulo_vendaorc.qrvendaAfterScroll(DataSet: TDataSet);
begin
     with modulo_vendaorc do
     begin
       if frmvendaorc <> nil then
          begin

            qrvenda_itemproduto.close;
            qrvenda_itemproduto.SQL.Clear;
            qrvenda_itemproduto.SQL.Add('select p.descricao, d.codigo, d.cpro, d.prve, d.qtde, dp.codigo as codprod, d.subtotal from dvenda d left join dprodutos dp on d.cpro = dp.codigo left join produtos p on dp.cdescprod = p.codigo where d.codsvenda = :codsvenda');
            qrvenda_itemproduto.ParamByName('codsvenda').AsInteger:= qrvenda.FieldByName('codigo').AsInteger;
            qrvenda_itemproduto.Open;

          end;
       //endi

     end;
   //end

end;

end.

