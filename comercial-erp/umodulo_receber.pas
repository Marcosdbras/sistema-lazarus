unit umodulo_receber;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_receber }

  Tmodulo_receber = class(TDataModule)
    dsReceber: TDataSource;
    dsMasterReceber: TDataSource;
    dstempReceber: TDataSource;
    dstempMasterReceber: TDataSource;
    qrMasterReceberCLIENTE: TStringField;
    qrMasterReceberCODBARRA: TStringField;
    qrMasterReceberCODCLIENTE: TLongintField;
    qrMasterReceberCODESPECIE: TLongintField;
    qrMasterReceberCODFUNCIONARIO: TLongintField;
    qrMasterReceberCODIGO: TLongintField;
    qrMasterReceberCODPEDIDOVENDA: TLongintField;
    qrMasterReceberCODPLANOCONTA: TLongintField;
    qrMasterReceberCODVENDEDOR: TLongintField;
    qrMasterReceberDATAHORACADASTRO: TDateTimeField;
    qrMasterReceberDATAVENCIMENTO: TDateField;
    qrMasterReceberDESCRICAOLANCAMENTO: TStringField;
    qrMasterReceberDOCUMENTO: TStringField;
    qrMasterReceberESPECIE: TStringField;
    qrMasterReceberFUNCIONARIO: TStringField;
    qrMasterReceberNPARCELA: TLongintField;
    qrMasterReceberOBS: TMemoField;
    qrMasterReceberORIGEM: TStringField;
    qrMasterReceberPLANOCONTA: TStringField;
    qrMasterReceberPRAZO: TLongintField;
    qrMasterReceberQTDEPARCELA: TLongintField;
    qrMasterReceberREPLICADA: TStringField;
    qrMasterReceberSTATUS: TStringField;
    qrMasterReceberVALORORIGINAL: TBCDField;
    qrMasterReceberVENDEDOR: TStringField;
    qrReceber: TSQLQuery;
    qrMasterReceber: TSQLQuery;
    qrtempReceber: TBufDataset;
    qrtempMasterReceber: TBufDataset;
    StringField1: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dstempMasterReceberDataChange(Sender: TObject; Field: TField);
    procedure qrMasterReceberAfterPost(DataSet: TDataSet);
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
                 Add('creceber', ftInteger, 0, True);
           end;

        qrtempReceber.CreateDataset;

        qrtempReceber.Open;

        qrtempReceber.Append;




        with qrtempMasterReceber.fieldDefs do
           begin
                 Add('cmasterreceber', ftInteger, 0, True);
           end;

        qrtempMasterReceber.CreateDataset;

        qrtempMasterReceber.Open;

        qrtempMasterReceber.Append;








      end;

procedure Tmodulo_receber.dstempMasterReceberDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure Tmodulo_receber.qrMasterReceberAfterPost(DataSet: TDataSet);
begin

end;

procedure Tmodulo_receber.qrReceberAfterScroll(DataSet: TDataSet);
begin
end;

end.

