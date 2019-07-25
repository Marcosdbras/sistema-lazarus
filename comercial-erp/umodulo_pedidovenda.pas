unit umodulo_pedidovenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, db, BufDataset, sqldb;

type

  { Tmodulo_pedidovenda }

  Tmodulo_pedidovenda = class(TDataModule)
    dspedidovenda_itemproduto: TDataSource;
    dspedidovenda: TDataSource;
    dstempCliente: TDataSource;
    dstempFuncionario: TDataSource;
    dstempUnidade: TDataSource;
    dstempVendedor: TDataSource;
    qrpedidovenda: TSQLQuery;
    qrpedidovendaACRESCIMO: TBCDField;
    qrpedidovendaBAIRRO: TStringField;
    qrpedidovendaCANCELADO: TStringField;
    qrpedidovendaCELULAR: TStringField;
    qrpedidovendaCEP: TStringField;
    qrpedidovendaCIDADE: TStringField;
    qrpedidovendaCNPJ: TStringField;
    qrpedidovendaCODCLIENTE: TLongintField;
    qrpedidovendaCODFUNCIONARIO: TLongintField;
    qrpedidovendaCODNFE: TLongintField;
    qrpedidovendaCODSEQUENCIA: TLongintField;
    qrpedidovendaCODVENDEDOR: TLongintField;
    qrpedidovendaCOMPLEMENTO: TStringField;
    qrpedidovendaCONDICAOPAGAMENTO: TMemoField;
    qrpedidovendaCONTROLE: TLongintField;
    qrpedidovendaCONTROLEVARCHAR: TStringField;
    qrpedidovendaCOO: TLongintField;
    qrpedidovendaCOOVINCULADO: TLongintField;
    qrpedidovendaCPF: TStringField;
    qrpedidovendaDATA: TDateField;
    qrpedidovendaDATAFATURADA: TDateField;
    qrpedidovendaDATAHORACADASTRO: TDateTimeField;
    qrpedidovendaDATAVENCIMENTO: TDateField;
    qrpedidovendaDESCONTO: TBCDField;
    qrpedidovendaDIASVENCIMENTO: TLongintField;
    qrpedidovendaEMAIL: TStringField;
    qrpedidovendaENDERECO: TStringField;
    qrpedidovendaFUNCIONARIO: TStringField;
    qrpedidovendaHORA: TTimeField;
    qrpedidovendaINDICADOR: TStringField;
    qrpedidovendaMARCAECF: TStringField;
    qrpedidovendaMD5DAV: TStringField;
    qrpedidovendaMESCLAR: TStringField;
    qrpedidovendaMODELOECF: TStringField;
    qrpedidovendaNOMECLIENTE: TStringField;
    qrpedidovendaNUMERO: TStringField;
    qrpedidovendaNUMEROECF: TLongintField;
    qrpedidovendaOBSERVACAO: TMemoField;
    qrpedidovendaRG: TStringField;
    qrpedidovendaSERIEECF: TStringField;
    qrpedidovendaSTATUS: TStringField;
    qrpedidovendaTELEFONE: TStringField;
    qrpedidovendaTIPOCLIENTE: TStringField;
    qrpedidovendaTIPODESCONTO: TStringField;
    qrpedidovendaTIPOECF: TStringField;
    qrpedidovendaTITULODAV: TStringField;
    qrpedidovendaUF: TStringField;
    qrpedidovendaVALOR: TBCDField;
    qrpedidovendaVALORTOTAL: TBCDField;
    qrpedidovendaVENDEDOR: TStringField;
    qrpedidoenda_itemproduto: TSQLQuery;
    qrpedidoenda_itemprodutoALIQUOTA: TBCDField;
    qrpedidoenda_itemprodutoCFOP: TStringField;
    qrpedidoenda_itemprodutoCODAPLICACAOPRODUTO: TLongintField;
    qrpedidoenda_itemprodutoCODITEM: TLongintField;
    qrpedidoenda_itemprodutoCODORCAMENTO: TLongintField;
    qrpedidoenda_itemprodutoCODPRODUTO: TLongintField;
    qrpedidoenda_itemprodutoCONTROLE: TLongintField;
    qrpedidoenda_itemprodutoCONTROLEORIGEMMESCLAGEM: TLongintField;
    qrpedidoenda_itemprodutoDATAHORACADASTRO: TDateTimeField;
    qrpedidoenda_itemprodutoDECIMAISQTDE: TLongintField;
    qrpedidoenda_itemprodutoDECIMAISVALORUNITARIO: TLongintField;
    qrpedidoenda_itemprodutoDESCRICAOCOMPLEMENTAR: TStringField;
    qrpedidoenda_itemprodutoINDICADORCANCELAMENTO: TStringField;
    qrpedidoenda_itemprodutoMD5DAV: TStringField;
    qrpedidoenda_itemprodutoMESCLAR: TStringField;
    qrpedidoenda_itemprodutoNUMERODAV: TStringField;
    qrpedidoenda_itemprodutoPERCACRESCIMOUNITARIO: TBCDField;
    qrpedidoenda_itemprodutoPERCDESCONTOUNITARIO: TBCDField;
    qrpedidoenda_itemprodutoPRODUTO: TStringField;
    qrpedidoenda_itemprodutoQTDE: TBCDField;
    qrpedidoenda_itemprodutoQTDE2: TBCDField;
    qrpedidoenda_itemprodutoQTDECONVERTIDA: TBCDField;
    qrpedidoenda_itemprodutoREFERENCIA: TStringField;
    qrpedidoenda_itemprodutoSITUACAOTRIBUTARIA: TStringField;
    qrpedidoenda_itemprodutoSTATUS: TStringField;
    qrpedidoenda_itemprodutoTOTALACRESCIMO: TBCDField;
    qrpedidoenda_itemprodutoTOTALDESCONTO: TBCDField;
    qrpedidoenda_itemprodutoTOTALLIQUIDO: TBCDField;
    qrpedidoenda_itemprodutoUN: TStringField;
    qrpedidoenda_itemprodutoUNCONVERTIDA: TStringField;
    qrpedidoenda_itemprodutoVALORACRESCIMOUNITARIO: TBCDField;
    qrpedidoenda_itemprodutoVALORDESCONTOUNITARIO: TBCDField;
    qrpedidoenda_itemprodutoVALORUNITARIO: TBCDField;
    qrpedidoenda_itemprodutoVALORUNITARIO2: TBCDField;
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
    procedure DataModuleCreate(Sender: TObject);
    procedure qrpedidovendaAfterScroll(DataSet: TDataSet);
    procedure qrpedidoenda_itemprodutoAfterPost(DataSet: TDataSet);
    procedure qrsequenciaAfterDelete(DataSet: TDataSet);
    procedure qrsequenciaAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_pedidovenda: Tmodulo_pedidovenda;

implementation
       uses umodulo_conexaodb;
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



end;

procedure Tmodulo_pedidovenda.qrpedidoenda_itemprodutoAfterPost(DataSet: TDataSet);
begin

end;

procedure Tmodulo_pedidovenda.qrsequenciaAfterDelete(DataSet: TDataSet);
begin


end;

procedure Tmodulo_pedidovenda.qrsequenciaAfterPost(DataSet: TDataSet);
begin
end;

end.

