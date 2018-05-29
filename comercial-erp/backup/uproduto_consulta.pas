unit uproduto_consulta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids;

type

  { Tfrmproduto_consulta }

  Tfrmproduto_consulta = class(TForm)
    btncancelar: TButton;
    btnconfirma: TButton;
    DBGrid1: TDBGrid;
    edtlocalizar: TEdit;
    Localizar: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure Panel3Click(Sender: TObject);
  private

  public

  end;

var
  frmproduto_consulta: Tfrmproduto_consulta;

implementation
      uses umodulo_produto;
{$R *.lfm}

{ Tfrmproduto_consulta }

procedure Tfrmproduto_consulta.Panel3Click(Sender: TObject);
begin

end;

end.

