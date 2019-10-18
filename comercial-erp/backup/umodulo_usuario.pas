unit umodulo_usuario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_usuario }

  Tmodulo_usuario = class(TDataModule)
    dsusuario: TDataSource;
    qrusuario: TSQLQuery;
  private

  public

  end;

var
  modulo_usuario: Tmodulo_usuario;

implementation

{$R *.lfm}

end.

