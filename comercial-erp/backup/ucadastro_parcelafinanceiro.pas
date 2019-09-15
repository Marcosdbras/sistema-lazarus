unit ucadastro_parcelafinanceiro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmcadastro_parcelafinanceiro }

  Tfrmcadastro_parcelafinanceiro = class(TForm)
    btncancelar: TButton;
    btnsalvar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btncancelarClick(Sender: TObject);
  private

  public

  end;

var
  frmcadastro_parcelafinanceiro: Tfrmcadastro_parcelafinanceiro;

implementation

{$R *.lfm}

{ Tfrmcadastro_parcelafinanceiro }

procedure Tfrmcadastro_parcelafinanceiro.btncancelarClick(Sender: TObject);
begin
  close;
end;

end.

