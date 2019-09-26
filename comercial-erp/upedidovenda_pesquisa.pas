unit upedidovenda_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DbCtrls, DBGrids, ZDataset, db, BufDataset, usincorc,
  Types, LCLType;

type

  { Tfrmpedidovenda_pesquisa }

  Tfrmpedidovenda_pesquisa = class(TForm)
    btnimpressao: TButton;
    btnfiltrar: TButton;
    btnfecharpedido: TButton;
    btnlimpar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    btnfecharpedido1: TButton;
    DBGrid1: TDBGrid;
    DBText1: TDBText;
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
    procedure btnimpressaoClick(Sender: TObject);
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnfecharpedidoClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure btnfecharpedido1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure cbxnomeclienteKeyPress(Sender: TObject; var Key: char);
    procedure cbxnomefunKeyPress(Sender: TObject; var Key: char);
    procedure cbxnomevenKeyPress(Sender: TObject; var Key: char);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1KeyPress(Sender: TObject; var Key: char);
    procedure DBText2Click(Sender: TObject);

    procedure edtdatafimKeyPress(Sender: TObject; var Key: char);
    procedure edtdatainicioKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
    procedure pnlsuperiorClick(Sender: TObject);
  private

  public
      opcao:string;
  end;

var
  frmpedidovenda_pesquisa: Tfrmpedidovenda_pesquisa;

implementation
     uses ufuncao_geral,  umodulo_pedidovenda, upedidovenda_cadastro, umodulo_cliente, umodulo_funcionario,
          upedidovenda_impressao, umodulo_conexaodb, ufechapedidovenda;
{$R *.lfm}

{ Tfrmpedidovenda_pesquisa }

procedure Tfrmpedidovenda_pesquisa.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_pesquisa.FormCreate(Sender: TObject);
begin


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
  cbxnomecliente.DataSource := modulo_cliente.dstempCliente;
  cbxnomecliente.DataField:='ccli';
  cbxnomecliente.ScrollListDataset:=true;

  //cbxnomecliente.Style:=csDropDownList;


  cbxnomefun.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomefun.ListField:='funcionario';
  cbxnomefun.KeyField:='controle';
  cbxnomefun.DataSource:=modulo_funcionario.dstempFuncionario;
  cbxnomefun.DataField:='cfun';
  cbxnomefun.ScrollListDataset:=true;

  cbxnomeven.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomeven.ListField:='funcionario';
  cbxnomeven.KeyField:='controle';
  cbxnomeven.DataSource:=modulo_funcionario.dstempVendedor;
  cbxnomeven.DataField:='cven';
  cbxnomeven.ScrollListDataset:=true;


  limpar;




end;

procedure Tfrmpedidovenda_pesquisa.FormShow(Sender: TObject);
begin
    with modulo_pedidovenda do
    begin

      qrmaster_pedidovenda.close;
      qrmaster_pedidovenda.SQL.Clear;
      qrmaster_pedidovenda.SQL.Add('select * from tmaster_pedidovenda where controle_tpedidovenda = :controle_tpedidovenda');
      qrmaster_pedidovenda.Params.ParamByName('controle_tpedidovenda').AsInteger:=qrpedidovenda.FieldByName('controle').AsInteger;
      qrmaster_pedidovenda.Open;

      if qrmaster_pedidovenda.FieldByName('statuspedido').AsString = 'F' then
         frmpedidovenda_pesquisa.btnfecharpedido.Caption:='Forma Pagto'
      else
         frmpedidovenda_pesquisa.btnfecharpedido.Caption:='Lançar Pedido';
      //endiif



    end;
  //endth

end;

procedure Tfrmpedidovenda_pesquisa.btnfiltrarClick(Sender: TObject);
begin
  filtrar;
end;

procedure Tfrmpedidovenda_pesquisa.btnimpressaoClick(Sender: TObject);
begin
   frmpedidovenda_impressao := tfrmpedidovenda_impressao.Create(self);
   frmpedidovenda_impressao.ShowModal;
   frmpedidovenda_impressao.free;
   frmpedidovenda_impressao := nil;

end;

procedure Tfrmpedidovenda_pesquisa.btnfecharpedidoClick(Sender: TObject);
begin

  frmfechapedidovenda := tfrmfechapedidovenda.Create(self);
  frmfechapedidovenda.ShowModal;
  frmfechapedidovenda.free;
  frmfechapedidovenda := nil;




end;

procedure Tfrmpedidovenda_pesquisa.btnlimparClick(Sender: TObject);
begin
  limpar;
end;

procedure Tfrmpedidovenda_pesquisa.btnfecharpedido1Click(Sender: TObject);
begin
  frmsincorc := tfrmsincorc.create(self);
  frmsincorc.showmodal;
  frmsincorc.free;
  frmsincorc := nil;
end;

procedure Tfrmpedidovenda_pesquisa.Button1Click(Sender: TObject);
begin
  opcao := 'I';

  frmpedidovenda_cadastro := tfrmpedidovenda_cadastro.Create(self);
  frmpedidovenda_cadastro.ShowModal;
  frmpedidovenda_cadastro.Free;
  frmpedidovenda_cadastro := nil;


end;

procedure Tfrmpedidovenda_pesquisa.Button2Click(Sender: TObject);
begin
 opcao := 'A';

  frmpedidovenda_cadastro := tfrmpedidovenda_cadastro.Create(self);
  frmpedidovenda_cadastro.ShowModal;
  frmpedidovenda_cadastro.Free;
  frmpedidovenda_cadastro := nil;

end;

procedure Tfrmpedidovenda_pesquisa.Button3Click(Sender: TObject);
begin
  opcao := 'E';

  if modulo_pedidovenda.qrpedidovenda.RecordCount = 0 then
     application.MessageBox('Nenhum registro existente!','Atenção',MB_OK);
  //endi

  frmpedidovenda_cadastro := tfrmpedidovenda_cadastro.Create(self);
  frmpedidovenda_cadastro.ShowModal;
  frmpedidovenda_cadastro.Free;
  frmpedidovenda_cadastro := nil;


  //frmpedidovenda_cadastro := nil;
end;

procedure Tfrmpedidovenda_pesquisa.Button4Click(Sender: TObject);
begin
  opcao := 'C';

  frmpedidovenda_cadastro := tfrmpedidovenda_cadastro.Create(self);
  frmpedidovenda_cadastro.ShowModal;
  frmpedidovenda_cadastro.Free;
  frmpedidovenda_cadastro := nil;


  //frmpedidovenda_cadastro := nil;
end;

procedure Tfrmpedidovenda_pesquisa.Button5Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmpedidovenda_pesquisa.cbxnomeclienteKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_pesquisa.cbxnomefunKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_pesquisa.cbxnomevenKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_pesquisa.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = 13 then
   begin
     key := 0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
   //endi

   if key = 9 then
   begin
     key := 0;

     exit;
   end;
   //endi



end;

procedure Tfrmpedidovenda_pesquisa.DBGrid1KeyPress(Sender: TObject; var Key: char
  );
begin

end;

procedure Tfrmpedidovenda_pesquisa.DBText2Click(Sender: TObject);
begin

end;



procedure Tfrmpedidovenda_pesquisa.edtdatafimKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_pesquisa.edtdatainicioKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_pesquisa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

  //modulo_conexaodb.atualizaBancoFechaTransacao;

  //FreeAndNil(frmpedidovenda_pesquisa);  //Action:= caFree;  //frmpedidovenda_pesquisa := nil;

end;

procedure Tfrmpedidovenda_pesquisa.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_pesquisa.limpar;
begin
  edtdatainicio.Date:= date;
  edtdatafim.Date:=date;


   modulo_cliente.qrtempCliente.FieldByName('ccli').AsInteger:=0;
   modulo_funcionario.qrtempFuncionario.FieldByName('cfun').AsInteger:=0;
   modulo_funcionario.qrtempVendedor.FieldByName('cven').AsInteger:=0;




  filtrar;
end;

procedure Tfrmpedidovenda_pesquisa.pnlsuperiorClick(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_pesquisa.filtrar;
var sdti,sdtf,filtro:string;


begin
  sdti := formatdatetime('dd.mm.yyyy 00:00', edtdatainicio.date);
  sdtf := formatdatetime('dd.mm.yyyy 23:59',edtdatafim.Date);

  filtro := '';

  if modulo_cliente.qrtempCliente.FieldByName('ccli').AsInteger  > 0 then
     begin
       filtro := filtro +' and (codcliente = ' +  inttostr(modulo_cliente.qrtempCliente.FieldByName('ccli').AsInteger)  +')';
     end;
  //endi


  if modulo_funcionario.qrtempFuncionario.FieldByName('cfun').AsInteger > 0 then
     begin
       filtro := filtro + ' and (codfuncionario = '+ inttostr(modulo_funcionario.qrtempFuncionario.FieldByName('cfun').AsInteger ) +')';
     end;
  //endi


  if modulo_funcionario.qrtempVendedor.FieldByName('cven').AsInteger > 0 then
     begin
       filtro := filtro + ' and (codvendedor = '+ inttostr(modulo_funcionario.qrtempVendedor.FieldByName('cven').AsInteger ) +')';
     end;
  //endi

  //showmessage(filtro);

  with modulo_pedidovenda do
    begin

      qrpedidovenda.Close;
      qrpedidovenda.SQL.Clear;
      qrpedidovenda.SQL.Add('select * from tpedidovenda where (cast(datahoracadastro as date) >= :dti and cast(datahoracadastro as date) <= :dtf) ' +filtro);
      qrpedidovenda.ParamByName('dti').AsDateTime:= edtdatainicio.Date;
      qrpedidovenda.ParamByName('dtf').AsDateTime:= edtdatafim.Date;
      qrpedidovenda.open;




    end;
  //endth




end;

end.

