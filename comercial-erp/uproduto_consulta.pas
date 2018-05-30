unit uproduto_consulta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids;

type

  { Tfrmproduto_consulta }

  Tfrmproduto_consulta = class(TForm)
    btncancelar: TButton;
    btnconfirma: TButton;
    DBGrid1: TDBGrid;
    edtlocalizar: TEdit;
    Localizar: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btncancelarClick(Sender: TObject);
    procedure btnconfirmaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
  private

  public

  end;

var
  frmproduto_consulta: Tfrmproduto_consulta;

implementation
      uses uorcamento_cadastro, umodulo_produto;
{$R *.lfm}

{ Tfrmproduto_consulta }

procedure Tfrmproduto_consulta.Panel3Click(Sender: TObject);
begin

end;

procedure Tfrmproduto_consulta.btncancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmproduto_consulta.btnconfirmaClick(Sender: TObject);
begin
   if frmorcamento_cadastro <> nil then
     begin
        frmorcamento_cadastro.lblcontroleprod.Caption:= inttostr( modulo_produto.qrproduto.FieldByName('controle').AsInteger );
        frmorcamento_cadastro.edtdescricao.Caption:=modulo_produto.qrproduto.FieldByName('produto').AsString;
     end;
  //endi

  close;
end;

procedure Tfrmproduto_consulta.DBGrid1DblClick(Sender: TObject);
begin
  btnconfirma.Click;
end;

procedure Tfrmproduto_consulta.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

  FreeAndNil(frmproduto_consulta);   // Action:= caFree;  // frmproduto_consulta := nil;

end;

procedure Tfrmproduto_consulta.FormCreate(Sender: TObject);
begin
  if frmorcamento_cadastro <> nil then
     edtlocalizar.Text:=frmorcamento_cadastro.edtdescricao.Text;
  //endi

end;

end.

