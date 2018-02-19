unit uprincipal_conexao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection;

type

  { Tfrmprincipal_conexao }

  Tfrmprincipal_conexao = class(TDataModule)
    conexaodb: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  frmprincipal_conexao: Tfrmprincipal_conexao;

implementation
       uses ufuncao_cria_ini;
{$R *.lfm}

{ Tfrmprincipal_conexao }

procedure Tfrmprincipal_conexao.DataModuleCreate(Sender: TObject);
begin
  GravarINIBD('localhost','C:\SGBR\Master\BASESGMASTER.FDB','3050','masterkey','SYSDBA','firebirdd-2.5');
end;

end.

