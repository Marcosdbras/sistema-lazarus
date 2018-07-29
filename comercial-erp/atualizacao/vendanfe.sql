/*SET TERM ^ ;*/

CREATE OR ALTER trigger tvendanfe_au1 for tvendanfe
active after update position 1
AS
begin
  execute procedure spatualizacest(old.controle);
end^

/*SET TERM ; ^*/

