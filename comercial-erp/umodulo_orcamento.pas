unit umodulo_orcamento;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, db, BufDataset, sqldb;

type

  { Tmodulo_orcamento }

  Tmodulo_orcamento = class(TDataModule)
    dsorcamento_itemproduto: TDataSource;
    dsorcamento: TDataSource;
    dstempCliente: TDataSource;
    dstempFuncionario: TDataSource;
    dstempVendedor: TDataSource;
    qrorcamento: TSQLQuery;
    qrorcamentoACRESCIMO: TBCDField;
    qrorcamentoBAIRRO: TStringField;
    qrorcamentoCANCELADO: TStringField;
    qrorcamentoCELULAR: TStringField;
    qrorcamentoCEP: TStringField;
    qrorcamentoCIDADE: TStringField;
    qrorcamentoCNPJ: TStringField;
    qrorcamentoCODCLIENTE: TLongintField;
    qrorcamentoCODFUNCIONARIO: TLongintField;
    qrorcamentoCODNFE: TLongintField;
    qrorcamentoCODSEQUENCIA: TLongintField;
    qrorcamentoCODVENDEDOR: TLongintField;
    qrorcamentoCOMPLEMENTO: TStringField;
    qrorcamentoCONDICAOPAGAMENTO: TMemoField;
    qrorcamentoCONTROLE: TLongintField;
    qrorcamentoCONTROLEVARCHAR: TStringField;
    qrorcamentoCOO: TLongintField;
    qrorcamentoCOOVINCULADO: TLongintField;
    qrorcamentoCPF: TStringField;
    qrorcamentoDATA: TDateField;
    qrorcamentoDATAFATURADA: TDateField;
    qrorcamentoDATAHORACADASTRO: TDateTimeField;
    qrorcamentoDATAVENCIMENTO: TDateField;
    qrorcamentoDESCONTO: TBCDField;
    qrorcamentoDIASVENCIMENTO: TLongintField;
    qrorcamentoEMAIL: TStringField;
    qrorcamentoENDERECO: TStringField;
    qrorcamentoFUNCIONARIO: TStringField;
    qrorcamentoHORA: TTimeField;
    qrorcamentoINDICADOR: TStringField;
    qrorcamentoMARCAECF: TStringField;
    qrorcamentoMD5DAV: TStringField;
    qrorcamentoMESCLAR: TStringField;
    qrorcamentoMODELOECF: TStringField;
    qrorcamentoNOMECLIENTE: TStringField;
    qrorcamentoNUMERO: TStringField;
    qrorcamentoNUMEROECF: TLongintField;
    qrorcamentoOBSERVACAO: TMemoField;
    qrorcamentoRG: TStringField;
    qrorcamentoSERIEECF: TStringField;
    qrorcamentoSTATUS: TStringField;
    qrorcamentoTELEFONE: TStringField;
    qrorcamentoTIPOCLIENTE: TStringField;
    qrorcamentoTIPODESCONTO: TStringField;
    qrorcamentoTIPOECF: TStringField;
    qrorcamentoTITULODAV: TStringField;
    qrorcamentoUF: TStringField;
    qrorcamentoVALOR: TBCDField;
    qrorcamentoVALORTOTAL: TBCDField;
    qrorcamentoVENDEDOR: TStringField;
    qrorcamento_itemproduto: TSQLQuery;
    qrorcamento_itemprodutoALIQUOTA: TBCDField;
    qrorcamento_itemprodutoCFOP: TStringField;
    qrorcamento_itemprodutoCODAPLICACAOPRODUTO: TLongintField;
    qrorcamento_itemprodutoCODITEM: TLongintField;
    qrorcamento_itemprodutoCODORCAMENTO: TLongintField;
    qrorcamento_itemprodutoCODPRODUTO: TLongintField;
    qrorcamento_itemprodutoCONTROLE: TLongintField;
    qrorcamento_itemprodutoCONTROLEORIGEMMESCLAGEM: TLongintField;
    qrorcamento_itemprodutoDATAHORACADASTRO: TDateTimeField;
    qrorcamento_itemprodutoDECIMAISQTDE: TLongintField;
    qrorcamento_itemprodutoDECIMAISVALORUNITARIO: TLongintField;
    qrorcamento_itemprodutoDESCRICAOCOMPLEMENTAR: TStringField;
    qrorcamento_itemprodutoINDICADORCANCELAMENTO: TStringField;
    qrorcamento_itemprodutoMD5DAV: TStringField;
    qrorcamento_itemprodutoMESCLAR: TStringField;
    qrorcamento_itemprodutoNUMERODAV: TStringField;
    qrorcamento_itemprodutoPERCACRESCIMOUNITARIO: TBCDField;
    qrorcamento_itemprodutoPERCDESCONTOUNITARIO: TBCDField;
    qrorcamento_itemprodutoPRODUTO: TStringField;
    qrorcamento_itemprodutoQTDE: TBCDField;
    qrorcamento_itemprodutoQTDE2: TBCDField;
    qrorcamento_itemprodutoQTDECONVERTIDA: TBCDField;
    qrorcamento_itemprodutoREFERENCIA: TStringField;
    qrorcamento_itemprodutoSITUACAOTRIBUTARIA: TStringField;
    qrorcamento_itemprodutoSTATUS: TStringField;
    qrorcamento_itemprodutoTOTALACRESCIMO: TBCDField;
    qrorcamento_itemprodutoTOTALDESCONTO: TBCDField;
    qrorcamento_itemprodutoTOTALLIQUIDO: TBCDField;
    qrorcamento_itemprodutoUN: TStringField;
    qrorcamento_itemprodutoUNCONVERTIDA: TStringField;
    qrorcamento_itemprodutoVALORACRESCIMOUNITARIO: TBCDField;
    qrorcamento_itemprodutoVALORDESCONTOUNITARIO: TBCDField;
    qrorcamento_itemprodutoVALORUNITARIO: TBCDField;
    qrorcamento_itemprodutoVALORUNITARIO2: TBCDField;
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
    qrtempVendedor: TBufDataset;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrorcamentoAfterScroll(DataSet: TDataSet);
    procedure qrsequenciaAfterDelete(DataSet: TDataSet);
    procedure qrsequenciaAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_orcamento: Tmodulo_orcamento;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

       { Tmodulo_orcamento }

       procedure Tmodulo_orcamento.DataModuleCreate(Sender: TObject);
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






       end;

procedure Tmodulo_orcamento.qrorcamentoAfterScroll(DataSet: TDataSet);
begin



end;

procedure Tmodulo_orcamento.qrsequenciaAfterDelete(DataSet: TDataSet);
begin


end;

procedure Tmodulo_orcamento.qrsequenciaAfterPost(DataSet: TDataSet);
begin
end;

end.

