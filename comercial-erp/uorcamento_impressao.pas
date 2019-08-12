unit uorcamento_impressao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmorcamento_impressao }

  Tfrmorcamento_impressao = class(TForm)
    btnok: TButton;
    btncancelar: TButton;
    cbxvisualiza: TComboBox;
    Label1: TLabel;
    SaveDialog1: TSaveDialog;
    procedure btncancelarClick(Sender: TObject);
    procedure btnokClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     caminhopadraopdf:string;
  public

  end;

var
  frmorcamento_impressao: Tfrmorcamento_impressao;

implementation
        uses uimporc, umodulo_geral, umodulo_orcamento;
{$R *.lfm}

        { Tfrmorcamento_impressao }

        procedure Tfrmorcamento_impressao.btncancelarClick(Sender: TObject);
        begin
          close;
        end;

procedure Tfrmorcamento_impressao.btnokClick(Sender: TObject);
begin
   case cbxvisualiza.ItemIndex of
      0:begin

          frmimporc := tfrmimporc.Create(self);
          frmimporc.rlimporc.preview;
          frmimporc.free;




        end;


      1:begin
          try
          frmimporc := tfrmimporc.Create(self);
          frmimporc.rlimporc.Print;
          frmimporc.free;
          except
            showmessage('Operação Cancelada!');
          end;

        end;



      2:begin
          SaveDialog1.FileName :=  caminhopadraopdf+'\ORC'+modulo_orcamento.qrorcamento.FieldByName('controlevarchar').AsString;
          if savedialog1.Execute then
             begin

               frmimporc := tfrmimporc.Create(self);
               frmimporc.rlimporc.SaveToFile( SaveDialog1.FileName );
               frmimporc.rlimporc.Prepare;
               frmimporc.rlfilter.FilterPages(frmimporc.rlimporc.Pages,1,-1,'',1);   //(frmimporc.rlimporc.Pages,1,-1,False);
               frmimporc.free;

             end;




        end;




   end;
end;

procedure Tfrmorcamento_impressao.FormCreate(Sender: TObject);
begin
        with modulo_geral do
        begin

          qrmaster_indice.Close;
          qrmaster_indice.SQL.Clear;
          qrmaster_indice.SQL.Add('select * from tmaster_indice');
          qrmaster_indice.Open;

          caminhopadraopdf := qrmaster_indice.FieldByName('caminhopadraopdf').AsString;

        end;

        cbxvisualiza.Style:=csDropDownList;

end;

end.

