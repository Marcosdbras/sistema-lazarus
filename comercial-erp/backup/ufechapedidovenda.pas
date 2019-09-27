unit ufechapedidovenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin, DbCtrls, DBGrids, Buttons, Types, LCLType, math;

type

  { Tfrmfechapedidovenda }

  Tfrmfechapedidovenda = class(TForm)
    btnalterarfin: TBitBtn;
    btnlancarparcela: TBitBtn;
    btnlancar: TBitBtn;
    btncancelar: TBitBtn;
    btnestornar: TButton;
    ckbimprimir: TCheckBox;
    dbgparcela: TDBGrid;
    cbxformapre: TDBLookupComboBox;
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
    Label16: TLabel;
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
    procedure btncancelarClick(Sender: TObject);
    procedure btnestornarClick(Sender: TObject);
    procedure btnlancarClick(Sender: TObject);
    procedure btnlancarparcelaClick(Sender: TObject);
    procedure cbxformapreChange(Sender: TObject);
    procedure cbxformapreExit(Sender: TObject);
    procedure dbgparcelaKeyPress(Sender: TObject; var Key: char);
    procedure cbxformapreKeyPress(Sender: TObject; var Key: char);
    procedure edtpercdescontoExit(Sender: TObject);
    procedure edtpercdescontoKeyPress(Sender: TObject; var Key: char);
    procedure edtvlravistaExit(Sender: TObject);
    procedure edtvlrdescontoExit(Sender: TObject);
    procedure edtvlrdescontoKeyPress(Sender: TObject; var Key: char);
    procedure edtvlrpagarExit(Sender: TObject);
    procedure edtvlrpagarKeyPress(Sender: TObject; var Key: char);
    procedure edtvlravistaKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure edtnparcKeyPress(Sender: TObject; var Key: char);
    procedure excluirparcelas;
  private
       icodigo_controle:integer;
       ftroco, fpercdesconto:real;
       stroco:string;




  public

  end;

var
  frmfechapedidovenda: Tfrmfechapedidovenda;

implementation
       uses ufuncao_geral, umodulo_receber, umodulo_pedidovenda, umodulo_especie,
            umodulo_conexaodb, umodulo_master_indice, ucadastro_parcelafinanceiro,
            umodulo_parcelapredefinida, upedidovenda_impressao, uimppedvenda;
{$R *.lfm}

{ Tfrmfechapedidovenda }

procedure Tfrmfechapedidovenda.cbxformapreKeyPress(Sender: TObject;
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

 if frac(fpercdesconto) <> frac(edtpercdesconto.Value) then
    fpercdesconto :=  edtpercdesconto.Value
 else
    if  int(fpercdesconto) <> int(edtpercdesconto.Value) then
        fpercdesconto :=  edtpercdesconto.Value;
    //endi
 //endi

 edtvlrdesconto.Value :=     fpercdesconto / 100 * strtofloat(tirapontos(lbltotal.Caption));
 edtvlrpagar.Value :=  strtofloat(tirapontos(lbltotal.Caption)) - edtvlrdesconto.Value;

end;

procedure Tfrmfechapedidovenda.btnlancarClick(Sender: TObject);
var
  ftotal, fvlrpagar:real;
begin
  fvlrpagar := strtofloat(tirapontos(edtvlrpagar.Text));

  if  modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('statuspedido').AsString <> 'F' then
     begin

       with modulo_conexaodb do
            begin

              qrconsulta_base.Close;
              qrconsulta_base.SQL.Clear;
              qrconsulta_base.SQL.Add('select sum(valororiginal) as total from tmaster_receber group by codpedidovenda having codpedidovenda = :codpedidovenda');
              qrconsulta_base.ParamByName('codpedidovenda').AsInteger:=icodigo_controle;
              qrconsulta_base.Open;
              ftotal := qrconsulta_base.FieldByName('total').AsFloat+edtvlravista.Value;
              if ftotal < fvlrpagar then
                 begin
                   application.MessageBox('Insuficiência de valores','Atençaõ',MB_OK);
                   exit;
                 end;
              //endi
              if (ftotal = 0) and (edtnparc.Value > 0) then
                 begin
                   application.MessageBox('Insuficiência de valores ou nenhuma parcela lançada','Atençaõ',MB_OK);
                   exit;
                 end;
              //endi

              qrexec_base.Close;
              qrexec_base.SQL.Clear;
              qrexec_base.SQL.Add('update tmaster_pedidovenda set cparc_pred = :cparc_pred, descricao_parc_pred = :descricao_parc_pred, percdesconto = :percdesconto, vlrdesconto = :vlrdesconto, vlrpagar = :vlrpagar, vlrrecebido = :vlrrecebido, vlrtroco = :vlrtroco, nparc = :nparc, statuspedido = :statuspedido where controle_tpedidovenda = :controle_tpedidovenda');
              if cbxformapre.Text <> '' then
                 begin

                   qrexec_base.ParamByName('cparc_pred').AsInteger:=  modulo_parcelapredefinida.qrParcelaPredefinida.FieldByName('controle').AsInteger;
                   qrexec_base.ParamByName('descricao_parc_pred').AsString:=modulo_parcelapredefinida.qrParcelaPredefinida.FieldByName('descricao').AsString;

                 end
              else
                 begin

                   qrexec_base.ParamByName('cparc_pred').AsInteger:=  0;
                   qrexec_base.ParamByName('descricao_parc_pred').AsString:='';

                 end;
              //endif

              //qrexec_base.ParamByName('vlrpagoavista').AsFloat:=edtvlrpagar.Value;
              qrexec_base.ParamByName('percdesconto').AsFloat:= edtpercdesconto.Value;
              qrexec_base.ParamByName('vlrdesconto').AsFloat:= edtvlrdesconto.Value;
              qrexec_base.ParamByName('vlrpagar').AsFloat:=edtvlrpagar.Value;
              qrexec_base.ParamByName('vlrrecebido').AsFloat:=edtvlravista.Value;
              qrexec_base.ParamByName('vlrtroco').AsFloat:=ftroco;
              qrexec_base.ParamByName('nparc').AsInteger:=edtnparc.Value;
              qrexec_base.ParamByName('statuspedido').AsString:='F';
              qrexec_base.ParamByName('controle_tpedidovenda').AsInteger:=icodigo_controle;

              qrexec_base.ExecSQL;

              atualizaBanco;

            end;


            if ftroco > 0 then
               begin

                 stroco := 'R$ '+formatfloat('###,###,##0.00',ftroco);
                 Application.MessageBox(pchar(stroco),'Troco',MB_OK);

               end;
            //end







     end;
  //endi



     if ckbimprimir.Checked then
        begin

          try
             frmimppedvenda := tfrmimppedvenda.Create(self);
             frmimppedvenda.rlimppedvenda.Print;
             frmimppedvenda.free;
             frmimppedvenda := nil;
          except
            showmessage('Impressão Cancelada!');
          end;


        end;
     //endi



     modulo_pedidovenda.qrpedidovenda.Refresh;


     modulo_pedidovenda.qrpedidovenda.Locate('controle',icodigo_controle,[]);

     close;

end;

procedure Tfrmfechapedidovenda.btnalterarfinClick(Sender: TObject);
begin

  frmcadastro_parcelafinanceiro := tfrmcadastro_parcelafinanceiro.Create(self);
  frmcadastro_parcelafinanceiro.ShowModal;
  frmcadastro_parcelafinanceiro.Free;
  frmcadastro_parcelafinanceiro := nil;

end;

procedure Tfrmfechapedidovenda.btncancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmfechapedidovenda.btnestornarClick(Sender: TObject);
begin
            with modulo_conexaodb do
            begin

              qrexec_base.Close;
              qrexec_base.SQL.Clear;
              qrexec_base.SQL.Add('update tmaster_pedidovenda set cparc_pred = :cparc_pred, descricao_parc_pred = :descricao_parc_pred, percdesconto = :percdesconto, vlrdesconto = :vlrdesconto, vlrpagar = :vlrpagar, vlrrecebido = :vlrrecebido, vlrtroco = :vlrtroco, nparc = :nparc, statuspedido = :statuspedido where controle_tpedidovenda = :controle_tpedidovenda');

              qrexec_base.ParamByName('cparc_pred').AsInteger:=  0;
              qrexec_base.ParamByName('descricao_parc_pred').AsString:='';
              qrexec_base.ParamByName('percdesconto').AsFloat:= 0;
              qrexec_base.ParamByName('vlrdesconto').AsFloat:= 0;
              qrexec_base.ParamByName('vlrpagar').AsFloat:=0;
              qrexec_base.ParamByName('vlrrecebido').AsFloat:=0;
              qrexec_base.ParamByName('vlrtroco').AsFloat:=0;
              qrexec_base.ParamByName('nparc').AsInteger:=0;
              qrexec_base.ParamByName('statuspedido').AsString:='A';
              qrexec_base.ParamByName('controle_tpedidovenda').AsInteger:=icodigo_controle;

              qrexec_base.ExecSQL;

              atualizaBanco;

            end;
            //endif


            excluirparcelas;

            modulo_pedidovenda.qrpedidovenda.Refresh;


            modulo_pedidovenda.qrpedidovenda.Locate('controle',icodigo_controle,[]);


  close;
end;

procedure Tfrmfechapedidovenda.btnlancarparcelaClick(Sender: TObject);
var
  i, iIntervalo, ultimocodigo:integer;
  ftotalapurado, fparcelas, fdiferenca, ftotalavista, ftotalapagar:real;
begin

  ftotalavista := edtvlravista.Value;

  ftotalapagar := edtvlrpagar.Value;


  excluirparcelas;

  if edtnparc.Value = 0 then
     begin

       exit;

     end;
  //endi


  i := 1;

  iIntervalo := 30;

  fparcelas := (edtvlrpagar.Value - edtvlravista.Value) / edtnparc.Value;

  while i <= edtnparc.Value do
     begin



       with modulo_conexaodb do
          begin

             qrexec_base.close;
             qrexec_base.SQL.Clear;
             qrexec_base.SQL.Add('insert into tmaster_receber( CODPEDIDOVENDA, DESCRICAOLANCAMENTO, QTDEPARCELA, NPARCELA, CODCLIENTE,         CLIENTE, CODESPECIE, ESPECIE, DATAHORACADASTRO,         DATAVENCIMENTO, CODPLANOCONTA, PLANOCONTA, DOCUMENTO,          ORIGEM, VALORORIGINAL,         OBS, CODFUNCIONARIO, FUNCIONARIO, CODVENDEDOR, VENDEDOR,        CODBARRA, REPLICADA, STATUS,        PRAZO,     CODCENTROCUSTO,       CENTROCUSTO)');
             qrexec_base.SQL.Add('                     values( :CODPEDIDOVENDA, :DESCRICAOLANCAMENTO, :QTDEPARCELA, :NPARCELA, :CODCLIENTE,      :CLIENTE, :CODESPECIE, :ESPECIE, :DATAHORACADASTRO,     :DATAVENCIMENTO, :CODPLANOCONTA, :PLANOCONTA, :DOCUMENTO,      :ORIGEM, :VALORORIGINAL,      :OBS, :CODFUNCIONARIO, :FUNCIONARIO, :CODVENDEDOR, :VENDEDOR,    :CODBARRA, :REPLICADA, :STATUS,    :PRAZO,      :CODCENTROCUSTO,        :CENTROCUSTO)');

             qrexec_base.Params.ParamByName('CODPEDIDOVENDA').AsInteger :=  modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
             qrexec_base.Params.ParamByName('DESCRICAOLANCAMENTO').AsString := 'Parcela '+inttostr(i)+' de '+edtnparc.Text;
             qrexec_base.Params.ParamByName('QTDEPARCELA').AsInteger := edtnparc.Value;
             qrexec_base.Params.ParamByName('NPARCELA').AsInteger := i;

             qrexec_base.Params.ParamByName('CODCLIENTE').AsInteger :=  modulo_pedidovenda.qrpedidovenda.fieldbyname('codcliente').asInteger;
             qrexec_base.Params.ParamByName('CLIENTE').AsString := modulo_pedidovenda.qrpedidovenda.fieldbyname('cliente').asString;



             if cbxformapre.Caption <> '' then
                begin

                  qrexec_base.Params.ParamByName('CODESPECIE').AsInteger := modulo_parcelapredefinida.qrParcelaPredefinida.FieldByName('codespecieaprazo').AsInteger;
                  qrexec_base.Params.ParamByName('ESPECIE').AsString  :=  modulo_parcelapredefinida.qrParcelaPredefinida.FieldByName('especieaprazo').AsString;

                end
             else
                begin

                  qrconsulta_base.Close;
                  qrconsulta_base.SQL.Clear;
                  qrconsulta_base.SQL.Add('select * from tespecie where controle = :controle');
                  qrconsulta_base.Params.ParamByName('controle').AsInteger:= modulo_master_indice.qrmaster_indice.FieldByName('CPAGAMENTOAPRAZOPADRAO').AsInteger;
                  qrconsulta_base.Open;

                  qrexec_base.Params.ParamByName('CODESPECIE').AsInteger := qrconsulta_base.FieldByName('controle').AsInteger;
                  qrexec_base.Params.ParamByName('ESPECIE').AsString  :=  qrconsulta_base.FieldByName('especie').AsString;


                end;
             //endi


             qrconsulta_base.Close;
             qrconsulta_base.SQL.Clear;
             qrconsulta_base.SQL.Add('select * from tplanoconta where controle = :controle');
             qrconsulta_base.Params.ParamByName('controle').AsInteger:= modulo_master_indice.qrmaster_indice.FieldByName('CPLANOCONTAAPRAZOPADRAO').AsInteger;
             qrconsulta_base.Open;

             qrexec_base.Params.ParamByName('CODPLANOCONTA').AsInteger :=  qrconsulta_base.FieldByName('controle').AsInteger;
             qrexec_base.Params.ParamByName('PLANOCONTA').AsString     :=  qrconsulta_base.FieldByName('planoconta').AsString;



             qrconsulta_base.Close;
             qrconsulta_base.SQL.Clear;
             qrconsulta_base.SQL.Add('select * from tcentrocusto where controle = :controle');
             qrconsulta_base.Params.ParamByName('controle').AsInteger:= modulo_master_indice.qrmaster_indice.FieldByName('CCENTROCUSTOPADRAO').AsInteger;
             qrconsulta_base.Open;

             qrexec_base.Params.ParamByName('CODCENTROCUSTO').AsInteger :=  qrconsulta_base.FieldByName('controle').AsInteger;
             qrexec_base.Params.ParamByName('CENTROCUSTO').AsString     :=  qrconsulta_base.FieldByName('centrocusto').AsString;


             qrexec_base.Params.ParamByName('CODFUNCIONARIO').AsInteger := modulo_pedidovenda.qrpedidovenda.FieldByName('codfuncionario').AsInteger;
             qrexec_base.Params.ParamByName('FUNCIONARIO').AsString := modulo_pedidovenda.qrpedidovenda.FieldByName('funcionario').AsString;
             qrexec_base.Params.ParamByName('CODVENDEDOR').AsInteger := modulo_pedidovenda.qrpedidovenda.FieldByName('codvendedor').AsInteger;
             qrexec_base.Params.ParamByName('VENDEDOR').AsString  := modulo_pedidovenda.qrpedidovenda.FieldByName('vendedor').AsString;

             qrexec_base.Params.ParamByName('DATAHORACADASTRO').AsDatetime := now();
             qrexec_base.Params.ParamByName('DATAVENCIMENTO').AsDate :=  date()+iIntervalo;
             qrexec_base.Params.ParamByName('DOCUMENTO').AsString := 'DAV nº '+modulo_pedidovenda.qrpedidovenda.FieldByName('controlevarchar').AsString;
             qrexec_base.Params.ParamByName('ORIGEM').AsString := 'PEDIDO DE VENDA';
             qrexec_base.Params.ParamByName('VALORORIGINAL').Asfloat := fparcelas;
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


     with modulo_conexaodb do
        begin

          qrconsulta_base.Close;
          qrconsulta_base.SQL.Clear;

          //qrconsulta_base.SQL.Add('select codigo, codpedidovenda from tmaster_receber where codigo = (select max(codigo) from tmaster_receber) and codpedidovenda = :codpedidovenda');

          qrconsulta_base.SQL.Add('select max(codigo) as ultimocodigo, codpedidovenda from tmaster_receber group by codpedidovenda having codpedidovenda = :codpedidovenda');
          qrconsulta_base.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
          qrconsulta_base.Open;

          ultimocodigo := qrconsulta_base.FieldByName('ultimocodigo').AsInteger;

          //showmessage(inttostr(ultimocodigo));

          qrconsulta_base.Close;
          qrconsulta_base.SQL.Clear;
          qrconsulta_base.SQL.Add('select codpedidovenda, sum(valororiginal) as total from tmaster_receber   group by codpedidovenda having codpedidovenda = :codpedidovenda');
          qrconsulta_base.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
          qrconsulta_base.Open;

          ftotalapurado := qrconsulta_base.FieldByName('total').AsFloat;

          fdiferenca :=  ftotalapagar - (ftotalapurado + ftotalavista);

          qrexec_base.Close;
          qrexec_base.SQL.Clear;
          qrexec_base.SQL.Add('update tmaster_receber set valororiginal = valororiginal + :diferenca where codigo = :codigo');
          qrexec_base.Params.ParamByName('diferenca').AsFloat:=fdiferenca;
          qrexec_base.Params.ParamByName('codigo').AsInteger:=ultimocodigo;
          qrexec_base.ExecSQL;

          atualizaBanco;


        end;
     //endi

     //showmessage(floattostr(fdiferenca));

     modulo_receber.qrMasterReceber.Refresh;


end;

procedure Tfrmfechapedidovenda.cbxformapreChange(Sender: TObject);
begin
 //modulo_parcelapredefinida.qrparcelapredefinida.
 if cbxformapre.Text <> '' then
    begin

      //frmfechapedidovenda.edtnparc.Value :=  modulo_parcelapredefinida.qrparcelapredefinida.FieldByName('qtdeparcela').AsInteger;
      //edtnparc.Enabled:=false;

    end
 else
    begin

      //frmfechapedidovenda.edtnparc.Value :=  0;
      //edtnparc.Enabled:=true;

    end;
 //endif



end;

procedure Tfrmfechapedidovenda.cbxformapreExit(Sender: TObject);
begin
   if cbxformapre.Text <> '' then
    begin

      edtnparc.Value :=  modulo_parcelapredefinida.qrparcelapredefinida.FieldByName('qtdeparcela').AsInteger;
      edtnparc.Enabled:=false;
      btnlancarparcela.Enabled:=false;
      btnlancarparcela.Click;

    end
 else
    begin

      edtnparc.Value :=  0;
      edtnparc.Enabled:=true;
      btnlancarparcela.Enabled:=true;

    end;
 //endif

end;

procedure Tfrmfechapedidovenda.dbgparcelaKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
     begin


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

procedure Tfrmfechapedidovenda.edtvlravistaExit(Sender: TObject);
var
  fvlravista,fvlrpagar:real;


begin

  fvlravista := strtofloat(edtvlravista.Text);
  fvlrpagar :=  strtofloat(edtvlrpagar.Text);


  if fvlravista >= fvlrpagar then
     begin

       ftroco := fvlravista-fvlrpagar;
       edtnparc.Enabled:= false;
       btnlancarparcela.Enabled:=false;
       btnalterarfin.Enabled:=false;
       cbxformapre.Enabled:=false;
       dbgparcela.Enabled:=false;
       btnlancarparcela.Enabled:=false;

       excluirparcelas;


       modulo_parcelapredefinida.qrtempParcelaPredefinida.FieldByName('cparcpre').AsInteger:=0;

       edtnparc.Value:=0;



     end
  else
     begin


       ftroco:=0;

       btnlancarparcela.Enabled:=true;
       btnalterarfin.Enabled:=true;
       cbxformapre.Enabled:=true;
       dbgparcela.Enabled:=true;

       if cbxformapre.Text = '' then
          begin
            edtnparc.Enabled:= true;
            btnlancarparcela.Enabled:=true;
          end
       else
          begin
            btnlancarparcela.Click;
          end;
       //endi

       //edtnparc.SetFocus;


     end;
  //endi
end;

procedure Tfrmfechapedidovenda.edtvlrdescontoExit(Sender: TObject);
begin

  fpercdesconto  := edtvlrdesconto.value / strtofloat(tirapontos(lbltotal.Caption)) * 100;

  edtpercdesconto.Value:=  fpercdesconto;


  edtvlrpagar.Value:= strtofloat(tirapontos(lbltotal.Caption))-edtvlrdesconto.value;


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

  edtvlrdesconto.Value:=strtofloat(tirapontos(lbltotal.Caption)) - strtofloat(tirapontos(edtvlrpagar.Text));


   fpercdesconto := strtofloat(tirapontos(edtvlrdesconto.text)) / strtofloat(tirapontos(lbltotal.Caption)) * 100;


   edtpercdesconto.Value:= fpercdesconto;

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

  fpercdesconto := 0.01;

  icodigo_controle := modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;


  lblpeddav.Caption :=  formatfloat('00000',modulo_pedidovenda.qrpedidovenda.FieldByName('controle').asfloat)+'/'+formatfloat('00000',modulo_pedidovenda.qrpedidovenda.FieldByName('controlevarchar').asfloat);
  lblnomecli.Caption:=  modulo_pedidovenda.qrpedidovenda.FieldByName('cliente').asString;
  lbltotal.Caption:=    formatfloat('###,###,##0.00',modulo_pedidovenda.qrpedidovenda.FieldByName('totalprodutos').asfloat);


  with modulo_pedidovenda do
     begin

       qrmaster_pedidovenda.Close;
       qrmaster_pedidovenda.SQL.Clear;
       qrmaster_pedidovenda.SQL.Add('select * from tmaster_pedidovenda where controle_tpedidovenda = :controle_tpedidovenda');
       qrmaster_pedidovenda.ParamByName('controle_tpedidovenda').AsInteger:=icodigo_controle;
       qrmaster_pedidovenda.Open;

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

  if  modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('statuspedido').AsString  = 'F' then
     begin

       edtvlrpagar.Value:=   modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrpagar').asfloat;
       edtpercdesconto.Value:=   modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('percdesconto').asfloat;
       edtvlrdesconto.Value:=   modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrdesconto').asfloat;
       edtvlravista.Value:=   modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrrecebido').asfloat - modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrtroco').asfloat;
       ftroco:= modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrtroco').asfloat;

       modulo_parcelapredefinida.qrtempParcelaPredefinida.FieldByName('cparcpre').AsInteger:= modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('cparc_pred').asInteger;

       btnlancar.Caption:='Imprimir';

       ckbimprimir.Checked:=true;

       ckbimprimir.Visible:=false;

       pnlsuperior.Enabled:=false;

       pnlcentral.Enabled:=false;

       btnestornar.Enabled:= true;

     end
  else
     begin

       modulo_parcelapredefinida.qrtempParcelaPredefinida.FieldByName('cparcpre').AsInteger:=0;

       edtnparc.Value:=0;

       edtvlrpagar.Value:=    modulo_pedidovenda.qrpedidovenda.FieldByName('totalprodutos').asfloat;

       btnestornar.Enabled:= false;

       excluirparcelas;

     end;
  //endi

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


  with modulo_parcelapredefinida do
     begin

       qrParcelaPredefinida.Close;
       qrParcelaPredefinida.SQL.Clear;
       qrParcelaPredefinida.SQL.Add('select * from tParcelaPredefinida');
       qrParcelaPredefinida.Open;

     end;
  //endth


  cbxformapre.ListSource := modulo_parcelapredefinida.dsParcelaPredefinida;
  cbxformapre.ListField:='descricao';
  cbxformapre.KeyField:='controle';
  cbxformapre.DataSource:=modulo_parcelapredefinida.dstempParcelaPredefinida;
  cbxformapre.DataField:='cparcpre';
  cbxformapre.ScrollListDataset:=true;
  cbxformapre.Style:=csDropDownList;




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


procedure tfrmfechapedidovenda.excluirparcelas;
begin

  with modulo_conexaodb do
     begin

       qrexec_base.Close;
       qrexec_base.SQL.Clear;
       qrexec_base.SQL.Add('delete from tmaster_receber where codpedidovenda = :codpedidovenda');
       qrexec_base.Params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
       qrexec_base.ExecSQL;

       atualizaBanco;

     end;
  //endth

  modulo_receber.qrMasterReceber.Refresh;


end;

end.

