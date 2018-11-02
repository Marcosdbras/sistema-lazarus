unit umodulo_emitente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil;

type

  { Tmodulo_emitente }

  Tmodulo_emitente = class(TDataModule)
    qremitente: TSQLQuery;
  private

  public

  end;

var
  modulo_emitente: Tmodulo_emitente;

implementation
      uses umodulo_conexaodb, ufuncao_conexaodb;
{$R *.lfm}

end.

