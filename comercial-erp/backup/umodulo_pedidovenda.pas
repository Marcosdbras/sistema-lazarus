unit umodulo_pedidovenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, db, BufDataset, sqldb;

type

  { Tmodulo_pedidovenda }

  Tmodulo_pedidovenda = class(TDataModule)
    dsmaster_pedidovenda: TDataSource;
    dspedidovenda_itemproduto: TDataSource;
    dspedidovenda: TDataSource;
    dstempCliente: TDataSource;
    dstempFuncionario: TDataSource;
    dstempUnidade: TDataSource;
    dstempVendedor: TDataSource;
    qrpedidovenda: TSQLQuery;
    qrpedidovendaBAIRRO: TStringField;
    qrpedidovendaCANCELADO: TStringField;
    qrpedidovendaCCF: TLongintField;
    qrpedidovendaCELULAR: TStringField;
    qrpedidovendaCEP: TStringField;
    qrpedidovendaCIDADE: TStringField;
    qrpedidovendaCLIENTE: TStringField;
    qrpedidovendaCNPJ: TStringField;
    qrpedidovendaCODCIDADE: TLongintField;
    qrpedidovendaCODCLIENTE: TLongintField;
    qrpedidovendaCODFUNCIONARIO: TLongintField;
    qrpedidovendaCODNFE: TLongintField;
    qrpedidovendaCODSEQUENCIA: TLongintField;
    qrpedidovendaCODVENDEDOR: TLongintField;
    qrpedidovendaCOMPLEMENTO: TStringField;
    qrpedidovendaCONTROLE: TLongintField;
    qrpedidovendaCONTROLEVARCHAR: TStringField;
    qrpedidovendaCOO: TLongintField;
    qrpedidovendaCOOVINCULADO: TLongintField;
    qrpedidovendaCPF: TStringField;
    qrpedidovendaDATAFATURADA: TDateField;
    qrpedidovendaDATAHORACADASTRO: TDateTimeField;
    qrpedidovendaDATAPREVISAOENTREGA: TDateField;
    qrpedidovendaEMAIL: TStringField;
    qrpedidovendaENDERECO: TStringField;
    qrpedidovendaFUNCIONARIO: TStringField;
    qrpedidovendaIE: TStringField;
    qrpedidovendaIM: TStringField;
    qrpedidovendaINDICADOR: TStringField;
    qrpedidovendaMARCAECF: TStringField;
    qrpedidovendaMD5DAV: TStringField;
    qrpedidovendaMESCLAR: TStringField;
    qrpedidovendaMODELOECF: TStringField;
    qrpedidovendaNUMERO: TStringField;
    qrpedidovendaNUMEROECF: TLongintField;
    qrpedidovendaOBSERVACAO: TMemoField;
    qrpedidovendaQTDEITEM: TLongintField;
    qrpedidovendaREFERENCIA: TStringField;
    qrpedidovendaRG: TStringField;
    qrpedidovendaSERIEECF: TStringField;
    qrpedidovendaSTATUS: TStringField;
    qrpedidovendaTELEFONE: TStringField;
    qrpedidovendaTIPOECF: TStringField;
    qrpedidovendaTITULODAV: TStringField;
    qrpedidovendaTOTALLIQUIDO: TBCDField;
    qrpedidovendaTOTALPRODUTOS: TBCDField;
    qrpedidovendaUF: TStringField;
    qrpedidovendaVALORACRESCIMO: TBCDField;
    qrpedidovendaVALORACRESCIMOFINANCEIRO: TBCDField;
    qrpedidovendaVALORDESCONTO: TBCDField;
    qrpedidovendaVENDEDOR: TStringField;
    qrpedidovenda_itemproduto: TSQLQuery;
    qrpedidovenda_itemprodutoALIQUOTA: TBCDField;
    qrpedidovenda_itemprodutoCANCELADO: TStringField;
    qrpedidovenda_itemprodutoCODITEM: TLongintField;
    qrpedidovenda_itemprodutoCODPEDIDOVENDA: TLongintField;
    qrpedidovenda_itemprodutoCODPRODUTO: TLongintField;
    qrpedidovenda_itemprodutoCONTROLE: TLongintField;
    qrpedidovenda_itemprodutoCONTROLEORIGEMMESCLAGEM: TLongintField;
    qrpedidovenda_itemprodutoDATAHORACADASTRO: TDateTimeField;
    qrpedidovenda_itemprodutoDECIMAISQTDE: TLongintField;
    qrpedidovenda_itemprodutoDECIMAISVALORUNITARIO: TLongintField;
    qrpedidovenda_itemprodutoMD5DAV: TStringField;
    qrpedidovenda_itemprodutoMESCLAR: TStringField;
    qrpedidovenda_itemprodutoNUMERODAV: TStringField;
    qrpedidovenda_itemprodutoOBS: TMemoField;
    qrpedidovenda_itemprodutoPERCACRESCIMO: TBCDField;
    qrpedidovenda_itemprodutoPERCDESCONTO: TBCDField;
    qrpedidovenda_itemprodutoPESO: TBCDField;
    qrpedidovenda_itemprodutoPRODUTO: TStringField;
    qrpedidovenda_itemprodutoQTDE: TBCDField;
    qrpedidovenda_itemprodutoQTDECONVERTIDA: TBCDField;
    qrpedidovenda_itemprodutoSITUACAOTRIBUTARIA: TStringField;
    qrpedidovenda_itemprodutoSTATUS: TStringField;
    qrpedidovenda_itemprodutoTOTALLIQUIDO: TBCDField;
    qrpedidovenda_itemprodutoUN: TStringField;
    qrpedidovenda_itemprodutoUNCONVERTIDA: TStringField;
    qrpedidovenda_itemprodutoVALORACRESCIMO: TBCDField;
    qrpedidovenda_itemprodutoVALORACRESCIMOUNITARIO: TBCDField;
    qrpedidovenda_itemprodutoVALORDESCONTO: TBCDField;
    qrpedidovenda_itemprodutoVALORDESCONTOUNITARIO: TBCDField;
    qrpedidovenda_itemprodutoVALORUNITARIO: TBCDField;
    qrsequenciaCODIGOCLIENTE: TLongintField;
    qrsequenciaCONTROLE: TLongintField;
    qrsequenciaCONTROLEVARCHAR: TLargeintField;
    qrsequenciaIDDFE: TLongintField;
    qrsequenciaNSUMANIFESTO: TLongintField;
    qrsequenciaNUMEROLOTE: TLongintField;
    qrsequenciaNUMERONOTAMANUAL: TLongintField;
    qrsequenciaNUMEROOS: TLongintField;
    qrsequenciaPREVENDA: TStringField;
    qrsequenciaRPS: TLongintField;
    qrsequenciaSENHACOMANDA: TLongintField;
    qrtempccli: TLongintField;
    qrtempcfun: TLongintField;
    qrtempCliente: TBufDataset;
    qrtempClienteccli: TLongintField;
    qrtempcontrole: TAutoIncField;
    qrtempcven: TLongintField;
    qrtempcven1: TLongintField;
    qrtempFuncionario: TBufDataset;
    qrtempFuncionariocfun: TLongintField;
    qrtempUnidade: TBufDataset;
    qrtempUnidadecund: TLongintField;
    qrtempVendedor: TBufDataset;
    qrmaster_pedidovenda: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrpedidovendaAfterScroll(DataSet: TDataSet);
    procedure qrpedidovenda_itemprodutoAfterPost(DataSet: TDataSet);
    procedure qrsequenciaAfterDelete(DataSet: TDataSet);
    procedure qrsequenciaAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_pedidovenda: Tmodulo_pedidovenda;

implementation
       uses umodulo_conexaodb, upedidovenda_pesquisa;
{$R *.lfm}

       { Tmodulo_pedidovenda }

       procedure Tmodulo_pedidovenda.DataModuleCreate(Sender: TObject);
       begin

        //Abre tabelas temp
         with qrtempCliente.fieldDefs do
            begin
                  Add('ccli', ftInteger, 0, True);
            end;

         qrtempCliente.CreateDataset;

         qrtempCliente.Open;

         qrtempCliente.Append;


         with qrtempFuncionario.fieldDefs do
            begin
                  Add('cfun', ftInteger, 0, True);

            end;

         qrtempFuncionario.CreateDataset;

         qrtempFuncionario.Open;

         qrtempFuncionario.Append;



         with qrtempVendedor.fieldDefs do
            begin
                  Add('cven', ftInteger, 0, True);
            end;

         qrtempVendedor.CreateDataset;

         qrtempVendedor.Open;

         qrtempVendedor.Append;




         with qrtempUnidade.fieldDefs do
            begin
                  Add('cund', ftInteger, 0, True);
            end;

         qrtempUnidade.CreateDataset;

         qrtempUnidade.Open;

         qrtempUnidade.Append;




       end;

procedure Tmodulo_pedidovenda.qrpedidovendaAfterScroll(DataSet: TDataSet);
begin
  if frmpedidovenda_pesquisa <> nil then
     begin

       qrmaster_pedidovenda.close;
       qrmaster_pedidovenda.SQL.Clear;
       qrmaster_pedidovenda.SQL.Add('select * from tmaster_pedidovenda where controle_tpedidovenda = :controle_tpedidovenda');
       qrmaster_pedidovenda.Params.ParamByName('controle_tpedidovenda').AsInteger:=qrpedidovenda.FieldByName('controle').AsInteger;
       qrmaster_pedidovenda.Open;

       if qrmaster_pedidovenda.FieldByName('statuspedido').AsString = 'F' then
          frmpedidovenda_pesquisa.btnfecharpedido.Caption:='Forma Pagto'
       else
          frmpedidovenda_pesquisa.btnfecharpedido.Caption:='Lançar Pedido';
       //endiif



     end;
  //endi


end;

procedure Tmodulo_pedidovenda.qrpedidovenda_itemprodutoAfterPost(DataSet: TDataSet);
begin

end;

procedure Tmodulo_pedidovenda.qrsequenciaAfterDelete(DataSet: TDataSet);
begin


end;

procedure Tmodulo_pedidovenda.qrsequenciaAfterPost(DataSet: TDataSet);
begin
end;

end.

