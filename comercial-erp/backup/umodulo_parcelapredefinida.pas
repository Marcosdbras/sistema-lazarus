unit umodulo_parcelapredefinida;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_parcelapredefinida }

  Tmodulo_parcelapredefinida = class(TDataModule)
    dsParcelaPredefinida: TDataSource;
    dstempParcelaPredefinida: TDataSource;
    qrParcelaPredefinida: TSQLQuery;
    qrtempParcelaPredefinida: TBufDataset;
    qrtempParcelaPredefinidacparcpre: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrParcelaPredefinidaAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_parcelapredefinida: Tmodulo_parcelapredefinida;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco, ufechapedidovenda;
{$R *.lfm}

      { Tmodulo_parcelapredefinida }

      procedure Tmodulo_parcelapredefinida.DataModuleCreate(Sender: TObject);
      begin

        with qrtempParcelaPredefinida.fieldDefs do
           begin
                 Add('cparcpre', ftInteger, 0, True);
           end;

        qrtempParcelaPredefinida.CreateDataset;

        qrtempParcelaPredefinida.Open;

        qrtempParcelaPredefinida.Append;

        qrtempParcelaPredefinida.FieldByName('cparcpre').AsInteger:=0;



      end;

procedure Tmodulo_parcelapredefinida.qrParcelaPredefinidaAfterScroll(DataSet: TDataSet);
begin

  if frmfechapedidovenda <> nil then
     begin
       if qrtempparcelapredefinida.FieldByName('cparcpre').AsInteger > 0 then
          begin

            frmfechapedidovenda.edtnparc.Value :=  qrparcelapredefinida.FieldByName('qtdeparcela').AsInteger;
            edtnparc.Enabled:=false;

          end
       else
          begin

            frmfechapedidovenda.edtnparc.Value := 0;
            edtnparc.Enabled:=true;

          end;
      //endi


     end;
  //endi

end;

end.

