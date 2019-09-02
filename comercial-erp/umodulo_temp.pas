unit umodulo_temp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, BufDataset, db, FileUtil;

type

  { Tmodulo_temp }

  Tmodulo_temp = class(TDataModule)
    dstempEspecieAvista: TDataSource;
    dstempCstCofins: TDataSource;
    dstempCentroCusto: TDataSource;
    dstempCstIPI: TDataSource;
    dstempCsticmsDe: TDataSource;
    dstempCsticmsPara: TDataSource;
    dstempCst: TDataSource;
    dstempCstOriem: TDataSource;
    dstempCstPis: TDataSource;
    dstempEspecieAprazo: TDataSource;
    dstempPlanoContaAvista: TDataSource;
    dstempPlanoContaAprazo: TDataSource;
    qrtempCsticmsDecodigo10: TLongintField;
    qrtempCsticmsDecodigo8: TLongintField;
    qrtempCsticmsDecodigo9: TLongintField;
    qrtempEspecieAvista: TBufDataset;
    qrtempCstCofins: TBufDataset;
    qrtempCentroCusto: TBufDataset;
    qrtempCsticmsDecodigo4: TLongintField;
    qrtempCsticmsDecodigo5: TLongintField;
    qrtempCsticmsDecodigo6: TLongintField;
    qrtempCsticmsDecodigo7: TLongintField;
    qrtempCstIPI: TBufDataset;
    qrtempCsticmsDe: TBufDataset;
    qrtempCsticmsDecodigo2: TLongintField;
    qrtempCsticmsDecodigo3: TLongintField;
    qrtempCsticmsPara: TBufDataset;
    qrtempCsticmsDecodigo: TLongintField;
    qrtempCsticmsDecodigo1: TLongintField;
    qrtempCst: TBufDataset;
    qrtempCstIPIcodigo: TLongintField;
    qrtempCstOriem: TBufDataset;
    qrtempCstPis: TBufDataset;
    qrtempEspecieAprazo: TBufDataset;
    qrtempPlanoContaAvista: TBufDataset;
    qrtempPlanoContaAprazo: TBufDataset;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_temp: Tmodulo_temp;

implementation

{$R *.lfm}

{ Tmodulo_temp }

procedure Tmodulo_temp.DataModuleCreate(Sender: TObject);
begin
        with qrtempCsticmsDe.fieldDefs do
            begin
              Add('codigo', ftInteger, 0, True);
            end;

        qrtempCsticmsDe.CreateDataset;

        qrtempCsticmsDe.Open;

        qrtempCsticmsDe.Append;


        with qrtempCsticmsPara.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempCsticmsPara.CreateDataset;

        qrtempCsticmsPara.Open;

        qrtempCsticmsPara.Append;


        with qrtempCst.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempCst.CreateDataset;

        qrtempCst.Open;

        qrtempCst.Append;


        with qrtempCstCofins.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempCstCofins.CreateDataset;

        qrtempCstCofins.Open;

        qrtempCstCofins.Append;


        with qrtempCstIPI.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempCstIPI.CreateDataset;

        qrtempCstIPI.Open;

        qrtempCstIPI.Append;


        with qrtempCstOriem.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempCstOriem.CreateDataset;

        qrtempCstOriem.Open;

        qrtempCstOriem.Append;


        with qrtempCstPis.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempCstPis.CreateDataset;

        qrtempCstPis.Open;

        qrtempCstPis.Append;



        with qrtempCentroCusto.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempCentroCusto.CreateDataset;

        qrtempCentroCusto.Open;

        qrtempCentroCusto.Append;


        with qrtempEspecieAvista.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempEspecieAvista.CreateDataset;

        qrtempEspecieAvista.Open;

        qrtempEspecieAVista.Append;



        with qrtempEspecieAprazo.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempEspecieAprazo.CreateDataset;

        qrtempEspecieAprazo.Open;

        qrtempEspecieAprazo.Append;



        with qrtempPlanoContaAvista.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempPlanoContaAvista.CreateDataset;

        qrtempPlanoContaAvista.Open;

        qrtempPlanoContaAVista.Append;


        with qrtempPlanoContaAprazo.fieldDefs do
           begin
             Add('codigo', ftInteger, 0, True);
           end;

        qrtempPlanoContaAprazo.CreateDataset;

        qrtempPlanoContaAprazo.Open;

        qrtempPlanoContaAprazo.Append;



end;

end.

