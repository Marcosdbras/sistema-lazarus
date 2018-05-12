unit uorcamento_cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DBCtrls, DBGrids, ComCtrls, Spin, ZDataset, DB,
  BufDataset, Types;

type

  { Tfrmorcamento_cadastro }

  Tfrmorcamento_cadastro = class(TForm)
    Button1: TButton;
    btnlancar: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    cbxnomecliente: TDBLookupComboBox;
    cbxnomeven: TDBLookupComboBox;
    cbxnomefun: TDBLookupComboBox;
    cbxunidade: TDBLookupComboBox;
    edtdescricao: TEdit;
    edtqtde: TFloatSpinEdit;
    edtvlrunitario: TFloatSpinEdit;
    edtvlrsubtotal: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    lblcliente: TLabel;
    lblcliente1: TLabel;
    lblcliente2: TLabel;
    lblcliente3: TLabel;
    lblcliente4: TLabel;
    lblcliente5: TLabel;
    lblcliente6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    ScrollBox1: TScrollBox;
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBText2Click(Sender: TObject);
    procedure dsorcamentoDataChange(Sender: TObject; Field: TField);
    procedure edtqtdeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
    procedure ScrollBox1Click(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
  private

  public

  end;

var
  frmorcamento_cadastro: Tfrmorcamento_cadastro;

implementation

uses ufuncao_geral, umodulo_orcamento, uorcamento_pesquisa, umodulo_cliente, umodulo_funcionario, umodulo_conexaodb;

{$R *.lfm}

{ Tfrmorcamento_cadastro }

procedure Tfrmorcamento_cadastro.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.FormCreate(Sender: TObject);
  var
    icodigo_controle:integer;
begin



  //with qrtemp.fieldDefs do
  //  begin
  //    Add('controle', ftAutoInc, 0, True);
  //    Add('ccli', ftInteger, 0, True);
  //    Add('cfun', ftInteger, 0, True);
  //    Add('cven', ftInteger, 0, True);
  //  end;

  //qrtemp.CreateDataset;

  //qrtemp.Open;

  //qrtemp.Append;

  with modulo_cliente do
    begin
       qrcliente.Close;
       qrcliente.SQL.Clear;
       qrcliente.SQL.Add('select * from tcliente order by cliente');
       qrcliente.Open;

    end;
  //endth

  with modulo_funcionario do
    begin
      qrfuncionario.Close;
      qrfuncionario.SQL.Clear;
      qrfuncionario.SQL.Add('select * from tfuncionario where ativo = :ativo order by funcionario');
      qrfuncionario.ParamByName('ativo').AsString:='SIM';
      qrfuncionario.Open;

    end;
  //endth

  with modulo_orcamento do
    begin
      if frmorcamento_pesquisa.opcao <> 'I' then
         begin
           icodigo_controle := qrorcamento.FieldByName('controle').AsInteger;

           qrtempCliente.FieldByName('ccli').AsInteger:= qrorcamento.FieldByName('codcliente').AsInteger;
           qrtempFuncionario.FieldByName('cfun').AsInteger:= qrorcamento.FieldByName('codfuncionario').AsInteger;
           qrtempVendedor.FieldByName('cven').AsInteger:= qrorcamento.FieldByName('codvendedor').AsInteger;



         end
      else
         begin
           icodigo_controle := 0;

           qrtempCliente.FieldByName('ccli').AsInteger:=0;
           qrtempFuncionario.FieldByName('cfun').AsInteger:=0;
           qrtempVendedor.FieldByName('cven').AsInteger:=0;

         end;
      //endi

      qrorcamento_itemproduto.Close;
      qrorcamento_itemproduto.SQL.Clear;
      qrorcamento_itemproduto.SQL.Add('select * from TITENSORCAMENTO where codorcamento = :codorcamento');
      qrorcamento_itemproduto.ParamByName('codorcamento').AsInteger:=icodigo_controle;
      qrorcamento_itemproduto.Open;


    end;
  //endth

  cbxnomecliente.ListSource := modulo_cliente.dscliente;
  cbxnomecliente.ListField:='cliente';
  cbxnomecliente.KeyField:='controle';
  cbxnomecliente.DataSource := modulo_orcamento.dstempCliente;
  cbxnomecliente.DataField:='ccli';
  cbxnomecliente.ScrollListDataset:=true;

  //cbxnomecliente.Style:=csDropDownList;


  cbxnomefun.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomefun.ListField:='funcionario';
  cbxnomefun.KeyField:='controle';
  cbxnomefun.DataSource:=modulo_orcamento.dstempFuncionario;
  cbxnomefun.DataField:='cfun';
  cbxnomefun.ScrollListDataset:=true;

  cbxnomeven.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomeven.ListField:='funcionario';
  cbxnomeven.KeyField:='controle';
  cbxnomeven.DataSource:=modulo_orcamento.dstempVendedor;
  cbxnomeven.DataField:='cven';
  cbxnomeven.ScrollListDataset:=true;




end;

procedure Tfrmorcamento_cadastro.GroupBox2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.btnfiltrarClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.btnlimparClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.Button1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.Button2Click(Sender: TObject);
begin
  //showmessage(modulo_conexaodb.qrtemp.FieldByName('ccli').AsString);

  Close;
end;

procedure Tfrmorcamento_cadastro.Button5Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.DBText2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.dsorcamentoDataChange(Sender: TObject; Field: TField);
begin

end;

procedure Tfrmorcamento_cadastro.edtqtdeChange(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.limpar;
begin

end;

procedure Tfrmorcamento_cadastro.ScrollBox1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.TabSheet1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: boolean);
begin

end;

procedure Tfrmorcamento_cadastro.filtrar;

begin

end;

end.








