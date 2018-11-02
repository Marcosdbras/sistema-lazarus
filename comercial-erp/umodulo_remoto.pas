unit umodulo_remoto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, FileUtil;

type

  { Tmodulo_remoto }

  Tmodulo_remoto = class(TDataModule)
    qrconsulta_base_remoto: TSQLQuery;
    qrexec_base_remoto: TSQLQuery;





  private


  public

  end;

var
  modulo_remoto: Tmodulo_remoto;

implementation
      uses umodulo_conexaodb;
{$R *.lfm}

      { Tmodulo_remoto }





end.

