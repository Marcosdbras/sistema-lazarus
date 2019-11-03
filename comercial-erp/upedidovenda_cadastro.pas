unit upedidovenda_cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DBCtrls, DBGrids, ComCtrls, Spin, ZDataset, DB,
  BufDataset, Types, LCLType, md5;

type

  { Tfrmpedidovenda_cadastro }

  Tfrmpedidovenda_cadastro = class(TForm)
    btnAlterarproduto: TButton;
    btnCancelarAltprod: TButton;
    btnExcluirProduto: TButton;
    btnClassItem: TButton;
    btnlancar: TButton;
    btnsalvar: TButton;
    Button2: TButton;
    btnCotacao: TButton;
    cbxunidade: TDBLookupComboBox;
    cbxnomecliente: TDBLookupComboBox;
    cbxnomeven: TDBLookupComboBox;
    cbxnomefun: TDBLookupComboBox;
    dbgproduto: TDBGrid;
    cbxtabpreco: TDBLookupComboBox;
    ediprazo: TSpinEdit;
    edtdescricao: TEdit;
    edtqtde: TFloatSpinEdit;
    edttotal: TFloatSpinEdit;
    edtvlrsubtotal: TFloatSpinEdit;
    edtvlrunitario: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
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
    memoobs: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    ScrollBox1: TScrollBox;
    Shape1: TShape;
    Shape2: TShape;
    procedure btnCancelarAltprodClick(Sender: TObject);
    procedure btnClassItemClick(Sender: TObject);
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnimprimirClick(Sender: TObject);
    procedure btnlancarClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure btnsalvarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAlterarprodutoClick(Sender: TObject);
    procedure btnExcluirProdutoClick(Sender: TObject);
    procedure btnCotacaoClick(Sender: TObject);
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
    procedure cbxtabprecoChange(Sender: TObject);
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
    procedure memoformapgtoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memoformapgtoKeyPress(Sender: TObject; var Key: char);
    procedure memoobsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Panel6Click(Sender: TObject);
    procedure Panel9Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
    procedure pnlsuperiorClick(Sender: TObject);
    procedure salvarCadastro;
    procedure limparProduto;
    procedure salvarProduto;
    procedure mostrarItemProduto;
    procedure mostrarProduto;
    procedure bloqueiaProdutoAlt;
    procedure desbloqueiaProdutoAlt;
    procedure classificarItem;
    procedure mostrarDados;
    procedure bloqueiatudo;

    procedure somaprodutos;




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
  frmpedidovenda_cadastro: Tfrmpedidovenda_cadastro;

implementation

uses ufuncao_geral, umodulo_pedidovenda, upedidovenda_pesquisa, umodulo_cliente, umodulo_funcionario,
      umodulo_conexaodb, umodulo_unidade, umodulo_produto, uproduto_consulta, umodulo_geral,
      umodulo_tabpreco, ucotacao_cadastro;

{$R *.lfm}

{ Tfrmpedidovenda_cadastro }

procedure Tfrmpedidovenda_cadastro.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.memoformapgtoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if (frmpedidovenda_pesquisa.opcao = 'E') or (frmpedidovenda_pesquisa.opcao = 'C') then
     key:=0;
  //endif

end;

procedure Tfrmpedidovenda_cadastro.memoformapgtoKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
//endi
end;

procedure Tfrmpedidovenda_cadastro.memoobsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (frmpedidovenda_pesquisa.opcao = 'E') or (frmpedidovenda_pesquisa.opcao = 'C') then
     key:=0;
  //endif
end;

procedure Tfrmpedidovenda_cadastro.Panel6Click(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.Panel9Click(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.FormCreate(Sender: TObject);
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

  //memoformapgto.Lines.Clear;
  memoobs.Lines.Clear;

  with modulo_geral do
        begin

          qrmaster_indice.Close;
          qrmaster_indice.SQL.Clear;
          qrmaster_indice.SQL.Add('select * from tmaster_indice');
          qrmaster_indice.Open;

        end;
  //endi

  with modulo_pedidovenda do
    begin
      if frmpedidovenda_pesquisa.opcao <> 'I' then
         begin

           icodigo_controle := qrpedidovenda.FieldByName('controle').AsInteger;

           qrtempCliente.FieldByName('ccli').AsInteger:= qrpedidovenda.FieldByName('codcliente').AsInteger;
           qrtempFuncionario.FieldByName('cfun').AsInteger:= qrpedidovenda.FieldByName('codfuncionario').AsInteger;
           qrtempVendedor.FieldByName('cven').AsInteger:= qrpedidovenda.FieldByName('codvendedor').AsInteger;

           memoobs.Lines.Add(qrpedidovenda.FieldByName('observacao').AsString);

           modulo_cliente.qrcliente.Locate('controle',qrpedidovenda.FieldByName('codcliente').AsInteger,[]);

           lblenderecocli.Caption:= modulo_cliente.qrcliente.FieldByName('endereco').AsString;
           lblnumerocli.Caption:=modulo_cliente.qrcliente.FieldByName('numero').AsString;
           lblbairrocli.Caption:=modulo_cliente.qrcliente.FieldByName('bairro').AsString;
           lblcidadecli.Caption:=modulo_cliente.qrcliente.FieldByName('cidade').AsString;
           lblcepcli.Caption:=modulo_cliente.qrcliente.FieldByName('cep').AsString;
           lblestadocli.Caption:=modulo_cliente.qrcliente.FieldByName('uf').AsString;

           modulo_conexaodb.qrconsulta_base.Close;
           modulo_conexaodb.qrconsulta_base.SQL.Clear;
           modulo_conexaodb.qrconsulta_base.SQL.Add('select * from tmaster_pedidovenda where controle_tpedidovenda = :controle_tpedidovenda');
           modulo_conexaodb.qrconsulta_base.Params.ParamByName('controle_tpedidovenda').AsInteger := modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
           modulo_conexaodb.qrconsulta_base.Open;

           modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger:=modulo_conexaodb.qrconsulta_base.FieldByName('ctabp').AsInteger;
           ediprazo.Value :=  modulo_conexaodb.qrconsulta_base.FieldByName('prazo').AsInteger;
           //showmessage(modulo_conexaodb.qrconsulta_base.FieldByName('ctabp').AsString);



           edttotal.Value:= qrpedidovenda.FieldByName('totalprodutos').Asfloat;

         end
      else
         begin
           icodigo_controle := 0;

           qrtempCliente.FieldByName('ccli').AsInteger:=0;
           qrtempFuncionario.FieldByName('cfun').AsInteger:=0;
           qrtempVendedor.FieldByName('cven').AsInteger:=0;



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
  cbxnomecliente.DataSource := modulo_pedidovenda.dstempCliente;
  cbxnomecliente.DataField:='ccli';
  cbxnomecliente.ScrollListDataset:=true;

  //cbxnomecliente.Style:=csDropDownList;


  cbxnomefun.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomefun.ListField:='funcionario';
  cbxnomefun.KeyField:='controle';
  cbxnomefun.DataSource:=modulo_pedidovenda.dstempFuncionario;
  cbxnomefun.DataField:='cfun';
  cbxnomefun.ScrollListDataset:=true;

  cbxnomeven.ListSource := modulo_funcionario.dsfuncionario;
  cbxnomeven.ListField:='funcionario';
  cbxnomeven.KeyField:='controle';
  cbxnomeven.DataSource:=modulo_pedidovenda.dstempVendedor;
  cbxnomeven.DataField:='cven';
  cbxnomeven.ScrollListDataset:=true;

  cbxunidade.ListSource := modulo_unidade.dsunidade;
  cbxunidade.ListField:='descricao';
  cbxunidade.KeyField:='controle';
  cbxunidade.DataSource:=modulo_pedidovenda.dstempUnidade;
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

procedure Tfrmpedidovenda_cadastro.FormShow(Sender: TObject);
begin
  if (frmpedidovenda_pesquisa.opcao = 'I') or (frmpedidovenda_pesquisa.opcao = 'A') then
    begin

      cbxnomefun.SetFocus;

    end;
  //endif

  if (frmpedidovenda_pesquisa.opcao = 'C') or (frmpedidovenda_pesquisa.opcao = 'E') then
    begin

      bloqueiatudo;

      if (frmpedidovenda_pesquisa.opcao = 'C') then
         begin

           btnsalvar.Visible:=false;

         end;
      //endi

      if (frmpedidovenda_pesquisa.opcao = 'E') then
         begin

           btnsalvar.Enabled:=true;
           btnsalvar.Caption:='Excluir';

         end;
      //endi



    end;
  //endif

end;

procedure Tfrmpedidovenda_cadastro.GroupBox2Click(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.btnfiltrarClick(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.btnimprimirClick(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.btnClassItemClick(Sender: TObject);

begin

  classificarItem;

  with modulo_pedidovenda do
    begin
      qrpedidovenda_itemproduto.Refresh;

      qrpedidovenda_itemproduto.Last;
    end;


end;

procedure Tfrmpedidovenda_cadastro.btnCancelarAltprodClick(Sender: TObject);
begin
  limparProduto;
  desbloqueiaProdutoAlt;
  edtdescricao.SetFocus;
end;

procedure Tfrmpedidovenda_cadastro.btnlancarClick(Sender: TObject);
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


  if frmpedidovenda_pesquisa.opcao = 'I' then
     begin

       salvarCadastro;

     end;
  //endi

  salvarProduto;

  if frmpedidovenda_pesquisa.opcao = 'I' then
     begin

       mostrarItemProduto;

       frmpedidovenda_pesquisa.opcao:='A';

     end;
  //endi


  salvarCadastro;

  limparproduto;

  desbloqueiaProdutoAlt;

  edtdescricao.SetFocus;





end;

procedure Tfrmpedidovenda_cadastro.btnlimparClick(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.btnsalvarClick(Sender: TObject);
var icontrole:integer;
begin
     if frmpedidovenda_pesquisa.opcao = 'E' then
        begin
          if application.MessageBox('Tem certeza que deseja excluir este registro?','Atenção',MB_YESNO) = 6 then
             begin

               icontrole :=  modulo_pedidovenda.qrpedidovenda.FieldByName('controle').asInteger;

               with modulo_conexaodb do
                 begin

                   qrconsulta_base.Close;
                   qrconsulta_base.SQL.Clear;
                   qrconsulta_base.SQL.Add('select m.ccotacao from titempedidovenda t inner join tmaster_itempedidovenda m on m.controle_titempedidovenda = t.controle where t.codpedidovenda = :codpedidovenda');
                   qrconsulta_base.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
                   qrconsulta_base.Open;
                   while not qrconsulta_base.EOF do
                      begin

                        qrexec_base.Close;
                        qrexec_base.SQL.Clear;
                        qrexec_base.sql.Add('delete from tmaster_cotacao_item where ccotacao = :ccotacao');
                        qrexec_base.Params.ParamByName('ccotacao').AsInteger := qrconsulta_base.FieldByName('ccotacao').AsInteger;
                        qrexec_base.ExecSQL;

                        qrconsulta_base.Next;


                      end;
                   //endi



                   qrexec_base.Close;
                   qrexec_base.SQL.Clear;
                   qrexec_base.SQL.Add('delete from titempedidovenda where codpedidovenda = :codpedidovenda');
                   qrexec_base.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
                   qrexec_base.ExecSQL;


                   qrexec_base.Close;
                   qrexec_base.SQL.Clear;
                   qrexec_base.SQL.Add('delete from tpedidovenda where controle = :controle');
                   qrexec_base.Params.ParamByName('controle').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
                   qrexec_base.ExecSQL;


                   atualizaBanco;

                   modulo_pedidovenda.qrpedidovenda.Refresh;

                   modulo_pedidovenda.qrpedidovenda.Locate('controle',icontrole+1,[]);


                 end;
               //endi
               close;
             end;
          //endi
          exit;
        end;
     //endi




        salvarCadastro;


        if (frmpedidovenda_pesquisa.opcao = 'I')  then
           begin

              modulo_pedidovenda.qrpedidovenda.Locate('controle',icodigo_controle,[]);

              Application.MessageBox(pchar('Registro inserido com sucesso!'),'Processo bem sucedido',MB_OK);

           end
        else if (frmpedidovenda_pesquisa.opcao = 'A') then
           begin

              if not modulo_pedidovenda.qrpedidovenda.Locate('controle',icodigo_controle,[]) then
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

procedure Tfrmpedidovenda_cadastro.Button2Click(Sender: TObject);
begin
  //showmessage(modulo_conexaodb.qrtemp.FieldByName('ccli').AsString);

  Close;
end;

procedure Tfrmpedidovenda_cadastro.btnAlterarprodutoClick(Sender: TObject);
begin
  if modulo_pedidovenda.qrpedidovenda_itemproduto.RecordCount = 0 then
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

procedure Tfrmpedidovenda_cadastro.btnExcluirProdutoClick(Sender: TObject);
var subtotal:real;
    aSQLText: string;
    aSQLCommand: string;
    coditem:integer;

begin
  if modulo_pedidovenda.qrpedidovenda_itemproduto.RecordCount = 0 then
     begin
       Application.MessageBox('Não há nennhum produto para ser excluido!','Atenção',MB_OK);
       exit;
     end;
  //endi



  if Application.MessageBox('Tem certeza que deseja excluir o produto selecionado?','Atenção',MB_YESNO) = 6  then
     begin

       with modulo_conexaodb do
         begin

           icodigo_controle_item := modulo_pedidovenda.qrpedidovenda_itemproduto.FieldByName('controle').AsInteger;
           subtotal := modulo_pedidovenda.qrpedidovenda_itemproduto.FieldByName('totalliquido').Asfloat;
           coditem := modulo_pedidovenda.qrpedidovenda_itemproduto.FieldByName('coditem').AsInteger;


           qrconsulta_base.Close;
           qrconsulta_base.SQL.Clear;
           qrconsulta_base.SQL.Add('select m.ccotacao from titempedidovenda t inner join tmaster_itempedidovenda m on m.controle_titempedidovenda = t.controle where t.controle = :controle');
           qrconsulta_base.Params.ParamByName('controle').AsInteger:=icodigo_controle_item;
           qrconsulta_base.Open;


           qrexec_base.Close;
           qrexec_base.SQL.Clear;
           qrexec_base.sql.Add('delete from tmaster_cotacao_item where ccotacao = :ccotacao');
           qrexec_base.Params.ParamByName('ccotacao').AsInteger := qrconsulta_base.FieldByName('ccotacao').AsInteger;
           qrexec_base.ExecSQL;


           qrexec_base.Close;
           qrexec_base.SQL.Clear;
           qrexec_base.SQL.Add('delete from titempedidovenda where controle = :controle');
           qrexec_base.ParamByName('controle').AsInteger:= icodigo_controle_item;
           qrexec_base.ExecSQL;

           atualizaBanco;


           //somaprodutos;
           aSQLText:= 'execute procedure sptotalizapedidovenda(%d)';
           aSQLCommand:= Format(aSQLText, [icodigo_controle]);
           conexaodb.ExecuteDirect(aSQLCommand);
           atualizaBanco;



           modulo_pedidovenda.qrpedidovenda.Refresh;

           modulo_pedidovenda.qrpedidovenda.Locate('controle',icodigo_controle,[]);

           modulo_pedidovenda.qrpedidovenda_itemproduto.Refresh;

           if not modulo_pedidovenda.qrpedidovenda_itemproduto.Locate('coditem',coditem+1,[]) then
              begin
                modulo_pedidovenda.qrpedidovenda_itemproduto.Last;
              end;
           //endi

         end;


        edttotal.Value:= modulo_pedidovenda.qrpedidovenda.FieldByName('totalprodutos').Asfloat;
     end;



end;

procedure Tfrmpedidovenda_cadastro.btnCotacaoClick(Sender: TObject);
begin

  frmcotacao_cadastro := tfrmcotacao_cadastro.Create(self);
  frmcotacao_cadastro.ShowModal;
  frmcotacao_cadastro.Free;
  frmcotacao_cadastro := nil;

end;

procedure Tfrmpedidovenda_cadastro.Button5Click(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.cbxnomeclienteChange(Sender: TObject);
begin




end;

procedure Tfrmpedidovenda_cadastro.cbxnomeclienteExit(Sender: TObject);
begin



end;

procedure Tfrmpedidovenda_cadastro.cbxnomeclienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

end;

procedure Tfrmpedidovenda_cadastro.cbxnomeclienteKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.cbxnomeclienteSelect(Sender: TObject);
begin
  mostrarDados;
end;

procedure Tfrmpedidovenda_cadastro.cbxnomefunExit(Sender: TObject);
begin
end;

procedure Tfrmpedidovenda_cadastro.cbxnomefunKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.cbxnomevenExit(Sender: TObject);
begin
end;

procedure Tfrmpedidovenda_cadastro.cbxnomevenKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.cbxtabprecoChange(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.cbxtabprecoKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.cbxunidadeKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.ComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

end;

procedure Tfrmpedidovenda_cadastro.ComboBox1KeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.dbgprodutoKeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrmpedidovenda_cadastro.dbgprodutoKeyPress(Sender: TObject; var Key: char
  );
begin
end;

procedure Tfrmpedidovenda_cadastro.DBGrid2KeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrmpedidovenda_cadastro.DBGrid2KeyPress(Sender: TObject; var Key: char
  );
begin
end;

procedure Tfrmpedidovenda_cadastro.DBText2Click(Sender: TObject);
begin

end;


procedure Tfrmpedidovenda_cadastro.ediprazoKeyPress(Sender: TObject; var Key: char
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

procedure Tfrmpedidovenda_cadastro.edtdescricaoExit(Sender: TObject);
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

                        if strtoint(lblcontroleprod.caption) = 0 then
                           begin

                             Application.MessageBox('Informação não localizada!','Atenção',MB_OK);
                             edtdescricao.SetFocus;


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

procedure Tfrmpedidovenda_cadastro.edtdescricaoKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtqtdeChange(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.edtqtdeExit(Sender: TObject);
begin
  edtvlrsubtotal.Value:=edtqtde.Value*edtvlrunitario.Value;
end;

procedure Tfrmpedidovenda_cadastro.edtqtdeKeyPress(Sender: TObject; var Key: char
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

procedure Tfrmpedidovenda_cadastro.edtKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtvlrsubtotalKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtpercdescKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtvlrdescKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtliquidoKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtvlrunitario4KeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtvlrunitario5KeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.edtvlrunitarioExit(Sender: TObject);
begin
  edtvlrsubtotal.Value:=edtqtde.Value*edtvlrunitario.Value;
end;

procedure Tfrmpedidovenda_cadastro.edtvlrunitarioKeyPress(Sender: TObject;
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

procedure Tfrmpedidovenda_cadastro.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin



  //FreeAndNil(frmpedidovenda_cadastro);
  //Action:= caFree;
  //frmpedidovenda_cadastro := nil;

end;

procedure Tfrmpedidovenda_cadastro.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.limpar;
begin

end;

procedure Tfrmpedidovenda_cadastro.pnlsuperiorClick(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.ScrollBox1Click(Sender: TObject);
begin

end;

procedure Tfrmpedidovenda_cadastro.TabSheet1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: boolean);
begin

end;

procedure Tfrmpedidovenda_cadastro.filtrar;
begin

end;

procedure Tfrmpedidovenda_cadastro.salvarCadastro;
var
  nomecliente, nomefuncionario, nomevendedor, hash, numDav:string;


begin

  with modulo_conexaodb do
    begin

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tcliente where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_pedidovenda.qrtempCliente.FieldByName('ccli').AsInteger;
      qrconsulta_base.Open;

      nomecliente := qrconsulta_base.FieldByName('cliente').AsString;

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tfuncionario where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_pedidovenda.qrtempfuncionario.FieldByName('cfun').AsInteger;
      qrconsulta_base.Open;

      nomefuncionario := qrconsulta_base.FieldByName('funcionario').AsString;

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tfuncionario where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_pedidovenda.qrtempvendedor.FieldByName('cven').AsInteger;
      qrconsulta_base.Open;

      nomevendedor := qrconsulta_base.FieldByName('funcionario').AsString;


    end;
  //endth

  if frmpedidovenda_pesquisa.opcao = 'I' then
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

            numDav := formatfloat('0000000000',qrsequencia.FieldByName('controlevarchar').AsInteger);

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('select GEN_ID(GEN_tpedidovenda_ID,1) as prox_codigo FROM RDB$DATABASE;');
            qrexec_base.Open;

            icodigo_controle := qrexec_base.FieldByName('prox_codigo').AsInteger;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tpedidovenda( controle, codcliente,  cliente,  codfuncionario,  funcionario,  codvendedor, vendedor,  controlevarchar,    datahoracadastro,  titulodav,  cancelado,  status, observacao,  dataprevisaoentrega, valordesconto, totalprodutos, totalliquido,         endereco,   bairro,   complemento,    cidade,     cep,     cpf,     cnpj,   email,    uf,    telefone,      numero,     rg,    ie,     im,     md5dav  ) ');
            qrexec_base.SQL.Add('                values(  :controle, :codcliente, :cliente, :codfuncionario, :funcionario, :codvendedor, :vendedor,  :controlevarchar,  :datahoracadastro,  :titulodav, :cancelado, :status, :observacao,  :dataprevisaoentrega, :valordesconto, :totalprodutos, :totalliquido, :endereco,  :bairro,  :complemento,   :cidade,    :cep,    :cpf,    :cnpj,  :email,   :uf,   :telefone,     :numero,    :rg,   :ie,    :im,    :md5dav     )');

            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle;



            hash :=   uppercase(   MD5Print(MD5String(  numDav + datetostr(now())  ))   );

            qrexec_base.ParamByName('md5dav').AsString:=hash;

            qrexec_base.ParamByName('controlevarchar').AsString:=formatfloat('0000000000',qrsequencia.FieldByName('controlevarchar').AsInteger);

            qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();

            qrexec_base.ParamByName('titulodav').AsString:='PEDIDO DE VENDA';
            qrexec_base.ParamByName('cancelado').AsString:='N';
            qrexec_base.ParamByName('status').AsString:='ABERTO';

            qrexec_base.ParamByName('valordesconto').Asfloat:=0;
            qrexec_base.ParamByName('totalprodutos').Asfloat:=0;
            qrexec_base.ParamByName('totalliquido').Asfloat:=0;



          end;
        //endth
     end
  else if frmpedidovenda_pesquisa.opcao = 'A' then
     begin
        with modulo_conexaodb do
          begin

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('update tpedidovenda set  codcliente  =  :codcliente,  cliente  =   :cliente, codfuncionario  =  :codfuncionario,  funcionario  =  :funcionario, codvendedor   = :codvendedor,   vendedor   =  :vendedor, observacao  = :observacao,  dataprevisaoentrega    =  :dataprevisaoentrega, endereco =  :endereco, bairro  =   :bairro,  complemento  =  :complemento, cidade  = :cidade, cep  =  :cep, cpf  = :cpf, cnpj  =  :cnpj, email  =  :email, uf  = :uf,  telefone   =   :telefone, numero  =  :numero,  rg =  :rg, ie =  :ie,   im = :im      where controle = :controle');

            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle;


          end;
        //endth

     end;
  //endif

  if (frmpedidovenda_pesquisa.opcao = 'I') or (frmpedidovenda_pesquisa.opcao = 'A') then
     begin
        with modulo_conexaodb do
          begin

            qrexec_base.ParamByName('codcliente').AsInteger := modulo_pedidovenda.qrtempCliente.FieldByName('ccli').AsInteger;
            qrexec_base.ParamByName('cliente').AsString:= nomecliente;
            qrexec_base.ParamByName('codfuncionario').AsInteger := modulo_pedidovenda.qrtempfuncionario.FieldByName('cfun').AsInteger;
            qrexec_base.ParamByName('funcionario').AsString:=  nomefuncionario;
            qrexec_base.ParamByName('codvendedor').AsInteger := modulo_pedidovenda.qrtempvendedor.FieldByName('cven').AsInteger;
            qrexec_base.ParamByName('vendedor').AsString:= nomevendedor;

            qrexec_base.ParamByName('observacao').AsString:=memoobs.Text;


            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select * from tcliente where controle = :controle');
            qrconsulta_base.Params.ParamByName('controle').AsInteger:=modulo_pedidovenda.qrtempCliente.FieldByName('ccli').AsInteger;;
            qrconsulta_base.Open;

            qrexec_base.ParamByName('endereco').AsString:= qrconsulta_base.FieldByName('endereco').AsString;
            qrexec_base.ParamByName('bairro').AsString:= qrconsulta_base.FieldByName('bairro').AsString;
            qrexec_base.ParamByName('cidade').AsString:= qrconsulta_base.FieldByName('cidade').AsString;
            qrexec_base.ParamByName('cep').AsString:=  qrconsulta_base.FieldByName('cep').AsString;
            qrexec_base.ParamByName('telefone').AsString:= qrconsulta_base.FieldByName('telefone').AsString;
            qrexec_base.ParamByName('numero').AsString:= qrconsulta_base.FieldByName('numero').AsString;
            qrexec_base.ParamByName('cpf').AsString:=  qrconsulta_base.FieldByName('cpf').AsString;
            qrexec_base.ParamByName('cnpj').AsString:=  qrconsulta_base.FieldByName('cnpj').AsString;

            qrexec_base.ExecSQL;

            atualizaBanco;

            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select * from tmaster_pedidovenda where controle_tpedidovenda = :controle_tpedidovenda');
            qrconsulta_base.Params.ParamByName('controle_tpedidovenda').AsInteger := icodigo_controle;
            qrconsulta_base.Open;
            if qrconsulta_base.RecordCount = 0 then
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('insert into tmaster_pedidovenda(controle_tpedidovenda,ctabp,prazo) values (:controle_tpedidovenda, :ctabp, :prazo);');
                 qrexec_base.Params.ParamByName('controle_tpedidovenda').AsInteger := icodigo_controle;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.Params.ParamByName('prazo').AsInteger := ediprazo.Value;
                 qrexec_base.ExecSQL;

               end
            else
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('update tmaster_pedidovenda  set ctabp = :ctabp, prazo = :prazo  where controle_tpedidovenda   = :controle_tpedidovenda;');
                 qrexec_base.Params.ParamByName('controle_tpedidovenda').AsInteger := icodigo_controle;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.Params.ParamByName('prazo').AsInteger := ediprazo.Value;
                 qrexec_base.ExecSQL;




               end;
            //endi

            atualizaBanco;

          end;
        //endth


       modulo_pedidovenda.qrpedidovenda.Refresh;

       modulo_pedidovenda.qrpedidovenda.Locate('controle',icodigo_controle,[]);

       edttotal.Value:= modulo_pedidovenda.qrpedidovenda.FieldByName('totalprodutos').Asfloat;



     end;
  //endi







end;



procedure Tfrmpedidovenda_cadastro.salvarProduto;
var
  sequencia:integer;
  hash, hash1:string;

  aSQLText: string;
  aSQLCommand: string;


begin

  with modulo_conexaodb do
    begin

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tunidademedida where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:=modulo_pedidovenda.qrtempUnidade.FieldByName('cund').AsInteger;
      qrconsulta_base.Open;

      descricaoun := qrconsulta_base.FieldByName('descricao').AsString;

      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from testoque where controle = :controle');
      qrconsulta_base.ParamByName('controle').AsInteger:= strtoint(lblcontroleprod.Caption);
      qrconsulta_base.Open;

      nomeprod := qrconsulta_base.FieldByName('produto').AsString;

      hash :=   uppercase(   MD5Print(MD5String(  lblcontroleprod.Caption + datetostr(now())  ))   );
      hash1 :=  uppercase(   MD5Print(MD5String(  nomeprod + datetostr(now())  ))   );

    end;
  //endth

  if opcao_item = 'I' then
     begin

        //Atualiza tabelas auxiliares do sistema
        with modulo_conexaodb do
          begin

            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select COALESCE(max(coditem),0)+1 as sequencia from titempedidovenda where CODpedidovenda = :CODpedidovenda');
            qrconsulta_base.ParamByName('codpedidovenda').AsInteger:=icodigo_controle;
            qrconsulta_base.Open;

            sequencia := qrconsulta_base.FieldByName('sequencia').AsInteger;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('select GEN_ID(GEN_titempedidovenda_ID,1) as prox_codigo FROM RDB$DATABASE;');
            qrexec_base.Open;

            icodigo_controle_item := qrexec_base.FieldByName('prox_codigo').AsInteger;

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into titempedidovenda(   controle,    codpedidovenda,   datahoracadastro,  codproduto,   produto,   qtde,   un,   valorunitario,   valordesconto,    valoracrescimo,    percdesconto,    percacrescimo,             situacaotributaria,      aliquota,  cancelado,     decimaisqtde,   decimaisvalorunitario,  coditem,    valordescontounitario,    valoracrescimounitario,    controleorigemmesclagem,           numerodav,    md5dav,      mesclar,  status,       qtdeconvertida,        unconvertida,        obs ) ');
            qrexec_base.SQL.Add('                     values( :controle, :codpedidovenda,   :datahoracadastro,  :codproduto,   :produto,   :qtde,   :un,   :valorunitario,   :valordesconto,    :valoracrescimo,    :percdesconto,    :percacrescimo,  :situacaotributaria,       :aliquota,  :cancelado,     :decimaisqtde,   :decimaisvalorunitario,  :coditem,    :valordescontounitario,    :valoracrescimounitario,    :controleorigemmesclagem,         :numerodav,   :md5dav,   :mesclar,  :status,       :qtdeconvertida,      :unconvertida,     :obs ) ');


            qrexec_base.ParamByName('datahoracadastro').AsDateTime := now();
            qrexec_base.ParamByName('coditem').AsInteger:=sequencia;
            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle_item;
            qrexec_base.ParamByName('codpedidovenda').AsInteger := icodigo_controle;

            qrexec_base.ParamByName('md5dav').AsString:=hash;

            qrexec_base.ParamByName('numerodav').AsString := modulo_pedidovenda.qrpedidovenda.FieldByName('controlevarchar').AsString;

            qrexec_base.Params.ParamByName('codproduto').AsInteger := strtoint(lblcontroleprod.Caption);
            qrexec_base.ParamByName('produto').AsString:=  edtdescricao.Text;
            qrexec_base.ParamByName('status').AsString := 'ABERTO';



          end;
        //endth
     end
  else if opcao_item = 'A' then
     begin
        with modulo_conexaodb do
          begin

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('update titempedidovenda set    qtde  = :qtde, un = :un,  valorunitario   =   :valorunitario, valordesconto  = :valordesconto,   valoracrescimo   =  :valoracrescimo,  percdesconto  =  :percdesconto,   percacrescimo  =  :percacrescimo,  situacaotributaria  =  :situacaotributaria, aliquota   =  :aliquota, cancelado  = :cancelado,  decimaisqtde  =  :decimaisqtde,   decimaisvalorunitario   =  :decimaisvalorunitario,  valordescontounitario   =  :valordescontounitario,  valoracrescimounitario   =   :valoracrescimounitario,  controleorigemmesclagem   =   :controleorigemmesclagem,  mesclar   =  :mesclar,  status  = :status, qtdeconvertida  =  :qtdeconvertida,  unconvertida  =  :unconvertida, obs  =  :obs  where controle = :controle');

            qrexec_base.ParamByName('controle').AsInteger:=icodigo_controle_item;


          end;
        //endth

     end;
  //endif

  if (opcao_item = 'I') or (opcao_item = 'A') then
     begin
        with modulo_conexaodb do
          begin

            qrexec_base.ParamByName('un').AsString:= descricaoun;
            qrexec_base.ParamByName('qtde').Asfloat := edtqtde.Value;
            qrexec_base.ParamByName('valorunitario').Asfloat := edtvlrunitario.Value;



            qrexec_base.ParamByName('valordesconto').Asfloat:= 0;
            qrexec_base.ParamByName('valoracrescimo').Asfloat:= 0;
            qrexec_base.ParamByName('percdesconto').Asfloat:= 0;
            qrexec_base.ParamByName('percacrescimo').Asfloat:= 0;
            qrexec_base.ParamByName('situacaotributaria').AsString:= 'F';
            qrexec_base.ParamByName('aliquota').Asfloat:= 0;
            qrexec_base.ParamByName('cancelado').AsString:= 'N';
            qrexec_base.ParamByName('decimaisqtde').AsInteger:= 2;
            qrexec_base.ParamByName('decimaisvalorunitario').AsInteger:= 2;

            qrexec_base.ParamByName('valordescontounitario').Asfloat:= 0;
            qrexec_base.ParamByName('valoracrescimounitario').Asfloat:= 0;



            //Analisar no SGBr como esta informação é persistida
            qrexec_base.ParamByName('qtdeconvertida').Asfloat := 1; //fatorconversao;  //valorconversao;

            qrexec_base.ExecSQL;

            atualizaBanco;


            qrconsulta_base.Close;
            qrconsulta_base.SQL.Clear;
            qrconsulta_base.SQL.Add('select * from tmaster_itempedidovenda where controle_titempedidovenda = :controle_titempedidovenda');
            qrconsulta_base.Params.ParamByName('controle_titempedidovenda').AsInteger := icodigo_controle_item;
            qrconsulta_base.Open;
            if qrconsulta_base.RecordCount = 0 then
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('insert into tmaster_itempedidovenda(controle_titempedidovenda,ctabp) values (:controle_titempedidovenda, :ctabp);');
                 qrexec_base.Params.ParamByName('controle_titempedidovenda').AsInteger := icodigo_controle_item;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.ExecSQL;

               end
            else
               begin

                 qrexec_base.Close;
                 qrexec_base.SQL.Clear;
                 qrexec_base.SQL.Add('update tmaster_itempedidovenda  set ctabp = :ctabp where controle_titempedidovenda   = :controle_titempedidovenda;');
                 qrexec_base.Params.ParamByName('controle_titempedidovenda').AsInteger := icodigo_controle_item;
                 qrexec_base.Params.ParamByName('ctabp').AsInteger := modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger;
                 qrexec_base.ExecSQL;

               end;
            //endi

            atualizaBanco;

          end;
        //endth

       modulo_pedidovenda.qrpedidovenda_itemproduto.Refresh;

     end;
  //endi

  if (opcao_item = 'I')  then
     begin

        //modulo_pedidovenda.qrpedidovenda_itemproduto.Locate('controle',icodigo_controle_item,[]);

        //Application.MessageBox(pchar('Registro inserido com sucesso!'),'Processo bem sucedido',MB_OK);

        modulo_pedidovenda.qrpedidovenda_itemproduto.Last;

     end
  else if (opcao_item = 'A') then
     begin

        if not modulo_pedidovenda.qrpedidovenda_itemproduto.Locate('controle',icodigo_controle_item,[]) then
           begin

             Application.MessageBox(pchar('Registro não foi atualizado, pois '+ formatfloat('00000',icodigo_controle_item) +' não se encontra mais na base de dados'),'Atenção',MB_OK);

           end;
        //endi

     end;
  //endi

  //somaprodutos;
  aSQLText:= 'execute procedure sptotalizapedidovenda(%d)';
  aSQLCommand:= Format(aSQLText, [icodigo_controle]);
  modulo_conexaodb.conexaodb.ExecuteDirect(aSQLCommand);
  modulo_conexaodb.atualizaBanco;



  modulo_pedidovenda.qrpedidovenda.Refresh;



end;




procedure Tfrmpedidovenda_cadastro.limparProduto;
begin

  edtdescricao.Text:='';
  edtqtde.Value:=0;
  edtvlrunitario.Value:=0;
  edtvlrsubtotal.Value:=0;
  lblcontroleprod.caption := '0';

  modulo_pedidovenda.qrtempUnidade.FieldByName('cund').AsInteger:=0;

  opcao_item := 'I';

end;


procedure Tfrmpedidovenda_cadastro.mostrarItemProduto;
begin

  with modulo_pedidovenda do
    begin

      qrpedidovenda_itemproduto.Close;
      qrpedidovenda_itemproduto.SQL.Clear;
      qrpedidovenda_itemproduto.SQL.Add('select * from titempedidovenda i  left join tmaster_itempedidovenda t on i.controle = t.controle_titempedidovenda  where i.codpedidovenda = :codpedidovenda order by i.coditem');
      qrpedidovenda_itemproduto.ParamByName('codpedidovenda').AsInteger:=icodigo_controle;
      qrpedidovenda_itemproduto.Open;

    end;



end;


procedure  Tfrmpedidovenda_cadastro.mostrarProduto;
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

      if qrunidade.Locate('descricao',modulo_pedidovenda.qrpedidovenda_itemproduto.FieldByName('un').AsString,[])then
         begin
           modulo_pedidovenda.qrtempUnidade.FieldByName('cund').AsInteger := qrunidade.FieldByName('controle').AsInteger;
         end
      else
         begin
           modulo_pedidovenda.qrtempUnidade.FieldByName('cund').AsInteger := 0;
         end;
      //endi


    end;
 //endi

  with modulo_pedidovenda do
    begin

      edtdescricao.text := qrpedidovenda_itemproduto.FieldByName('produto').AsString;
      edtqtde.value := qrpedidovenda_itemproduto.FieldByName('qtde').Asfloat;
      edtvlrunitario.Value:=qrpedidovenda_itemproduto.FieldByName('valorunitario').Asfloat;
      edtvlrsubtotal.Value:= qrpedidovenda_itemproduto.FieldByName('totalliquido').Asfloat;
      lblcontroleprod.Caption:=  inttostr( qrpedidovenda_itemproduto.FieldByName('codproduto').AsInteger );
      icodigo_controle_item := qrpedidovenda_itemproduto.FieldByName('controle').AsInteger;


    end;


end;


procedure Tfrmpedidovenda_cadastro.bloqueiaProdutoAlt;
begin

  edtdescricao.Enabled:=false;
  dbgproduto.Enabled:=false;
  btnAlterarProduto.Enabled:=false;
  btnExcluirProduto.Enabled:=false;
  btnclassitem.Enabled:=false;

  btnCancelarAltprod.Enabled:=true;


end;



procedure Tfrmpedidovenda_cadastro.desbloqueiaProdutoAlt;
begin

  edtdescricao.Enabled:=true;
  dbgproduto.Enabled:=true;
  btnAlterarProduto.Enabled:=true;
  btnExcluirProduto.Enabled:=true;
  btnclassitem.Enabled:=true;

  btnCancelarAltprod.Enabled:=false;


end;


procedure Tfrmpedidovenda_cadastro.classificarItem;
var
  novoNumero:integer;


begin
  with modulo_pedidovenda do
    begin


      novoNumero := 1;
      qrpedidovenda_itemproduto.First;

      while not qrpedidovenda_itemproduto.EOF do
        begin

          with modulo_conexaodb do
            begin
              qrexec_base.Close;
              qrexec_base.SQL.Clear;
              qrexec_base.SQL.Add('update titempedidovenda set coditem = :coditem where controle = :controle');
              qrexec_base.ParamByName('coditem').AsInteger:=novoNumero;
              qrexec_base.ParamByName('controle').AsInteger:=qrpedidovenda_itemproduto.FieldByName('controle').AsInteger;
              qrexec_base.ExecSQL;
            end;

          qrpedidovenda_itemproduto.Next;

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


procedure Tfrmpedidovenda_cadastro.localizaUn;
begin
  with modulo_conexaodb do
    begin
      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
      qrconsulta_base.ParamByName('descricao').AsString := descricaoun;
      qrconsulta_base.Open;

      modulo_pedidovenda.qrtempUnidade.Edit;
      modulo_pedidovenda.qrtempUnidade.FieldByName('cund').AsInteger  :=  qrconsulta_base.FieldByName('controle').AsInteger;

    end;
end;

procedure Tfrmpedidovenda_cadastro.carregaCampoProd;
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


procedure  Tfrmpedidovenda_cadastro.mostrarDados;
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

procedure Tfrmpedidovenda_cadastro.bloqueiatudo;
begin

  btnsalvar.Enabled:=false;
  cbxnomefun.Enabled:=false;
  cbxnomeven.Enabled:=false;
  cbxnomecliente.Enabled:=false;
  cbxtabpreco.Enabled:=false;
  ediprazo.Enabled:=false;
  edtdescricao.Enabled:=false;
  edtqtde.Enabled:=false;
  cbxunidade.Enabled:=false;
  edtvlrunitario.Enabled:=false;
  edtvlrsubtotal.Enabled:=false;
  btnlancar.Enabled:=false;
  btnalterarproduto.Enabled:=false;
  btncancelaraltprod.Enabled:=false;
  btnExcluirProduto.Enabled:=false;
  btnclassitem.Enabled:=false;
  btncotacao.Enabled:=false;



end;


procedure tfrmpedidovenda_cadastro.somaprodutos;
begin

  with modulo_conexaodb do
    begin
      qrconsulta_base.Close;
      qrconsulta_base.SQL.Clear;
      qrconsulta_base.SQL.Add('select sum(qtde*valorunitario) as totalprodutos from titempedidovenda where codpedidovenda = :codpedidovenda');
      qrconsulta_base.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
      qrconsulta_base.Open;

      qrexec_base.Close;
      qrexec_base.SQL.Clear;
      qrexec_base.sql.Add('update tpedidovenda set totalprodutos = :totalprodutos, totalliquido = :totalliquido, valordesconto = :valordesconto where controle = :controle');
      qrexec_base.Params.ParamByName('totalprodutos').AsFloat:=qrconsulta_base.FieldByName('totalprodutos').AsFloat;
      qrexec_base.Params.ParamByName('valordesconto').AsFloat:=0;
      qrexec_base.Params.ParamByName('totalliquido').AsFloat:=qrconsulta_base.FieldByName('totalprodutos').AsFloat;
      qrexec_base.Params.ParamByName('controle').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
      qrexec_base.ExecSQL;


      atualizabanco;


    end;


end;

end.









