unit umodulo_usuario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_usuario }

  Tmodulo_usuario = class(TDataModule)
    dsusuario: TDataSource;
    dsusuario_lista: TDataSource;
    qrusuario: TSQLQuery;
    qrusuario_lista: TSQLQuery;
  private

  public

  end;

var
  modulo_usuario: Tmodulo_usuario;

implementation

{$R *.lfm}

end.

