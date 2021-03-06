unit umodulo_vendaorc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_vendaorc }

  Tmodulo_vendaorc = class(TDataModule)
    dsfornecedores: TDataSource;
    dsclientes: TDataSource;
    dsprodutos: TDataSource;
    dsdescricao_tabpreco: TDataSource;
    dstabpreco: TDataSource;
    dsvenda: TDataSource;
    dsvenda_itemproduto: TDataSource;
    qrvenda: TSQLQuery;
    qrvendaBAIRROENT: TStringField;
    qrvendaCCLI: TLongintField;
    qrvendaCEPENT: TStringField;
    qrvendaCFUNC: TLongintField;
    qrvendaCIDADEENT: TStringField;
    qrvendaCODIGO: TLongintField;
    qrvendaCOMPLENT: TStringField;
    qrvendaCONTATO: TStringField;
    qrvendaCPF: TStringField;
    qrvendaCTIPOCLI: TLongintField;
    qrvendaDDDEENT: TStringField;
    qrvendaDDDFS: TStringField;
    qrvendaENDENT: TStringField;
    qrvendaESTADOENT: TStringField;
    qrvendaFANTASIA: TStringField;
    qrvendaIE: TStringField;
    qrvendaLIQUIDO_P: TBCDField;
    qrvendaNFUNC: TStringField;
    qrvendaNOME: TStringField;
    qrvendaNPED: TLongintField;
    qrvendaNROENT: TStringField;
    qrvendaOBSERVACAO: TMemoField;
    qrvendaREFERENCIA_END: TStringField;
    qrvendaRESPONSAVELENT: TStringField;
    qrvendaTELEFONEENT: TStringField;
    qrvendaTELEFONES: TStringField;
    qrvendaTOTAL: TBCDField;
    qrvenda_itemproduto: TSQLQuery;
    qrvenda_itemprodutoCCOFINS: TLongintField;
    qrvenda_itemprodutoCEST: TStringField;
    qrvenda_itemprodutoCGRU: TLongintField;
    qrvenda_itemprodutoCODBARRAS: TStringField;
    qrvenda_itemprodutoCODCSTORIGEM: TStringField;
    qrvenda_itemprodutoCODIGO: TLongintField;
    qrvenda_itemprodutoCODIGOCSTORIGEM: TLongintField;
    qrvenda_itemprodutoCODIPI: TLongintField;
    qrvenda_itemprodutoCODPROD: TLongintField;
    qrvenda_itemprodutoCODSITB: TLongintField;
    qrvenda_itemprodutoCODUNIDADEMEDIDA: TLongintField;
    qrvenda_itemprodutoCPIS: TLongintField;
    qrvenda_itemprodutoCPRO: TLongintField;
    qrvenda_itemprodutoCSOSN: TStringField;
    qrvenda_itemprodutoDESCRICAO: TStringField;
    qrvenda_itemprodutoDESCRICAOGRUPO: TStringField;
    qrvenda_itemprodutoNCM: TStringField;
    qrvenda_itemprodutoPERCLUCRO: TBCDField;
    qrvenda_itemprodutoPRECOCUSTO: TBCDField;
    qrvenda_itemprodutoPRECOVENDA: TBCDField;
    qrvenda_itemprodutoPRVE: TBCDField;
    qrvenda_itemprodutoQTDE: TBCDField;
    qrvenda_itemprodutoREFERENCIA: TStringField;
    qrvenda_itemprodutoSIGLACOFINS: TStringField;
    qrvenda_itemprodutoSIGLAIPI: TStringField;
    qrvenda_itemprodutoSIGLAPIS: TStringField;
    qrvenda_itemprodutoSUBTOTAL: TBCDField;
    qrvenda_itemprodutoUND: TStringField;
    qrconsulta_baseaux: TSQLQuery;
    qrtabpreco: TSQLQuery;
    qrdescricao_tabpreco: TSQLQuery;
    qrprodutos: TSQLQuery;
    qrclientes: TSQLQuery;
    qrfornecedores: TSQLQuery;
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
            qrvenda_itemproduto.SQL.Add('select dp.codipi,  ipi.sigla as siglaipi,  dp.cpis, pis.sigla as siglapis, dp.ccofins, cofins.sigla as siglacofins, dp.csosn, dp.cest,  dp.cbar as codbarras, dp.caux as referencia, dp.ncm,  dp.cgru, gr.descricao  as descricaogrupo, dp.codsita as codigocstorigem,  o.descricao as codcstorigem,   dp.codsitb, dp.prcu as precocusto, dp.per as perclucro,  dp.prve as precovenda,  dp.cuni as codunidademedida,  u.descricao as und,  p.descricao, d.codigo, d.cpro, d.prve, d.qtde, dp.codigo as codprod, d.subtotal from dvenda d      left join dprodutos dp on d.cpro = dp.codigo     left join produtos p on dp.cdescprod = p.codigo    left join unidade u on  dp.cuni = u.codigo    left join sita o on dp.codsita = o.codigo    left join sitb cst on dp.codsitb = cst.codigo       left join grupo gr on dp.cgru = gr.codigo     left join ipi on dp.codipi = ipi.codigo       left join pis on dp.cpis = pis.codigo    left join cofins on dp.ccofins = cofins.codigo  where d.codsvenda = :codsvenda');
            qrvenda_itemproduto.ParamByName('codsvenda').AsInteger:= qrvenda.FieldByName('codigo').AsInteger;
            qrvenda_itemproduto.Open;

            qrconsulta_baseaux.Close;
            qrconsulta_baseaux.SQL.Clear;
            qrconsulta_baseaux.SQL.Add('select sum(qtde*prve) as total from dvenda  group by codsvenda  having codsvenda = :codsvenda ');
            qrconsulta_baseaux.ParamByName('codsvenda').AsInteger:= qrvenda.FieldByName('codigo').AsInteger;
            qrconsulta_baseaux.Open;


            frmvendaorc.lbltotal.Caption:=formatfloat('0.00',qrconsulta_baseaux.FieldByName('total').AsFloat);



          end;
       //endi

     end;
   //end

end;

end.

