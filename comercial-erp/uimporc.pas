unit uimporc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport,
  RLPDFFilter, RLPreviewForm;

type

  { Tfrmimporc }

  Tfrmimporc = class(TForm)
    lblbairroemi: TRLLabel;
    lblcepemi: TRLLabel;
    lblcidadeemi: TRLLabel;
    lbldav: TRLLabel;
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
    lbliecli: TRLLabel;
    lblie: TRLLabel;
    lblcnpjcli: TRLLabel;
    lblcepcli: TRLLabel;
    lbliecli1: TRLLabel;
    lblnomecli1: TRLLabel;
    lblnomeemi: TRLLabel;
    lblnomeemi1: TRLLabel;
    lblnorc: TRLLabel;
    lblnorc1: TRLLabel;
    lblnorc2: TRLLabel;
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
    lbltelefoneemi: TRLLabel;
    lbltitulo: TRLLabel;
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
    RLDraw2: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw9: TRLDraw;
    RLImage1: TRLImage;
    rlimporc: TRLReport;
    RLLabel1: TRLLabel;
    lbltittotal: TRLLabel;
    lbltotal: TRLLabel;
    RLLabel10: TRLLabel;
    lblncm: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    rlfilter: TRLPDFFilter;
    RLLabel7: TRLLabel;
    lblcnpj: TRLLabel;
    RLLabel9: TRLLabel;
    memocodgeral: TRLMemo;
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
  frmimporc: Tfrmimporc;

implementation
       uses umodulo_orcamento, umodulo_geral, umodulo_conexaodb, umodulo_cliente;

{$R *.lfm}

       { Tfrmimporc }

       procedure Tfrmimporc.FormCreate(Sender: TObject);

       //var cnpjcli,iecli, cpfcli, rgcli:string;

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
          qrcliente.Params.ParamByName('codcli').AsInteger:=modulo_orcamento.qrorcamento.FieldByName('codcliente').AsInteger;
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
          qrconsulta_base.SQL.Add('select sum(qtde*valorunitario) as total from TITENSORCAMENTO  where codorcamento = :codorcamento   group by codorcamento');  //coditem
          qrconsulta_base.params.ParamByName('codorcamento').AsInteger:=modulo_orcamento.qrorcamento.FieldByName('controle').AsInteger;
          qrconsulta_base.Open;

          lbltotal.Caption:='R$ '+formatfloat('0.00',qrconsulta_base.FieldByName('total').AsFloat);





        end;


       with modulo_orcamento do
       begin

         //lblnorc.Caption := qrorcamento.FieldByName('controlevarchar').asString;

         lblnorc.Caption:=  formatfloat('00000',qrorcamento.FieldByName('controle').asfloat);
         lbldav.Caption := formatfloat('00000',qrorcamento.FieldByName('controlevarchar').asfloat);


         qrorcamento_itemproduto.Close;
         qrorcamento_itemproduto.SQL.Clear;
         qrorcamento_itemproduto.SQL.Add('select * from TITENSORCAMENTO where codorcamento = :codorcamento order by coditem');
         qrorcamento_itemproduto.ParamByName('codorcamento').AsInteger:=qrorcamento.FieldByName('controle').AsInteger;
         qrorcamento_itemproduto.Open;


         memocodgeral.Lines.Clear;
         memocodgeral.Lines.Add(qrorcamento.FieldByName('condicaopagamento').AsString);

       end;




       end;

procedure Tfrmimporc.RLBand1AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimporc.RLBand2AfterPrint(Sender: TObject);
begin



end;

procedure Tfrmimporc.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
    lblncm.Caption:='';

  with modulo_conexaodb do
  begin

    //Localiza ncm
    qrconsulta_base.Close;
    qrconsulta_base.sql.Clear;
    qrconsulta_base.SQL.Add('select * from testoque where controle = :codproduto');
    qrconsulta_base.Params.ParamByName('codproduto').AsInteger:= modulo_orcamento.qrorcamento_itemproduto.FieldByName('codproduto').AsInteger;
    qrconsulta_base.Open;

    if qrconsulta_base.RecordCount > 0 then
       begin
         lblncm.Caption:=qrconsulta_base.FieldByName('ncm').AsString;
       end;
    //endif


  end;

end;

procedure Tfrmimporc.RLImage1AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimporc.RLLabel3AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimporc.RLLabel4AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimporc.RLLabel7AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimporc.RLSystemInfo1AfterPrint(Sender: TObject);
begin

end;

end.

