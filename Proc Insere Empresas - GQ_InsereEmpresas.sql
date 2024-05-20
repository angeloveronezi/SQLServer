
-- Proc Criada para inserir TODAS as Empresas criadas na tabela ADPB020
-- Passa no EXEC da PROC apnas o PERFIL + Usuário
-- Exemplo: EXEC GQ_InsereEmpresas 100005, 100005

CREATE OR ALTER PROCEDURE [dbo].[GQ_InsereEmpresas]
( @nCdPerfil  DECIMAL (10,0)
, @ncdUsuario DECIMAL (10,0)
)
AS
 BEGIN 
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  SET NOCOUNT ON

DROP TABLE IF EXISTS #Empresas 

CREATE TABLE #Empresas ( nCdEmpresa DECIMAL(10,0) NULL  
                        )

INSERT INTO #Empresas
SELECT nCdEmpresa
  FROM ADPB020 WITH(NOLOCK)
 ORDER BY nCdEmpresa


DELETE FROM #Empresas WHERE nCdEmpresa IN (SELECT nCdEmpresa 
                                             FROM ADSP01C WITH(NOLOCK)
									        WHERE nCdUsuario = @ncdUsuario AND nCdPerfil = @nCdPerfil)

INSERT INTO ADSP01C
SELECT nCdUsuario = @ncdUsuario
     , nCdPerfil = @nCdPerfil
	 , #Empresas.nCdEmpresa
	 , dInicioVigencia = '20230101'
	 , dFimVigencia = NULL
	 , dUltimaModificacaoVigencia = NULL
  FROM #Empresas WITH(NOLOCK)

END