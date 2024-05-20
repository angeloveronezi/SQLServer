DECLARE @NomeUsuario VARCHAR (100) = ''
      , @CodUsuario   INT = ''

SELECT [ADSP010 - CdTerceiro] =  ADSP010.nCdTerceiroEquivalente
     , [ADSP010 - Ativo] = ADSP010.cAtivo
	 , [ADSP010 - CdAcesso] = ADSP010.nCdSituacaoAcesso
	 , [ADSP010 - SitRH] = ADSP010.nCdSituacaoRH
	 , [ADSP010 - CdUsuario] = ADSP010.nCdUsuario
	 , [ADSP010 - NomeUsuario] = ADSP010.cNmUsuario
	 , [FRIP500 - SitRh] = FIRP500.cSitRH
	 , [FRIP500 - CPFChefe] = FIRP500.cCPFChefe
	 , [ADSP010 - nCdUsuario Gestor] = Gest.nCdUsuario
	 , [Nome Gestor]  = Gestor.cNmUsuario
FROM ADSP010
INNER JOIN FIRP500 ON FIRP500.nCdTerceiro = ADSP010.nCdTerceiroEquivalente
INNER JOIN FIRP500 Gestor ON Gestor.cCPF = FIRP500.cCPFChefe
INNER JOIN ADSP010 Gest ON Gest.nCdTerceiroEquivalente = Gestor.nCdTerceiro
WHERE (ADSP010.cNmUsuario = @NomeUsuario OR ADSP010.nCdUsuario = @CodUsuario)


-- UPDATE ADSP010 SET nCdSituacaoRH = 1	, nCdSituacaoAcesso = 1 WHERE nCdUsuario = 2359
-- UPDATE FIRP500 SET cSitRH = 'A' WHERE nCdTerceiro = 1145104