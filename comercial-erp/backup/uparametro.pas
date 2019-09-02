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
    cbxcodcentrocustopadrao: TDBLookupComboBox;
    cbxcodespecieavistapadrao: TDBLookupComboBox;
    cbxcodespecieaprazopadrao: TDBLookupComboBox;
    cbxcodplanocontasavistapadrao: TDBLookupComboBox;
    cbxcodplanocontasaprazopadrao: TDBLookupComboBox;
    cbxcodcstde: TDBLookupComboBox;
    cbxdesccentrocustopadrao: TDBLookupComboBox;
    cbxdescespecieavistapadrao: TDBLookupComboBox;
    cbxdescespecieaprazopadrao: TDBLookupComboBox;
    cbxdescplanocontasavistapadrao: TDBLookupComboBox;
    cbxdescplanocontasaprazopadrao: TDBLookupComboBox;
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
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
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
     uses umodulo_temp, umodulo_produto, umodulo_geral,
          umodulo_conexaodb, umodulo_centrocusto, umodulo_planoconta, umodulo_especie;
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
         qrexec_base.SQL.Add('insert into tmaster_indice( logotipo, caminhopadraopdf, codcsosnpadrao, codcstpispadrao, codcstoriempadrao, codcstipipadrao, codcstpadrao, codcstcofinspadrao, ccentrocustopadrao, cplanocontaaprazopadrao, cplanocontaavistapadrao, cpagamentoaprazopadrao, cpagamentoavistapadrao) values (:logotipo, :caminhopadraopdf,  :codcsosnpadrao, :codcstpispadrao, :codcstoriempadrao, :codcstipipadrao, :codcstpadrao, :codcstcofinspadrao, :ccentrocustopadrao, :cplanocontaaprazopadrao, :cplanocontaavistapadrao, :cpagamentoaprazopadrao, :cpagamentoavistapadrao)');
      end
    else
      begin
         qrexec_base.SQL.Add('update tmaster_indice set  logotipo  = :logotipo, caminhopadraopdf = :caminhopadraopdf,   codcsosnpadrao = :codcsosnpadrao, codcstpispadrao = :codcstpispadrao, codcstoriempadrao = :codcstoriempadrao, codcstipipadrao = :codcstipipadrao, codcstpadrao = :codcstpadrao, codcstcofinspadrao = :codcstcofinspadrao,  ccentrocustopadrao = :ccentrocustopadrao, cplanocontaaprazopadrao = :cplanocontaaprazopadrao, cplanocontaavistapadrao = :cplanocontaavistapadrao, cpagamentoaprazopadrao = :cpagamentoaprazopadrao, cpagamentoavistapadrao = :cpagamentoavistapadrao ');
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


    qrexec_base.ParamByName('CCENTROCUSTOPADRAO').AsInteger:=modulo_temp.qrtempCentroCusto.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('CPLANOCONTAAPRAZOPADRAO').AsInteger:=modulo_temp.qrtempPlanoContaAprazo.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('CPLANOCONTAAVISTAPADRAO').AsInteger:=modulo_temp.qrtempPlanoContaAvista.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('CPAGAMENTOAPRAZOPADRAO').AsInteger:=modulo_temp.qrtempEspecieAprazo.FieldByName('codigo').AsInteger;
    qrexec_base.ParamByName('CPAGAMENTOAVISTAPADRAO').AsInteger:=modulo_temp.qrtempEspecieAvista.FieldByName('codigo').AsInteger;


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
    qrmaster_indice.SQL.Add('select * from tmaster_indice');
    qrmaster_indice.Open;
  end;
  //endth


  with modulo_centrocusto do
     begin
       qrcentrocusto.Close;
       qrcentrocusto.SQL.Clear;
       qrcentrocusto.SQL.Add('select * from tcentrocusto');
       qrcentrocusto.Open;

     end;
 //end


 with modulo_especie do
    begin
      qrespecie.Close;
      qrespecie.SQL.Clear;
      qrespecie.SQL.Add('select * from tespecie');
      qrespecie.Open;

    end;
//end


with modulo_planoconta do
   begin
     qrplanoconta.Close;
     qrplanoconta.SQL.Clear;
     qrplanoconta.SQL.Add('select * from tplanoconta');
     qrplanoconta.Open;

   end;
//end





modulo_temp.qrtempCsticmsDe.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcsosnpadrao').AsInteger;
  modulo_temp.qrtempCstCofins.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstcofinspadrao').AsInteger;
  modulo_temp.qrtempCstipi.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstipipadrao').AsInteger;
  modulo_temp.qrtempCstoriem.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstoriempadrao').AsInteger;
  modulo_temp.qrtempCstpis.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstpispadrao').AsInteger;
  modulo_temp.qrtempCst.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('codcstpadrao').AsInteger;


  modulo_temp.qrtempCentroCusto.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('CCENTROCUSTOPADRAO').AsInteger;
  modulo_temp.qrtempEspecieaPrazo.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('CPAGAMENTOAPRAZOPADRAO').AsInteger;
  modulo_temp.qrtempEspecieaVista.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('CPAGAMENTOAVISTAPADRAO').AsInteger;
  modulo_temp.qrtempPlanoContaAvista.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('CPLANOCONTAAVISTAPADRAO').AsInteger;
  modulo_temp.qrtempPlanoContaAPrazo.FieldByName('codigo').AsInteger := modulo_geral.qrmaster_indice.FieldByName('CPLANOCONTAAPRAZOPADRAO').AsInteger;


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


  cbxcodcentrocustopadrao.ListSource := modulo_centrocusto.dsCentroCusto;
  cbxcodcentrocustopadrao.ListField:='controle';
  cbxcodcentrocustopadrao.KeyField:='controle';
  cbxcodcentrocustopadrao.DataSource := modulo_temp.dstempCentroCusto;
  cbxcodcentrocustopadrao.DataField:='codigo';
  cbxcodcentrocustopadrao.ScrollListDataset:=true;
  cbxcodcentrocustopadrao.Style:=csDropDownList;

  cbxdesccentrocustopadrao.ListSource := modulo_centrocusto.dsCentroCusto;
  cbxdesccentrocustopadrao.ListField:='centrocusto';
  cbxdesccentrocustopadrao.KeyField:='controle';
  cbxdesccentrocustopadrao.DataSource := modulo_temp.dstempCentroCusto;
  cbxdesccentrocustopadrao.DataField:='codigo';
  cbxdesccentrocustopadrao.ScrollListDataset:=true;
  cbxdesccentrocustopadrao.Style:=csDropDownList;

  cbxcodespecieavistapadrao.ListSource := modulo_especie.dsEspecie;
  cbxcodespecieavistapadrao.ListField:='controle';
  cbxcodespecieavistapadrao.KeyField:='controle';
  cbxcodespecieavistapadrao.DataSource := modulo_temp.dstempEspecieAvista;
  cbxcodespecieavistapadrao.DataField:='codigo';
  cbxcodespecieavistapadrao.ScrollListDataset:=true;
  cbxcodespecieavistapadrao.Style:=csDropDownList;

  cbxdescespecieavistapadrao.ListSource := modulo_especie.dsEspecie;
  cbxdescespecieavistapadrao.ListField:='especie';
  cbxdescespecieavistapadrao.KeyField:='controle';
  cbxdescespecieavistapadrao.DataSource := modulo_temp.dstempEspecieAvista;
  cbxdescespecieavistapadrao.DataField:='codigo';
  cbxdescespecieavistapadrao.ScrollListDataset:=true;
  cbxdescespecieavistapadrao.Style:=csDropDownList;

  cbxcodespecieaprazopadrao.ListSource := modulo_especie.dsEspecie;
  cbxcodespecieaprazopadrao.ListField:='controle';
  cbxcodespecieaprazopadrao.KeyField:='controle';
  cbxcodespecieaprazopadrao.DataSource := modulo_temp.dstempEspecieAprazo;
  cbxcodespecieaprazopadrao.DataField:='codigo';
  cbxcodespecieaprazopadrao.ScrollListDataset:=true;
  cbxcodespecieaprazopadrao.Style:=csDropDownList;

  cbxdescespecieaprazopadrao.ListSource := modulo_especie.dsEspecie;
  cbxdescespecieaprazopadrao.ListField:='especie';
  cbxdescespecieaprazopadrao.KeyField:='controle';
  cbxdescespecieaprazopadrao.DataSource := modulo_temp.dstempEspecieAprazo;
  cbxdescespecieaprazopadrao.DataField:='codigo';
  cbxdescespecieaprazopadrao.ScrollListDataset:=true;
  cbxdescespecieaprazopadrao.Style:=csDropDownList;



  cbxcodplanocontasavistapadrao.ListSource := modulo_planoconta.dsPlanoConta;
  cbxcodplanocontasavistapadrao.ListField:='controle';
  cbxcodplanocontasavistapadrao.KeyField:='controle';
  cbxcodplanocontasavistapadrao.DataSource := modulo_temp.dstempPlanoContaAvista;
  cbxcodplanocontasavistapadrao.DataField:='codigo';
  cbxcodplanocontasavistapadrao.ScrollListDataset:=true;
  cbxcodplanocontasavistapadrao.Style:=csDropDownList;

  cbxdescplanocontasavistapadrao.ListSource := modulo_planoconta.dsPlanoConta;
  cbxdescplanocontasavistapadrao.ListField:='planoconta';
  cbxdescplanocontasavistapadrao.KeyField:='controle';
  cbxdescplanocontasavistapadrao.DataSource := modulo_temp.dstempPlanoContaAvista;
  cbxdescplanocontasavistapadrao.DataField:='codigo';
  cbxdescplanocontasavistapadrao.ScrollListDataset:=true;
  cbxdescplanocontasavistapadrao.Style:=csDropDownList;






end;

end.

