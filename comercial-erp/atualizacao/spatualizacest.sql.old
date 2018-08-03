/*SET TERM ^ ;*/

CREATE OR ALTER procedure spatualizacest (
    codnfe integer)
as
declare variable codproduto integer;
declare variable cest varchar(10);
declare variable controle integer;
declare variable ncm varchar(8);
declare variable codbarra varchar(60);
declare variable codigo_barra varchar(60);
begin
  for
    select titensvendanfe.controle, titensvendanfe.ncm, titensvendanfe.codproduto, titensvendanfe.codbarra  from titensvendanfe where titensvendanfe.codnfe = :codnfe  into :controle, :ncm, :codproduto, :codigo_barra
  do
  begin

    if (:codigo_barra is null) then
      begin

        select testoque.codbarras from testoque where testoque.controle = :codproduto  into :codbarra;

        update titensvendanfe set titensvendanfe.codbarra = :codbarra where  titensvendanfe.controle = :controle;

      end



    execute procedure sparetucest(:ncm) returning_values :cest;

    update titensvendanfe set titensvendanfe.cest = :cest where  titensvendanfe.controle = :controle;


  end


  suspend;
end^

/*SET TERM ; ^*/

