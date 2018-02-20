unit umodulo_conexaodb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection;

type

  { Tmodulo_conexaodb }

  Tmodulo_conexaodb = class(TDataModule)
    conexaodb: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_conexaodb: Tmodulo_conexaodb;

implementation

{$R *.lfm}

{ Tmodulo_conexaodb }

procedure Tmodulo_conexaodb.DataModuleCreate(Sender: TObject);
begin

end;

end.

