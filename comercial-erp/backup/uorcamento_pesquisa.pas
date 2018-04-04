unit uorcamento_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DbCtrls, DBGrids;

type

  { Tfrmorcamentos }

  Tfrmorcamentos = class(TForm)
    btnfiltrar: TButton;
    btnlimpar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    edtdatainicio: TDateEdit;
    edtdatafim: TDateEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
  private

  public

  end;

var
  frmorcamentos: Tfrmorcamentos;

implementation
     uses ufuncao_geral,  umodulo_orcamento;
{$R *.lfm}

{ Tfrmorcamentos }

procedure Tfrmorcamentos.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamentos.FormCreate(Sender: TObject);
begin

  edtdatainicio.Date:= date;
  edtdatafim.Date:=date;

  with modulo_orcamento do
    begin



      qrorcamento.Active:= false;
      qrorcamento.SQL.Clear;
      qrorcamento.SQL.Add('select * from torcamento');
      qrorcamento.Active:=true;
    end;




end;

procedure Tfrmorcamentos.pnlinferiorClick(Sender: TObject);
begin

end;

end.

