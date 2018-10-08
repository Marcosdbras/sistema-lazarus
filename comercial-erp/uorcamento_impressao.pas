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
  private

  public

  end;

var
  frmorcamento_impressao: Tfrmorcamento_impressao;

implementation
        uses uimporc;
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

          frmimporc := tfrmimporc.Create(self);
          frmimporc.rlimporc.Print;
          frmimporc.free;


        end;



      2:begin
          SaveDialog1.FileName :=  'C:\';
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

end.

