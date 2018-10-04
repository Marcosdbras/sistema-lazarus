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
  private

  public

  end;

var
  frmimporc: Tfrmimporc;

implementation
       uses umodulo_orcamento;

{$R *.lfm}

end.

