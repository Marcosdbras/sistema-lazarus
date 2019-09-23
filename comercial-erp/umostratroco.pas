unit umostratroco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { Tfrmmostratroco }

  Tfrmmostratroco = class(TForm)
    btnok: TBitBtn;
    Label17: TLabel;
    lbltroco: TLabel;
    procedure btnokClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmmostratroco: Tfrmmostratroco;

implementation
         uses ufechapedidovenda, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmmostratroco }

procedure Tfrmmostratroco.btnokClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmmostratroco.FormCreate(Sender: TObject);
begin
       //modulo_conexaodb.qrconsulta_base.Close;
       //modulo_conexaodb.qrconsulta_base.SQL.Clear;
       //modulo_conexaodb.qrconsulta_base.SQL.Add('select * from tmaster_pedidovenda where controle_tpedidovenda = :controle_tpedidovenda');
       //formatfloat('###,###,##0.00',frmfechapedidovenda.ftroco);
end;

end.

