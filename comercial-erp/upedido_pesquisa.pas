unit upedido_pesquisa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { Tfrmpedidos }

  Tfrmpedidos = class(TForm)
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

