unit ucadastro_parcelafinanceiro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DbCtrls, Spin, EditBtn;

type

  { Tfrmcadastro_parcelafinanceiro }

  Tfrmcadastro_parcelafinanceiro = class(TForm)
    btncancelar: TButton;
    btnsalvar: TButton;
    DateEdit1: TDateEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    FloatSpinEdit1: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtparcela: TLabel;
    SpinEdit1: TSpinEdit;
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

