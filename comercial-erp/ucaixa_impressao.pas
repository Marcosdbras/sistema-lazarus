unit ucaixa_impressao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn;

type

  { Tfrmcaixa_impressao }

  Tfrmcaixa_impressao = class(TForm)
    btnok: TButton;
    btncancelar: TButton;
    cbxvisualiza: TComboBox;
    edtdatainicial: TDateEdit;
    edtdatafinal: TDateEdit;


    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    procedure btncancelarClick(Sender: TObject);
    procedure btnokClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     caminhopadraopdf:string;
  public

  end;

var
  frmcaixa_impressao: Tfrmcaixa_impressao;

implementation
        uses uimporc, umodulo_geral, umodulo_orcamento, uimpcaixa, umodulo_consulta;
{$R *.lfm}

        { Tfrmcaixa_impressao }

        procedure Tfrmcaixa_impressao.btncancelarClick(Sender: TObject);
        begin
          close;
        end;

procedure Tfrmcaixa_impressao.btnokClick(Sender: TObject);
begin

   with modulo_consulta.qrcaixatdinheiro do
        begin

           Close;
           SQL.Clear;
           SQL.Add('select tdinheiro from spcaixatdinheiro(:datai, :dataf)');
           Params.ParamByName('datai').Asdate:= edtdatainicial.date;                   //;//datetostr( datai );  //'06/10/2019';
           Params.ParamByName('dataf').Asdate:= edtdatafinal.date; //;//datetostr(dataf);  //'06/10/2019';
           Open;

        end;
  //endi


  with modulo_consulta.qrtotalporespecie do
       begin

          Close;
          SQL.Clear;
          SQL.Add('select e.controle, e.especie, coalesce(p.statuspedido,'+quotedstr('A')+'),   r.codespecie, sum( coalesce(r.valororiginal,0) ) as totaltipopgto  from   tmaster_receber r  right join tespecie e on r.codespecie = e.controle left join tmaster_pedidovenda p on p.controle_tpedidovenda = r.codpedidovenda where r.datafec >= :datai and  r.datafec <=:dataf  group by p.statuspedido, e.controle, r.codespecie, e.especie;');
          Params.ParamByName('datai').Asdate:= edtdatainicial.date;
          Params.ParamByName('dataf').Asdate:= edtdatafinal.date;
          Open;

       end;
 //endi



   case cbxvisualiza.ItemIndex of
      0:begin

          frmimpcaixa := tfrmimpcaixa.Create(self);
          frmimpcaixa.rlimporc.preview;
          frmimpcaixa.free;
          frmimpcaixa := nil;



        end;


      1:begin
          try
          frmimpcaixa := tfrmimpcaixa.Create(self);
          frmimpcaixa.rlimporc.Print;
          frmimpcaixa.free;
          frmimpcaixa := nil;
          except
            showmessage('Operação Cancelada!');
          end;

        end;



      2:begin
          SaveDialog1.FileName :=  caminhopadraopdf+'\CAIXA';
          if savedialog1.Execute then
             begin

               frmimpcaixa := tfrmimpcaixa.Create(self);
               frmimpcaixa.rlimporc.SaveToFile( SaveDialog1.FileName );
               frmimpcaixa.rlimporc.Prepare;
               frmimpcaixa.rlfilter.FilterPages(frmimporc.rlimporc.Pages,1,-1,'',1);   //(frmimporc.rlimporc.Pages,1,-1,False);
               frmimpcaixa.free;
               frmimpcaixa := nil;

             end;




        end;




   end;

   close;

end;

procedure Tfrmcaixa_impressao.FormCreate(Sender: TObject);
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

        edtdatainicial.Date:=date;
        edtdatafinal.Date:=date;


end;

end.

