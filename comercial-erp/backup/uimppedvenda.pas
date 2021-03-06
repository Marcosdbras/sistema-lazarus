unit uimppedvenda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport,
  RLPDFFilter, RLPreviewForm;

type

  { Tfrmimppedvenda }

  Tfrmimppedvenda = class(TForm)
    lblbairroemi: TRLLabel;
    lblcepemi: TRLLabel;
    lblcidadeemi: TRLLabel;
    lblemailemi: TRLLabel;
    lblenderecoemi: TRLLabel;
    lblestadocli: TRLLabel;
    lblcepemi2: TRLLabel;
    lblemailcli: TRLLabel;
    lblenderecocli2: TRLLabel;
    lblbairrocli: TRLLabel;
    lblcnpj1: TRLLabel;
    lblcnpjcli1: TRLLabel;
    lblenderecocli1: TRLLabel;
    lblestadoemi: TRLLabel;
    lblie1: TRLLabel;
    lbldatafec: TRLLabel;
    lbliecli: TRLLabel;
    lblie: TRLLabel;
    lblcnpjcli: TRLLabel;
    lblcepcli: TRLLabel;
    lbliecli1: TRLLabel;
    lblnomecli1: TRLLabel;
    lblnomeemi: TRLLabel;
    lblnomeemi1: TRLLabel;
    lblnorc2: TRLLabel;
    lbldav: TRLLabel;
    lblsiteemi: TRLLabel;
    lblslogan: TRLLabel;
    lbltelefonecli1: TRLLabel;
    lbltelefonecli2: TRLLabel;
    lblcidadecli: TRLLabel;
    lbltelefonecli3: TRLLabel;
    lbltelefonecli4: TRLLabel;
    lbltelefonecli: TRLLabel;
    lblnomecli: TRLLabel;
    lblenderecocli: TRLLabel;
    lblnped: TRLLabel;
    lblnorc1: TRLLabel;
    lbltelefoneemi: TRLLabel;
    memo2: TRLMemo;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw10: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw9: TRLDraw;
    RLImage1: TRLImage;
    rlimppedvenda: TRLReport;
    RLLabel1: TRLLabel;
    lbltittotal: TRLLabel;
    lbltotal: TRLLabel;
    RLLabel10: TRLLabel;
    lblncm: TRLLabel;
    RLLabel11: TRLLabel;
    lbltitulo: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    rlfilter: TRLPDFFilter;
    RLLabel7: TRLLabel;
    lblcnpj: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    memoobs: TRLMemo;
    memo1: TRLMemo;
    rlpreview: TRLPreviewSetup;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    procedure FormCreate(Sender: TObject);
    procedure RLBand1AfterPrint(Sender: TObject);
    procedure RLBand2AfterPrint(Sender: TObject);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLImage1AfterPrint(Sender: TObject);
    procedure RLLabel3AfterPrint(Sender: TObject);
    procedure RLLabel4AfterPrint(Sender: TObject);
    procedure RLLabel7AfterPrint(Sender: TObject);
    procedure RLSystemInfo1AfterPrint(Sender: TObject);
  private

  public

  end;

var
  frmimppedvenda: Tfrmimppedvenda;

implementation
       uses umodulo_pedidovenda, umodulo_geral, umodulo_conexaodb, umodulo_cliente, umodulo_receber;

{$R *.lfm}

       { Tfrmimppedvenda }

       procedure Tfrmimppedvenda.FormCreate(Sender: TObject);

       //var cnpjcli,iecli, cpfcli, rgcli:string;
       var sreceber:string;
       begin


        with modulo_geral do
        begin

          qrmaster_indice.Close;
          qrmaster_indice.SQL.Clear;
          qrmaster_indice.SQL.Add('select * from tmaster_indice');
          qrmaster_indice.Open;

          if qrmaster_indice.FieldByName('logotipo').AsString <> '' then
             rlimage1.Picture.LoadFromFile(qrmaster_indice.FieldByName('logotipo').AsString);
          //endi
          lblslogan.caption := qrmaster_indice.FieldByName('slogan').AsString;

        end;


        with modulo_cliente do
        begin

          qrcliente.Close;
          qrcliente.SQL.Clear;
          qrcliente.SQL.Add('select * from tcliente where controle = :codcli');
          qrcliente.Params.ParamByName('codcli').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('codcliente').AsInteger;
          qrcliente.Open;

          if qrcliente.FieldByName('cnpj').AsString <> '' then
             begin
               lblcnpjcli.Caption:=qrcliente.FieldByName('cnpj').AsString;
               lbliecli.Caption:=qrcliente.FieldByName('ie').AsString;
             end
          else if qrcliente.FieldByName('cpf').AsString <> '' then
             begin
               lblcnpjcli.Caption := qrcliente.FieldByName('cpf').AsString;
               lbliecli.Caption := qrcliente.FieldByName('rg').AsString;
             end
          else
             begin
               lblcnpjcli.Caption := '';
               lbliecli.Caption := '';
             end;
          //endi

          lblnomecli.Caption:= qrcliente.FieldByName('cliente').AsString;
          lblenderecocli.Caption:=qrcliente.FieldByName('endereco').AsString+' N.o '+qrcliente.FieldByName('numero').AsString;
          lblbairrocli.Caption:=qrcliente.FieldByName('bairro').AsString;
          lblcidadecli.Caption:= qrcliente.FieldByName('cidade').AsString;
          lblestadocli.Caption:=qrcliente.FieldByName('uf').AsString;
          lblcepcli.Caption:= qrcliente.FieldByName('cep').AsString;




        end;


        with modulo_conexaodb do
        begin


          //Localiza cliente
          qrconsulta_base.Close;
          qrconsulta_base.sql.Clear;
          qrconsulta_base.SQL.Add('select * from temitente');
          qrconsulta_base.Open;

          if qrconsulta_base.FieldByName('cnpj').AsString <> '' then
             begin
               lblcnpj.Caption:= qrconsulta_base.FieldByName('cnpj').AsString;
               lblie.Caption :=  qrconsulta_base.FieldByName('ie').AsString;
             end
          else if qrconsulta_base.FieldByName('cpf').AsString <> '' then
             begin
               lblcnpj.Caption:= qrconsulta_base.FieldByName('cpf').AsString;
               lblie.Caption := '';
             end
          else
             begin
               lblcnpj.Caption:= '';
               lblie.Caption := '';
             end;
          //endi

          lblnomeemi.Caption:= qrconsulta_base.FieldByName('razaosocial').AsString;
          lbltitulo.Caption:= qrconsulta_base.FieldByName('nomefantasia').AsString;
          lbltelefoneemi.Caption:=qrconsulta_base.FieldByName('telefone').AsString;
          lblenderecoemi.Caption:=qrconsulta_base.FieldByName('endereco').AsString+
                                  ' N.o: '+qrconsulta_base.FieldByName('numero').AsString;

          lblbairroemi.Caption := qrconsulta_base.FieldByName('bairro').AsString;
          lblcidadeemi.Caption := qrconsulta_base.FieldByName('cidade').AsString;
          lblestadoemi.Caption := qrconsulta_base.FieldByName('uf').AsString;
          lblcepemi.Caption    := qrconsulta_base.FieldByName('cep').AsString;
          lbltelefoneemi.Caption:= qrconsulta_base.FieldByName('telefone').AsString;
          lblemailemi.Caption:=qrconsulta_base.FieldByName('email').AsString;
          lblsiteemi.Caption :=  qrconsulta_base.FieldByName('site').AsString;

          //Totaliza pedido
          qrconsulta_base.Close;
          qrconsulta_base.SQL.Clear;
          qrconsulta_base.SQL.Add('select sum(qtde*valorunitario) as total from titempedidovenda  where codpedidovenda = :codpedidovenda   group by codpedidovenda');  //coditem
          qrconsulta_base.params.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
          qrconsulta_base.Open;

          lbltotal.Caption:='R$ '+formatfloat('0.00',qrconsulta_base.FieldByName('total').AsFloat);

        end;


       with modulo_pedidovenda do
       begin

         //lblnped.Caption := qrpedidovenda.FieldByName('controlevarchar').asString;


         lblnped.Caption:=  formatfloat('00000',qrpedidovenda.FieldByName('controle').asfloat);
         lbldav.Caption:=formatfloat('00000',qrpedidovenda.FieldByName('controlevarchar').asfloat);

         qrpedidovenda_itemproduto.Close;
         qrpedidovenda_itemproduto.SQL.Clear;
         qrpedidovenda_itemproduto.SQL.Add('select * from titempedidovenda where codpedidovenda = :codpedidovenda order by coditem');
         qrpedidovenda_itemproduto.ParamByName('codpedidovenda').AsInteger:=qrpedidovenda.FieldByName('controle').AsInteger;
         qrpedidovenda_itemproduto.Open;


         memoobs.Lines.Clear;
         memoobs.Lines.Add('- Observação: '+qrpedidovenda.FieldByName('observacao').AsString);


       end;

       with modulo_pedidovenda do
          begin

             qrmaster_pedidovenda.Close;
             qrmaster_pedidovenda.SQL.Clear;
             qrmaster_pedidovenda.SQL.Add('select * from tmaster_pedidovenda where controle_tpedidovenda = :controle_tpedidovenda');
             qrmaster_pedidovenda.Params.ParamByName('controle_tpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;
             qrmaster_pedidovenda.Open;

          end;
       //endif


       if modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('datafec').AsString <> '' then
          begin
             lbldatafec.Caption := modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('datafec').AsString;
          end
       else
          begin
            lbldatafec.Caption := 'EM ABERTO';
          end;
       //endif





       memo1.Lines.Clear;
       memo2.Lines.Clear;





       if modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('percdesconto').AsFloat > 0 then
          begin
            memo2.Lines.Add('Desconto: ');
            memo1.Lines.Add(formatfloat('0.00',modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('percdesconto').AsFloat)+'%   R$ '+formatfloat('###,###,##0.00', modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrdesconto').AsFloat));
          end;
       //endif

       if modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrpagar').AsFloat > 0 then
          begin
            memo2.Lines.Add('Valor Pago:    R$');
            memo1.Lines.Add(formatfloat('###,##0.00',modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrpagar').AsFloat));
          end;
       //endif

       sreceber := '';
       if modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrrecebido').AsFloat > 0 then
          begin
            sreceber := '(À VISTA: R$'+ formatfloat('###,###,##0.00',  modulo_pedidovenda.qrmaster_pedidovenda.FieldByName('vlrrecebido').Asfloat)+ ') ';
          end;
       //endif

       with modulo_receber do
          begin

             qrMasterReceber.Close;
             qrMasterReceber.SQL.Clear;
             qrMasterReceber.SQL.Add('select * from tmaster_receber where codpedidovenda = :codpedidovenda');
             qrMasterReceber.ParamByName('codpedidovenda').AsInteger:=modulo_pedidovenda.qrpedidovenda.FieldByName('controle').AsInteger;;
             qrMasterReceber.Open;

             if qrMasterReceber.RecordCount > 0 then
                begin


                  while not qrMasterReceber.EOF do
                     begin

                        sreceber := sreceber +'('+  qrMasterReceber.FieldByName('especie').AsString+'  '+qrMasterReceber.FieldByName('datavencimento').AsString+' R$ '+formatfloat('###,###,##0.00',qrMasterReceber.FieldByName('valororiginal').Asfloat)+') ';

                        qrMasterReceber.Next;
                     end;
                  //endw




                end;
             //endi


          end;
       //endth


       memoobs.Lines.Add('- Forma de Pagamento: '+sreceber);



       end;

procedure Tfrmimppedvenda.RLBand1AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimppedvenda.RLBand2AfterPrint(Sender: TObject);
begin



end;

procedure Tfrmimppedvenda.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
    lblncm.Caption:='';

  with modulo_conexaodb do
  begin

    //Localiza ncm
    qrconsulta_base.Close;
    qrconsulta_base.sql.Clear;
    qrconsulta_base.SQL.Add('select * from testoque where controle = :codproduto');
    qrconsulta_base.Params.ParamByName('codproduto').AsInteger:= modulo_pedidovenda.qrpedidovenda_itemproduto.FieldByName('codproduto').AsInteger;
    qrconsulta_base.Open;

    if qrconsulta_base.RecordCount > 0 then
       begin
         lblncm.Caption:=qrconsulta_base.FieldByName('ncm').AsString;
       end;
    //endif


  end;

end;

procedure Tfrmimppedvenda.RLImage1AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimppedvenda.RLLabel3AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimppedvenda.RLLabel4AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimppedvenda.RLLabel7AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimppedvenda.RLSystemInfo1AfterPrint(Sender: TObject);
begin

end;

end.

