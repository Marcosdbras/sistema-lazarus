unit uprincipal_tela;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus;

type

  { Tfrmprincipal }

  Tfrmprincipal = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    pnlsuperior: TPanel;
    pnlsuperior1: TPanel;
    pnlsuperior2: TPanel;
    pnlsuperior3: TPanel;
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private

  public

  end;

var
  frmprincipal: Tfrmprincipal;

implementation

{$R *.lfm}

{ Tfrmprincipal }

procedure Tfrmprincipal.MenuItem1Click(Sender: TObject);
begin

end;

procedure Tfrmprincipal.MenuItem3Click(Sender: TObject);
begin

end;

procedure Tfrmprincipal.MenuItem4Click(Sender: TObject);
begin
  close;
end;

end.

