unit umodulo_temp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, BufDataset, db, FileUtil;

type

  { Tmodulo_temp }

  Tmodulo_temp = class(TDataModule)
    dstempCsticmsDe: TDataSource;
    dstempCsticmsPara: TDataSource;
    qrtempCsticmsDe: TBufDataset;
    qrtempCsticmsPara: TBufDataset;
    qrtempCsticmsDecodigo: TLongintField;
    qrtempCsticmsDecodigo1: TLongintField;
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




end;

end.

