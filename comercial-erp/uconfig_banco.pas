unit uconfig_banco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType;

type

  { Tfrmconfig_banco }

  Tfrmconfig_banco = class(TForm)
    btnfechar: TButton;
    Button2: TButton;
    cbxhostname: TComboBox;
    cbxversaosgdb: TComboBox;
    edibancodados: TEdit;
    ediporta: TEdit;
    ediusuario: TEdit;
    edisenha: TEdit;
    Label1: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    procedure btnfecharClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  frmconfig_banco: Tfrmconfig_banco;

implementation
   uses ufuncao_cria_ini;
{$R *.lfm}

{ Tfrmconfig_banco }

procedure Tfrmconfig_banco.Button2Click(Sender: TObject);
var smensagem:String;

begin
  if (GravarINIBD(cbxhostname.Text,
                  edibancodados.Text,
                  ediporta.Text,
                  edisenha.Text,
                  ediusuario.Text,
                  cbxversaosgdb.Text))
  then
     begin
        smensagem := 'Configuração realizada com sucesso!';
     end
  else
     begin
        smensagem := 'Falha ao configurar informações sobre o banco de dados!';
     end;

  Application.MessageBox(PChar(smensagem),'Sistema',MB_OK);


end;

procedure Tfrmconfig_banco.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

  //FreeAndNil(frmconfig_banco);

  //action:=caFree;
  //frmconfig_banco:=nil;
end;

procedure Tfrmconfig_banco.btnfecharClick(Sender: TObject);
begin
  close;
end;

end.

