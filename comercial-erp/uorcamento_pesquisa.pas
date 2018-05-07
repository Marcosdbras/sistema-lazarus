unit uorcamento_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DbCtrls, DBGrids, ZDataset, db, BufDataset;

type

  { Tfrmorcamento_pesquisa }

  Tfrmorcamento_pesquisa = class(TForm)
    btnfiltrar: TButton;
    btnlimpar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    DBText1: TDBText;
    dstemp: TDataSource;
    edtdatainicio: TDateEdit;
    edtdatafim: TDateEdit;
    cbxnomecliente: TDBLookupComboBox;
    cbxnomefun: TDBLookupComboBox;
    cbxnomeven: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    qrtemp: TBufDataset;
    qrtempccli: TLongintField;
    qrtempcfun: TLongintField;
    qrtempcontrole: TAutoIncField;
    qrtempcven: TLongintField;
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBText2Click(Sender: TObject);
    procedure dsorcamentoDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
  private

  public
      opcao:string;
  end;

var
  frmorcamento_pesquisa: Tfrmorcamento_pesquisa;

implementation
     uses ufuncao_geral,  umodulo_orcamento, uorcamento_cadastro, umodulo_cliente, umodulo_funcionario;
{$R *.lfm}

{ Tfrmorcamento_pesquisa }

procedure Tfrmorcamento_pesquisa.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.FormCreate(Sender: TObject);
begin

  with qrtemp.fieldDefs do
    begin
      Add('controle', ftAutoInc, 0, True);
      Add('ccli', ftInteger, 0, True);
      Add('cfun', ftInteger, 0, True);
      Add('cven', ftInteger, 0, True);
    end;

  qrtemp.CreateDataset;

  qrtemp.Open;

  qrtemp.Append;


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

  cbxnomecliente.ListSource := modulo_cliente.dscliente;
  cbxnomecliente.ListField:='cliente';
  cbxnomecliente.KeyField:='controle';

  cbxnomefun.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomefun.ListField:='funcionario';
  cbxnomefun.KeyField:='controle';

  cbxnomeven.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomeven.ListField:='funcionario';
  cbxnomeven.KeyField:='controle';

  limpar;




end;

procedure Tfrmorcamento_pesquisa.btnfiltrarClick(Sender: TObject);
begin
  filtrar;
end;

procedure Tfrmorcamento_pesquisa.btnlimparClick(Sender: TObject);
begin
  limpar;
end;

procedure Tfrmorcamento_pesquisa.Button1Click(Sender: TObject);
begin
  opcao := 'I';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;


end;

procedure Tfrmorcamento_pesquisa.Button2Click(Sender: TObject);
begin
    opcao := 'A';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;

end;

procedure Tfrmorcamento_pesquisa.Button5Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmorcamento_pesquisa.DBText2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.dsorcamentoDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure Tfrmorcamento_pesquisa.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.limpar;
begin
  edtdatainicio.Date:= date;
  edtdatafim.Date:=date;

  qrtemp.FieldByName('ccli').AsInteger:=0;
  qrtemp.FieldByName('cfun').AsInteger:=0;
  qrtemp.FieldByName('cven').AsInteger:=0;


  filtrar;
end;

procedure Tfrmorcamento_pesquisa.filtrar;
var sdti,sdtf,filtro:string;


begin
  sdti := formatdatetime('dd.mm.yyyy', edtdatainicio.date);
  sdtf := formatdatetime('dd.mm.yyyy',edtdatafim.Date);

  filtro := '';

  if qrtemp.FieldByName('ccli').AsInteger > 0 then
     begin
       filtro := filtro +' and (codcliente = ' +  inttostr(qrtemp.FieldByName('ccli').AsInteger)  +')';
     end;
  //endi


  if qrtemp.FieldByName('cfun').AsInteger > 0 then
     begin
       filtro := filtro + ' and (codfuncionario = '+ inttostr( qrtemp.FieldByName('cfun').AsInteger ) +')';
     end;
  //endi


  showmessage(filtro);




  with modulo_orcamento do
    begin

      qrorcamento.Active:= false;
      qrorcamento.SQL.Clear;
      qrorcamento.SQL.Add('select * from torcamento where (data >= :dti and data <= :dtf )');
      qrorcamento.ParamByName('dti').AsDate:= edtdatainicio.date;
      qrorcamento.ParamByName('dtf').AsDate:= edtdatafim.Date;
      qrorcamento.Active:=true;

    end;
  //endth

end;

end.

