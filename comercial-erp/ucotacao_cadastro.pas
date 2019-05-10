unit ucotacao_cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, MaskEdit, Spin, DBGrids, Types, LCLType;

type

  { Tfrmcotacao_cadastro }

  Tfrmcotacao_cadastro = class(TForm)
    btnAlterarproduto: TButton;
    btnCancelarAltprod: TButton;
    btnExcluirProduto: TButton;
    btnlancar: TButton;
    Button2: TButton;
    cbxescolhido: TComboBox;
    DBGrid1: TDBGrid;
    cbxnomefor: TDBLookupComboBox;
    edivalor: TFloatSpinEdit;
    edimargem_lucro: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblvalor: TLabel;
    edidatacotacao: TMaskEdit;
    ediprazo: TSpinEdit;
    edindanfe: TSpinEdit;
    edidif_prazo: TSpinEdit;
    Valor: TLabel;
    lblnomeproduto: TLabel;
    Panel1: TPanel;
    pnlsuperior: TPanel;
    pnlcentral: TPanel;
    pnlinferior: TPanel;
    procedure btnlancarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbxescolhidoKeyPress(Sender: TObject; var Key: char);
    procedure cbxnomeforKeyPress(Sender: TObject; var Key: char);
    procedure edidatacotacaoKeyPress(Sender: TObject; var Key: char);
    procedure edidif_prazoKeyPress(Sender: TObject; var Key: char);
    procedure edimargem_lucroKeyPress(Sender: TObject; var Key: char);
    procedure edindanfeKeyPress(Sender: TObject; var Key: char);
    procedure ediprazoKeyPress(Sender: TObject; var Key: char);
    procedure edivalorKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure lblnomeprodutoClick(Sender: TObject);
    procedure pnlcentralClick(Sender: TObject);
    procedure limparCampo;
    procedure salvarCotacao;
    procedure desbloqueiaCampo;
    procedure bloqueiaCampo;

  private
     opcao_item:string;
  public

  end;

var
  frmcotacao_cadastro: Tfrmcotacao_cadastro;

implementation
      uses uorcamento_cadastro, umodulo_orcamento, umodulo_fornecedor,umodulo_cotacao,umodulo_conexaodb;
{$R *.lfm}

{ Tfrmcotacao_cadastro }

procedure Tfrmcotacao_cadastro.Button2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmcotacao_cadastro.btnlancarClick(Sender: TObject);
begin
 if cbxnomefor.Text = '' then
    begin
      Application.MessageBox('Por favor preencher o fornecedor!','Atenção',MB_OK);
      if opcao_item = 'I' then
         begin
            cbxnomefor.SetFocus;
         end;
      //endi
      exit;
    end;
 //endi

 salvarCotacao;

 limparCampo;

 desbloqueiaCampo;

 cbxnomefor.SetFocus;

 opcao_item := 'I';

end;

procedure Tfrmcotacao_cadastro.cbxescolhidoKeyPress(Sender: TObject;
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

procedure Tfrmcotacao_cadastro.cbxnomeforKeyPress(Sender: TObject; var Key: char
  );
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
  //endi

end;

procedure Tfrmcotacao_cadastro.edidatacotacaoKeyPress(Sender: TObject;
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

procedure Tfrmcotacao_cadastro.edidif_prazoKeyPress(Sender: TObject;
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

procedure Tfrmcotacao_cadastro.edimargem_lucroKeyPress(Sender: TObject;
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

procedure Tfrmcotacao_cadastro.edindanfeKeyPress(Sender: TObject; var Key: char
  );
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
  //endi

end;

procedure Tfrmcotacao_cadastro.ediprazoKeyPress(Sender: TObject; var Key: char);
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
  //endi

end;

procedure Tfrmcotacao_cadastro.edivalorKeyPress(Sender: TObject; var Key: char);
begin
   if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
  //endi

end;

procedure Tfrmcotacao_cadastro.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
end;

procedure Tfrmcotacao_cadastro.FormCreate(Sender: TObject);
begin

  modulo_conexaodb.qrconsulta_base.Close;
  modulo_conexaodb.qrconsulta_base.SQL.Clear;


  if frmorcamento_cadastro <> nil then
     begin

       modulo_conexaodb.qrconsulta_base.SQL.Add('select * from master_itensorcamento where controle_titensorcamento = :controle_titensorcamento');
       modulo_conexaodb.qrconsulta_base.Params.ParamByName('controle_titensorcamento').AsInteger:= modulo_orcamento.qrorcamento_itemproduto.FieldByName('controle').AsInteger;

       lblnomeproduto.Caption := modulo_orcamento.qrorcamento_itemproduto.FieldByName('produto').AsString;
       lblvalor.Caption:= formatfloat('0.00',modulo_orcamento.qrorcamento_itemproduto.FieldByName('valorunitario').AsFloat);

     end
  else
     begin

     end;
  //endi

  modulo_conexaodb.qrconsulta_base.Open;

  with modulo_cotacao do
     begin

       qrmaster_cotacao_item.Close;
       qrmaster_cotacao_item.SQL.Clear;
       qrmaster_cotacao_item.SQL.Add('select * from master_cotacao_item where ccotacao = :ccotacao');
       qrmaster_cotacao_item.Params.ParamByName('ccotacao').AsInteger:=modulo_conexaodb.qrconsulta_base.FieldByName('ccotacao').AsInteger;
       qrmaster_cotacao_item.Open;

     end;
  //endi


  with modulo_fornecedor do
     begin

       qrfornecedor.Close;
       qrfornecedor.SQL.Clear;
       qrfornecedor.SQL.Add('select * from tfornecedor');
       qrfornecedor.Open;

     end;
 //end


  cbxnomefor.ListSource := modulo_fornecedor.dsfornecedor;
  cbxnomefor.ListField:='razaosocial';
  cbxnomefor.KeyField:='controle';
  cbxnomefor.DataSource:=modulo_fornecedor.dstempfornecedor;
  cbxnomefor.DataField:='cfor';
  cbxnomefor.ScrollListDataset:=true;



 limparCampo;

 opcao_item := 'I';

end;

procedure Tfrmcotacao_cadastro.Label6Click(Sender: TObject);
begin

end;

procedure Tfrmcotacao_cadastro.lblnomeprodutoClick(Sender: TObject);
begin

end;

procedure Tfrmcotacao_cadastro.pnlcentralClick(Sender: TObject);
begin

end;

procedure tfrmcotacao_cadastro.limparCampo;
begin
  edidatacotacao.Text:='';
  edivalor.Value:=0;
  edimargem_lucro.Value:=0;
  ediprazo.Value:=0;
  edidif_prazo.value:=0;
  cbxescolhido.Text := 'N';

  modulo_fornecedor.qrtempFornecedor.FieldByName('cfor').AsInteger:=0;

end;

procedure tfrmcotacao_cadastro.salvarCotacao;
var
  iccotacao, icodigo:integer;

begin


  modulo_conexaodb.qrconsulta_base.Close;
  modulo_conexaodb.qrconsulta_base.SQL.Clear;

  if frmorcamento_cadastro <> nil then
     begin

       modulo_conexaodb.qrconsulta_base.SQL.Add('select * from master_itensorcamento where controle_titensorcamento = :controle_titensorcamento');
       modulo_conexaodb.qrconsulta_base.Params.ParamByName('controle_titensorcamento').AsInteger:= modulo_orcamento.qrorcamento_itemproduto.FieldByName('controle').AsInteger;

     end
  else
     begin
       // seleciona tabela master pedido
     end;
  //endi


  modulo_conexaodb.qrconsulta_base.Open;

  icodigo := modulo_conexaodb.qrconsulta_base.FieldByName('codigo').AsInteger;

  if opcao_item = 'I' then
     begin

       if modulo_conexaodb.qrconsulta_base.FieldByName('ccotacao').AsInteger = 0 then
          begin

            modulo_conexaodb.qrexec_base.Close;
            modulo_conexaodb.qrexec_base.SQL.Clear;
            modulo_conexaodb.qrexec_base.SQL.Add('select GEN_ID(GEN_CCOTACAO_ID,1) as prox_codigo FROM RDB$DATABASE;');
            modulo_conexaodb.qrexec_base.Open;

            iccotacao := modulo_conexaodb.qrexec_base.FieldByName('prox_codigo').AsInteger;

          end
       else
          begin

             iccotacao :=  modulo_conexaodb.qrconsulta_base.FieldByName('ccotacao').AsInteger;

          end;
       //endi

       modulo_conexaodb.qrexec_base.Close;
       modulo_conexaodb.qrexec_base.SQL.Clear;
       modulo_conexaodb.qrexec_base.SQL.Add('insert into master_cotacao_item( prazo,  escolhido,  margem_lucro,  ndanfe,  valor,  cfor,  dif_prazo,    data,  ccotacao ) ');
       modulo_conexaodb.qrexec_base.SQL.Add('                     values( :prazo,  :escolhido,  :margem_lucro,  :ndanfe,  :valor,  :cfor,  :dif_prazo,    :data,  :ccotacao) ');

       modulo_conexaodb.qrexec_base.FieldByName('ccotacao').AsString:=iccotacao;


     end
  else if opcao_item = 'A' then
     begin

       qrexec_base.Close;
       qrexec_base.SQL.Clear;
       qrexec_base.SQL.Add('update master_cotacao_item set prazo = :prazo, escolhido = :escolhido, margem_lucro  = :margem_lucro,  ndanfe = :ndanfe, valor = :valor, cfor = :cfor,  dif_prazo = :dif_prazo,  data =  :data,   where codigo = :codigo');

       qrexec_base.ParamByName('codigo').AsInteger:=icodigo;



     end;
  //endi

  if (opcao_item = 'I') or (opcao_item = 'A') then
     begin




       modulo_conexaodb.atualizaBanco;

     end;




end;

procedure tfrmcotacao_cadastro.desbloqueiaCampo;
begin
  cbxnomefor.Enabled:=true;
  edidatacotacao.Enabled:=true;
  edivalor.Enabled:=true;
  edimargem_lucro.Enabled:=true;
  ediprazo.Enabled:=true;
  edindanfe.Enabled:=true;
  cbxescolhido.Enabled:=true;
end;


procedure tfrmcotacao_cadastro.bloqueiaCampo;
begin
  cbxnomefor.Enabled:=false;
  edidatacotacao.Enabled:=false;
  edivalor.Enabled:=false;
  edimargem_lucro.Enabled:=false;
  ediprazo.Enabled:=false;
  edindanfe.Enabled:=false;
  cbxescolhido.Enabled:=false;
end;




end.

