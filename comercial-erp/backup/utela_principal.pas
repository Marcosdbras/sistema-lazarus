unit utela_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ComCtrls, DBGrids, StdCtrls, XMLRead, XMLWrite, DOM, db, LCLType, md5;

type

  { Tfrmtela_principal }

  Tfrmtela_principal = class(TForm)
    Button1: TButton;
    Button2: TButton;
    btnorcamento: TButton;
    btnpedidovenda: TButton;
    btnmovcaixa: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    lblstatus: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    Ajustes: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    pnlsuperior: TPanel;
    pnlsuperior1: TPanel;
    pnlsuperior2: TPanel;
    pnlsuperior3: TPanel;
    StatusBar1: TStatusBar;
    procedure btnmovcaixaClick(Sender: TObject);
    procedure btnorcamentoClick(Sender: TObject);
    procedure btnpedidovendaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);

  private
    icodigo_controle, icodigo_controle_item, codaplicacaoproduto, sequencia_num, icodimpostomedio,
    icsosnpadrao, icodcstipipadrao, icodcstpispadrao, icodcstcofinspadrao:integer;

    opcao_item, cfop, referencia, fatorconversao, codbarras, descricaoun, nomeprod, numDav,
    permitecreditoicmspadrao, possuiicmsstpadrao, isentoicmspadrao, tributadoicmspadrao:string;

    qtdeconvertida, valorconversao, faliquotanacional,faliquotaimportada,fpercimpostomedio :real;

  public

  end;

var
  frmtela_principal: Tfrmtela_principal;

implementation


         uses ufuncao_arq_ini, uconfig_banco, ufuncao_geral, ufuncao_conexaodb,
           uorcamento_pesquisa, umodulo_conexaodb, ulogin, umodulo_vendaorc, uvendaorc,
           uindice, uparametro, usincbaseremota, umodulo_tabpreco, umodulo_produto, umodulo_geral,
           upedidovenda_pesquisa, ucaixa_impressao, umodulo_usuario, uusuario_pesquisa;
{$R *.lfm}

{ Tfrmtela_principal }

procedure Tfrmtela_principal.MenuItem1Click(Sender: TObject);
begin

end;

procedure Tfrmtela_principal.FormCreate(Sender: TObject);
var
   Documento: TXMLDocument;
   Child: TDOMNode;

begin



//Carrega dados de conexão do banco na variáveis globais
LerINIBD;


//Se não consegue conectar banco abre tela config banco
if not conectarBanco then
   begin
     frmconfig_banco := tfrmconfig_banco.create(self);
     frmconfig_banco.showmodal;
     frmconfig_banco.free;
   end;
//endi

 atualiza_base;

 verificaInf;

 frmlogin := tfrmlogin.Create(self);
 frmlogin.ShowModal;
 frmlogin.Free;

 if frmlogin.ModalResult <> mrOK then
    begin

      Application.Terminate;

    end;



  //showmessage(inttostr(existe_tabela('TUSUARIO')));

  //mostrar_inf_campo('TUSUARIO','LOGIN');


  //execscript;


  //atualiza_base;

end;

procedure Tfrmtela_principal.Button2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmtela_principal.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  modulo_conexaodb.atualizaBancoFechaTransacao;
end;

procedure Tfrmtela_principal.Button1Click(Sender: TObject);
begin
  MenuItem6Click(Sender);
end;

procedure Tfrmtela_principal.btnorcamentoClick(Sender: TObject);
begin
  MenuItem3Click(Sender);
end;

procedure Tfrmtela_principal.btnmovcaixaClick(Sender: TObject);
begin
  MenuItem13Click(Sender);
end;

procedure Tfrmtela_principal.btnpedidovendaClick(Sender: TObject);
begin
  MenuItem9Click(Sender);
end;

procedure Tfrmtela_principal.FormShow(Sender: TObject);
begin

   modulo_usuario.qrusuario.Close;
   modulo_usuario.qrusuario.SQL.Clear;
   modulo_usuario.qrusuario.SQL.Add('select * from tusuario u inner join tmaster_usuario t on u.controle=t.controle_tusuario where controle = :controle');
   modulo_usuario.qrusuario.Params.ParamByName('controle').AsInteger:=icontrole_usuario;
   modulo_usuario.qrusuario.Open;

   lblstatus.Caption:='';

end;

procedure Tfrmtela_principal.MenuItem10Click(Sender: TObject);
begin
  //frmsincbaseremota := tfrmsincbaseremota.Create(self);
  //frmsincbaseremota.ShowModal;
  //frmsincbaseremota.Free;
end;

procedure Tfrmtela_principal.MenuItem11Click(Sender: TObject);
begin
  frmparametro := tfrmparametro.create(self);
  frmparametro.showmodal;
  frmparametro.free;

end;

procedure Tfrmtela_principal.MenuItem12Click(Sender: TObject);
begin

end;

procedure Tfrmtela_principal.MenuItem13Click(Sender: TObject);
begin

  if  modulo_usuario.qrusuario.FieldByName('caixa').AsString <> 'SIM' then
     begin
       application.MessageBox('Você não tem acesso a este recurso!','Atenção',mb_ok);
       exit;
     end;
  //endi

  frmcaixa_impressao := tfrmcaixa_impressao.create(self);
  frmcaixa_impressao.showmodal;
  frmcaixa_impressao.free;
  frmcaixa_impressao := nil;

end;

procedure Tfrmtela_principal.MenuItem15Click(Sender: TObject);
begin

  if  modulo_usuario.qrusuario.FieldByName('nivelacesso').AsString <> 'ADMINISTRADOR' then
     begin
       application.MessageBox('Você não tem acesso a este recurso!','Atenção',mb_ok);
       exit;
     end;
  //endi

  frmusuario_pesquisa := tfrmusuario_pesquisa.create(self);
  frmusuario_pesquisa.showmodal;
  frmusuario_pesquisa.free;


end;

procedure Tfrmtela_principal.MenuItem3Click(Sender: TObject);
begin
  if  modulo_usuario.qrusuario.FieldByName('orcamento').AsString <> 'SIM' then
     begin
       application.MessageBox('Você não tem acesso a este recurso!','Atenção',mb_ok);
       exit;
     end;
  //endi

  frmorcamento_pesquisa := tfrmorcamento_pesquisa.create(self);
  frmorcamento_pesquisa.showmodal;
  frmorcamento_pesquisa.free;
end;

procedure Tfrmtela_principal.MenuItem4Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmtela_principal.MenuItem5Click(Sender: TObject);
begin

//if frmconfig_banco=nil then
//  frmconfig_banco:=Tfrmconfig_banco.Create(application)
//else
//  frmconfig_banco.Show;

frmconfig_banco := tfrmconfig_banco.create(self);
frmconfig_banco.showmodal;
frmconfig_banco.free;
end;

procedure Tfrmtela_principal.MenuItem6Click(Sender: TObject);
begin
  if conectarBanco_Aux then
     begin

       frmvendaorc := tfrmvendaorc.create(self);
       frmvendaorc.showmodal;
       frmvendaorc.free;

     end;
  //endi
end;

procedure Tfrmtela_principal.MenuItem8Click(Sender: TObject);

var
  controle, codigocstorigem, codigocst, idddent, ipos, idddfs:integer;
  scodigocstpis, scodigocstcofins,  scodigocstipi, scpf, sie, sgrupo, scest, sCestDescricao, hash, hash1:string;

begin
 if MessageDlg('Confirmação', 'Você realmente deseja transferir os dados?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
 then
     begin

       lblstatus.Caption:='Abrindo tabela padrão';

       with modulo_geral do
        begin

          qrmaster_indice.Close;
          qrmaster_indice.SQL.Clear;
          qrmaster_indice.SQL.Add('select * from tmaster_indice');
          qrmaster_indice.Open;

        end;


       with modulo_produto do
        begin


            //Carregar valor padrão

           qrcsticms.Close;
           qrcsticms.SQL.Clear;
           qrcsticms.SQL.Add('select * from tcsticms where controle = :controle');
           qrcsticms.ParamByName('controle').AsInteger:=modulo_geral.qrmaster_indice.FieldByName('codcsosnpadrao').AsInteger;
           qrcsticms.Open;

           icsosnpadrao := qrcsticms.FieldByName('codigocst').AsInteger;
           permitecreditoicmspadrao := qrcsticms.FieldByName('permitecredito').AsString;
           possuiicmsstpadrao := qrcsticms.FieldByName('possuiicmsst').Asstring;
           isentoicmspadrao := qrcsticms.FieldByName('isento').AsString;
           tributadoicmspadrao := qrcsticms.FieldByName('tributado').AsString;

           qrcstipi.Close;
           qrcstipi.SQL.Clear;
           qrcstipi.SQL.Add('select * from tcstipi where controle = :controle');
           qrcstipi.ParamByName('controle').AsInteger:=modulo_geral.qrmaster_indice.FieldByName('codcstipipadrao').AsInteger;
           qrcstipi.Open;

           icodcstipipadrao := qrcstipi.FieldByName('codcstipi').AsInteger;


           qrcstpis.Close;
           qrcstpis.SQL.Clear;
           qrcstpis.SQL.Add('select * from tcstpis where controle = :controle');
           qrcstpis.ParamByName('controle').AsInteger:=modulo_geral.qrmaster_indice.FieldByName('codcstpispadrao').AsInteger;
           qrcstpis.Open;

           icodcstpispadrao := qrcstpis.FieldByName('codigocst').AsInteger;



           qrcstcofins.Close;
           qrcstcofins.SQL.Clear;
           qrcstcofins.SQL.Add('select * from tcstcofins where controle = :controle');
           qrcstcofins.ParamByName('controle').AsInteger:=modulo_geral.qrmaster_indice.FieldByName('codcstcofinspadrao').AsInteger;
           qrcstcofins.Open;

           icodcstcofinspadrao := qrcstcofins.FieldByName('codigocstcofins').AsInteger;

        end;
       //endth

       lblstatus.Caption:='Excluindo informações da tabela';


       with modulo_conexaodb do
          begin
            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('delete from titemtabelapreco');
            qrexec_base.ExecSQL;


            qrexec_base.Close;
            qrexec_base.SQL.Clear;
            qrexec_base.SQL.Add('delete from ttabelapreco');
            qrexec_base.ExecSQL;


             modulo_conexaodb.atualizaBancoFechaTransacao;


          end;
       //endi






       with modulo_vendaorc do
           begin

             lblstatus.Caption:='Abrindo tabela diferenciada de preço';

             qrprodutos.close;
             qrprodutos.SQL.Clear;
             qrprodutos.SQL.Add('select  p.descricao as descproduto,  dp.codigo as codproduto, dp.codipi,  ipi.sigla as siglaipi,  dp.cpis, pis.sigla as siglapis, dp.ccofins, cofins.sigla as siglacofins, dp.csosn, dp.cest,  dp.cbar as codbarras, dp.caux as referencia, dp.ncm,  dp.cgru, gr.descricao  as descricaogrupo, dp.codsita as codigocstorigem,  o.descricao as codcstorigem,   dp.codsitb, dp.prcu as precocusto, dp.per as perclucro,  dp.prve as precovenda,  dp.cuni as codunidademedida,  u.descricao as und,  p.descricao,  dp.codigo as codprod from dprodutos dp   inner join produtos p on dp.cdescprod = p.codigo    left join unidade u on  dp.cuni = u.codigo    left join sita o on dp.codsita = o.codigo    left join sitb cst on dp.codsitb = cst.codigo       left join grupo gr on dp.cgru = gr.codigo     left join ipi on dp.codipi = ipi.codigo       left join pis on dp.cpis = pis.codigo    left join cofins on dp.ccofins = cofins.codigo order by dp.codigo');
             qrprodutos.Open;
             while not qrprodutos.EOF do
                 begin

                   try


                   hash :=   uppercase(   MD5Print(MD5String(  modulo_vendaorc.qrprodutos.FieldByName('codproduto').AsString + datetostr(now())  ))   );
                   hash1 :=  uppercase(   MD5Print(MD5String(  modulo_vendaorc.qrprodutos.FieldByName('descproduto').AsString + datetostr(now())  ))   );

                   scest := proc_cest(modulo_vendaorc.qrprodutos.FieldByName('ncm').AsString);
                   scestDescricao := proc_cestDescricao(modulo_vendaorc.qrprodutos.FieldByName('ncm').AsString);

                   //Atualiza tabelas auxiliares do sistema
                   with modulo_conexaodb do
                     begin

                       //Consulta Imposto médio
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from timpostomedio where ncmnbs = :ncmnbs');
                       qrconsulta_base.ParamByName('ncmnbs').AsString:= modulo_vendaorc.qrprodutos.FieldByName('ncm').AsString;
                       qrconsulta_base.Open;

                       if qrconsulta_base.RecordCount > 0 then
                          begin

                            icodimpostomedio :=  qrconsulta_base.FieldByName('controle').AsInteger;
                            faliquotanacional :=  qrconsulta_base.FieldByName('aliquotanacional').Asfloat;
                            faliquotaimportada :=  qrconsulta_base.FieldByName('aliquotaimportada').Asfloat;


                          end
                       else
                          begin


                            icodimpostomedio :=  40242;
                            faliquotanacional :=  31.60;
                            faliquotaimportada :=  39.09;


                          end;
                       //endi


                       //Consulta tcest
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tcest where ncm = :ncm');
                       qrconsulta_base.ParamByName('ncm').AsString:= copy(modulo_vendaorc.qrprodutos.FieldByName('ncm').AsString,1,8);
                       qrconsulta_base.Open;
                       if qrconsulta_base.RecordCount = 0 then
                          begin

                            qrexec_base.Close;
                            qrexec_base.SQL.Clear;
                            qrexec_base.SQL.Add('insert into tcest (cest, ncm, codimpostomedio, descricao) values (:cest, :ncm, :codimpostomedio, :descricao)');

                            if modulo_vendaorc.qrprodutos.FieldByName('cest').AsString <> '' then
                               begin

                                 qrexec_base.ParamByName('cest').AsString:=modulo_vendaorc.qrprodutos.FieldByName('cest').AsString;
                                 qrexec_base.ParamByName('descricao').AsString:='Outros:';

                               end
                            else
                               begin

                                 qrexec_base.ParamByName('cest').AsString := scest;
                                 qrexec_base.ParamByName('descricao').AsString:=scestDescricao;

                               end;
                            //endi


                            qrexec_base.ParamByName('ncm').AsString:=copy(modulo_vendaorc.qrprodutos.FieldByName('ncm').AsString,1,8);

                            qrexec_base.ParamByName('codimpostomedio').AsInteger:=icodimpostomedio;

                            qrexec_base.ExecSQL;

                            atualizaBanco;


                          end;
                       //endi


                       // Unidade Medida
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
                       qrconsulta_base.ParamByName('descricao').AsString:= modulo_vendaorc.qrprodutos.FieldByName('und').AsString;
                       qrconsulta_base.Open;

                       //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                       if (qrconsulta_base.RecordCount = 0) then
                          begin

                             qrexec_base.Close;
                             qrexec_base.SQL.Clear;
                             qrexec_base.SQL.Add('insert into tunidademedida (descricao, dataehoracadastro) values (:descricao, :dataehoracadastro)');
                             qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrprodutos.FieldByName('und').AsString;
                             qrexec_base.ParamByName('dataehoracadastro').AsDateTime := now();
                             qrexec_base.ExecSQL;

                             atualizaBanco;

                          end;
                       //endi

                       // CST Origem
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tcstoriem where codigoorigem = :codigoorigem');
                       codigocstorigem := StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('codcstorigem').AsString,0);
                       qrconsulta_base.ParamByName('codigoorigem').AsInteger:= codigocstorigem;
                       qrconsulta_base.Open;

                       //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                       if (qrconsulta_base.RecordCount = 0) then
                           begin
                             qrexec_base.Close;
                             qrexec_base.SQL.Clear;
                             qrexec_base.SQL.Add('insert into tcstoriem (codigoorigem, descricaoorigem) values (:codigoorigem, :descricaoorigem)');
                             qrexec_base.ParamByName('codigodescricao').AsString:=modulo_vendaorc.qrprodutos.FieldByName('codcstorigem').AsString;
                             qrexec_base.ParamByName('descricaoorigem').AsString:=modulo_vendaorc.qrprodutos.FieldByName('codcstorigem').AsString;
                             qrexec_base.ExecSQL;

                             atualizaBanco;

                           end;
                       //endi


                       // Grupo
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tgrupoestoque where  grupo = :grupo');
                       qrconsulta_base.ParamByName('grupo').AsString:=   RemoveAcento(  modulo_vendaorc.qrprodutos.FieldByName('descricaogrupo').AsString  );
                       qrconsulta_base.Open;

                       //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));


                       if (qrconsulta_base.RecordCount = 0) then
                           begin
                             qrexec_base.Close;
                             qrexec_base.SQL.Clear;
                             qrexec_base.SQL.Add('insert into tgrupoestoque (grupo) values (:grupo)');
                             qrexec_base.ParamByName('grupo').AsString:= RemoveAcento(  modulo_vendaorc.qrprodutos.FieldByName('descricaogrupo').AsString);
                             qrexec_base.ExecSQL;

                             atualizaBanco;

                           end;
                       //endi

                       // IPI
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tcstipi where codcstipi = :codcstipi');
                       scodigocstipi := formatfloat('00',  StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('siglaipi').AsString,icodcstipipadrao));
                       qrconsulta_base.ParamByName('codcstipi').AsString:= scodigocstipi;
                       qrconsulta_base.Open;

                       //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                       if (qrconsulta_base.RecordCount = 0) then
                          begin
                            qrexec_base.Close;
                            qrexec_base.SQL.Clear;
                            qrexec_base.SQL.Add('insert into tcstipi (codcstipi, descricao) values (:codcstipi, :descricao)');
                            qrexec_base.ParamByName('codcstipi').AsString:=modulo_vendaorc.qrprodutos.FieldByName('siglaipi').AsString;
                            qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrprodutos.FieldByName('siglaipi').AsString;
                            qrexec_base.ExecSQL;

                            atualizaBanco;
                          end;
                       //endi


                       // PIS
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tcstpis where codigocst = :codigocst');
                       scodigocstpis := formatfloat('00',StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('siglapis').AsString,icodcstpispadrao));
                       qrconsulta_base.ParamByName('codigocst').AsString:= scodigocstpis;
                       qrconsulta_base.Open;

                       //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                       if (qrconsulta_base.RecordCount = 0) then
                          begin
                            qrexec_base.Close;
                            qrexec_base.SQL.Clear;
                            qrexec_base.SQL.Add('insert into tcstpis (codigocst, descricao) values (:codigocst, :descricao)');
                            qrexec_base.ParamByName('codigocst').AsString:=modulo_vendaorc.qrprodutos.FieldByName('siglapis').AsString;
                            qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrprodutos.FieldByName('siglapis').AsString;
                            qrexec_base.ExecSQL;

                            atualizaBanco;
                          end;
                       //endi

                       // COFINS
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tcstcofins where codigocstcofins = :codigocstcofins');
                       scodigocstcofins := formatfloat('00',StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('siglacofins').AsString,icodcstcofinspadrao));
                       qrconsulta_base.ParamByName('codigocstcofins').Asstring:= scodigocstcofins;
                       qrconsulta_base.Open;

                       //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                       if (qrconsulta_base.RecordCount = 0) then
                          begin
                            qrexec_base.Close;
                            qrexec_base.SQL.Clear;
                            qrexec_base.SQL.Add('insert into tcstcofins (codigocstcofins, descricao) values (:codigocstcofins, :descricao)');
                            qrexec_base.ParamByName('codigocstcofins').AsString:=modulo_vendaorc.qrprodutos.FieldByName('siglacofins').AsString;
                            qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrprodutos.FieldByName('siglacofins').AsString;
                            qrexec_base.ExecSQL;

                            atualizaBanco;
                          end;
                       //endi


                       //  CSOSN
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from tcsticms where codigocst = :codigocst');
                       codigocst := StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('csosn').AsString,icsosnpadrao);
                       qrconsulta_base.ParamByName('codigocst').AsInteger:= codigocst;
                       qrconsulta_base.Open;

                       //showmessage(  inttostr( modulo_vendaorc.qrvenda_itemproduto.FieldByName('codunidademedida').AsInteger));

                       if (qrconsulta_base.RecordCount = 0) then
                          begin
                            qrexec_base.Close;
                            qrexec_base.SQL.Clear;
                            qrexec_base.SQL.Add('insert into tcsticms (codigocst, descricao) values (:codigocst, :descricao)');
                            qrexec_base.ParamByName('codigocst').AsString:=modulo_vendaorc.qrprodutos.FieldByName('csosn').AsString;
                            qrexec_base.ParamByName('descricao').AsString:=modulo_vendaorc.qrprodutos.FieldByName('csosn').AsString;
                            qrexec_base.ExecSQL;

                            atualizaBanco;
                          end;
                       //endi


                       // ----



                       // Produto
                       qrconsulta_base.Close;
                       qrconsulta_base.SQL.Clear;
                       qrconsulta_base.SQL.Add('select * from testoque where controle = :controle');
                       qrconsulta_base.ParamByName('controle').AsInteger:= modulo_vendaorc.qrprodutos.FieldByName('codproduto').AsInteger;
                       qrconsulta_base.Open;
                       if qrconsulta_base.RecordCount = 0 then
                          begin

                            qrexec_base.Close;
                            qrexec_base.SQL.Clear;
                            qrexec_base.SQL.Add('insert into testoque (controle,   origem,  grupo,  produto,  unidade,  precocusto,  perclucro,  precovenda,  IAT,  IPPT,  tributado,  pesado,  codunidademedida,  codcstorigem,  codigocstorigem,  fatorconversao,  controlarvalidade,  codgrupo,  ncm,  codbarras,  tipobarra,  ativo,  referencia,  customedio,  datahoracadastro,  usagrade,  usaserial,  codtributacaoipi,  tributacaoipi,  codtributacaopis,  tributacaopis,  codtributacaocofins,  tributacaocofins,  possuiicmsst,  isento,  csosn,  descricaocsosn,  codaplicacaoproduto,  aplicacaoproduto,  codemitente,  cest,  valorconversao,   codimpostomedio,   percimpostomedio,  md5,  md5e2,  PERCICMSSTINTERNA,  percmvaoriginal,   percicmspropriost, valorunitariocompra,   percreducaobcst, percipi,   nometabelapreco,  percimpostomedioestadual,  percimpostomediomunicipal,   percglpcomb,   percgnncomb,     percgnicomb,   valorpartidacomb,    aliquotafcp,   PERCFCPST  ) values ');
                            qrexec_base.SQL.Add('                     (:controle, :origem, :grupo, :produto, :unidade, :precocusto, :perclucro, :precovenda, :IAT, :IPPT, :tributado, :pesado, :codunidademedida, :codcstorigem, :codigocstorigem, :fatorconversao, :controlarvalidade, :codgrupo, :ncm, :codbarras, :tipobarra, :ativo, :referencia, :customedio, :datahoracadastro, :usagrade, :usaserial, :codtributacaoipi, :tributacaoipi, :codtributacaopis, :tributacaopis, :codtributacaocofins, :tributacaocofins, :possuiicmsst, :isento, :csosn, :descricaocsosn, :codaplicacaoproduto, :aplicacaoproduto, :codemitente, :cest, :valorconversao,  :codimpostomedio,  :percimpostomedio, :md5, :md5e2, :PERCICMSSTINTERNA, :percmvaoriginal,  :percicmspropriost, :valorunitariocompra, :percreducaobcst, :percipi, :nometabelapreco, :percimpostomedioestadual, :percimpostomediomunicipal, :percglpcomb,    :percgnncomb,   :percgnicomb,   :valorpartidacomb,  :aliquotafcp,  :PERCFCPST  )');

                            qrexec_base.ParamByName('controle').AsInteger:=modulo_vendaorc.qrprodutos.FieldByName('codproduto').AsInteger;
                            qrexec_base.ParamByName('produto').AsString:=modulo_vendaorc.qrprodutos.FieldByName('descricao').AsString;;
                            qrexec_base.ParamByName('unidade').AsString:=modulo_vendaorc.qrprodutos.FieldByName('und').AsString;

                            qrexec_base.ParamByName('md5').AsString:= hash;
                            qrexec_base.ParamByName('md5e2').AsString:= hash1;

                            if modulo_vendaorc.qrprodutos.FieldByName('cest').AsString <> '' then
                               begin

                                 qrexec_base.ParamByName('cest').AsString:=modulo_vendaorc.qrprodutos.FieldByName('cest').AsString;

                               end
                            else
                               begin

                                 qrexec_base.ParamByName('cest').AsString := scest;

                              end;
                            //endi


                            qrexec_base.ParamByName('valorunitariocompra').Asfloat:= qrprodutos.FieldByName('precocusto').Asfloat;

                            qrexec_base.ParamByName('usagrade').AsString:= 'NÃO';
                            qrexec_base.ParamByName('usaserial').AsString:= 'NÃO';

                            qrexec_base.ParamByName('datahoracadastro').AsDate:= now();
                            qrexec_base.ParamByName('possuiicmsst').AsString:= possuiicmsstpadrao;
                            qrexec_base.ParamByName('isento').AsString:= isentoicmspadrao;

                            qrexec_base.ParamByName('codaplicacaoproduto').AsString:= '00';
                            qrexec_base.ParamByName('aplicacaoproduto').AsString:= 'MERCADORIA PARA REVENDA';
                            qrexec_base.ParamByName('codemitente').AsInteger:= 1;
                            qrexec_base.ParamByName('valorconversao').Asfloat:= 1;


                            qrexec_base.ParamByName('percicmsstinterna').Asfloat:= 0;
                            qrexec_base.ParamByName('percmvaoriginal').Asfloat:= 0;
                            qrexec_base.ParamByName('percicmspropriost').Asfloat:= 0;
                            qrexec_base.ParamByName('percreducaobcst').Asfloat:= 0;
                            qrexec_base.ParamByName('percipi').Asfloat:= 0;
                            qrexec_base.ParamByName('percglpcomb').Asfloat:= 0;
                            qrexec_base.ParamByName('percgnncomb').Asfloat:= 0;
                            qrexec_base.ParamByName('percgnicomb').Asfloat:= 0;
                            qrexec_base.ParamByName('valorpartidacomb').Asfloat:= 0;
                            qrexec_base.ParamByName('aliquotafcp').Asfloat:= 0;
                            qrexec_base.ParamByName('PERCFCPST').Asfloat:= 0;
                            qrexec_base.ParamByName('nometabelapreco').AsString:= '';
                            qrexec_base.ParamByName('percimpostomedioestadual').Asfloat:= 12;
                            qrexec_base.ParamByName('percimpostomediomunicipal').Asfloat:= 0;




                            // Consulta Unidade Medida
                            qrconsulta_base.Close;
                            qrconsulta_base.SQL.Clear;
                            qrconsulta_base.SQL.Add('select * from tunidademedida where descricao = :descricao');
                            qrconsulta_base.ParamByName('descricao').AsString:= modulo_vendaorc.qrprodutos.FieldByName('und').AsString;
                            qrconsulta_base.Open;

                            qrexec_base.ParamByName('codunidademedida').AsInteger :=    qrconsulta_base.FieldByName('controle').AsInteger;


                            //Consulta origem
                            qrconsulta_base.Close;
                            qrconsulta_base.SQL.Clear;
                            qrconsulta_base.SQL.Add('select * from tcstoriem where codigoorigem = :codigoorigem');
                            codigocstorigem := StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('codcstorigem').AsString,0);
                            qrconsulta_base.ParamByName('codigoorigem').AsInteger:= codigocstorigem;
                            qrconsulta_base.Open;

                            qrexec_base.ParamByName('codcstorigem').AsInteger :=  qrconsulta_base.FieldByName('controle').AsInteger  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                            qrexec_base.ParamByName('origem').AsString:= qrconsulta_base.FieldByName('codigoorigem').AsString+' - '+qrconsulta_base.FieldByName('descricaoorigem').AsString ;
                            qrexec_base.ParamByName('codigocstorigem').AsInteger := qrconsulta_base.FieldByName('codigoorigem').AsInteger;


                            //percentual medio de imposto
                            fpercimpostomedio := faliquotanacional;
                            qrexec_base.ParamByName('codimpostomedio').AsInteger :=  icodimpostomedio; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                            qrexec_base.ParamByName('percimpostomedio').Asfloat := fpercimpostomedio;


                            //Consulta IPI
                            qrconsulta_base.Close;
                            qrconsulta_base.SQL.Clear;
                            qrconsulta_base.SQL.Add('select * from tcstipi where codcstipi = :codcstipi');
                            scodigocstipi := formatfloat('00',StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('siglaipi').AsString,icodcstipipadrao));
                            qrconsulta_base.ParamByName('codcstipi').AsString:= scodigocstipi;
                            qrconsulta_base.Open;

                            qrexec_base.ParamByName('codtributacaoipi').Asstring :=  qrconsulta_base.FieldByName('codcstipi').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                            qrexec_base.ParamByName('tributacaoipi').AsString:= qrconsulta_base.FieldByName('descricao').AsString;


                            //Consulta PIS
                            qrconsulta_base.Close;
                            qrconsulta_base.SQL.Clear;
                            qrconsulta_base.SQL.Add('select * from tcstpis where codigocst = :codigocst');
                            scodigocstpis :=  formatfloat('00',  StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('siglapis').AsString,icodcstpispadrao));
                            qrconsulta_base.ParamByName('codigocst').AsString:= scodigocstpis;
                            qrconsulta_base.Open;

                            qrexec_base.ParamByName('codtributacaopis').AsString :=  qrconsulta_base.FieldByName('codigocst').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                            qrexec_base.ParamByName('tributacaopis').AsString:= qrconsulta_base.FieldByName('descricao').AsString;


                            //Consulta Cofins
                            qrconsulta_base.Close;
                            qrconsulta_base.SQL.Clear;
                            qrconsulta_base.SQL.Add('select * from tcstcofins where codigocstcofins = :codigocstcofins');
                            scodigocstcofins :=  formatfloat('00',  StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('siglacofins').AsString,icodcstcofinspadrao));
                            qrconsulta_base.ParamByName('codigocstcofins').AsString:= scodigocstcofins;
                            qrconsulta_base.Open;

                            qrexec_base.ParamByName('codtributacaocofins').AsString :=  qrconsulta_base.FieldByName('codigocstcofins').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                            qrexec_base.ParamByName('tributacaocofins').AsString:= qrconsulta_base.FieldByName('descricao').AsString;


                            //Consulta CSOSN
                            qrconsulta_base.Close;
                            qrconsulta_base.SQL.Clear;
                            qrconsulta_base.SQL.Add('select * from tcsticms where codigocst = :codigocst');
                            codigocst :=  StrToIntDef(modulo_vendaorc.qrprodutos.FieldByName('csosn').AsString,icsosnpadrao);
                            qrconsulta_base.ParamByName('codigocst').AsInteger:= codigocst;
                            qrconsulta_base.Open;

                            qrexec_base.ParamByName('csosn').AsString :=  qrconsulta_base.FieldByName('codigocst').AsString  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                            qrexec_base.ParamByName('descricaocsosn').AsString:= qrconsulta_base.FieldByName('descricao').AsString;


                            //Consulta Grupo
                            //try
                            qrconsulta_base.Close;
                            qrconsulta_base.SQL.Clear;
                            qrconsulta_base.SQL.Add('select * from tgrupoestoque where grupo = :grupo');
                            qrconsulta_base.ParamByName('grupo').AsString:= RemoveAcento(modulo_vendaorc.qrprodutos.FieldByName('descricaogrupo').AsString);
                            qrconsulta_base.Open;

                            qrexec_base.ParamByName('codgrupo').AsInteger :=  qrconsulta_base.FieldByName('controle').AsInteger  ; //modulo_vendaorc.qrvenda_itemproduto.FieldByName('codigocstorigem').AsInteger;
                            qrexec_base.ParamByName('grupo').AsString :=   RemoveAcento(modulo_vendaorc.qrprodutos.FieldByName('descricaogrupo').AsString);

                            qrexec_base.ParamByName('precocusto').Asfloat:=modulo_vendaorc.qrprodutos.FieldByName('precocusto').Asfloat;
                            qrexec_base.ParamByName('perclucro').Asfloat:=modulo_vendaorc.qrprodutos.FieldByName('perclucro').Asfloat;
                            qrexec_base.ParamByName('precovenda').Asfloat:=modulo_vendaorc.qrprodutos.FieldByName('precovenda').Asfloat;


                            qrexec_base.ParamByName('codbarras').AsString:=modulo_vendaorc.qrprodutos.FieldByName('codbarras').AsString;
                            qrexec_base.ParamByName('referencia').AsString:=modulo_vendaorc.qrprodutos.FieldByName('referencia').AsString;
                            qrexec_base.ParamByName('ncm').AsString:=modulo_vendaorc.qrprodutos.FieldByName('ncm').AsString;


                            //permitecreditoicmspadrao


                            qrexec_base.ParamByName('IAT').AsString:='A';
                            qrexec_base.ParamByName('IPPT').AsString:='T';

                            qrexec_base.ParamByName('tributado').AsString:=tributadoicmspadrao;



                            qrexec_base.ParamByName('pesado').AsString:='NÃO';
                            qrexec_base.ParamByName('fatorconversao').AsString:='*';
                            qrexec_base.ParamByName('controlarvalidade').AsString:='NÃO';
                            qrexec_base.ParamByName('ativo').AsString:='SIM';

                            qrexec_base.ExecSQL;

                            atualizaBanco;
                            //except
                            //Quando ocorre erro de grupo
                            //end;

                          end;
                       //endif



                       // ----




                     end;
                   //endth

                   except




                       GravarLog( 'mensagem.tabela.produto.log', 'Nao foi possivel gravar'+chr(13)+
                                 'Codigo Produto: '+' '+ qrprodutos.FieldByName('codproduto').AsString+chr(13) );






                   end;


                   lblstatus.Caption:='Produto> Lendo código '+qrprodutos.fieldbyname('codproduto').asstring;
                   frmtela_principal.Update;


                   qrprodutos.Next;
                 end;
             //endw
             qrprodutos.Close;




             //tabela de preço
             qrdescricao_tabpreco.Close;
             qrdescricao_tabpreco.SQL.Clear;
             qrdescricao_tabpreco.SQL.Add('select * from tipotab order by codigo');
             qrdescricao_tabpreco.Open;

             while not qrdescricao_tabpreco.EOF do
                 begin
                   modulo_conexaodb.qrexec_base.Close;
                   modulo_conexaodb.qrexec_base.SQL.Clear;
                   modulo_conexaodb.qrexec_base.SQL.Add('insert into ttabelapreco(controle, nometabela, datainicial, datafinal, datahoracadastro, ativo, percdesconto, percacrescimo, expirado, tipo, diasemana) values (:controle, :nometabela, :datainicial, :datafinal, :datahoracadastro, :ativo, :percdesconto, :percacrescimo, :expirado, :tipo, :diasemana)');

                   modulo_conexaodb.qrexec_base.ParamByName('controle').AsInteger:= qrdescricao_tabpreco.FieldByName('codigo').AsInteger;
                   modulo_conexaodb.qrexec_base.ParamByName('nometabela').asString:=  qrdescricao_tabpreco.FieldByName('descricao').AsString;
                   modulo_conexaodb.qrexec_base.ParamByName('datainicial').asdate:=date;
                   modulo_conexaodb.qrexec_base.ParamByName('datafinal').asdate:=date+720;
                   modulo_conexaodb.qrexec_base.ParamByName('datahoracadastro').asdatetime:= now();
                   modulo_conexaodb.qrexec_base.ParamByName('ativo').AsString:='SIM';
                   modulo_conexaodb.qrexec_base.ParamByName('percdesconto').asfloat:= 0;
                   modulo_conexaodb.qrexec_base.ParamByName('percacrescimo').asfloat:= 0;
                   modulo_conexaodb.qrexec_base.ParamByName('expirado').asString:= 'NÃO';

                   modulo_conexaodb.qrexec_base.ExecSQL;

                   lblstatus.Caption:='Descrição Tabela de preço> Lendo código '+qrdescricao_tabpreco.fieldbyname('codigo').asstring;
                   frmtela_principal.Update;

                   qrdescricao_tabpreco.Next;
                 end;
             //endw
             qrdescricao_tabpreco.Close;


             qrtabpreco.close;
             qrtabpreco.SQL.Clear;
             qrtabpreco.SQL.Add('select ');

             qrtabpreco.SQL.Add('p.codigo as codigo_detalhe,');
             qrtabpreco.SQL.Add('t.codigo as codigo_tabela,');
             qrtabpreco.SQL.Add('t.descricao as descricao_tabela,');
             qrtabpreco.SQL.Add('d.codigo as codigo_produto,');
             qrtabpreco.SQL.Add('pr.descricao as produto,');
             qrtabpreco.SQL.Add('p.per as per_tabelado,');
             qrtabpreco.SQL.Add('p.prve as prve_tabelado,');
             qrtabpreco.SQL.Add('d.prve as prve_normal,');
             qrtabpreco.SQL.Add('d.per as per_normal ');

             qrtabpreco.SQL.Add('from tabprp p ');

             qrtabpreco.SQL.Add('inner join tipotab t on p.ctab = t.codigo ');
             qrtabpreco.sql.Add('inner join dprodutos d on p.cpro = d.codigo ');
             qrtabpreco.sql.Add('inner join produtos pr on d.cdescprod = pr.codigo ');

             qrtabpreco.sql.Add('order by codigo_detalhe');

             qrtabpreco.Open;

             while not qrtabpreco.EOF do
                 begin
                   try
                   modulo_conexaodb.qrexec_base.Close;
                   modulo_conexaodb.qrexec_base.SQL.Clear;
                   modulo_conexaodb.qrexec_base.SQL.Add('insert into TITEMTABELAPRECO(controle, codproduto, produto, datahoracadastro, codtabelapreco, codgrupoestoque, grupoestoque, precovenda, precovendatabelado) values (:controle, :codproduto, :produto, :datahoracadastro, :codtabelapreco, :codgrupoestoue, :grupoestoque, :precovenda, :precovendatabelado)');

                   modulo_conexaodb.qrexec_base.ParamByName('controle').AsInteger:= qrtabpreco.FieldByName('codigo_detalhe').AsInteger;
                   modulo_conexaodb.qrexec_base.ParamByName('codproduto').AsInteger:= qrtabpreco.FieldByName('codigo_produto').AsInteger;
                   modulo_conexaodb.qrexec_base.ParamByName('produto').asString:=  qrtabpreco.FieldByName('produto').AsString;
                   modulo_conexaodb.qrexec_base.ParamByName('datahoracadastro').asdatetime:= now();
                   modulo_conexaodb.qrexec_base.ParamByName('codtabelapreco').AsInteger:= qrtabpreco.FieldByName('codigo_tabela').AsInteger;
                   modulo_conexaodb.qrexec_base.ParamByName('precovenda').Asfloat:= qrtabpreco.FieldByName('prve_normal').Asfloat;
                   modulo_conexaodb.qrexec_base.ParamByName('precovendatabelado').Asfloat:= qrtabpreco.FieldByName('prve_tabelado').Asfloat;





                   modulo_conexaodb.qrexec_base.ExecSQL;

                   except


                     GravarLog( 'mensagem.tabela.pr_detalhe.log', 'Nao foi possivel gravar'+chr(13)+
                                 'Codigo Detalhe: '+' '+qrtabpreco.FieldByName('codigo_detalhe').AsString+chr(13)+
                                 'Codigo Produto: '+' '+qrtabpreco.FieldByName('codigo_produto').AsString+chr(13)+
                                 'Descricao Produto: '+' '+qrtabpreco.FieldByName('produto').AsString+chr(13)+
                                 'Codigo Tabela Preco: '+qrtabpreco.FieldByName('codigo_tabela').AsString+chr(13)+
                                 'Preco Normal: '+qrtabpreco.FieldByName('prve_normal').AsString+chr(13)+
                                 'preco Diferenciado: '+qrtabpreco.FieldByName('prve_tabelado').AsString+chr(13) );




                   end;

                   lblstatus.Caption:='Tabela de Preço Detalhe> Lendo código '+qrtabpreco.fieldbyname('codigo_detalhe').asstring;
                   frmtela_principal.Update;

                   qrtabpreco.Next;
                 end;
             //endiw

             qrtabpreco.Close;

             //Atualizar generator
             //GEN_TTABELAPRECO_ID
             //GEN_TITEMTABELAPRECO_ID

             modulo_conexaodb.atualizaBancoFechaTransacao;

             application.MessageBox('Transferência de informação concluida!','Informação',mb_ok);

             lblstatus.Caption:='';

           end;
       //endth

     end;
 //endif

end;

procedure Tfrmtela_principal.MenuItem9Click(Sender: TObject);
begin

 if  modulo_usuario.qrusuario.FieldByName('pedidovenda').AsString <> 'SIM' then
    begin
      application.MessageBox('Você não tem acesso a este recurso!','Atenção',mb_ok);
      exit;
    end;
 //endi

 frmpedidovenda_pesquisa := tfrmpedidovenda_pesquisa.create(self);
 frmpedidovenda_pesquisa.showmodal;
 frmpedidovenda_pesquisa.free;
 frmpedidovenda_pesquisa := nil;

end;



end.

