


SELECT FIRP500.cNmUsuario
     , FIRP500.cCargo
	 , Gestor.cNmUsuario
	 , FIRP500.cSitRH
  FROM FIRP500
INNER JOIN FIRP500 Gestor ON Gestor.cCPF = FIRP500.cCPFChefe
INNER JOIN FIRP500 Gestor2 ON Gestor2.cCPF = FIRP500.cCPFChefe
WHERE (FIRP500.cCPFChefe = ''
       OR FIRP500.cCPFChefe = '')
  AND FIRP500.cSitRH <> 'D'
GROUP BY Gestor.cNmUsuario, FIRP500.cNmUsuario, FIRP500.cCargo, FIRP500.cSitRH
ORDER BY FIRP500.cNmUsuario