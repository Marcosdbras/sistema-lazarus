unit uconfig_banco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType, IniFiles;

type

  { Tfrmconfig_banco }

  Tfrmconfig_banco = class(TForm)
    btncaminhodb1: TButton;
    btnfechar: TButton;
    btncaminhodb: TButton;
    Button2: TButton;
    cbxhostname: TComboBox;
    cbxhostnameremoto: TComboBox;
    cbxversaosgdb: TComboBox;
    edibancodados: TEdit;
    edibancodadosremoto: TEdit;
    edibancodados2: TEdit;
    ediporta: TEdit;
    ediusuario: TEdit;
    edisenha: TEdit;
    Label1: TLabel;
    opeCaminhodb: TOpenDialog;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    procedure btncaminhodb1Click(Sender: TObject);
    procedure btncaminhodbClick(Sender: TObject);
    procedure btnfecharClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmconfig_banco: Tfrmconfig_banco;

implementation
   uses ufuncao_geral,  ufuncao_arq_ini, ufuncao_conexaodb;
{$R *.lfm}

{ Tfrmconfig_banco }

procedure Tfrmconfig_banco.Button2Click(Sender: TObject);
var smensagem:String;
  bgravou, bconectou:boolean;
begin

  if ( (GravarINIBD(cbxhostname.Text,
                  edibancodados.Text,
                  ediporta.Text,
                  edisenha.Text,
                  ediusuario.Text,
                  cbxversaosgdb.Text,
                  'UTF8',
                  edibancodados2.Text,
                  cbxhostnameremoto.Text,
                  edibancodadosremoto.Text))

        and (conectarBanco)


     )
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

procedure Tfrmconfig_banco.FormCreate(Sender: TObject);
begin

   //Carrega dados de conexão do banco na variáveis globais
   LerINIBD;

   // Carrega Variáveis globais nos textbox
   cbxhostname.Text := sHostName;
   ediporta.Text := sPort;
   cbxversaosgdb.Text := sProtocol;
   ediusuario.Text := sUser;
   edisenha.Text := sPassword;
   edibancodados.Text := sDatabase;
   edibancodados2.Text:=sCaminhoDb2;

   cbxhostnameremoto.Text := sHostNameremoto;
   edibancodadosremoto.Text := sDatabaseremoto;

   //Localização da clientdll e informação da Codepage
   //sLibraryLocation;
   //sClientCodepage;






end;

procedure Tfrmconfig_banco.btnfecharClick(Sender: TObject);
begin
  close;
end;

procedure Tfrmconfig_banco.btncaminhodbClick(Sender: TObject);
begin


  if opeCaminhodb.Execute then
     begin
       edibancodados.Text:= opeCaminhodb.FileName;


     end;
end;

procedure Tfrmconfig_banco.btncaminhodb1Click(Sender: TObject);
begin
  

  if opeCaminhodb.Execute then
     begin
       edibancodados2.Text:= opeCaminhodb.FileName;


     end;
end;

end.

