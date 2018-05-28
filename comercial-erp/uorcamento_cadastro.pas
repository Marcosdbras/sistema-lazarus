unit uorcamento_cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DBCtrls, DBGrids, ComCtrls, Spin, ZDataset, DB,
  BufDataset, Types, LCLType;

type

  { Tfrmorcamento_cadastro }

  Tfrmorcamento_cadastro = class(TForm)
    btnlancar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    btngerar: TButton;
    cbxunidade: TDBLookupComboBox;
    cbxnomecliente: TDBLookupComboBox;
    cbxnomeven: TDBLookupComboBox;
    cbxnomefun: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    edtdescricao: TEdit;
    edtqtde: TFloatSpinEdit;
    edtvlrsubtotal: TFloatSpinEdit;
    edtvlrsubtotal1: TFloatSpinEdit;
    edtvlrunitario: TFloatSpinEdit;
    edtvlrunitario1: TFloatSpinEdit;
    edtvlrunitario2: TFloatSpinEdit;
    edtvlrunitario3: TFloatSpinEdit;
    edtvlrunitario4: TFloatSpinEdit;
    edtvlrunitario5: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblstatus: TLabel;
    lblcliente: TLabel;
    lblcliente1: TLabel;
    lblcliente2: TLabel;
    lblcliente3: TLabel;
    lblcliente4: TLabel;
    lblcliente5: TLabel;
    lblcliente6: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    pnlparcelar: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    ScrollBox1: TScrollBox;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBText2Click(Sender: TObject);
    procedure dsorcamentoDataChange(Sender: TObject; Field: TField);
    procedure edtdescricaoExit(Sender: TObject);
    procedure edtqtdeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure Panel9Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
    procedure salvarCadastro;
    procedure limparProduto;

    procedure ScrollBox1Click(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
  private
      icodigo_controle:integer;

  public

  end;

var
  frmorcamento_cadastro: Tfrmorcamento_cadastro;

implementation

uses ufuncao_geral, umodulo_orcamento, uorcamento_pesquisa, umodulo_cliente, umodulo_funcionario, umodulo_conexaodb, umodulo_unidade, umodulo_produto, uproduto_consulta;

{$R *.lfm}

{ Tfrmorcamento_cadastro }

procedure Tfrmorcamento_cadastro.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.Panel6Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.Panel9Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.FormCreate(Sender: TObject);
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


  with modulo_unidade do
    begin
       qrunidade.Close;
       qrunidade.SQL.Clear;
       qrunidade.SQL.Add('select * from master_unidade order by sigla');
       qrunidade.Open;

    end;
  //endth

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

  cbxunidade.ListSource := modulo_unidade.dsunidade;
  cbxunidade.ListField:='sigla';
  cbxunidade.KeyField:='codigo';
  cbxunidade.DataSource:=modulo_orcamento.dstempUnidade;
  cbxunidade.DataField:='cund';
  cbxunidade.ScrollListDataset:=true;



  limparProduto;


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
  salvarCadastro;

  close;

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

procedure Tfrmorcamento_cadastro.edtdescricaoExit(Sender: TObject);
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

procedure Tfrmorcamento_cadastro.salvarCadastro;
var
  nomecliente, nomefuncionario, nomevendedor:string;

begin

  with modulo_conexaodb do
    begin

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tcliente where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_orcamento.qrtempCliente.FieldByName('ccli').AsInteger;
      qrconsulta_base.Open;

      nomecliente := qrconsulta_base.FieldByName('cliente').AsString;

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tfuncionario where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_orcamento.qrtempfuncionario.FieldByName('cfun').AsInteger;
      qrconsulta_base.Open;

      nomefuncionario := qrconsulta_base.FieldByName('funcionario').AsString;

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tfuncionario where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_orcamento.qrtempvendedor.FieldByName('cven').AsInteger;
      qrconsulta_base.Open;

      nomevendedor := qrconsulta_base.FieldByName('funcionario').AsString;


    end;
  //endth

  if frmorcamento_pesquisa.opcao = 'I' then
     begin

        //Atualiza tabelas auxiliares do sistema
        with modulo_conexaodb do
          begin

            qrsequencia.Close;
            qrsequencia.SQL.Clear;
            qrsequencia.SQL.Add('update tsequencia set controlevarchar = controlevarchar + 1');
            qrsequencia.ExecSQL;

            atualizaBanco;

            qrsequencia.Close;
            qrsequencia.SQL.Clear;
            qrsequencia.SQL.Add('select * from tsequencia');
            qrsequencia.Open;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into torcamento( codcliente,  nomecliente,  codfuncionario,  funcionario,  codvendedor, vendedor,  data, controlevarchar,   hora,  datahoracadastro, tipodesconto,   titulodav,  cancelado,  status  ) ');
            qrexec_base.SQL.Add('                values(:codcliente, :nomecliente, :codfuncionario, :funcionario, :codvendedor, :vendedor, :data, :controlevarchar, :hora, :datahoracadastro, :tipodesconto, :titulodav, :cancelado, :status  )');


            qrexec_base.ParamByName('data').AsDate:=date;
            qrexec_base.ParamByName('controlevarchar').AsString:=formatfloat('0000000000',qrsequencia.FieldByName('controlevarchar').AsInteger);
            qrexec_base.ParamByName('hora').AsString := formatdatetime('HH:mm:ss',time);
            qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
            qrexec_base.ParamByName('tipodesconto').AsString:='R$';
            qrexec_base.ParamByName('titulodav').AsString:='ORÇAMENTOS';
            qrexec_base.ParamByName('cancelado').AsString:='NÃO';
            qrexec_base.ParamByName('status').AsString:='ABERTO';


          end;
        //endth
     end
  else if frmorcamento_pesquisa.opcao = 'A' then
     begin
        with modulo_conexaodb do
          begin

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('update torcamento set codcliente = :codcliente,  nomecliente = :nomecliente,  codfuncionario = :codfuncionario,  funcionario = :funcionario,  codvendedor = :codvendedor, vendedor = :vendedor where controle = :controle');

            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle;


          end;
        //endth

     end;
  //endif

  if (frmorcamento_pesquisa.opcao = 'I') or (frmorcamento_pesquisa.opcao = 'A') then
     begin
        with modulo_conexaodb do
          begin


            qrexec_base.ParamByName('codcliente').AsInteger := modulo_orcamento.qrtempCliente.FieldByName('ccli').AsInteger;
            qrexec_base.ParamByName('nomecliente').AsString:= nomecliente;
            qrexec_base.ParamByName('codfuncionario').AsInteger := modulo_orcamento.qrtempfuncionario.FieldByName('cfun').AsInteger;
            qrexec_base.ParamByName('funcionario').AsString:=  nomefuncionario;
            qrexec_base.ParamByName('codvendedor').AsInteger := modulo_orcamento.qrtempvendedor.FieldByName('cven').AsInteger;
            qrexec_base.ParamByName('vendedor').AsString:= nomevendedor;
            qrexec_base.ExecSQL;

            atualizaBanco;

          end;
        //endth


       modulo_orcamento.qrorcamento.Refresh;

     end;
  //endi

  if (frmorcamento_pesquisa.opcao = 'I')  then
     begin

        modulo_orcamento.qrorcamento.Last;

        Application.MessageBox(pchar('Registro inserido com sucesso!'),'Processo bem sucedido',MB_OK);

     end
  else if (frmorcamento_pesquisa.opcao = 'A') then
     begin

        if not modulo_orcamento.qrorcamento.Locate('controle',icodigo_controle,[]) then
           begin

             Application.MessageBox(pchar('Registro não foi atualizado, pois '+ formatfloat('00000',icodigo_controle) +' não se encontra mais na base de dados'),'Atenção',MB_OK);

           end
        else
           begin

             Application.MessageBox(pchar('Registro '+ formatfloat('00000',icodigo_controle) +' atualizado com sucesso!'),'Processo bem sucedido',MB_OK);

           end;
        //endi



     end;
  //endi


end;


procedure tfrmorcamento_cadastro.limparProduto;
begin

  edtdescricao.Text:='';
  edtqtde.Value:=0;
  edtvlrunitario.Value:=0;
  edtvlrsubtotal.Value:=0;

  modulo_orcamento.qrtempUnidade.FieldByName('cund').AsInteger:=0;

end;

end.









