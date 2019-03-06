unit upedido_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ExtDlgs, EditBtn;

type

  { Tfrmpedidos }

  Tfrmpedidos = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlsuperior: TPanel;
    pnlinferior: TPanel;
    pnlcentral: TPanel;
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  frmpedidos: Tfrmpedidos;

implementation

{$R *.lfm}

{ Tfrmpedidos }

procedure Tfrmpedidos.Label1Click(Sender: TObject);
begin

end;

end.

