unit upedido_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DbCtrls, DBGrids, ZDataset, db, BufDataset, usincorc,
  Types, LCLType;

type

  { Tfrmpedido_pesquisa }

  Tfrmpedido_pesquisa = class(TForm)
    btnfiltrar: TButton;
    btnimprimir: TButton;
    btnlimpar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    btnsinc: TButton;
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
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnimprimirClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure btnsincClick(Sender: TObject);
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
    procedure dsorcamentoDataChange(Sender: TObject; Field: TField);
    procedure edtdatafimKeyPress(Sender: TObject; var Key: char);
    procedure edtdatainicioKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
  frmpedido_pesquisa: Tfrmpedido_pesquisa;

implementation
     uses ufuncao_geral,  umodulo_orcamento, uorcamento_cadastro, umodulo_cliente, umodulo_funcionario, uorcamento_impressao, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmpedido_pesquisa }

procedure Tfrmpedido_pesquisa.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmpedido_pesquisa.FormCreate(Sender: TObject);
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

procedure Tfrmpedido_pesquisa.btnfiltrarClick(Sender: TObject);
begin
  filtrar;
end;

procedure Tfrmpedido_pesquisa.btnimprimirClick(Sender: TObject);
begin
  frmorcamento_impressao := tfrmorcamento_impressao.Create(self);
  frmorcamento_impressao.ShowModal;
  frmorcamento_impressao.free;
  frmorcamento_impressao := nil;
end;

procedure Tfrmpedido_pesquisa.btnlimparClick(Sender: TObject);
begin
  limpar;
end;

procedure Tfrmpedido_pesquisa.btnsincClick(Sender: TObject);
begin
  frmsincorc := tfrmsincorc.create(self);
  frmsincorc.showmodal;
  frmsincorc.free;
  frmsincorc := nil;
end;

procedure Tfrmpedido_pesquisa.Button1Click(Sender: TObject);
begin
  opcao := 'I';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;
  frmorcamento_cadastro := nil;


end;

procedure Tfrmpedido_pesquisa.Button2Click(Sender: TObject);
begin
 opcao := 'A';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;
  frmorcamento_cadastro := nil;

end;

procedure Tfrmpedido_pesquisa.Button3Click(Sender: TObject);
begin
  opcao := 'E';

  if modulo_orcamento.qrorcamento.RecordCount = 0 then
     application.MessageBox('Nenhum registro existente!','Atenção',MB_OK);
  //endi

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;
  frmorcamento_cadastro := nil;


  //frmorcamento_cadastro := nil;
end;

procedure Tfrmpedido_pesquisa.Button4Click(Sender: TObject);
begin
  opcao := 'C';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;
  frmorcamento_cadastro := nil;


  //frmorcamento_cadastro := nil;
end;

procedure Tfrmpedido_pesquisa.Button5Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmpedido_pesquisa.cbxnomeclienteKeyPress(Sender: TObject;
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

procedure Tfrmpedido_pesquisa.cbxnomefunKeyPress(Sender: TObject;
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

procedure Tfrmpedido_pesquisa.cbxnomevenKeyPress(Sender: TObject;
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

procedure Tfrmpedido_pesquisa.DBGrid1KeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrmpedido_pesquisa.DBGrid1KeyPress(Sender: TObject; var Key: char
  );
begin

end;

procedure Tfrmpedido_pesquisa.DBText2Click(Sender: TObject);
begin

end;

procedure Tfrmpedido_pesquisa.dsorcamentoDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure Tfrmpedido_pesquisa.edtdatafimKeyPress(Sender: TObject;
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

procedure Tfrmpedido_pesquisa.edtdatainicioKeyPress(Sender: TObject;
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

procedure Tfrmpedido_pesquisa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

  //modulo_conexaodb.atualizaBancoFechaTransacao;

  //FreeAndNil(frmpedido_pesquisa);  //Action:= caFree;  //frmpedido_pesquisa := nil;

end;

procedure Tfrmpedido_pesquisa.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmpedido_pesquisa.limpar;
begin
  edtdatainicio.Date:= date;
  edtdatafim.Date:=date;


   modulo_cliente.qrtempCliente.FieldByName('ccli').AsInteger:=0;
   modulo_funcionario.qrtempFuncionario.FieldByName('cfun').AsInteger:=0;
   modulo_funcionario.qrtempVendedor.FieldByName('cven').AsInteger:=0;




  filtrar;
end;

procedure Tfrmpedido_pesquisa.pnlsuperiorClick(Sender: TObject);
begin

end;

procedure Tfrmpedido_pesquisa.filtrar;
var sdti,sdtf,filtro:string;


begin
  sdti := formatdatetime('dd.mm.yyyy', edtdatainicio.date);
  sdtf := formatdatetime('dd.mm.yyyy',edtdatafim.Date);

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

  with modulo_orcamento do
    begin

      qrorcamento.Active:= false;
      qrorcamento.SQL.Clear;
      qrorcamento.SQL.Add('select * from torcamento where (data >= :dti and data <= :dtf) ' +filtro);
      qrorcamento.ParamByName('dti').AsDate:= edtdatainicio.date;
      qrorcamento.ParamByName('dtf').AsDate:= edtdatafim.Date;
      qrorcamento.Active:=true;

    end;
  //endth

end;

end.

