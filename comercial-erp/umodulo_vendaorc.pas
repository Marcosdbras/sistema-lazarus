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
    qrvendaCEPENT: TStringField;
    qrvendaCFUNC: TLongintField;
    qrvendaCODIGO: TLongintField;
    qrvendaNFUNC: TStringField;
    qrvendaNOME: TStringField;
    qrvendaNPED: TLongintField;
    qrvendaTOTAL: TBCDField;
    qrvenda_itemproduto: TSQLQuery;
    qrvenda_itemprodutoCODIGO: TLongintField;
    qrvenda_itemprodutoCODPROD: TLongintField;
    qrvenda_itemprodutoCPRO: TLongintField;
    qrvenda_itemprodutoCUNI: TLongintField;
    qrvenda_itemprodutoDESCRICAO: TStringField;
    qrvenda_itemprodutoPERCLUCRO: TBCDField;
    qrvenda_itemprodutoPRECOCUSTO: TBCDField;
    qrvenda_itemprodutoPRECOVENDA: TBCDField;
    qrvenda_itemprodutoPRVE: TBCDField;
    qrvenda_itemprodutoQTDE: TBCDField;
    qrvenda_itemprodutoSUBTOTAL: TBCDField;
    qrvenda_itemprodutoUND: TStringField;
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
            qrvenda_itemproduto.SQL.Add('select dp.prcu as precocusto, dp.per as perclucro,  dp.prve as precovenda,  d.cuni,  u.descricao as und,  p.descricao, d.codigo, d.cpro, d.prve, d.qtde, dp.codigo as codprod, d.subtotal from dvenda d left join dprodutos dp on d.cpro = dp.codigo left join produtos p on dp.cdescprod = p.codigo    left join unidade u on  dp.cuni = u.codigo     where d.codsvenda = :codsvenda');
            qrvenda_itemproduto.ParamByName('codsvenda').AsInteger:= qrvenda.FieldByName('codigo').AsInteger;
            qrvenda_itemproduto.Open;

          end;
       //endi

     end;
   //end

end;

end.

