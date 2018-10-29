unit usincorc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmsincorc }

  { th }

  th = class(tthread)
       public
         constructor create(CreateSuspended:boolean);
         procedure atualizaform;

       protected
         procedure execute; override;


  end;


  Tfrmsincorc = class(TForm)
    btnok: TButton;
    btncancelar: TButton;
    lblmensagem: TLabel;
    procedure btnokClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmsincorc: Tfrmsincorc;

implementation
      uses umodulo_conexaodb,ufuncao_conexaodb, ufuncao_geral;
{$R *.lfm}

{ Tfrmsincorc }

procedure Tfrmsincorc.btnokClick(Sender: TObject);
//var
  //t:th;
begin
  //t.create(true);
  //t.Start;

    lblmensagem.caption := 'Iniciando conexão...';
    lblmensagem.Update;

    if conectarBanco_remoto then
     begin




       modulo_conexaodb.desconectarBancoRemoto;

     end
     else
     begin


       showmessage('Falha na conexão!');


     end;

     lblmensagem.caption := 'Finalizando conexão...';


end;

procedure Tfrmsincorc.FormCreate(Sender: TObject);
begin
  lblmensagem.caption := '';
end;

{ th }

constructor th.create(CreateSuspended: boolean);
begin
  FreeOnTerminate := true;
  Inherited create(CreateSuspended);

end;

procedure th.atualizaform;
begin
  frmsincorc.lblmensagem.Caption:='';
end;

procedure th.execute;
begin
  Synchronize(@atualizaform);
end;

end.

