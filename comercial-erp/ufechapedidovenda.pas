unit ufechapedidovenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin, DbCtrls, DBGrids, Buttons, Types, LCLType;

type

  { Tfrmfechapedidovenda }

  Tfrmfechapedidovenda = class(TForm)
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
    procedure btnlancarClick(Sender: TObject);
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
       uses ufuncao_geral, umodulo_receber, umodulo_pedidovenda, umodulo_especie;
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

