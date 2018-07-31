unit uajusteprodutos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls;

type

  { Tfrmajusteprodutos }

  Tfrmajusteprodutos = class(TForm)
    btngravartodos: TButton;
    btncancelar: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btncancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmajusteprodutos: Tfrmajusteprodutos;

implementation
     uses umodulo_temp, umodulo_produto;
{$R *.lfm}

{ Tfrmajusteprodutos }

procedure Tfrmajusteprodutos.btncancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmajusteprodutos.FormCreate(Sender: TObject);
begin
    with modulo_produto do
    begin

      qrcsticms.Close;
      qrcsticms.SQL.Clear;
      qrcsticms.SQL.Add('select * from tcsticms');
      qrcsticms.Open;

    end;
  //endth

  cbxnomecliente.ListSource := modulo_cliente.dscliente;
  cbxnomecliente.ListField:='cliente';
  cbxnomecliente.KeyField:='controle';
  cbxnomecliente.DataSource := modulo_cliente.dstempCliente;
  cbxnomecliente.DataField:='ccli';
  cbxnomecliente.ScrollListDataset:=true;

  //cbxnomecliente.Style:=csDropDownList;

end;

end.

