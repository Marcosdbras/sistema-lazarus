unit uproduto_consulta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, LCLType;

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
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure DBGrid1KeyPress(Sender: TObject; var Key: char);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtlocalizarExit(Sender: TObject);
    procedure edtlocalizarKeyPress(Sender: TObject; var Key: char);
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
        frmorcamento_cadastro.edtvlrunitario.Value:=modulo_produto.qrproduto.FieldByName('precovenda').AsFloat;
     end;
  //endi

  close;
end;

procedure Tfrmproduto_consulta.DBGrid1DblClick(Sender: TObject);
begin
  btnconfirma.Click;
end;

procedure Tfrmproduto_consulta.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = 13 then
   begin
     key := 0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
   //endi

   if key = 9 then
   begin
     key := 0;

     exit;
   end;
   //endi

end;

procedure Tfrmproduto_consulta.DBGrid1KeyPress(Sender: TObject; var Key: char);
begin

end;

procedure Tfrmproduto_consulta.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure Tfrmproduto_consulta.DBGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure Tfrmproduto_consulta.edtlocalizarExit(Sender: TObject);
var reglocalizado:integer;
begin



   if modulo_produto.localizaControle(edtlocalizar.Text) = 0 then
        begin

          reglocalizado := modulo_produto.localizaDescricao(edtlocalizar.Text);
          if reglocalizado = 0 then
             begin

               reglocalizado := modulo_produto.localizaCodBarra(edtlocalizar.Text);
               if reglocalizado = 0 then
                  begin

                     reglocalizado := modulo_produto.localizaCampo(edtlocalizar.Text);
                     if reglocalizado = 0 then
                        begin

                           Application.MessageBox('Informação não localizada!','Atenção',MB_OK);

                        end;
                     //endi

                  end;
               //endi

             end;
          //endi

        end;
   //endi




end;

procedure Tfrmproduto_consulta.edtlocalizarKeyPress(Sender: TObject;
  var Key: char);
begin
    if key = #13 then
   begin
     key := #0;
     SelectNext(ActiveControl,True,True);
     exit;
   end;
//endi

end;

procedure Tfrmproduto_consulta.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

  //FreeAndNil(frmproduto_consulta);   // Action:= caFree;  // frmproduto_consulta := nil;

end;

procedure Tfrmproduto_consulta.FormCreate(Sender: TObject);
begin
  if frmorcamento_cadastro <> nil then
     edtlocalizar.Text:=frmorcamento_cadastro.edtdescricao.Text;
  //endi

end;

end.

