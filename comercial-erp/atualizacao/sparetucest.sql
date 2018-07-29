/*SET TERM ^ ;*/

CREATE OR ALTER procedure sparetucest (
    ncm varchar(8))
returns (
    cest varchar(10))
as
begin
  for
    select tcest.ncm,  tcest.cest from tcest where tcest.ncm = :ncm into :ncm, :cest
  do
  begin
    suspend;
  end
end^

/*SET TERM ; ^*/

