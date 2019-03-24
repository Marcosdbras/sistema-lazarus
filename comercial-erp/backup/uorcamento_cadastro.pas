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
    btnAlterarproduto: TButton;
    btnCancelarAltprod: TButton;
    btnExcluirProduto: TButton;
    btnClassItem: TButton;
    btnlancar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    cbxunidade: TDBLookupComboBox;
    cbxnomecliente: TDBLookupComboBox;
    cbxnomeven: TDBLookupComboBox;
    cbxnomefun: TDBLookupComboBox;
    dbgproduto: TDBGrid;
    cbxtabpreco: TDBLookupComboBox;
    edtdescricao: TEdit;
    edtqtde: TFloatSpinEdit;
    edttotal: TFloatSpinEdit;
    edtvlrsubtotal: TFloatSpinEdit;
    edtvlrunitario: TFloatSpinEdit;
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
    Label7: TLabel;
    lblcliente8: TLabel;
    lblestadocli: TLabel;
    lblcidadecli: TLabel;
    lblenderecocli: TLabel;
    lblcliente6: TLabel;
    lblcliente7: TLabel;
    lblcontroleprod: TLabel;
    lblnumerocli: TLabel;
    lblbairrocli: TLabel;
    lblcepcli: TLabel;
    lblstatus: TLabel;
    lblcliente: TLabel;
    lblcliente1: TLabel;
    lblcliente2: TLabel;
    lblcliente3: TLabel;
    lblcliente4: TLabel;
    lblcliente5: TLabel;
    memoformapgto: TMemo;
    memoobs: TMemo;
    Panel1: TPanel;
    pnlobservacao: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    ScrollBox1: TScrollBox;
    ediprazo: TSpinEdit;
    procedure btnCancelarAltprodClick(Sender: TObject);
    procedure btnClassItemClick(Sender: TObject);
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnimprimirClick(Sender: TObject);
    procedure btnlancarClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAlterarprodutoClick(Sender: TObject);
    procedure btnExcluirProdutoClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure cbxnomeclienteChange(Sender: TObject);
    procedure cbxnomeclienteExit(Sender: TObject);
    procedure cbxnomeclienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxnomeclienteKeyPress(Sender: TObject; var Key: char);
    procedure cbxnomeclienteSelect(Sender: TObject);
    procedure cbxnomefunExit(Sender: TObject);
    procedure cbxnomefunKeyPress(Sender: TObject; var Key: char);
    procedure cbxnomevenExit(Sender: TObject);
    procedure cbxnomevenKeyPress(Sender: TObject; var Key: char);
    procedure cbxtabprecoKeyPress(Sender: TObject; var Key: char);
    procedure cbxunidadeKeyPress(Sender: TObject; var Key: char);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: char);
    procedure dbgprodutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure dbgprodutoKeyPress(Sender: TObject; var Key: char);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid2KeyPress(Sender: TObject; var Key: char);
    procedure DBText2Click(Sender: TObject);
    procedure dsorcamentoDataChange(Sender: TObject; Field: TField);
    procedure ediprazoKeyPress(Sender: TObject; var Key: char);
    procedure edtdescricaoExit(Sender: TObject);
    procedure edtdescricaoKeyPress(Sender: TObject; var Key: char);
    procedure edtqtdeChange(Sender: TObject);
    procedure edtqtdeExit(Sender: TObject);
    procedure edtqtdeKeyPress(Sender: TObject; var Key: char);
    procedure edtKeyPress(Sender: TObject; var Key: char);
    procedure edtvlrsubtotalKeyPress(Sender: TObject; var Key: char);
    procedure edtpercdescKeyPress(Sender: TObject; var Key: char);
    procedure edtvlrdescKeyPress(Sender: TObject; var Key: char);
    procedure edtliquidoKeyPress(Sender: TObject; var Key: char);
    procedure edtvlrunitario4KeyPress(Sender: TObject; var Key: char);
    procedure edtvlrunitario5KeyPress(Sender: TObject; var Key: char);
    procedure edtvlrunitarioExit(Sender: TObject);
    procedure edtvlrunitarioKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure memoformapgtoKeyPress(Sender: TObject; var Key: char);
    procedure Panel6Click(Sender: TObject);
    procedure Panel9Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
    procedure salvarCadastro;
    procedure limparProduto;
    procedure salvarProduto;
    procedure mostrarItemProduto;
    procedure mostrarProduto;
    procedure bloqueiaProdutoAlt;
    procedure desbloqueiaProdutoAlt;
    procedure classificarItem;
    procedure mostrarDados;




    procedure ScrollBox1Click(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
  private
      icodigo_controle, icodigo_controle_item, codaplicacaoproduto:integer;
      opcao_item, cfop, referencia, fatorconversao, codbarras, descricaoun, nomeprod:string;
      qtdeconvertida, valorconversao:real;

  public
    procedure localizaUn;
    procedure carregaCampoProd;

  end;

var
  frmorcamento_cadastro: Tfrmorcamento_cadastro;

implementation

uses ufuncao_geral, umodulo_orcamento, uorcamento_pesquisa, umodulo_cliente, umodulo_funcionario,
      umodulo_conexaodb, umodulo_unidade, umodulo_produto, uproduto_consulta, umodulo_geral,
      umodulo_tabpreco, ucotacao_cadastro;

{$R *.lfm}

{ Tfrmorcamento_cadastro }

procedure Tfrmorcamento_cadastro.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.memoformapgtoKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
//endi
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
       qrunidade.SQL.Add('select * from tunidademedida order by descricao');
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


  with modulo_tabpreco do
    begin

      qrtabpreco.Close;
      qrtabpreco.SQL.Clear;
      qrtabpreco.SQL.Add('select * from ttabelapreco where ativo = :ativo order by nometabela');
      qrtabpreco.ParamByName('ativo').AsString:='SIM';
      qrtabpreco.Open;

    end;
  //endth

  memoformapgto.Lines.Clear;
  memoobs.Lines.Clear;

  with modulo_geral do
        begin

          qrmaster_indice.Close;
          qrmaster_indice.SQL.Clear;
          qrmaster_indice.SQL.Add('select * from master_indice');
          qrmaster_indice.Open;

        end;
  //endi

  with modulo_orcamento do
    begin
      if frmorcamento_pesquisa.opcao <> 'I' then
         begin

           icodigo_controle := qrorcamento.FieldByName('controle').AsInteger;

           qrtempCliente.FieldByName('ccli').AsInteger:= qrorcamento.FieldByName('codcliente').AsInteger;
           qrtempFuncionario.FieldByName('cfun').AsInteger:= qrorcamento.FieldByName('codfuncionario').AsInteger;
           qrtempVendedor.FieldByName('cven').AsInteger:= qrorcamento.FieldByName('codvendedor').AsInteger;

           memoformapgto.Lines.Add(qrorcamento.FieldByName('condicaopagamento').AsString);
           memoobs.Lines.Add(qrorcamento.FieldByName('observacao').AsString);

           modulo_cliente.qrcliente.Locate('controle',qrorcamento.FieldByName('codcliente').AsInteger,[]);

           lblenderecocli.Caption:= modulo_cliente.qrcliente.FieldByName('endereco').AsString;
           lblnumerocli.Caption:=modulo_cliente.qrcliente.FieldByName('numero').AsString;
           lblbairrocli.Caption:=modulo_cliente.qrcliente.FieldByName('bairro').AsString;
           lblcidadecli.Caption:=modulo_cliente.qrcliente.FieldByName('cidade').AsString;
           lblcepcli.Caption:=modulo_cliente.qrcliente.FieldByName('cep').AsString;
           lblestadocli.Caption:=modulo_cliente.qrcliente.FieldByName('uf').AsString;

           modulo_conexaodb.qrconsulta_base.Close;
           modulo_conexaodb.qrconsulta_base.SQL.Clear;
           modulo_conexaodb.qrconsulta_base.SQL.Add('select * from master_orcamento where controle_torcamento = :controle_torcamento');
           modulo_conexaodb.qrconsulta_base.Params.ParamByName('controle_torcamento').AsInteger := modulo_orcamento.qrorcamento.FieldByName('controle').AsInteger;
           modulo_conexaodb.qrconsulta_base.Open;

           modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger:=modulo_conexaodb.qrconsulta_base.FieldByName('ctabp').AsInteger;
           ediprazo.Value :=  modulo_conexaodb.qrconsulta_base.FieldByName('prazo').AsInteger;
           //showmessage(modulo_conexaodb.qrconsulta_base.FieldByName('ctabp').AsString);



           edttotal.Value:= qrorcamento.FieldByName('valortotal').Asfloat;

         end
      else
         begin
           icodigo_controle := 0;

           qrtempCliente.FieldByName('ccli').AsInteger:=0;
           qrtempFuncionario.FieldByName('cfun').AsInteger:=0;
           qrtempVendedor.FieldByName('cven').AsInteger:=0;

            memoformapgto.Lines.add(modulo_geral.qrmaster_indice.FieldByName('padraoorcamento').AsString);


           modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger:=0;

           ediprazo.Value := 0;

            lblenderecocli.Caption:= '';
            lblnumerocli.Caption:='';
            lblbairrocli.Caption:='';
            lblcidadecli.Caption:='';
            lblcepcli.Caption:='';
            lblestadocli.Caption:='';

            edttotal.Value := 0;

         end;
      //endi

      mostrarItemProduto;

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
  cbxunidade.ListField:='descricao';
  cbxunidade.KeyField:='controle';
  cbxunidade.DataSource:=modulo_orcamento.dstempUnidade;
  cbxunidade.DataField:='cund';
  cbxunidade.ScrollListDataset:=true;

  cbxtabpreco.ListSource := modulo_tabpreco.dstabpreco;
  cbxtabpreco.ListField:='nometabela';
  cbxtabpreco.KeyField:='controle';
  cbxtabpreco.DataSource:=modulo_tabpreco.dstemptabpreco;
  cbxtabpreco.DataField:='ctabp';
  cbxtabpreco.ScrollListDataset:=true;

  limparProduto;


  {
  modulo_conexaodb.qrconsulta_base.Close;
  modulo_conexaodb.qrconsulta_base.SQL.Clear;
  modulo_conexaodb.qrconsulta_base.SQL.Add('select * from tcliente where controle = :controle');
  modulo_conexaodb.qrconsulta_base.Params.ParamByName('controle').AsInteger := modulo_cliente.qrtempCliente.FieldByName('ccli').AsInteger;
  modulo_conexaodb.qrconsulta_base.Open;

  if modulo_conexaodb.qrconsulta_base.RecordCount > 0 then
     begin

       lblenderecocli.Caption:= modulo_conexaodb.qrconsulta_base.FieldByName('endereco').AsString;
       lblnumerocli.Caption:=modulo_conexaodb.qrconsulta_base.FieldByName('numero').AsString;
       lblbairrocli.Caption:=modulo_conexaodb.qrconsulta_base.FieldByName('bairro').AsString;
       lblcidadecli.Caption:=modulo_conexaodb.qrconsulta_base.FieldByName('cidade').AsString;
       lblcepcli.Caption:=modulo_conexaodb.qrconsulta_base.FieldByName('cep').AsString;
       lblestadocli.Caption:=modulo_conexaodb.qrconsulta_base.FieldByName('uf').AsString;

     end;
  //endi

  }


  btnCancelarAltprod.Enabled:=false;

end;

procedure Tfrmorcamento_cadastro.FormShow(Sender: TObject);
begin
  if (frmorcamento_pesquisa.opcao = 'I') or (frmorcamento_pesquisa.opcao = 'A') then
    begin

      cbxnomefun.SetFocus;

    end;
end;

procedure Tfrmorcamento_cadastro.GroupBox2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.btnfiltrarClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.btnimprimirClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.btnClassItemClick(Sender: TObject);

begin

  classificarItem;

  with modulo_orcamento do
    begin
      qrorcamento_itemproduto.Refresh;

      qrorcamento_itemproduto.Last;
    end;


end;

procedure Tfrmorcamento_cadastro.btnCancelarAltprodClick(Sender: TObject);
begin
  limparProduto;
  desbloqueiaProdutoAlt;
  edtdescricao.SetFocus;
end;

procedure Tfrmorcamento_cadastro.btnlancarClick(Sender: TObject);
begin
  if edtdescricao.Text = '' then
    begin
      Application.MessageBox('Não há nenhum produto no campo descrição para lançamento!','Atenção',MB_OK);
      if opcao_item = 'I' then
         begin
            edtdescricao.SetFocus;
         end;
      //endi
      exit;
    end;
 //endi


  if frmorcamento_pesquisa.opcao = 'I' then
     begin

       salvarCadastro;

     end;
  //endi

  salvarProduto;

  if frmorcamento_pesquisa.opcao = 'I' then
     begin

       mostrarItemProduto;

       frmorcamento_pesquisa.opcao:='A';

     end;
  //endi


  salvarCadastro;

  limparproduto;

  desbloqueiaProdutoAlt;

  edtdescricao.SetFocus;





end;

procedure Tfrmorcamento_cadastro.btnlimparClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.Button1Click(Sender: TObject);
begin

        salvarCadastro;


        if (frmorcamento_pesquisa.opcao = 'I')  then
           begin

              modulo_orcamento.qrorcamento.Locate('controle',icodigo_controle,[]);

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

        close;

end;

procedure Tfrmorcamento_cadastro.Button2Click(Sender: TObject);
begin
  //showmessage(modulo_conexaodb.qrtemp.FieldByName('ccli').AsString);

  Close;
end;

procedure Tfrmorcamento_cadastro.btnAlterarprodutoClick(Sender: TObject);
begin
  if modulo_orcamento.qrorcamento_itemproduto.RecordCount = 0 then
     begin
       Application.MessageBox('Não há nennhum produto para ser alterado!','Atenção',MB_OK);
       exit;
     end;
  //endi

  opcao_item := 'A';

  mostrarProduto;

  bloqueiaProdutoAlt;

  edtqtde.SetFocus;


end;

procedure Tfrmorcamento_cadastro.btnExcluirProdutoClick(Sender: TObject);
var subtotal:real;
    aSQLText: string;
    aSQLCommand: string;
    coditem:integer;

begin
  if modulo_orcamento.qrorcamento_itemproduto.RecordCount = 0 then
     begin
       Application.MessageBox('Não há nennhum produto para ser excluido!','Atenção',MB_OK);
       exit;
     end;
  //endi



  if Application.MessageBox('Tem certeza que deseja excluir o produto selecionado?','Atenção',MB_YESNO) = 6  then
     begin

       with modulo_conexaodb do
         begin

           icodigo_controle_item := modulo_orcamento.qrorcamento_itemproduto.FieldByName('controle').AsInteger;
           subtotal := modulo_orcamento.qrorcamento_itemproduto.FieldByName('totalliquido').Asfloat;
           coditem := modulo_orcamento.qrorcamento_itemproduto.FieldByName('coditem').AsInteger;

           qrexec_base.Close;
           qrexec_base.SQL.Clear;
           qrexec_base.SQL.Add('delete from titensorcamento where controle = :controle');
           qrexec_base.ParamByName('controle').AsInteger:= icodigo_controle_item;
           qrexec_base.ExecSQL;

           atualizaBanco;

           aSQLText:= 'execute procedure sptotalizaorcamento(%d)';
           aSQLCommand:= Format(aSQLText, [icodigo_controle]);
           conexaodb.ExecuteDirect(aSQLCommand);
           atualizaBanco;

           modulo_orcamento.qrorcamento.Refresh;

           modulo_orcamento.qrorcamento.Locate('controle',icodigo_controle,[]);

           modulo_orcamento.qrorcamento_itemproduto.Refresh;

           if not modulo_orcamento.qrorcamento_itemproduto.Locate('coditem',coditem+1,[]) then
              begin
                modulo_orcamento.qrorcamento_itemproduto.Last;
              end;
           //endi

         end;


        edttotal.Value:= modulo_orcamento.qrorcamento.FieldByName('valortotal').Asfloat;
     end;



end;

procedure Tfrmorcamento_cadastro.Button3Click(Sender: TObject);
begin

  frmcotacao_cadastro := tfrmcotacao_cadastro.Create(self);
  frmcotacao_cadastro.ShowModal;
  frmcotacao_cadastro.Free;
  frmcotacao_cadastro := nil;

end;

procedure Tfrmorcamento_cadastro.Button5Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.cbxnomeclienteChange(Sender: TObject);
begin




end;

procedure Tfrmorcamento_cadastro.cbxnomeclienteExit(Sender: TObject);
begin



end;

procedure Tfrmorcamento_cadastro.cbxnomeclienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

end;

procedure Tfrmorcamento_cadastro.cbxnomeclienteKeyPress(Sender: TObject;
  var Key: char);
begin






  if key = #13 then
   begin

     if modulo_cliente.qrcliente.Locate('cliente',cbxnomecliente.Text,[]) then
        begin

          lblenderecocli.Caption:= modulo_cliente.qrcliente.FieldByName('endereco').AsString;
          lblnumerocli.Caption:=modulo_cliente.qrcliente.FieldByName('numero').AsString;
          lblbairrocli.Caption:=modulo_cliente.qrcliente.FieldByName('bairro').AsString;
          lblcidadecli.Caption:=modulo_cliente.qrcliente.FieldByName('cidade').AsString;
          lblcepcli.Caption:=modulo_cliente.qrcliente.FieldByName('cep').AsString;
          lblestadocli.Caption:=modulo_cliente.qrcliente.FieldByName('uf').AsString;



        end
     else
        begin


          modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger:=0;

          ediprazo.Value := 0;

          lblenderecocli.Caption:= '';
          lblnumerocli.Caption:='';
          lblbairrocli.Caption:='';
          lblcidadecli.Caption:='';
          lblcepcli.Caption:='';
          lblestadocli.Caption:='';



        end;




     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
//endi







end;

procedure Tfrmorcamento_cadastro.cbxnomeclienteSelect(Sender: TObject);
begin
  mostrarDados;
end;

procedure Tfrmorcamento_cadastro.cbxnomefunExit(Sender: TObject);
begin
end;

procedure Tfrmorcamento_cadastro.cbxnomefunKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.cbxnomevenExit(Sender: TObject);
begin
end;

procedure Tfrmorcamento_cadastro.cbxnomevenKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.cbxtabprecoKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.cbxunidadeKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.ComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

end;

procedure Tfrmorcamento_cadastro.ComboBox1KeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.dbgprodutoKeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrmorcamento_cadastro.dbgprodutoKeyPress(Sender: TObject; var Key: char
  );
begin
end;

procedure Tfrmorcamento_cadastro.DBGrid2KeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrmorcamento_cadastro.DBGrid2KeyPress(Sender: TObject; var Key: char
  );
begin
end;

procedure Tfrmorcamento_cadastro.DBText2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.dsorcamentoDataChange(Sender: TObject; Field: TField);
begin

end;

procedure Tfrmorcamento_cadastro.ediprazoKeyPress(Sender: TObject; var Key: char
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

procedure Tfrmorcamento_cadastro.edtdescricaoExit(Sender: TObject);
var reglocalizado:integer;

begin

  if edtdescricao.Text = '' then
     exit;
  //endi


  if modulo_produto.localizaControle(edtdescricao.Text) = 0 then
     begin

       reglocalizado := modulo_produto.localizaDescricao(edtdescricao.Text);
       if reglocalizado = 0 then
          begin

            reglocalizado := modulo_produto.localizaCodBarra(edtdescricao.Text);
            if reglocalizado = 0 then
               begin

                  reglocalizado := modulo_produto.localizaCampo(edtdescricao.Text);
                  if reglocalizado = 0 then
                     begin

                        Application.MessageBox('Informação não localizada!','Atenção',MB_OK);
                        edtdescricao.SetFocus;

                     end
                  else
                     begin


                       if reglocalizado > 1 then
                          begin

                            frmproduto_consulta := tfrmproduto_consulta.Create(self);
                            frmproduto_consulta.ShowModal;
                            frmproduto_consulta.Free;
                            frmproduto_consulta := nil;

                          end
                       else
                          begin


                            carregaCampoProd;

                            localizaUn;


                          end;
                       //endi




                     end;
                  //endi

               end
            else
               begin


                  if reglocalizado > 1 then
                     begin

                       frmproduto_consulta := tfrmproduto_consulta.Create(self);
                       frmproduto_consulta.ShowModal;
                       frmproduto_consulta.Free;
                       frmproduto_consulta := nil;

                      end
                  else
                     begin
                       carregaCampoProd;

                       localizaUn;
                     end;
                  //endi


               end;
            //endi

          end
       else
          begin

            if reglocalizado > 1 then
               begin

                 frmproduto_consulta := tfrmproduto_consulta.Create(self);
                 frmproduto_consulta.ShowModal;
                 frmproduto_consulta.Free;
                 frmproduto_consulta := nil;

               end
            else
               begin

                 carregaCampoProd;

                 localizaUn;
               end;
            //endi

          end;
       //endi

     end
 else
    begin

      carregaCampoProd;

      localizaUn;

    end;
 //endi



end;

procedure Tfrmorcamento_cadastro.edtdescricaoKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtqtdeChange(Sender: TObject);
begin

end;

procedure Tfrmorcamento_cadastro.edtqtdeExit(Sender: TObject);
begin
  edtvlrsubtotal.Value:=edtqtde.Value*edtvlrunitario.Value;
end;

procedure Tfrmorcamento_cadastro.edtqtdeKeyPress(Sender: TObject; var Key: char
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

procedure Tfrmorcamento_cadastro.edtKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtvlrsubtotalKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtpercdescKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtvlrdescKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtliquidoKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtvlrunitario4KeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtvlrunitario5KeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.edtvlrunitarioExit(Sender: TObject);
begin
  edtvlrsubtotal.Value:=edtqtde.Value*edtvlrunitario.Value;
end;

procedure Tfrmorcamento_cadastro.edtvlrunitarioKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_cadastro.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin



  //FreeAndNil(frmorcamento_cadastro);
  //Action:= caFree;
  //frmorcamento_cadastro := nil;

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
            qrexec_base.SQL.Add('select GEN_ID(GEN_TORCAMENTO_ID,1) as prox_codigo FROM RDB$DATABASE;');
            qrexec_base.Open;

            icodigo_controle := qrexec_base.FieldByName('prox_codigo').AsInteger;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into torcamento(controle, codcliente,  nomecliente,  codfuncionario,  funcionario,  codvendedor, vendedor,  data, controlevarchar,   hora,  datahoracadastro, tipodesconto,   titulodav,  cancelado,  status, observacao, condicaopagamento  ) ');
            qrexec_base.SQL.Add('                values(:controle, :codcliente, :nomecliente, :codfuncionario, :funcionario, :codvendedor, :vendedor, :data, :controlevarchar, :hora, :datahoracadastro, :tipodesconto, :titulodav, :cancelado, :status, :observacao, :condicaopagamento  )');

            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle;
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
            qrexec_base.SQL.Add('update torcamento set codcliente = :codcliente,  nomecliente = :nomecliente,  codfuncionario = :codfuncionario,  funcionario = :funcionario,  codvendedor = :codvendedor, vendedor = :vendedor, observacao = :observacao, condicaopagamento = :condicaopagamento where controle = :controle');

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
            qrexec_base.ParamByName('condicaopagamento').AsString:=memoformapgto.Text;
            qrexec_base.ParamByName('observacao').AsString:=memoobs.Text;
            qrexec_base.ExecSQL;

            atualizaBanco;

            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select * from master_orcamento where controle_torcamento = :controle_torcamento');
            qrconsulta_base.Params.ParamByName('controle_torcamento').AsInteger := icodigo_controle;
            qrconsulta_base.Open;
            if qrconsulta_base.RecordCount = 0 then
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('insert into master_orcamento(controle_torcamento,ctabp,prazo) values (:controle_torcamento, :ctabp, :prazo);');
                 qrexec_base.Params.ParamByName('controle_torcamento').AsInteger := icodigo_controle;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.Params.ParamByName('prazo').AsInteger := ediprazo.Value;
                 qrexec_base.ExecSQL;

               end
            else
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('update master_orcamento  set ctabp = :ctabp, prazo = :prazo  where controle_torcamento   = :controle_torcamento;');
                 qrexec_base.Params.ParamByName('controle_torcamento').AsInteger := icodigo_controle;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.Params.ParamByName('prazo').AsInteger := ediprazo.Value;
                 qrexec_base.ExecSQL;




               end;
            //endi

            atualizaBanco;

          end;
        //endth


       modulo_orcamento.qrorcamento.Refresh;

       modulo_orcamento.qrorcamento.Locate('controle',icodigo_controle,[]);

       edttotal.Value:= modulo_orcamento.qrorcamento.FieldByName('valortotal').Asfloat;



     end;
  //endi







end;



procedure Tfrmorcamento_cadastro.salvarProduto;
var
  sequencia:integer;

begin

  with modulo_conexaodb do
    begin

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tunidademedida where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_orcamento.qrtempUnidade.FieldByName('cund').AsInteger;
      qrconsulta_base.Open;

      descricaoun := qrconsulta_base.FieldByName('descricao').AsString;

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from testoque where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:= strtoint(lblcontroleprod.Caption);
      qrconsulta_base.Open;

      nomeprod := qrconsulta_base.FieldByName('produto').AsString;



    end;
  //endth

  if opcao_item = 'I' then
     begin

        //Atualiza tabelas auxiliares do sistema
        with modulo_conexaodb do
          begin

            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select COALESCE(max(coditem),0)+1 as sequencia from TITENSORCAMENTO where CODORCAMENTO = :CODORCAMENTO');
            qrconsulta_base.ParamByName('codorcamento').AsInteger:=icodigo_controle;
            qrconsulta_base.Open;

            sequencia := qrconsulta_base.FieldByName('sequencia').AsInteger;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('select GEN_ID(GEN_TITENSORCAMENTO_ID,1) as prox_codigo FROM RDB$DATABASE;');
            qrexec_base.Open;

            icodigo_controle_item := qrexec_base.FieldByName('prox_codigo').AsInteger;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into TITENSORCAMENTO( controle,  codorcamento,  codproduto,  produto,  datahoracadastro,  coditem,  un,    valordescontounitario,  percdescontounitario,  valoracrescimounitario,  percacrescimounitario,   indicadorcancelamento,  decimaisqtde,  decimaisvalorunitario, totaldesconto,  numerodav,  cfop,   totalacrescimo,  referencia,  qtdeconvertida,  unconvertida,  codaplicacaoproduto,   qtde,   valorunitario ) ');
            qrexec_base.SQL.Add('                     values(:controle, :codorcamento, :codproduto, :produto, :datahoracadastro, :coditem, :un,   :valordescontounitario, :percdescontounitario, :valoracrescimounitario, :percacrescimounitario,  :indicadorcancelamento, :decimaisqtde, :decimaisvalorunitario,  :totaldesconto, :numerodav, :cfop,  :totalacrescimo, :referencia, :qtdeconvertida, :unconvertida, :codaplicacaoproduto,  :qtde,  :valorunitario ) ');


            qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
            qrexec_base.ParamByName('coditem').AsInteger:=sequencia;
            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle_item;
            qrexec_base.ParamByName('codorcamento').AsInteger := icodigo_controle;


          end;
        //endth
     end
  else if opcao_item = 'A' then
     begin
        with modulo_conexaodb do
          begin

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('update TITENSORCAMENTO set  codproduto = :codproduto,  produto = :produto,   un = :un,    valordescontounitario = :valordescontounitario,  percdescontounitario = :percdescontounitario,  valoracrescimounitario = :valoracrescimounitario,  percacrescimounitario = :percacrescimounitario,   indicadorcancelamento = :indicadorcancelamento,  decimaisqtde = :decimaisqtde,  decimaisvalorunitario = :decimaisvalorunitario, totaldesconto = :totaldesconto,  numerodav = :numerodav,  cfop = :cfop,   totalacrescimo = :totalacrescimo,  referencia = :referencia,  qtdeconvertida = :qtdeconvertida,  unconvertida = :unconvertida,  codaplicacaoproduto = :codaplicacaoproduto,   qtde = :qtde,   valorunitario = :valorunitario where controle = :controle');

            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle_item;


          end;
        //endth

     end;
  //endif

  if (opcao_item = 'I') or (opcao_item = 'A') then
     begin
        with modulo_conexaodb do
          begin

            qrexec_base.Params.ParamByName('codproduto').AsInteger := strtoint(lblcontroleprod.Caption);
            qrexec_base.ParamByName('produto').AsString:=  edtdescricao.Text;
            qrexec_base.ParamByName('un').AsString:= descricaoun;
            qrexec_base.ParamByName('valordescontounitario').Asfloat:= 0;
            qrexec_base.ParamByName('percdescontounitario').Asfloat:= 0;
            qrexec_base.ParamByName('valoracrescimounitario').Asfloat:= 0;
            qrexec_base.ParamByName('percacrescimounitario').Asfloat:= 0;
            qrexec_base.ParamByName('indicadorcancelamento').AsString:= 'N';
            qrexec_base.ParamByName('decimaisqtde').AsInteger:= 2;
            qrexec_base.ParamByName('decimaisvalorunitario').AsInteger:= 2;
            qrexec_base.ParamByName('qtde').Asfloat := edtqtde.Value;
            qrexec_base.ParamByName('valorunitario').Asfloat := edtvlrunitario.Value;
            qrexec_base.ParamByName('numerodav').AsString := modulo_orcamento.qrorcamento.FieldByName('controlevarchar').AsString;
            qrexec_base.ParamByName('referencia').AsString := referencia;
            qrexec_base.ParamByName('cfop').AsString := cfop;
            qrexec_base.ParamByName('codaplicacaoproduto').AsInteger := codaplicacaoproduto;
            //Analisar no SGBr como esta informação é persistida
            qrexec_base.ParamByName('qtdeconvertida').Asfloat := 1; //fatorconversao;  //valorconversao;

            qrexec_base.ExecSQL;

            atualizaBanco;


            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select * from master_itensorcamento where controle_titensorcamento = :controle_titensorcamento');
            qrconsulta_base.Params.ParamByName('controle_titensorcamento').AsInteger := icodigo_controle_item;
            qrconsulta_base.Open;
            if qrconsulta_base.RecordCount = 0 then
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('insert into master_itensorcamento(controle_titensorcamento,ctabp) values (:controle_titensorcamento, :ctabp);');
                 qrexec_base.Params.ParamByName('controle_titensorcamento').AsInteger := icodigo_controle_item;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.ExecSQL;

               end
            else
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('update master_itensorcamento  set ctabp = :ctabp where controle_titensorcamento   = :controle_titensorcamento;');
                 qrexec_base.Params.ParamByName('controle_titensorcamento').AsInteger := icodigo_controle_item;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.ExecSQL;




               end;
            //endi

            atualizaBanco;






          end;
        //endth


       modulo_orcamento.qrorcamento_itemproduto.Refresh;

     end;
  //endi

  if (opcao_item = 'I')  then
     begin

        //modulo_orcamento.qrorcamento_itemproduto.Locate('controle',icodigo_controle_item,[]);

        //Application.MessageBox(pchar('Registro inserido com sucesso!'),'Processo bem sucedido',MB_OK);

        modulo_orcamento.qrorcamento_itemproduto.Last;

     end
  else if (opcao_item = 'A') then
     begin

        if not modulo_orcamento.qrorcamento_itemproduto.Locate('controle',icodigo_controle_item,[]) then
           begin

             Application.MessageBox(pchar('Registro não foi atualizado, pois '+ formatfloat('00000',icodigo_controle_item) +' não se encontra mais na base de dados'),'Atenção',MB_OK);

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

  opcao_item := 'I';

end;


procedure tfrmorcamento_cadastro.mostrarItemProduto;
begin

  with modulo_orcamento do
    begin

      qrorcamento_itemproduto.Close;
      qrorcamento_itemproduto.SQL.Clear;
      qrorcamento_itemproduto.SQL.Add('select * from TITENSORCAMENTO where codorcamento = :codorcamento order by coditem');
      qrorcamento_itemproduto.ParamByName('codorcamento').AsInteger:=icodigo_controle;
      qrorcamento_itemproduto.Open;

    end;



end;


procedure  tfrmorcamento_cadastro.mostrarProduto;
begin

  //with modulo_conexaodb do
  //  begin

  //    qrconsulta_base.Close;
  //    qrconsulta_base.SQL.Clear;
  //    qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
  //    qrconsulta_base.ParamByName('descricao').AsString:= ;
  //    qrconsulta_base.Open;


  //  end;
  //endi

  with modulo_unidade do
    begin

      if qrunidade.Locate('descricao',modulo_orcamento.qrorcamento_itemproduto.FieldByName('un').AsString,[])then
         begin
           modulo_orcamento.qrtempUnidade.FieldByName('cund').AsInteger := qrunidade.FieldByName('controle').AsInteger;
         end
      else
         begin
           modulo_orcamento.qrtempUnidade.FieldByName('cund').AsInteger := 0;
         end;
      //endi


    end;
 //endi

  with modulo_orcamento do
    begin

      edtdescricao.text := qrorcamento_itemproduto.FieldByName('produto').AsString;
      edtqtde.value := qrorcamento_itemproduto.FieldByName('qtde').Asfloat;
      edtvlrunitario.Value:=qrorcamento_itemproduto.FieldByName('valorunitario').Asfloat;
      edtvlrsubtotal.Value:= qrorcamento_itemproduto.FieldByName('totalliquido').Asfloat;
      lblcontroleprod.Caption:=  inttostr( qrorcamento_itemproduto.FieldByName('codproduto').AsInteger );
      icodigo_controle_item := qrorcamento_itemproduto.FieldByName('controle').AsInteger;


    end;


end;


procedure tfrmorcamento_cadastro.bloqueiaProdutoAlt;
begin

  edtdescricao.Enabled:=false;
  dbgproduto.Enabled:=false;
  btnAlterarProduto.Enabled:=false;
  btnExcluirProduto.Enabled:=false;
  btnclassitem.Enabled:=false;

  btnCancelarAltprod.Enabled:=true;


end;



procedure tfrmorcamento_cadastro.desbloqueiaProdutoAlt;
begin

  edtdescricao.Enabled:=true;
  dbgproduto.Enabled:=true;
  btnAlterarProduto.Enabled:=true;
  btnExcluirProduto.Enabled:=true;
  btnclassitem.Enabled:=true;

  btnCancelarAltprod.Enabled:=false;


end;


procedure tfrmorcamento_cadastro.classificarItem;
var
  novoNumero:integer;


begin
  with modulo_orcamento do
    begin


      novoNumero := 1;
      qrorcamento_itemproduto.First;

      while not qrorcamento_itemproduto.EOF do
        begin

          with modulo_conexaodb do
            begin
              qrexec_base.Close;
              qrexec_base.SQL.Clear;
              qrexec_base.SQL.Add('update titensorcamento set coditem = :coditem where controle = :controle');
              qrexec_base.ParamByName('coditem').AsInteger:=novoNumero;
              qrexec_base.ParamByName('controle').AsInteger:=qrorcamento_itemproduto.FieldByName('controle').AsInteger;
              qrexec_base.ExecSQL;
            end;

          qrorcamento_itemproduto.Next;

           novoNumero := novoNumero + 1;
        end;

    end;
  //endth

  with modulo_conexaodb do
    begin

      atualizaBanco;

    end;
  //endth




end;


procedure tfrmorcamento_cadastro.localizaUn;
begin
  with modulo_conexaodb do
    begin
      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
      qrconsulta_base.ParamByName('descricao').AsString := descricaoun;
      qrconsulta_base.Open;

      modulo_orcamento.qrtempUnidade.Edit;
      modulo_orcamento.qrtempUnidade.FieldByName('cund').AsInteger  :=  qrconsulta_base.FieldByName('controle').AsInteger;

    end;
end;

procedure tfrmorcamento_cadastro.carregaCampoProd;
   begin

     lblcontroleprod.Caption:= inttostr( modulo_produto.qrproduto.FieldByName('controle').AsInteger );
     edtdescricao.Caption:=modulo_produto.qrproduto.FieldByName('produto').AsString;

     if modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger > 0 then
        begin
          modulo_conexaodb.qrconsulta_base.Close;
          modulo_conexaodb.qrconsulta_base.SQL.Clear;
          modulo_conexaodb.qrconsulta_base.SQL.Add('select t.controle, i.codtabelapreco, i.codproduto, i.precovendatabelado from ttabelapreco t inner join titemtabelapreco i on t.controle=i.codtabelapreco inner join testoque e on i.codproduto=e.controle where i.codproduto = :codproduto and i.codtabelapreco = :codtabelapreco');
          modulo_conexaodb.qrconsulta_base.Params.ParamByName('codproduto').AsInteger:=modulo_produto.qrproduto.FieldByName('controle').AsInteger;
          modulo_conexaodb.qrconsulta_base.Params.ParamByName('codtabelapreco').AsInteger:=modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger ;
          modulo_conexaodb.qrconsulta_base.Open;

          edtvlrunitario.Value:=  modulo_conexaodb.qrconsulta_base.FieldByName('precovendatabelado').AsFloat;
        end
     else
        begin
          edtvlrunitario.Value:=modulo_produto.qrproduto.FieldByName('precovenda').AsFloat;
        end;
     //endi

     referencia:=modulo_produto.qrproduto.FieldByName('referencia').AsString;
     cfop:=modulo_produto.qrproduto.FieldByName('cfop').AsString;
     codaplicacaoproduto:=modulo_produto.qrproduto.FieldByName('codaplicacaoproduto').AsInteger;
     fatorconversao:=modulo_produto.qrproduto.FieldByName('fatorconversao').AsString;
     valorconversao:=modulo_produto.qrproduto.FieldByName('valorconversao').Asfloat;

     descricaoun:=modulo_produto.qrproduto.FieldByName('unidade').AsString;
     codbarras:=modulo_produto.qrproduto.FieldByName('codbarras').AsString;



   end;


procedure  tfrmorcamento_cadastro.mostrarDados;
begin


  if cbxnomecliente.Text <> '' then
     begin

       lblenderecocli.Caption:= modulo_cliente.qrcliente.FieldByName('endereco').AsString;
       lblnumerocli.Caption:=modulo_cliente.qrcliente.FieldByName('numero').AsString;
       lblbairrocli.Caption:=modulo_cliente.qrcliente.FieldByName('bairro').AsString;
       lblcidadecli.Caption:=modulo_cliente.qrcliente.FieldByName('cidade').AsString;
       lblcepcli.Caption:=modulo_cliente.qrcliente.FieldByName('cep').AsString;
       lblestadocli.Caption:=modulo_cliente.qrcliente.FieldByName('uf').AsString;

     end
  else
     begin

       modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger:=0;

       ediprazo.Value := 0;

       lblenderecocli.Caption:= '';
       lblnumerocli.Caption:='';
       lblbairrocli.Caption:='';
       lblcidadecli.Caption:='';
       lblcepcli.Caption:='';
       lblestadocli.Caption:='';

     end;
  //endi





end;



end.









