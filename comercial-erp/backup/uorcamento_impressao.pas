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
    ComboBox1: TComboBox;
    Label1: TLabel;
  private

  public

  end;

var
  frmorcamento_impressao: Tfrmorcamento_impressao;

implementation
        uses uimporc;
{$R *.lfm}

end.

