unit uimpcaixa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ZStoredProcedure, RLReport, RLPDFFilter, RLPreviewForm;

type

  { Tfrmimpcaixa }

  Tfrmimpcaixa = class(TForm)
    lblbairroemi: TRLLabel;
    lblcepemi: TRLLabel;
    lblcidadeemi: TRLLabel;
    lblcnpj2: TRLLabel;
    lblcnpj3: TRLLabel;
    lblmovimentocaixa: TRLLabel;
    lblemailemi: TRLLabel;
    lblenderecoemi: TRLLabel;
    lblcnpj1: TRLLabel;
    lblestadoemi: TRLLabel;
    lblie1: TRLLabel;
    lblie: TRLLabel;
    lbldinheiro: TRLLabel;
    lblnomeemi: TRLLabel;
    lblnomeemi1: TRLLabel;
    lblsiteemi: TRLLabel;
    lblslogan: TRLLabel;
    lbltelefoneemi: TRLLabel;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand4: TRLBand;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw9: TRLDraw;
    RLImage1: TRLImage;
    rlimporc: TRLReport;
    lblespecie: TRLLabel;
    RLLabel10: TRLLabel;
    rlfilter: TRLPDFFilter;
    lbltotal: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    lblcnpj: TRLLabel;
    rlpreview: TRLPreviewSetup;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    procedure FormCreate(Sender: TObject);
    procedure RLBand1AfterPrint(Sender: TObject);
    procedure RLBand2AfterPrint(Sender: TObject);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLImage1AfterPrint(Sender: TObject);
    procedure RLLabel3AfterPrint(Sender: TObject);
    procedure RLLabel4AfterPrint(Sender: TObject);
    procedure RLLabel7AfterPrint(Sender: TObject);
    procedure RLSubDetail1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLSystemInfo1AfterPrint(Sender: TObject);
  private

  public
     datai, dataf:string;

  end;

var
  frmimpcaixa: Tfrmimpcaixa;

implementation
       uses umodulo_orcamento, umodulo_geral, umodulo_conexaodb, umodulo_cliente, umodulo_consulta, ucaixa_impressao, umodulo_especie;

{$R *.lfm}

       { Tfrmimpcaixa }

       procedure Tfrmimpcaixa.FormCreate(Sender: TObject);

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


        with modulo_conexaodb do
        begin


          //Localiza emitente
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

        end;




       lbldinheiro.Caption:= formatfloat('###,##0.00',  modulo_consulta.qrcaixatdinheiro.FieldByName('tdinheiro').AsFloat);



       end;

procedure Tfrmimpcaixa.RLBand1AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimpcaixa.RLBand2AfterPrint(Sender: TObject);
begin



end;

procedure Tfrmimpcaixa.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin


    lblespecie.Caption:=modulo_especie.qrEspecie.FieldByName('especie').AsString;

    if modulo_consulta.qrtotalporespecie.Locate('controle',modulo_especie.qrEspecie.FieldByName('controle').AsInteger,[])then
       begin
         lbltotal.Caption:=formatfloat('###,###,##0.00',modulo_consulta.qrtotalporespecie.FieldByName('totaltipopgto').Asfloat);
       end
    else
       begin
         lbltotal.Caption:='0,00';
       end;
    //endif



end;

procedure Tfrmimpcaixa.RLImage1AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimpcaixa.RLLabel3AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimpcaixa.RLLabel4AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimpcaixa.RLLabel7AfterPrint(Sender: TObject);
begin

end;

procedure Tfrmimpcaixa.RLSubDetail1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

end;

procedure Tfrmimpcaixa.RLSystemInfo1AfterPrint(Sender: TObject);
begin

end;

end.

