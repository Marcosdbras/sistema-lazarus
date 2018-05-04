unit umodulo_conexaodb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, sqldb, sqldblib,
  IBConnection, db, BufDataset, Dbf, Dbf_Common;

type

  { Tmodulo_conexaodb }

  Tmodulo_conexaodb = class(TDataModule)
    dstemp: TDataSource;
    qrtemp: TBufDataset;
    conexaodb: TIBConnection;
    qrorcamento1CONTROLE: TLongintField;
    qrtempccli: TLongintField;
    qrtempcontrole: TAutoIncField;
    Script: TSQLScript;
    qrconsulta_base: TSQLQuery;
    qrexec_base: TSQLQuery;
    tzcontrole: TSQLTransaction;
    procedure conexaodbStartTransaction(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_conexaodb: Tmodulo_conexaodb;

implementation
   uses ufuncao_geral;
{$R *.lfm}

{ Tmodulo_conexaodb }

procedure Tmodulo_conexaodb.DataModuleCreate(Sender: TObject);
begin
  with qrtemp.fieldDefs do
    begin
      Add('controle', ftAutoInc, 0, True);
      Add('ccli', ftInteger, 0, True);
      Add('cfun', ftInteger, 0, True);
      Add('cven', ftInteger, 0, True);



    end;

  qrtemp.CreateDataset;

  qrtemp.Open;

  qrtemp.Append;

  qrtemp.FieldByName('ccli').AsInteger:=0;
  qrtemp.FieldByName('cfun').AsInteger:=0;
  qrtemp.FieldByName('cven').AsInteger:=0;



end;

procedure Tmodulo_conexaodb.conexaodbStartTransaction(Sender: TObject);
begin

end;

end.

