unit uorcamento_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DbCtrls, DBGrids, ZDataset, db, BufDataset, usincorc,
  Types, LCLType, md5;

type

  { Tfrmorcamento_pesquisa }

  Tfrmorcamento_pesquisa = class(TForm)
    btnfiltrar: TButton;
    btnimprimir: TButton;
    btnlimpar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    btntransfpedido: TButton;
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
    procedure btntransfpedidoClick(Sender: TObject);
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
  frmorcamento_pesquisa: Tfrmorcamento_pesquisa;

implementation
     uses ufuncao_geral,  umodulo_orcamento, uorcamento_cadastro, umodulo_cliente, umodulo_funcionario, uorcamento_impressao, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmorcamento_pesquisa }

procedure Tfrmorcamento_pesquisa.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.FormCreate(Sender: TObject);
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

procedure Tfrmorcamento_pesquisa.btnfiltrarClick(Sender: TObject);
begin
  filtrar;
end;

procedure Tfrmorcamento_pesquisa.btnimprimirClick(Sender: TObject);
begin
  frmorcamento_impressao := tfrmorcamento_impressao.Create(self);
  frmorcamento_impressao.ShowModal;
  frmorcamento_impressao.free;
  frmorcamento_impressao := nil;
end;

procedure Tfrmorcamento_pesquisa.btnlimparClick(Sender: TObject);
begin
  limpar;
end;

procedure Tfrmorcamento_pesquisa.btntransfpedidoClick(Sender: TObject);
var
  hash,numDav:String;
  icontrole:integer;

begin
  if modulo_orcamento.qrorcamento.RecordCount = 0 then
     begin
       Application.MessageBox('Não há nennhum orçamento selecionado para ser transferido!','Atenção',MB_OK);
       exit;
     end;
  //endi

  if Application.MessageBox('Tem certeza que deseja transferir o orçamento selecionado?','Atenção',MB_YESNO) = 6  then
     begin

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

            hash :=   uppercase(   MD5Print(MD5String(  numDav + datetostr(now())  ))   );

            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('select GEN_ID(GEN_tpedidovenda_ID,1) as prox_codigo FROM RDB$DATABASE;');
            qrexec_base.Open;

            icontrole := qrexec_base.FieldByName('prox_codigo').AsInteger;


            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into titempedidovenda(   codpedidovenda,    datahoracadastro,    codproduto,    produto,      qtde,     un,     valorunitario,   valordesconto,                valoracrescimo,              percdesconto,                     percacrescimo,                       situacaotributaria,      aliquota,      cancelado,     decimaisqtde,          decimaisvalorunitario,                 coditem,         valordescontounitario,    valoracrescimounitario,    controleorigemmesclagem,           numerodav,    md5dav,      mesclar,     status,       qtdeconvertida,        unconvertida,        obs ) ');
            qrexec_base.SQL.Add('              select            :codpedidovenda,  :datahoracadastro,  t.codproduto,  t.produto,    t.qtde,   t.un,   t.valorunitario,   t.valordescontounitario,            t.valoracrescimounitario,            t.percdescontounitario,                   t.percacrescimounitario,             :situacaotributaria,     :aliquota,     :cancelado,     t.decimaisqtde,        t.decimaisvalorunitario,               t.coditem,       t.valordescontounitario,   t.valoracrescimounitario,   :controleorigemmesclagem,          :numerodav,   :md5dav,     :mesclar,    :status,       :qtdeconvertida,       :unconvertida,       :obs     from titensorcamento t  where t.codorcamento = :codorcamento');

            qrexec_base.Params.ParamByName('codorcamento').AsInteger:=modulo_orcamento.qrorcamento.FieldByName('controle').AsInteger;;
            qrexec_base.Params.ParamByName('codpedidovenda').AsInteger:=icontrole;
            qrexec_base.Params.ParamByName('datahoracadastro').AsDateTime := now();
            qrexec_base.Params.ParamByName('numerodav').AsString:=numDav;
            qrexec_base.Params.ParamByName('md5dav').AsString:=hash;

            //qrexec_base.Params.ParamByName('valordesconto').Asfloat:= 0;
            //qrexec_base.Params.ParamByName('valoracrescimo').Asfloat:= 0;
            //qrexec_base.Params.ParamByName('percdesconto').Asfloat:= 0;
            //qrexec_base.Params.ParamByName('percacrescimo').Asfloat:= 0;
            qrexec_base.Params.ParamByName('situacaotributaria').AsString:= 'F';
            qrexec_base.Params.ParamByName('aliquota').Asfloat:= 0;
            qrexec_base.Params.ParamByName('cancelado').AsString:= 'N';
            //qrexec_base.Params.ParamByName('decimaisqtde').AsInteger:= 2;
            //qrexec_base.Params.ParamByName('decimaisvalorunitario').AsInteger:= 2;

            //qrexec_base.Params.ParamByName('valordescontounitario').Asfloat:= 0;
            //qrexec_base.Params.ParamByName('valoracrescimounitario').Asfloat:= 0;



            //Analisar no SGBr como esta informação é persistida
            qrexec_base.Params.ParamByName('qtdeconvertida').Asfloat := 1; //fatorconversao;  //valorconversao;

            qrexec_base.ExecSQL;

            atualizabanco;

            qrexec_base.Close;                                                                                                                                                      //tipodesconto,   ,  cancelado,  status, condicaopagamento
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('insert into tpedidovenda( controle,              codcliente,     cliente,         codfuncionario,     funcionario,     codvendedor,    vendedor,     controlevarchar,     titulodav,               observacao, datahoracadastro, valordesconto,    totalprodutos,  totalliquido, endereco  , bairro  ,   complemento,   cidade  ,   cep  , cpf  , cnpj  , email  , uf  , telefone   , numero  , rg  , ie  , im  ,cancelado, status   ,md5dav       ) ');
            qrexec_base.SQL.Add('                     select :numcontrole,      t.codcliente,   t.nomecliente,   t.codfuncionario,   t.funcionario,   t.codvendedor,  t.vendedor,    :controlevarchar,     ''PEDIDO DE VENDA'',   t.observacao, current_time,     0            ,    0            ,  0           , c.endereco, c.bairro,   c.complemento, c.cidade,   c.cep, c.cpf, c.cnpj, c.email, c.uf, c.telefone, c.numero, c.rg, c.ie, c.im,''N''     ,''ABERTO'',:md5dav      from torcamento t  inner join tcliente c  on  t.codcliente=c.controle     where t.controle = :controle ');
            qrexec_base.Params.ParamByName('controle').AsInteger:=modulo_orcamento.qrorcamento.FieldByName('controle').AsInteger;
            qrexec_base.Params.ParamByName('controlevarchar').AsString:=numDav;
            qrexec_base.Params.ParamByName('md5dav').AsString:=hash;
            qrexec_base.Params.ParamByName('numcontrole').AsInteger:=icontrole;
            qrexec_base.ExecSQL;

            atualizabanco;

            aSQLText:= 'execute procedure sptotalizapedidovenda(%d)';
            aSQLCommand:= Format(aSQLText, [icontrole]);
            conexaodb.ExecuteDirect(aSQLCommand);

            atualizaBanco;



          end;
        //endi

        Application.MessageBox(pchar('Pedido nº '+ formatfloat('0000000000',icontrole) +' foi criado com sucesso!'),'Processo bem sucedido',MB_OK);


     end;
  //endif



end;

procedure Tfrmorcamento_pesquisa.Button1Click(Sender: TObject);
begin
  opcao := 'I';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;
  frmorcamento_cadastro := nil;


end;

procedure Tfrmorcamento_pesquisa.Button2Click(Sender: TObject);
begin
 opcao := 'A';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;
  frmorcamento_cadastro := nil;

end;

procedure Tfrmorcamento_pesquisa.Button3Click(Sender: TObject);
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

procedure Tfrmorcamento_pesquisa.Button4Click(Sender: TObject);
begin
  opcao := 'C';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;
  frmorcamento_cadastro := nil;


  //frmorcamento_cadastro := nil;
end;

procedure Tfrmorcamento_pesquisa.Button5Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmorcamento_pesquisa.cbxnomeclienteKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_pesquisa.cbxnomefunKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_pesquisa.cbxnomevenKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_pesquisa.DBGrid1KeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrmorcamento_pesquisa.DBGrid1KeyPress(Sender: TObject; var Key: char
  );
begin

end;

procedure Tfrmorcamento_pesquisa.DBText2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.dsorcamentoDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure Tfrmorcamento_pesquisa.edtdatafimKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_pesquisa.edtdatainicioKeyPress(Sender: TObject;
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

procedure Tfrmorcamento_pesquisa.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

  //modulo_conexaodb.atualizaBancoFechaTransacao;

  //FreeAndNil(frmorcamento_pesquisa);  //Action:= caFree;  //frmorcamento_pesquisa := nil;

end;

procedure Tfrmorcamento_pesquisa.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.limpar;
begin
  edtdatainicio.Date:= date;
  edtdatafim.Date:=date;


   modulo_cliente.qrtempCliente.FieldByName('ccli').AsInteger:=0;
   modulo_funcionario.qrtempFuncionario.FieldByName('cfun').AsInteger:=0;
   modulo_funcionario.qrtempVendedor.FieldByName('cven').AsInteger:=0;




  filtrar;
end;

procedure Tfrmorcamento_pesquisa.pnlsuperiorClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.filtrar;
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

