unit ucadastro_parcelafinanceiro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DbCtrls, Spin, EditBtn;

type

  { Tfrmcadastro_parcelafinanceiro }

  Tfrmcadastro_parcelafinanceiro = class(TForm)
    btncancelar: TButton;
    btnsalvar: TButton;
    edtvencto: TDateEdit;
    CBXESPECIE: TDBLookupComboBox;
    edtvalororiginal: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtdescricao: TLabel;
    edtprazo: TSpinEdit;
    procedure btncancelarClick(Sender: TObject);
    procedure btnsalvarClick(Sender: TObject);
    procedure CBXESPECIEKeyPress(Sender: TObject; var Key: char);
    procedure edtprazoExit(Sender: TObject);
    procedure edtprazoKeyPress(Sender: TObject; var Key: char);
    procedure edtvalororiginalKeyPress(Sender: TObject; var Key: char);
    procedure edtvenctoExit(Sender: TObject);
    procedure edtvenctoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    icodigo:integer;
  public

  end;

var
  frmcadastro_parcelafinanceiro: Tfrmcadastro_parcelafinanceiro;

implementation
     uses umodulo_conexaodb, umodulo_receber, umodulo_especie;
{$R *.lfm}

{ Tfrmcadastro_parcelafinanceiro }

procedure Tfrmcadastro_parcelafinanceiro.btncancelarClick(Sender: TObject);
begin
  showmessage(modulo_especie.qrtempEspecie.FieldByName('cespecie').AsString);

  close;
end;

procedure Tfrmcadastro_parcelafinanceiro.btnsalvarClick(Sender: TObject);
begin
  with modulo_conexaodb do
       begin

             qrexec_base.close;
             qrexec_base.SQL.Clear;
             //qrexec_base.SQL.Add('update tmaster_receber set   DESCRICAOLANCAMENTO = :DESCRICAOLANCAMENTO, QTDEPARCELA = :QTDEPARCELA, NPARCELA = :NPARCELA, CODCLIENTE = :CODCLIENTE,  CLIENTE = :CLIENTE, CODESPECIE = :CODESPECIE, ESPECIE = :ESPECIE, DATAHORACADASTRO = :DATAHORACADASTRO,         DATAVENCIMENTO = :DATAVENCIMENTO, CODPLANOCONTA = :CODPLANOCONTA, PLANOCONTA = :PLANOCONTA, DOCUMENTO = :DOCUMENTO,          ORIGEM = :ORIGEM, VALORORIGINAL = :VALORORIGINAL,         OBS = :OBS, CODFUNCIONARIO = :CODFUNCIONARIO, FUNCIONARIO = :FUNCIONARIO, CODVENDEDOR = :CODVENDEDOR, VENDEDOR = :VENDEDOR,        CODBARRA = :CODBARRA,  REPLICADA = :REPLICADA, STATUS = :STATUS,        PRAZO = :PRAZO where codigo = :codigo')
             qrexec_base.SQL.Add('update tmaster_receber set  DATAHORACADASTRO = :DATAHORACADASTRO  ,CODESPECIE = :CODESPECIE, ESPECIE = :ESPECIE, DATAVENCIMENTO = :DATAVENCIMENTO, VALORORIGINAL = :VALORORIGINAL,  PRAZO = :PRAZO where codigo = :codigo');
             qrexec_base.Params.ParamByName('codigo').AsInteger:=icodigo;
             qrexec_base.Params.ParamByName('codespecie').AsInteger :=  modulo_especie.qrtempEspecie.FieldByName('cespecie').AsInteger;
             qrexec_base.Params.ParamByName('especie').AsString:= cbxespecie.Text;
             qrexec_base.Params.ParamByName('prazo').AsInteger :=  edtprazo.Value;
             qrexec_base.Params.ParamByName('datavencimento').AsDate := edtvencto.Date;
             qrexec_base.Params.ParamByName('valororiginal').Asfloat := edtvalororiginal.Value;
             qrexec_base.Params.ParamByName('datahoracadastro').AsDate := now();
             qrexec_base.ExecSQL;

             atualizaBanco;
       end;

  modulo_receber.qrMasterReceber.Refresh;

  modulo_receber.qrMasterReceber.Locate('codigo',icodigo,[]);

  close;

end;

procedure Tfrmcadastro_parcelafinanceiro.CBXESPECIEKeyPress(Sender: TObject;
  var Key: char);
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
//endi

end;

procedure Tfrmcadastro_parcelafinanceiro.edtprazoExit(Sender: TObject);
begin
   edtvencto.Date :=  now() + edtprazo.Value;
end;

procedure Tfrmcadastro_parcelafinanceiro.edtprazoKeyPress(Sender: TObject;
  var Key: char);
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
   //endi

end;

procedure Tfrmcadastro_parcelafinanceiro.edtvalororiginalKeyPress(
  Sender: TObject; var Key: char);
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
   //endi

end;

procedure Tfrmcadastro_parcelafinanceiro.edtvenctoExit(Sender: TObject);
begin
  edtprazo.Value:=edtvencto.Date -  now() + 1;
end;

procedure Tfrmcadastro_parcelafinanceiro.edtvenctoKeyPress(Sender: TObject;
  var Key: char);
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
   //endi

end;

procedure Tfrmcadastro_parcelafinanceiro.FormCreate(Sender: TObject);
begin
    with modulo_especie do
     begin

       qrespecie.Close;
       qrespecie.SQL.Clear;
       qrespecie.SQL.Add('select * from tespecie');
       qrespecie.Open;




     end;
  //endth


  cbxespecie.ListSource := modulo_especie.dsEspecie;
  cbxespecie.ListField:='especie';
  cbxespecie.KeyField:='controle';
  cbxespecie.DataSource:=modulo_especie.dstempEspecie;
  cbxespecie.DataField:='cespecie';
  cbxespecie.ScrollListDataset:=true;

  modulo_especie.qrtempEspecie.Edit;
  modulo_especie.qrtempEspecie.FieldByName('cespecie').AsInteger:= modulo_receber.qrMasterReceber.FieldByName('codespecie').AsInteger;


  edtdescricao.Caption:=modulo_receber.qrMasterReceber.FieldByName('descricaolancamento').AsString;
  edtprazo.Value:=modulo_receber.qrMasterReceber.FieldByName('prazo').AsInteger;
  edtvencto.Date:=modulo_receber.qrMasterReceber.FieldByName('datavencimento').AsDatetime;
  edtvalororiginal.Value:=modulo_receber.qrMasterReceber.FieldByName('valororiginal').Asfloat;

  icodigo :=  modulo_receber.qrMasterReceber.FieldByName('codigo').AsInteger;



end;

procedure Tfrmcadastro_parcelafinanceiro.Label5Click(Sender: TObject);
begin

end;

end.

