unit upedidovenda_impressao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmpedidovenda_impressao }

  Tfrmpedidovenda_impressao = class(TForm)
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
  frmpedidovenda_impressao: Tfrmpedidovenda_impressao;

implementation
        uses uimpped, umodulo_geral, umodulo_pedidovenda;
{$R *.lfm}

        { Tfrmpedidovenda_impressao }

        procedure Tfrmpedidovenda_impressao.btncancelarClick(Sender: TObject);
        begin
          close;
        end;

procedure Tfrmpedidovenda_impressao.btnokClick(Sender: TObject);
begin
   case cbxvisualiza.ItemIndex of
      0:begin

          frmimpped := tfrmimpped.Create(self);
          frmimpped.rlimpped.preview;
          frmimpped.free;




        end;


      1:begin
          try
          frmimpped := tfrmimpped.Create(self);
          frmimpped.rlimpped.Print;
          frmimpped.free;
          except
            showmessage('Operação Cancelada!');
          end;

        end;



      2:begin
          SaveDialog1.FileName :=  caminhopadraopdf+'\PED'+modulo_pedidovenda.qrpedidovenda.FieldByName('controlevarchar').AsString;
          if savedialog1.Execute then
             begin

               frmimpped := tfrmimpped.Create(self);
               frmimpped.rlimpped.SaveToFile( SaveDialog1.FileName );
               frmimpped.rlimpped.Prepare;
               frmimpped.rlfilter.FilterPages(frmimpped.rlimpped.Pages,1,-1,'',1);   //(frmimpped.rlimpped.Pages,1,-1,False);
               frmimpped.free;

             end;




        end;




   end;
end;

procedure Tfrmpedidovenda_impressao.FormCreate(Sender: TObject);
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

