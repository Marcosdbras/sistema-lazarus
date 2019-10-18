unit uusuario_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids;

type

  { Tfrmusuario_pesquisa }

  Tfrmusuario_pesquisa = class(TForm)
    Button5: TButton;
    DBGrid1: TDBGrid;
    pnlsuperior: TPanel;
    pnlcentral: TPanel;
    pnlinferior: TPanel;
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmusuario_pesquisa: Tfrmusuario_pesquisa;

implementation
       uses umodulo_usuario, ufuncao_geral;
{$R *.lfm}

       { Tfrmusuario_pesquisa }

       procedure Tfrmusuario_pesquisa.Button5Click(Sender: TObject);
       begin
         close;
       end;

procedure Tfrmusuario_pesquisa.FormCreate(Sender: TObject);
begin
  with modulo_usuario do
     begin
       qrusuario_lista.Close;
       qrusuario_lista.SQL.Clear;
       qrusuario_lista.SQL.Add('select * from tusuario');
       qrusuario_lista.Open;


     end;
  //endth
end;

end.

