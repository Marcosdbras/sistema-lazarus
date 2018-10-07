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
    procedure btncancelarClick(Sender: TObject);
  private

  public

  end;

var
  frmorcamento_impressao: Tfrmorcamento_impressao;

implementation
        uses uimporc;
{$R *.lfm}

        { Tfrmorcamento_impressao }

        procedure Tfrmorcamento_impressao.btncancelarClick(Sender: TObject);
        begin
          close;
        end;

end.

