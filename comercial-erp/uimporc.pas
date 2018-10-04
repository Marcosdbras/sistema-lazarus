unit uimporc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, RLReport,
  RLPDFFilter, RLPreviewForm;

type

  { Tfrmimporc }

  Tfrmimporc = class(TForm)
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    rlimporc: TRLReport;
    RLPDFFilter1: TRLPDFFilter;
    RLPreviewSetup1: TRLPreviewSetup;
    procedure FormCreate(Sender: TObject);
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

end.

