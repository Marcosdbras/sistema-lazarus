unit umodulo_geral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil;

type

  { Tmodulo_geral }

  Tmodulo_geral = class(TDataModule)
    qrmaster_indice: TSQLQuery;
  private

  public

  end;

var
  modulo_geral: Tmodulo_geral;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

end.

