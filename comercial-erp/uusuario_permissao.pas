unit uusuario_permissao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { Tfrmusuario_permissao }

  Tfrmusuario_permissao = class(TForm)
    btnsalvar: TButton;
    btncancelar: TButton;
    ckbexcluirorcamento: TCheckBox;
    ckbpesquisarperiodo: TCheckBox;
    ckbexcluirpedidovenda: TCheckBox;
    ckbgrupomovimentocaixa: TCheckGroup;
    ckbgrupopedidovenda: TCheckGroup;
    ckborcamento: TCheckBox;
    ckbgrupoorcamento: TCheckGroup;
    ckbmovimentocaixa: TCheckBox;
    ckbpedidovenda: TCheckBox;
    edtsenha: TEdit;
    edtsenha2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblusuario: TLabel;
    procedure btncancelarClick(Sender: TObject);
    procedure btnsalvarClick(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmusuario_permissao: Tfrmusuario_permissao;

implementation
      uses umodulo_usuario, ufuncao_geral, umodulo_conexaodb;
{$R *.lfm}

{ Tfrmusuario_permissao }

procedure Tfrmusuario_permissao.FormCreate(Sender: TObject);
begin

   modulo_usuario.qrtmaster_usuario.Close;
   modulo_usuario.qrtmaster_usuario.SQL.Clear;
   modulo_usuario.qrtmaster_usuario.SQL.Add('select * from tmaster_usuario where controle_tusuario = :controle_tusuario');
   modulo_usuario.qrtmaster_usuario.Params.ParamByName('controle_tusuario').AsInteger:=modulo_usuario.qrusuario_lista.FieldByName('controle').AsInteger;
   modulo_usuario.qrtmaster_usuario.Open;

   lblusuario.Caption:= modulo_usuario.qrusuario_lista.FieldByName('login').AsString;
   edtsenha.Text:=modulo_usuario.qrtmaster_usuario.FieldByName('senha').AsString;
   edtsenha2.Text:=modulo_usuario.qrtmaster_usuario.FieldByName('senha').AsString;


   //Módulo segurança principal
   if  modulo_usuario.qrusuario_lista.FieldByName('orcamento').AsString <> 'SIM' then
       begin
         ckborcamento.Checked:= false;
       end
   else
      begin
        ckborcamento.Checked:= true;
      end;
   //endi


   if  modulo_usuario.qrusuario_lista.FieldByName('pedidovenda').AsString <> 'SIM' then
       begin
         ckbpedidovenda.Checked:= false;
       end
   else
      begin
        ckbpedidovenda.Checked:= true;
      end;
   //endi


   if  modulo_usuario.qrusuario_lista.FieldByName('caixa').AsString <> 'SIM' then
       begin
         ckbmovimentocaixa.Checked:= false;
       end
   else
      begin
        ckbmovimentocaixa.Checked:= true;
      end;
   //endi


   //Módulo segurança secudário
   if  modulo_usuario.qrtmaster_usuario.FieldByName('excluir_orcamento').AsString <> 'SIM' then
       begin
         ckbexcluirorcamento.Checked:= false;
       end
   else
      begin
        ckbexcluirorcamento.Checked:= true;
      end;
   //endi

   if  modulo_usuario.qrtmaster_usuario.FieldByName('excluir_pedidovenda').AsString <> 'SIM' then
       begin
         ckbexcluirpedidovenda.Checked:= false;
       end
   else
      begin
        ckbexcluirpedidovenda.Checked:= true;
      end;
   //endi


   if (modulo_usuario.qrtmaster_usuario.FieldByName('pesqperiodo_movcaixa').AsString <> 'SIM')  then
       begin
         ckbpesquisarperiodo.Checked:= false;
       end
   else
      begin
        ckbpesquisarperiodo.Checked:= true;
      end;
   //endi




end;

procedure Tfrmusuario_permissao.CheckBox2Change(Sender: TObject);
begin

end;

procedure Tfrmusuario_permissao.btncancelarClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmusuario_permissao.btnsalvarClick(Sender: TObject);
begin
  if edtsenha2.Text  <> edtsenha.Text then
     begin
       showmessage('Confirmação de senha não coencide com a senha secundária, redigite-a caso queira trocar a senha, caso contrário clique em fechar.');
       exit;
     end;
  //endi

  with modulo_conexaodb do
     begin
       //Módulo Segurança principal
       qrexec_base.Close;
       qrexec_base.SQL.Clear;
       qrexec_base.SQL.Add('update tusuario set orcamento = :orcamento, pedidovenda = :pedidovenda, caixa = :caixa where controle = :controle');
       qrexec_base.ParamByName('controle').AsInteger:=modulo_usuario.qrusuario_lista.FieldByName('controle').AsInteger;
       if ckborcamento.Checked then
          begin
            qrexec_base.ParamByName('orcamento').AsString:='SIM';
          end
       else
          begin
            qrexec_base.ParamByName('orcamento').AsString:='NÃO';
          end;
       //endif
       if ckbpedidovenda.Checked then
          begin
            qrexec_base.ParamByName('pedidovenda').AsString:='SIM';
          end
       else
          begin
            qrexec_base.ParamByName('pedidovenda').AsString:='NÃO';
          end;
       //endif

       if ckbmovimentocaixa.Checked then
          begin
            qrexec_base.ParamByName('caixa').AsString:='SIM';
          end
       else
          begin
            qrexec_base.ParamByName('caixa').AsString:='NÃO';
          end;
       //endif

       qrexec_base.ExecSQL;


        atualizabanco;

        //Módulo Segurança secundário

        qrexec_base.Close;
        qrexec_base.SQL.Clear;
        qrexec_base.SQL.Add('update tmaster_usuario set excluir_orcamento = :excluir_orcamento, excluir_pedidovenda = :excluir_pedidovenda, pesqperiodo_movcaixa = :pesqperiodo_movcaixa where controle_tusuario = :controle_tusuario');
        qrexec_base.ParamByName('controle_tusuario').AsInteger:=modulo_usuario.qrusuario_lista.FieldByName('controle').AsInteger;
        if ckborcamento.Checked then
           begin
             qrexec_base.ParamByName('excluir_orcamento').AsString:='SIM';
           end
        else
           begin
             qrexec_base.ParamByName('excluir_orcamento').AsString:='NÃO';
           end;
        //endif
        if ckbpedidovenda.Checked then
           begin
             qrexec_base.ParamByName('excluir_pedidovenda').AsString:='SIM';
           end
        else
           begin
             qrexec_base.ParamByName('excluir_pedidovenda').AsString:='NÃO';
           end;
        //endif

        if ckbpesquisarperiodo.Checked then
           begin
             qrexec_base.ParamByName('pesqperiodo_movcaixa').AsString:='SIM';
           end
        else
           begin
             qrexec_base.ParamByName('pesqperiodo_movcaixa').AsString:='NÃO';
           end;
        //endif



        qrexec_base.ExecSQL;


         atualizabanco;




     end;
  //endi

  close;

end;

end.

