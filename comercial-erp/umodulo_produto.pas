unit umodulo_produto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_produto }

  Tmodulo_produto = class(TDataModule)
    dscest: TDataSource;
    dstempProduto: TDataSource;
    dsproduto: TDataSource;
    qrprodutoALIQUOTAICMSECF: TBCDField;
    qrprodutoALIQUOTAISS: TBCDField;
    qrprodutoAPLICACAOPRODUTO: TStringField;
    qrprodutoATIVO: TStringField;
    qrprodutoBASECALCULOICMSSTRETIDO: TBCDField;
    qrprodutoCAMPO1: TStringField;
    qrprodutoCAMPO10: TStringField;
    qrprodutoCAMPO2: TStringField;
    qrprodutoCAMPO3: TStringField;
    qrprodutoCAMPO4: TStringField;
    qrprodutoCAMPO5: TStringField;
    qrprodutoCAMPO6: TStringField;
    qrprodutoCAMPO7: TStringField;
    qrprodutoCAMPO8: TStringField;
    qrprodutoCAMPO9: TStringField;
    qrprodutoCEST: TStringField;
    qrprodutoCFOP: TStringField;
    qrprodutoCNPJFABRICANTE: TStringField;
    qrprodutoCODAPLICACAOPRODUTO: TStringField;
    qrprodutoCODBARRAS: TStringField;
    qrprodutoCODBENEFICIOFISCAL: TStringField;
    qrprodutoCODCOMPRA: TLongintField;
    qrprodutoCODCSTORIGEM: TLongintField;
    qrprodutoCODEMITENTE: TLongintField;
    qrprodutoCODFORNECEDOR: TLongintField;
    qrprodutoCODGRUPO: TLongintField;
    qrprodutoCODIGOANP: TStringField;
    qrprodutoCODIGOCSTORIGEM: TLongintField;
    qrprodutoCODIGOENQUADRAMENTOIPI: TStringField;
    qrprodutoCODIMPOSTOMEDIO: TLongintField;
    qrprodutoCODMARCA: TLongintField;
    qrprodutoCODMENSAGEMNFE: TLongintField;
    qrprodutoCODSUBGRUPO: TLongintField;
    qrprodutoCODTABELAPRECO: TLongintField;
    qrprodutoCODTRIBUTACAOCOFINS: TStringField;
    qrprodutoCODTRIBUTACAOIPI: TStringField;
    qrprodutoCODTRIBUTACAOPIS: TStringField;
    qrprodutoCODUNIDADEMEDIDA: TLongintField;
    qrprodutoCONTROLARVALIDADE: TStringField;
    qrprodutoCONTROLE: TLongintField;
    qrprodutoCSOSN: TStringField;
    qrprodutoCUSTOMEDIO: TBCDField;
    qrprodutoCUSTOULTIMACOMPRA: TBCDField;
    qrprodutoDATAHORACADASTRO: TDateTimeField;
    qrprodutoDATAULTIMACOMPRA: TDateField;
    qrprodutoDATAULTIMAVENDA: TDateField;
    qrprodutoDESCRICAOANP: TStringField;
    qrprodutoDESCRICAOCOMPLEMENTAR: TStringField;
    qrprodutoDESCRICAOCSOSN: TStringField;
    qrprodutoDIASVALIDADEPRODUTO: TLongintField;
    qrprodutoFATORCONVERSAO: TStringField;
    qrprodutoFATORCONVERSAOETIQUETA: TBCDField;
    qrprodutoFORNECEDOR: TStringField;
    qrprodutoFOTO: TBlobField;
    qrprodutoGRUPO: TStringField;
    qrprodutoIAT: TStringField;
    qrprodutoIPPT: TStringField;
    qrprodutoISENTO: TStringField;
    qrprodutoMARCA: TStringField;
    qrprodutoMD5: TStringField;
    qrprodutoMD5E2: TStringField;
    qrprodutoMENSAGEMNFE: TStringField;
    qrprodutoNCM: TStringField;
    qrprodutoNOMETABELAPRECO: TStringField;
    qrprodutoOBS: TMemoField;
    qrprodutoORIGEM: TStringField;
    qrprodutoPERCCOFINS: TBCDField;
    qrprodutoPERCCOMISSAO: TBCDField;
    qrprodutoPERCGLPCOMB: TBCDField;
    qrprodutoPERCGNICOMB: TBCDField;
    qrprodutoPERCGNNCOMB: TBCDField;
    qrprodutoPERCICMSPROPRIOST: TBCDField;
    qrprodutoPERCICMSSTINTERNA: TBCDField;
    qrprodutoPERCIMPOSTOMEDIO: TBCDField;
    qrprodutoPERCIMPOSTOMEDIOESTADUAL: TBCDField;
    qrprodutoPERCIMPOSTOMEDIOMUNICIPAL: TBCDField;
    qrprodutoPERCIPI: TBCDField;
    qrprodutoPERCLUCRO: TBCDField;
    qrprodutoPERCMAXIMODESCONTO: TBCDField;
    qrprodutoPERCMVAORIGINAL: TBCDField;
    qrprodutoPERCPIS: TBCDField;
    qrprodutoPERCREDITOCICMS: TBCDField;
    qrprodutoPERCREDUCAOBC: TBCDField;
    qrprodutoPERCREDUCAOBCST: TBCDField;
    qrprodutoPESADO: TStringField;
    qrprodutoPESO: TBCDField;
    qrprodutoPOSSUIICMSST: TStringField;
    qrprodutoPRECOCUSTO: TBCDField;
    qrprodutoPRECOMINIMO: TBCDField;
    qrprodutoPRECOMINIMOUSS: TBCDField;
    qrprodutoPRECOREVENDA: TBCDField;
    qrprodutoPRECOVENDA: TBCDField;
    qrprodutoPRECOVENDAUSS: TBCDField;
    qrprodutoPRODUTO: TStringField;
    qrprodutoQTDE: TBCDField;
    qrprodutoQTDEEMPRODUCAO: TBCDField;
    qrprodutoQTDEEMPRODUCAOMP: TBCDField;
    qrprodutoQTDEINICIAL: TBCDField;
    qrprodutoQTDEMAXIMA: TBCDField;
    qrprodutoQTDEMINIMA: TBCDField;
    qrprodutoQTDEPEDIDOCOMPRA: TBCDField;
    qrprodutoQTDEPEDIDOVENDA: TBCDField;
    qrprodutoQTDEREAL: TBCDField;
    qrprodutoQTDERESERVADA: TBCDField;
    qrprodutoQTDETOTALCOMPRADA: TBCDField;
    qrprodutoQTDETOTALVENDIDA: TBCDField;
    qrprodutoREDUCAOBASECALCULOSERVICO: TBCDField;
    qrprodutoREFERENCIA: TStringField;
    qrprodutoSTATUS: TStringField;
    qrprodutoSUBGRUPO: TStringField;
    qrprodutoTAMANHO: TStringField;
    qrprodutoTIPOBARRA: TStringField;
    qrprodutoTIPOTRIBUTACAO: TStringField;
    qrprodutoTRIBUTACAOCOFINS: TStringField;
    qrprodutoTRIBUTACAOIPI: TStringField;
    qrprodutoTRIBUTACAOPIS: TStringField;
    qrprodutoTRIBUTACAOSERVICO: TStringField;
    qrprodutoTRIBUTADO: TStringField;
    qrprodutoUNIDADE: TStringField;
    qrprodutoUNIDADECONVERSAOVENDA: TStringField;
    qrprodutoUNIDADEMEDIDAETIQUETA: TStringField;
    qrprodutoUSAGRADE: TStringField;
    qrprodutoUSASERIAL: TStringField;
    qrprodutoVALORCOMISSAOFIXO: TBCDField;
    qrprodutoVALORCONVERSAO: TFMTBCDField;
    qrprodutoVALORCONVERSAOVENDA: TFMTBCDField;
    qrprodutoVALORFRETE: TBCDField;
    qrprodutoVALORICMSST: TBCDField;
    qrprodutoVALORICMSSTRETIDO: TBCDField;
    qrprodutoVALORIPI: TBCDField;
    qrprodutoVALOROUTROS: TBCDField;
    qrprodutoVALORPARTIDACOMB: TBCDField;
    qrprodutoVALORUNITARIOCOMPRA: TBCDField;
    qrtempProduto: TBufDataset;
    qrtempProdutocund: TLongintField;
    qrproduto: TSQLQuery;
    qrcest: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure dsprodutoDataChange(Sender: TObject; Field: TField);
  private

  public
    function localizaControle(controle:string):integer;
    function localizaDescricao(descricao:string):integer;
    function localizaCodBarra(codbarra:string):integer;
    function localizaCampo(dado:string):integer;


  end;

var
  modulo_produto: Tmodulo_produto;

implementation

{$R *.lfm}

{ Tmodulo_produto }

procedure Tmodulo_produto.DataModuleCreate(Sender: TObject);
begin
           with qrtempProduto.fieldDefs do
              begin
                Add('cprod', ftInteger, 0, True);
              end;

         qrtempProduto.CreateDataset;

         qrtempProduto.Open;

         qrtempProduto.Append;

end;

procedure Tmodulo_produto.dsprodutoDataChange(Sender: TObject; Field: TField);
begin

end;



function Tmodulo_produto.localizaControle(controle:string):integer;
var
  Num   :String;
  Code  :byte;
  Valor :real;

begin


      Num := controle;

      val(Num,Valor,Code);

      if Code <> 0 then
         begin
           result := 0;
           exit;
         end;
      //endi

      qrproduto.Close;
      qrproduto.SQL.Clear;
      qrproduto.SQL.Add('select * from testoque where (controle = :controle) and (ativo = :ativo)');
      qrproduto.ParamByName('controle').AsInteger:=strtoint(controle);
      qrproduto.ParamByName('ativo').AsString:='SIM';
      qrproduto.Open;

      result:= qrproduto.recordcount;





end;



function Tmodulo_produto.localizaDescricao(descricao:string):integer;
begin



      qrproduto.Close;
      qrproduto.SQL.Clear;
      qrproduto.SQL.Add('select * from testoque where (produto like :produto) and (ativo = :ativo)');
      qrproduto.ParamByName('produto').AsString:='%'+descricao+'%';
      qrproduto.ParamByName('ativo').AsString:='SIM';
      qrproduto.Open;

      result:= qrproduto.recordcount;





end;


function Tmodulo_produto.localizaCodBarra(codbarra:string):integer;
begin


      qrproduto.Close;
      qrproduto.SQL.Clear;
      qrproduto.SQL.Add('select * from testoque where (codbarras = :codbarras) and (ativo = :ativo)');
      qrproduto.ParamByName('codbarras').AsString:=codbarra;
      qrproduto.ParamByName('ativo').AsString:='SIM';
      qrproduto.Open;

      result:= qrproduto.recordcount;




end;


function Tmodulo_produto.localizaCampo(dado:string):integer;
  begin



        qrproduto.Close;
        qrproduto.SQL.Clear;
        qrproduto.SQL.Add('select * from testoque where (campo1 like :campo) and (ativo = :ativo)');
        qrproduto.ParamByName('campo').AsString:='%'+dado+'%';
        qrproduto.ParamByName('ativo').AsString:='SIM';
        qrproduto.Open;

        result:= qrproduto.recordcount;





  end;


end.

