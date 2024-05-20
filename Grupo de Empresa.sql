
-- Pesquisar empresas por grupo de empresas ou por nome

DECLARE @CodEmpresa INT = ''
DECLARE @NomeAbrevEmpresa VARCHAR (3) = 'AND'

SELECT DISTINCT [Cód. Grupo Empresa]  = ADPB191.nCdGrupoEmpresa
     , [Nome Grupo Empresa]  = ADPB190.cNmGrupoEmpresa
	 , [Cód. Empresa]        = ADPB191.nCdEmpresa
	 , [Nome Empresa]        = ADPB020.cNmEmpresa
	 , [Abreviatura Empresa] = ADPB191.cTotalizaPor
FROM ADPB191 WITH(NOLOCK)
INNER JOIN ADPB190 WITH(NOLOCK) ON ADPB190.nCdGrupoEmpresa = ADPB191.nCdGrupoEmpresa --  ADPB190 Nome Grupo de Empresas
INNER JOIN ADPB020 WITH(NOLOCK) ON ADPB020.nCdEmpresa = ADPB191.nCdEmpresa
WHERE (ADPB191.nCdEmpresa = @CodEmpresa
        OR ADPB191.cTotalizaPor =  @NomeAbrevEmpresa
	   )
  AND ADPB020.cAtivo = 1

--SELECT *
--FROM ADPB191
--WHERE nCdGrupoEmpresa = 75

--SELECT *
--FROM ADPB020
--WHERE cNmEmpresa LIKE '%JBS%LIN%'