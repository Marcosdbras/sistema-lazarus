unit uindice;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls;

type

  { Tfrmindice }

  Tfrmindice = class(TForm)
    btngravartodos: TButton;
    btncancelar: TButton;
    cbxcodcstde: TDBLookupComboBox;
    cbxdesccstde: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure btncancelarClick(Sender: TObject);
    procedure btngravartodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmindice: Tfrmindice;

implementation
     uses umodulo_temp, umodulo_produto, umodulo_geral, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmindice }

procedure Tfrmindice.btncancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmindice.btngravartodosClick(Sender: TObject);
begin
  with modulo_conexaodb do
  begin

    qrexec_base.Close;
    qrexec_base.SQL.Clear;
    if modulo_geral.qrmaster_indice.RecordCount = 0 then
       begin
         qrexec_base.SQL.Add('insert into master_indice(codcsosnpadrao) values (:codcsosnpadrao)');
      end
    else
      begin
         qrexec_base.SQL.Add('update master_indice set codcsosnpadrao = :codcsosnpadrao');
       end;
    //endi
    qrexec_base.ParamByName('codcsosnpadrao').AsInteger:=modulo_temp.qrtempCsticmsDe.FieldByName('codigo').AsInteger;
    qrexec_base.ExecSQL;



    atualizaBanco;


  end;


  close;

end;

procedure Tfrmindice.FormCreate(Sender: TObject);
begin
  with modulo_produto do
  begin

    qrcsticms.Close;
    qrcsticms.SQL.Clear;
    qrcsticms.SQL.Add('select * from tcsticms');
    qrcsticms.Open;

  end;
  //endth

  with modulo_geral do
  begin
    qrmaster_indice.Close;
    qrmaster_indice.SQL.Clear;
    qrmaster_indice.SQL.Add('select * from master_indice');
    qrmaster_indice.Open;
  end;
  //endth


  modulo_temp.qrtempCsticmsDe.FieldByName('codigo').AsInteger := modulo_produto.qrcsticms.FieldByName('controle').AsInteger;

  cbxcodcstde.ListSource := modulo_produto.dscsticms;
  cbxcodcstde.ListField:='codigocst';
  cbxcodcstde.KeyField:='controle';
  cbxcodcstde.DataSource := modulo_temp.dstempCsticmsDe;
  cbxcodcstde.DataField:='codigo';
  cbxcodcstde.ScrollListDataset:=true;
  cbxcodcstde.Style:=csDropDownList;

  cbxdesccstde.ListSource := modulo_produto.dscsticms;
  cbxdesccstde.ListField:='descricao';
  cbxdesccstde.KeyField:='controle';
  cbxdesccstde.DataSource := modulo_temp.dstempCsticmsDe;
  cbxdesccstde.DataField:='codigo';
  cbxdesccstde.ScrollListDataset:=true;
  cbxdesccstde.Style:=csDropDownList;



end;

end.

