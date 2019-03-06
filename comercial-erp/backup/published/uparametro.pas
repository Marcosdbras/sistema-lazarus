unit uparametro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls;

type

  { Tfrmparametro }

  Tfrmparametro = class(TForm)
    btngravartodos: TButton;
    btncancelar: TButton;
    btnbuscarlogo: TButton;
    btnbuscarcaminhopadraoarquivo: TButton;
    cbxcodcstde: TDBLookupComboBox;
    cbxdesccstde: TDBLookupComboBox;
    cbxcodipi: TDBLookupComboBox;
    cbxdescipi: TDBLookupComboBox;
    cbxcodpis: TDBLookupComboBox;
    cbxdescpis: TDBLookupComboBox;
    cbxcodcofins: TDBLookupComboBox;
    cbxdesccofins: TDBLookupComboBox;
    edtlogotipo: TEdit;
    edtcaminhopadraopdf: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    OpenDialog1: TOpenDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure btnbuscarcaminhopadraoarquivoClick(Sender: TObject);
    procedure btnbuscarlogoClick(Sender: TObject);
    procedure btncancelarClick(Sender: TObject);
    procedure btngravartodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmparametro: Tfrmparametro;

implementation
     uses umodulo_temp, umodulo_produto, umodulo_geral, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmparametro }

procedure Tfrmparametro.btncancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmparametro.btnbuscarlogoClick(Sender: TObject);
begin
  if opendialog1.Execute then
     begin

       edtlogotipo.Text:=opendialog1.FileName;


     end;
end;

procedure Tfrmparametro.btnbuscarcaminhopadraoarquivoClick(Sender: TObject);
begin

  if selectdirectorydialog1.Execute then
     begin

       edtcaminhopadraopdf.Text:=selectdirectorydialog1.FileName;

     end;
end;

procedure Tfrmparametro.btngravartodosClick(Sender: TObject);
begin
  with modulo_conexaodb do
  begin

    qrexec_base.Close;
    qrexec_base.SQL.Clear;
    if modulo_geral.qrmaster_indice.RecordCount = 0 then
       begin
         qrexec_base.SQL.Add('insert into master_indice( logotipo, caminhopadraopdf, codcsosnpadrao, codcstpispadrao, codcstoriempadrao, codcstipipadrao, codcstpadrao, codcstcofinspadrao) values (:logotipo, :caminhopadraopdf,  :codcsosnpadrao, :codcstpispadrao, :codcstoriempadrao, :codcstipipadrao, :codcstpadrao, :codcstcofinspadrao)');
      end
    else
      begin
         qrexec_base.SQL.Add('update master_indice set  logotipo  = :logotipo, caminhopadraopdf = :caminhopadraopdf,   codcsosnpadrao = :codcsosnpadrao, codcstpispadrao = :codcstpispadrao, codcstoriempadrao = :codcstoriempadrao, codcstipipadrao = :codcstipipadrao, codcstpadrao = :codcstpadrao, codcstcofinspadrao = :codcstcofinspadrao');
       end;
    //endi
    qrexec_base.ParamByName('codcsosnpadrao').AsInteger:=modulo_temp.qrtempCsticmsDe.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('codcstpispadrao').AsInteger:=modulo_temp.qrtempCstPis.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('codcstoriempadrao').AsInteger:=modulo_temp.qrtempcstoriem.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('codcstipipadrao').AsInteger:=modulo_temp.qrtempcstipi.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('codcstpadrao').AsInteger:=modulo_temp.qrtempcst.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('codcstcofinspadrao').AsInteger:=modulo_temp.qrtempcstcofins.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('logotipo').AsString  := edtlogotipo.Text;
    qrexec_base.ParamByName('caminhopadraopdf').AsString := edtcaminhopadraopdf.Text;


    qrexec_base.ExecSQL;



    atualizaBanco;


  end;


  close;

end;

procedure Tfrmparametro.FormCreate(Sender: TObject);
begin
  with modulo_produto do
  begin

    qrcsticms.Close;
    qrcsticms.SQL.Clear;
    qrcsticms.SQL.Add('select * from tcsticms');
    qrcsticms.Open;

  end;
  //endth

  with modulo_produto do
  begin

    qrcstipi.Close;
    qrcstipi.SQL.Clear;
    qrcstipi.SQL.Add('select * from tcstipi');
    qrcstipi.Open;

  end;
  //endth


  with modulo_produto do
  begin

    qrcstcofins.Close;
    qrcstcofins.SQL.Clear;
    qrcstcofins.SQL.Add('select * from tcstcofins');
    qrcstcofins.Open;

  end;
  //endth



  with modulo_produto do
  begin

    qrcstoriem.Close;
    qrcstoriem.SQL.Clear;
    qrcstoriem.SQL.Add('select * from tcstoriem');
    qrcstoriem.Open;

  end;
  //endth


  with modulo_produto do
  begin

    qrcstpis.Close;
    qrcstpis.SQL.Clear;
    qrcstpis.SQL.Add('select * from tcstpis');
    qrcstpis.Open;

  end;
  //endth



  with modulo_produto do
  begin

    qrcst.Close;
    qrcst.SQL.Clear;
    qrcst.SQL.Add('select * from tcst');
    qrcst.Open;

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


  modulo_temp.qrtempCsticmsDe.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcsosnpadrao').AsInteger;
  modulo_temp.qrtempCstCofins.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstcofinspadrao').AsInteger;
  modulo_temp.qrtempCstipi.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstipipadrao').AsInteger;
  modulo_temp.qrtempCstoriem.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstoriempadrao').AsInteger;
  modulo_temp.qrtempCstpis.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstpispadrao').AsInteger;
  modulo_temp.qrtempCst.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstpadrao').AsInteger;
  edtlogotipo.Text := modulo_geral.qrmaster_indice.FieldByName('logotipo').AsString;
  edtcaminhopadraopdf.Text := modulo_geral.qrmaster_indice.FieldByName('caminhopadraopdf').AsString;

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

  cbxcodipi.ListSource := modulo_produto.dscstipi;
  cbxcodipi.ListField:='codcstipi';
  cbxcodipi.KeyField:='controle';
  cbxcodipi.DataSource := modulo_temp.dstempCstIPI;
  cbxcodipi.DataField:='codigo';
  cbxcodipi.ScrollListDataset:=true;
  cbxcodipi.Style:=csDropDownList;

  cbxdescipi.ListSource := modulo_produto.dscstipi;
  cbxdescipi.ListField:='descricao';
  cbxdescipi.KeyField:='controle';
  cbxdescipi.DataSource := modulo_temp.dstempCstIPI;
  cbxdescipi.DataField:='codigo';
  cbxdescipi.ScrollListDataset:=true;
  cbxdescipi.Style:=csDropDownList;

  cbxcodpis.ListSource := modulo_produto.dscstpis;
  cbxcodpis.ListField:='codigocst';
  cbxcodpis.KeyField:='controle';
  cbxcodpis.DataSource := modulo_temp.dstempCstPis;
  cbxcodpis.DataField:='codigo';
  cbxcodpis.ScrollListDataset:=true;
  cbxcodpis.Style:=csDropDownList;

  cbxdescpis.ListSource := modulo_produto.dscstpis;
  cbxdescpis.ListField:='descricao';
  cbxdescpis.KeyField:='controle';
  cbxdescpis.DataSource := modulo_temp.dstempCstPis;
  cbxdescpis.DataField:='codigo';
  cbxdescpis.ScrollListDataset:=true;
  cbxdescpis.Style:=csDropDownList;

  cbxcodcofins.ListSource := modulo_produto.dscstcofins;
  cbxcodcofins.ListField:='codigocstcofins';
  cbxcodcofins.KeyField:='controle';
  cbxcodcofins.DataSource := modulo_temp.dstempCstCofins;
  cbxcodcofins.DataField:='codigo';
  cbxcodcofins.ScrollListDataset:=true;
  cbxcodcofins.Style:=csDropDownList;

  cbxdesccofins.ListSource := modulo_produto.dscstcofins;
  cbxdesccofins.ListField:='descricao';
  cbxdesccofins.KeyField:='controle';
  cbxdesccofins.DataSource := modulo_temp.dstempCstCofins;
  cbxdesccofins.DataField:='codigo';
  cbxdesccofins.ScrollListDataset:=true;
  cbxdesccofins.Style:=csDropDownList;


end;

end.

