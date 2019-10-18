unit uususario_permissao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmusuario_permissao }

  Tfrmusuario_permissao = class(TForm)
    btnsalvar: TButton;
    btncancelar: TButton;
    Label1: TLabel;
    lblusuario: TLabel;
  private

  public

  end;

var
  frmusuario_permissao: Tfrmusuario_permissao;

implementation

{$R *.lfm}

end.

