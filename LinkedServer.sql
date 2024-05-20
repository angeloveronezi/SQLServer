USE tsMatriz

SELECT cSituacao, cCodColigada, cCodEmpresaERP, *
FROM matriz.tsIntegracaoRh.dbo.VW_Colaborador
WHERE cNome IN ( ''
               , ''
               )
ORDER BY cNome


SELECT cSituacao, cCodColigada, CodEmpresaERP, *
FROM matriz.tsIntegracaoRh.dbo.VW_Colaborator
WHERE cNome IN (''
               , ''
               )
ORDER BY cNome
