unit usplash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tfrmsplash }

  Tfrmsplash = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
  private

  public

  end;

var
  frmsplash: Tfrmsplash;

implementation

{$R *.lfm}

end.

