unit uvendaorc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls;

type

  { Tfrmvendaorc }

  Tfrmvendaorc = class(TForm)
    btnexportar: TButton;
    btncancelar: TButton;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    procedure btncancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmvendaorc: Tfrmvendaorc;

implementation
    uses umodulo_conexaodb, umodulo_vendaorc, ufuncao_geral;
{$R *.lfm}

    { Tfrmvendaorc }

    procedure Tfrmvendaorc.btncancelarClick(Sender: TObject);
    begin
      close;
    end;

procedure Tfrmvendaorc.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
   modulo_conexaodb.conexaodb_Aux.Connected:=false;
end;

procedure Tfrmvendaorc.FormCreate(Sender: TObject);
begin
   with modulo_vendaorc do
     begin

       qrvendaorc.close;
       qrvendaorc.SQL.Clear;
       qrvendaorc.SQL.Add('select v.ccli, v.total, c.nome from svenda v left join clientes c on v.ccli = c.codigo');
       qrvendaorc.Open;

     end;
   //end
end;

end.

