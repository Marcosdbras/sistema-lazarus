unit uorcamento_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn, DbCtrls, DBGrids, ZDataset, db;

type

  { Tfrmorcamento_pesquisa }

  Tfrmorcamento_pesquisa = class(TForm)
    btnfiltrar: TButton;
    btnlimpar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBGrid1: TDBGrid;
    DBText1: TDBText;
    edtdatainicio: TDateEdit;
    edtdatafim: TDateEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    procedure btnfiltrarClick(Sender: TObject);
    procedure btnlimparClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBText2Click(Sender: TObject);
    procedure dsorcamentoDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure pnlinferiorClick(Sender: TObject);
    procedure filtrar;
    procedure limpar;
  private

  public
      opcao:string;
  end;

var
  frmorcamento_pesquisa: Tfrmorcamento_pesquisa;

implementation
     uses ufuncao_geral,  umodulo_orcamento, uorcamento_cadastro;
{$R *.lfm}

{ Tfrmorcamento_pesquisa }

procedure Tfrmorcamento_pesquisa.Label1Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.FormCreate(Sender: TObject);
begin


  limpar;

  filtrar;






end;

procedure Tfrmorcamento_pesquisa.btnfiltrarClick(Sender: TObject);
begin
  filtrar;
end;

procedure Tfrmorcamento_pesquisa.btnlimparClick(Sender: TObject);
begin
  limpar;
end;

procedure Tfrmorcamento_pesquisa.Button1Click(Sender: TObject);
begin
  opcao := 'I';

  frmorcamento_cadastro := tfrmorcamento_cadastro.Create(self);
  frmorcamento_cadastro.ShowModal;
  frmorcamento_cadastro.Free;


end;

procedure Tfrmorcamento_pesquisa.Button5Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmorcamento_pesquisa.DBText2Click(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.dsorcamentoDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure Tfrmorcamento_pesquisa.pnlinferiorClick(Sender: TObject);
begin

end;

procedure Tfrmorcamento_pesquisa.limpar;
begin
  edtdatainicio.Date:= date;
  edtdatafim.Date:=date;

  filtrar;
end;

procedure Tfrmorcamento_pesquisa.filtrar;
var sdti,sdtf:string;

begin
  sdti := formatdatetime('dd.mm.yyyy', edtdatainicio.date);
  sdtf := formatdatetime('dd.mm.yyyy',edtdatafim.Date);

   with modulo_orcamento do
    begin

      qrorcamento.Active:= false;
      qrorcamento.SQL.Clear;
      qrorcamento.SQL.Add('select * from torcamento where data >= :dti and data <= :dtf');
      qrorcamento.ParamByName('dti').AsDate:= edtdatainicio.date;
      qrorcamento.ParamByName('dtf').AsDate:= edtdatafim.Date;
      qrorcamento.Active:=true;

    end;


end;

end.

