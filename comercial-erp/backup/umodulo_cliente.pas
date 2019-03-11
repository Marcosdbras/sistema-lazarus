unit umodulo_cliente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, BufDataset, FileUtil;

type

  { Tmodulo_cliente }

  Tmodulo_cliente = class(TDataModule)
    dscliente: TDataSource;
    dstempCliente: TDataSource;
    qrcliente: TSQLQuery;
    qrtempCliente: TBufDataset;
    qrtempClienteccli: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrclienteAfterScroll(DataSet: TDataSet);
  private

  public

  end;

var
  modulo_cliente: Tmodulo_cliente;

implementation
      uses umodulo_conexaodb, uorcamento_cadastro,umodulo_tabpreco;
{$R *.lfm}

      { Tmodulo_cliente }

      procedure Tmodulo_cliente.DataModuleCreate(Sender: TObject);
      begin

        with qrtempCliente.fieldDefs do
           begin
                 Add('ccli', ftInteger, 0, True);
           end;

        qrtempCliente.CreateDataset;

        qrtempCliente.Open;

        qrtempCliente.Append;




      end;

procedure Tmodulo_cliente.qrclienteAfterScroll(DataSet: TDataSet);
begin
    if  frmorcamento_cadastro <> nil then
        begin

          if modulo_tabpreco.qrtabpreco.Locate('controle',qrcliente.FieldByName('codtabelapreco').AsInteger,[]) then
             begin

               modulo_tabpreco.qrtempTabPreco.Edit;
               modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger := qrcliente.FieldByName('codtabelapreco').AsInteger;

             end
          else
             begin

               modulo_tabpreco.qrtempTabPreco.Edit;
               modulo_tabpreco.qrtempTabPreco.FieldByName('ctabp').AsInteger := 0;


             end;
          //endi

          {

          if frmorcamento_cadastro.cbxnomecliente.Text <> '' then
             begin

               frmorcamento_cadastro.lblenderecocli.Caption:= qrcliente.FieldByName('endereco').AsString;
               frmorcamento_cadastro.lblnumerocli.Caption:=qrcliente.FieldByName('numero').AsString;
               frmorcamento_cadastro.lblbairrocli.Caption:=qrcliente.FieldByName('bairro').AsString;
               frmorcamento_cadastro.lblcidadecli.Caption:=qrcliente.FieldByName('cidade').AsString;
               frmorcamento_cadastro.lblcepcli.Caption:=qrcliente.FieldByName('cep').AsString;
               frmorcamento_cadastro.lblestadocli.Caption:=qrcliente.FieldByName('uf').AsString;

             end
          else
             begin

               frmorcamento_cadastro.lblenderecocli.Caption:= '';
               frmorcamento_cadastro.lblnumerocli.Caption:='';
               frmorcamento_cadastro.lblbairrocli.Caption:='';
               frmorcamento_cadastro.lblcidadecli.Caption:='';
               frmorcamento_cadastro.lblcepcli.Caption:='';
               frmorcamento_cadastro.lblestadocli.Caption:='';

             end;
          //endi

          }

        end;
    //endi
end;

end.

