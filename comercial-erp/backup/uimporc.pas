unit uimporc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport,
  RLPDFFilter, RLPreviewForm;

type

  { Tfrmimporc }

  Tfrmimporc = class(TForm)
    lblnome: TRLLabel;
    lblendereco: TRLLabel;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLImage1: TRLImage;
    rlimporc: TRLReport;
    RLLabel1: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    rlfilter: TRLPDFFilter;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    lblcnpjie: TRLLabel;
    rlpreview: TRLPreviewSetup;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    procedure FormCreate(Sender: TObject);
    procedure RLBand1AfterPrint(Sender: TObject);
    procedure RLLabel3AfterPrint(Sender: TObject);
    procedure RLLabel4AfterPrint(Sender: TObject);
    procedure RLLabel7AfterPrint(Sender: TObject);
  private

  public

  end;

var
  frmimporc: Tfrmimporc;

implementation
       uses umodulo_orcamento;

{$R *.lfm}

       { Tfrmimporc }

       procedure Tfrmimporc.FormCreate(Sender: TObject);
       begin

           with modulo_orcamento do
    begin

      qrorcamento_itemproduto.Close;
      qrorcamento_itemproduto.SQL.Clear;
      qrorcamento_itemproduto.SQL.Add('select * from TITENSORCAMENTO where codorcamento = :codorcamento order by coditem');
      qrorcamento_itemproduto.ParamByName('codorcamento').AsInteger:=qrorcamento.FieldByName('controle').AsInteger;
      qrorcamento_itemproduto.Open;

    end;





       end;

procedure Tfrmimporc.RLBand1AfterPrint(Sender: TObject);
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

end.

