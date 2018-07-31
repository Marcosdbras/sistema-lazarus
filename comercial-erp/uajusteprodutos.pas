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
    cbxcodcstde: TDBLookupComboBox;
    cbxdesccstde: TDBLookupComboBox;
    cbxcodcstpara: TDBLookupComboBox;
    cbxdesccstpara: TDBLookupComboBox;
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

  cbxcodcstde.ListSource := modulo_produto.dscsticms;
  cbxcodcstde.ListField:='codigocst';
  cbxcodcstde.KeyField:='controle';
  cbxcodcstde.DataSource := modulo_temp.dstempCsticmsDe;
  cbxcodcstde.DataField:='codigo';
  cbxcodcstde.ScrollListDataset:=true;
  cbxcodcstde.Style:=csDropDownList;

end;

end.

