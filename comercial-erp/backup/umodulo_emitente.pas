unit umodulo_emitente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    SQLQuery1: TSQLQuery;
  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation
      uses umodulo_conexaodb, ufuncao_conexaodb;
{$R *.lfm}

end.

