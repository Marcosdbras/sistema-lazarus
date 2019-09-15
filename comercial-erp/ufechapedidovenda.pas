unit ufechapedidovenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin, DbCtrls, DBGrids, Buttons, Types, LCLType;

type

  { Tfrmfechapedidovenda }

  Tfrmfechapedidovenda = class(TForm)
    btnalterarfin: TBitBtn;
    btnlancarparcela: TBitBtn;
    btnlancar: TBitBtn;
    btncancelar: TBitBtn;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    edtpercdesconto: TFloatSpinEdit;
    edtvlrdesconto: TFloatSpinEdit;
    edtvlrpagar: TFloatSpinEdit;
    edtvlravista: TFloatSpinEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblbairro: TLabel;
    lblcep: TLabel;
    lblcidade: TLabel;
    lblcompl: TLabel;
    lblendereco: TLabel;
    lbltelefone: TLabel;
    lbltotal: TLabel;
    lblpeddav: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    lblnomecli: TLabel;
    pnlsuperior: TPanel;
    pnlcentral: TPanel;
    pnlinferior: TPanel;
    edtnparc: TSpinEdit;
    procedure btnalterarfinClick(Sender: TObject);
    procedure btnlancarClick(Sender: TObject);
    procedure btnlancarparcelaClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: char);
    procedure DBLookupComboBox1KeyPress(Sender: TObject; var Key: char);
    procedure edtpercdescontoExit(Sender: TObject);
    procedure edtpercdescontoKeyPress(Sender: TObject; var Key: char);
    procedure edtvlrdescontoExit(Sender: TObject);
    procedure edtvlrdescontoKeyPress(Sender: TObject; var Key: char);
    procedure edtvlrpagarExit(Sender: TObject);
    procedure edtvlrpagarKeyPress(Sender: TObject; var Key: char);
    procedure edtvlravistaKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure edtnparcKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  frmfechapedidovenda: Tfrmfechapedidovenda;

implementation
       uses ufuncao_geral, umodulo_receber, umodulo_pedidovenda, umodulo_especie,
            umodulo_conexaodb, umodulo_master_indice, ucadastro_parcelafinanceiro;
{$R *.lfm}

{ Tfrmfechapedidovenda }

procedure Tfrmfechapedidovenda.DBLookupComboBox1KeyPress(Sender: TObject;
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

procedure Tfrmfechapedidovenda.edtpercdescontoExit(Sender: TObject);
begin
  edtvlrdesconto.Value:=edtpercdesconto.Value/100*strtofloat(tirapontos(lbltotal.Caption));
  edtvlrpagar.Value:=strtofloat(tirapontos(lbltotal.Caption))-edtvlrdesconto.Value;
end;

procedure Tfrmfechapedidovenda.btnlancarClick(Sender: TObject);
begin


end;

procedure Tfrmfechapedidovenda.btnalterarfinClick(Sender: TObject);
begin

  frmcadastro_parcelafinanceiro := tfrmcadastro_parcelafinanceiro.Create(self);
  frmcadastro_parcelafinanceiro.ShowModal;
  frmcadastro_parcelafinanceiro.Free;
  frmcadastro_parcelafinanceiro := nil;

end;

procedure Tfrmfechapedidovenda.btnlancarparcelaClick(Sender: TObject);
var
  i, iIntervalo:integer;
begin

  with modulo_conexaodb do
     begin

       qrexec_base.Close;
       qrexec_base.SQL.Clear;
       qrexec_base.SQL.Add('delete from tmaster_receber where codpedidovenda = :codpedidovenda');
       qrexec_base.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
       qrexec_base.ExecSQL;

       atualizaBanco;

       modulo_receber.qrMasterReceber.Refresh;

     end;
  //endi

  i := 1;

  iIntervalo := 30;

  while i <= edtnparc.Value do
     begin



       with modulo_conexaodb do
          begin

             qrexec_base.close;
             qrexec_base.SQL.Clear;
             qrexec_base.SQL.Add('insert into tmaster_receber( CODPEDIDOVENDA, DESCRICAOLANCAMENTO, QTDEPARCELA, NPARCELA, CODCLIENTE,         CLIENTE, CODESPECIE, ESPECIE, DATAHORACADASTRO,         DATAVENCIMENTO, CODPLANOCONTA, PLANOCONTA, DOCUMENTO,          ORIGEM, VALORORIGINAL,         OBS, CODFUNCIONARIO, FUNCIONARIO, CODVENDEDOR, VENDEDOR,        CODBARRA, REPLICADA, STATUS,        PRAZO)');
             qrexec_base.SQL.Add('                     values( :CODPEDIDOVENDA, :DESCRICAOLANCAMENTO, :QTDEPARCELA, :NPARCELA, :CODCLIENTE,      :CLIENTE, :CODESPECIE, :ESPECIE, :DATAHORACADASTRO,     :DATAVENCIMENTO, :CODPLANOCONTA, :PLANOCONTA, :DOCUMENTO,      :ORIGEM, :VALORORIGINAL,      :OBS, :CODFUNCIONARIO, :FUNCIONARIO, :CODVENDEDOR, :VENDEDOR,    :CODBARRA, :REPLICADA, :STATUS,    :PRAZO)');

             qrexec_base.Params.ParamByName('CODPEDIDOVENDA').AsInteger :=  modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
             qrexec_base.Params.ParamByName('DESCRICAOLANCAMENTO').AsString := 'Parcela '+inttostr(i)+' de '+edtnparc.Text;
             qrexec_base.Params.ParamByName('QTDEPARCELA').AsInteger := edtnparc.Value;
             qrexec_base.Params.ParamByName('NPARCELA').AsInteger := i;

             qrexec_base.Params.ParamByName('CODCLIENTE').AsInteger :=  modulo_pedidovenda.qrpedidovenda.fieldbyname('codcliente').asInteger;
             qrexec_base.Params.ParamByName('CLIENTE').AsString := modulo_pedidovenda.qrpedidovenda.fieldbyname('cliente').asString;

             qrconsulta_base.Close;
             qrconsulta_base.SQL.Clear;
             qrconsulta_base.SQL.Add('select * from tespecie where controle = :controle');
             qrconsulta_base.Params.ParamByName('controle').AsInteger:= modulo_master_indice.qrmaster_indice.FieldByName('CPAGAMENTOAPRAZOPADRAO').AsInteger;
             qrconsulta_base.Open;

             qrexec_base.Params.ParamByName('CODESPECIE').AsInteger := qrconsulta_base.FieldByName('controle').AsInteger;
             qrexec_base.Params.ParamByName('ESPECIE').AsString  :=  qrconsulta_base.FieldByName('especie').AsString;

             qrconsulta_base.Close;
             qrconsulta_base.SQL.Clear;
             qrconsulta_base.SQL.Add('select * from tplanoconta where controle = :controle');
             qrconsulta_base.Params.ParamByName('controle').AsInteger:= modulo_master_indice.qrmaster_indice.FieldByName('CPLANOCONTAAPRAZOPADRAO').AsInteger;
             qrconsulta_base.Open;

             qrexec_base.Params.ParamByName('CODPLANOCONTA').AsInteger :=  qrconsulta_base.FieldByName('controle').AsInteger;
             qrexec_base.Params.ParamByName('PLANOCONTA').AsString     :=  qrconsulta_base.FieldByName('planoconta').AsString;

             qrexec_base.Params.ParamByName('CODFUNCIONARIO').AsInteger := modulo_pedidovenda.qrpedidovenda.FieldByName('codfuncionario').AsInteger;
             qrexec_base.Params.ParamByName('FUNCIONARIO').AsString := modulo_pedidovenda.qrpedidovenda.FieldByName('funcionario').AsString;
             qrexec_base.Params.ParamByName('CODVENDEDOR').AsInteger := modulo_pedidovenda.qrpedidovenda.FieldByName('codvendedor').AsInteger;
             qrexec_base.Params.ParamByName('VENDEDOR').AsString  := modulo_pedidovenda.qrpedidovenda.FieldByName('vendedor').AsString;

             qrexec_base.Params.ParamByName('DATAHORACADASTRO').AsDatetime := now();
             qrexec_base.Params.ParamByName('DATAVENCIMENTO').AsDate :=  date()+iIntervalo;
             qrexec_base.Params.ParamByName('DOCUMENTO').AsString := 'DAV nº '+modulo_pedidovenda.qrpedidovenda.FieldByName('controlevarchar').AsString;
             qrexec_base.Params.ParamByName('ORIGEM').AsString := 'PEDIDO DE VENDA';
             qrexec_base.Params.ParamByName('VALORORIGINAL').Asfloat := (edtvlrpagar.Value - edtvlravista.Value) / edtnparc.Value;
             qrexec_base.Params.ParamByName('PRAZO').AsInteger  :=  iIntervalo;
             //qrexec_base.//Params.ParamByName('OBS').AsString
             //qrexec_base.//Params.ParamByName('CODBARRA').AsString
             qrexec_base.Params.ParamByName('REPLICADA').AsString  := 'SIM';
             qrexec_base.Params.ParamByName('STATUS').AsString  := 'A';

             qrexec_base.ExecSQL;

             atualizaBanco;


          end;
       //endth

       i := i + 1;

       iIntervalo := iIntervalo + 30;


     end;


     modulo_receber.qrMasterReceber.Refresh;






end;

procedure Tfrmfechapedidovenda.DBGrid1KeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
     begin

       modulo_receber.qrMasterReceber.Post;

     end;
end;

procedure Tfrmfechapedidovenda.edtpercdescontoKeyPress(Sender: TObject;
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

procedure Tfrmfechapedidovenda.edtvlrdescontoExit(Sender: TObject);
begin
  edtpercdesconto.Value:=edtvlrdesconto.Value/strtofloat(tirapontos(lbltotal.Caption))*100;
  edtvlrpagar.Value:=strtofloat(tirapontos(lbltotal.Caption))-edtvlrdesconto.Value;
end;

procedure Tfrmfechapedidovenda.edtvlrdescontoKeyPress(Sender: TObject;
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

procedure Tfrmfechapedidovenda.edtvlrpagarExit(Sender: TObject);
begin
  edtvlrdesconto.Value:=strtofloat(tirapontos(lbltotal.Caption))-edtvlrpagar.Value;
  edtpercdesconto.Value:=edtvlrdesconto.Value/strtofloat(tirapontos(lbltotal.Caption))*100;
end;

procedure Tfrmfechapedidovenda.edtvlrpagarKeyPress(Sender: TObject;
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

procedure Tfrmfechapedidovenda.edtvlravistaKeyPress(Sender: TObject;
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

procedure Tfrmfechapedidovenda.FormCreate(Sender: TObject);
begin

  lblpeddav.Caption :=  formatfloat('00000',modulo_pedidovenda.qrpedidovenda.FieldByName('controle').asfloat)+'/'+formatfloat('00000',modulo_pedidovenda.qrpedidovenda.FieldByName('controlevarchar').asfloat);
  lblnomecli.Caption:=  modulo_pedidovenda.qrpedidovenda.FieldByName('cliente').asString;
  lbltotal.Caption:=    formatfloat('###,###,##0.00',modulo_pedidovenda.qrpedidovenda.FieldByName('totalprodutos').asfloat);
  edtvlrpagar.Value:=   modulo_pedidovenda.qrpedidovenda.FieldByName('totalprodutos').asfloat;

  with modulo_master_indice do
     begin

       qrmaster_indice.Close;
       qrmaster_indice.SQL.Clear;
       qrmaster_indice.SQL.Add('select * from tmaster_indice');
       qrmaster_indice.Open;


     end;
 //endth


  with modulo_especie do
     begin

       qrespecie.Close;
       qrespecie.SQL.Clear;
       qrespecie.SQL.Add('select * from tespecie');
       qrespecie.Open;

     end;
  //endth




  with modulo_receber do
    begin

      qrMasterReceber.Close;
      qrMasterReceber.SQL.Clear;
      qrMasterReceber.SQL.Add('select * from tmaster_receber where codpedidovenda = :codpedidovenda');
      qrMasterReceber.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
      qrMasterReceber.Open;

      //dblcontrole.KeyFields:='codespecie';
      //dblcontrole.LookupKeyFields:='controle';
      //dblcontrole.LookupResultField:='especie';
      //dblcontrole.LookupDataSet := modulo_especie.qrEspecie;



    end;
  //endth


end;

procedure Tfrmfechapedidovenda.edtnparcKeyPress(Sender: TObject; var Key: char
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

end.

