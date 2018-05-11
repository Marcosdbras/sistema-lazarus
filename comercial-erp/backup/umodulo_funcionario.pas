unit umodulo_funcionario;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_funcionario }

  Tmodulo_funcionario = class(TDataModule)
    dsfuncionario: TDataSource;
    dstemp: TDataSource;
    qrfuncionario: TSQLQuery;
    qrtemp: TBufDataset;
    qrtempccli: TLongintField;
    qrtempcfun: TLongintField;
    qrtempcontrole: TAutoIncField;
    qrtempcven: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  modulo_funcionario: Tmodulo_funcionario;

implementation
        uses umodulo_conexaodb;
{$R *.lfm}

        { Tmodulo_funcionario }

        procedure Tmodulo_funcionario.DataModuleCreate(Sender: TObject);
        begin

          with qrtemp.fieldDefs do
             begin
                   Add('cfun', ftInteger, 0, True);
                   Add('cven', ftInteger, 0, True);
             end;

          qrtemp.CreateDataset;

          qrtemp.Open;

          qrtemp.Append;




        end;

end.

