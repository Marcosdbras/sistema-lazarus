unit uususario_permissao;

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
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckGroup1: TCheckGroup;
    Label1: TLabel;
    lblusuario: TLabel;
    procedure CheckBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmusuario_permissao: Tfrmusuario_permissao;

implementation

{$R *.lfm}

{ Tfrmusuario_permissao }

procedure Tfrmusuario_permissao.FormCreate(Sender: TObject);
begin

end;

procedure Tfrmusuario_permissao.CheckBox2Change(Sender: TObject);
begin

end;

end.

