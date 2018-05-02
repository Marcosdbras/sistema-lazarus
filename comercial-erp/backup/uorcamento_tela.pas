unit uorcamento_tela;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DbCtrls, DBGrids, ComCtrls, ZDataset, db, Types;

type

  { Tfrmorcamento_tela }

  Tfrmorcamento_tela = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBText2Click(Sender: TObject);
    procedure dsorcamentoDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private

  public

  end;

var
  frmorcamento_tela: Tfrmorcamento_tela;

implementation
     uses ufuncao_geral,  umodulo_orcamento;
{$R *.lfm}

{ Tfrmorcamento_tela }

procedure Tfrmorcamento_tela.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_tela.FormCreate(Sender: TObject);
begin









end;

procedure Tfrmorcamento_tela.btnfiltrarClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_tela.btnlimparClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_tela.Button2Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmorcamento_tela.Button5Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_tela.DBText2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_tela.dsorcamentoDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure Tfrmorcamento_tela.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_tela.limpar;
begin

end;

procedure Tfrmorcamento_tela.TabSheet1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure Tfrmorcamento_tela.filtrar;

begin


end;

end.

