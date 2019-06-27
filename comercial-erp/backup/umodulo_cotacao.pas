unit umodulo_cotacao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil;

type

  { Tmodulo_cotacao }

  Tmodulo_cotacao = class(TDataModule)
    dsmaster_cotacao_item: TDataSource;
    qrmaster_cotacao_item: TSQLQuery;
    qrmaster_cotacao_itemCFORN: TLongintField;
    qrmaster_cotacao_itemCODIGO: TLongintField;
    qrmaster_cotacao_itemDATA: TDateField;
    qrmaster_cotacao_itemDIF_PRAZO: TLongintField;
    qrmaster_cotacao_itemESCOLHIDO: TStringField;
    qrmaster_cotacao_itemMARGEM_LUCRO: TBCDField;
    qrmaster_cotacao_itemNDANFE: TLongintField;
    qrmaster_cotacao_itemPRAZO: TLongintField;
    qrmaster_cotacao_itemVALOR: TBCDField;
  private

  public

  end;

var
  modulo_cotacao: Tmodulo_cotacao;

implementation
       uses umodulo_conexaodb;
{$R *.lfm}

end.

