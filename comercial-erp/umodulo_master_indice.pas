unit umodulo_master_indice;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_master_indice }

  Tmodulo_master_indice = class(TDataModule)
    dsmaster_indice: TDataSource;
    dstempMaster_Indice: TDataSource;
    qrmaster_indice: TSQLQuery;
    qrtempMaster_Indice: TBufDataset;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_master_indice: Tmodulo_master_indice;

implementation

{$R *.lfm}

{ Tmodulo_master_indice }

procedure Tmodulo_master_indice.DataModuleCreate(Sender: TObject);
begin

end;

end.

