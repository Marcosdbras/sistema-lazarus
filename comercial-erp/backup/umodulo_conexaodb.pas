unit umodulo_conexaodb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZDataset, sqldb, IBConnection, db;

type

  { Tmodulo_conexaodb }

  Tmodulo_conexaodb = class(TDataModule)
    conexaodb: TIBConnection;
    qrorcamento1CONTROLE: TLongintField;
    Script: TSQLScript;
    qrconsulta_base: TSQLQuery;
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
  var sarquivo:string;
begin


try

  //compilação windows
  sarquivo := DataDirectory+'\atualizacao\' + versao + '.sql';

  if fileexists(sarquivo) then
     begin

       Script.Script.LoadFromFile(sarquivo);
       Script.Execute;


     end;

except

end;

end;

procedure Tmodulo_conexaodb.conexaodbStartTransaction(Sender: TObject);
begin

end;

end.

