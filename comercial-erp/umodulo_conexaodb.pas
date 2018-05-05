unit umodulo_conexaodb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, sqldb, sqldblib,
  IBConnection, db, BufDataset, Dbf, Dbf_Common;

type

  { Tmodulo_conexaodb }

  Tmodulo_conexaodb = class(TDataModule)
    conexaodb: TIBConnection;
    qrorcamento1CONTROLE: TLongintField;
    qrtempccli: TLongintField;
    qrtempcfun: TLongintField;
    qrtempcontrole: TAutoIncField;
    qrtempcven: TLongintField;
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




end;

procedure Tmodulo_conexaodb.conexaodbStartTransaction(Sender: TObject);
begin

end;

end.

