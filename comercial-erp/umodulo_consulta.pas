unit umodulo_consulta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_consulta }

  Tmodulo_consulta = class(TDataModule)
    dsptotalporespecie: TDataSource;
    dspcaixadinheiro: TDataSource;
    qrcaixatdinheiro: TSQLQuery;
    qrtotalporespecie: TSQLQuery;
    qrtotalporespecieCOALESCE: TStringField;
    qrtotalporespecieCODESPECIE: TLongintField;
    qrtotalporespecieCONTROLE: TLongintField;
    qrtotalporespecieESPECIE: TStringField;
    qrtotalporespecieTOTALTIPOPGTO: TBCDField;
  private

  public

  end;

var
  modulo_consulta: Tmodulo_consulta;

implementation

{$R *.lfm}

end.

