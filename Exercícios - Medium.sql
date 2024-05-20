/* 
 Questão: 
 Mostre a quantidade total de pacientes do sexo masculino e a quantidade total de pacientes do sexo feminino na tabela de pacientes.
 Exiba os dois resultados na mesma linha.
*/

-- 1º Solução:
SELECT (SELECT COUNT (patient_id)
          FROM patients
         WHERE gender = 'M') AS 'Masculino'
     , (SELECT COUNT (patient_id)
          FROM patients
         WHERE gender = 'F') AS 'Feminino'
-- 'M' = 2468
-- 'F' = 2062

--- 2º Solução:
SELECT SUM(gender = 'M') AS 'Masculino'
     , SUM(gender = 'F') AS 'Feminino'
  FROM patients

-- 3º Solução:
SELECT SUM(CASE WHEN gender = 'M' THEN 1 END) AS 'Masculino'
     , SUM(CASE WHEN gender = 'F' THEN 1 END) AS 'Feminino'
  FROM patients;
  
  

/* 
 Questão: 
 Mostrar nome e sobrenome, alergias de pacientes que têm alergia a 'Penicilina' ou 'Morfina'. 
 Mostrar resultados ordenados crescentemente por alergias, depois por primeiro_nome e depois por último_nome.
*/

-- 1º Solução:
SELECT first_name
     , last_name
     , allergies
  FROM patients
 WHERE allergies IN ('Penicillin', 'Morphine')
 ORDER BY allergies, first_name, last_name 


/* 
 Questão: 
 Mostrar Patient_id, diagnóstico de internações. 
 Encontre pacientes admitidos várias vezes para o mesmo diagnóstico.
*/

-- 1º Solução:

SELECT patient_id, diagnosis
  FROM admissions
 GROUP BY patient_id, diagnosis
 HAVING COUNT(diagnosis) > 1;
 
 /*
	Questão:
	Mostre a cidade e o número total de pacientes na cidade.
	Ordene do maior para o menor número de pacientes e depois pelo nome da cidade em ordem crescente.
 */
 -- 1º Solução:
 
SELECT city, COUNT(patient_id) AS 'Total Pacientes'
  FROM patients
 GROUP BY city
 HAVING COUNT (*) > 0
 ORDER BY COUNT(patient_id) DESC, city
  
  -- 2º Solução:
  
  SELECT city, COUNT(patient_id) AS 'Total Pacientes'
    FROM patients
   GROUP BY city
   ORDER BY COUNT(patient_id) DESC, city ASC
   
 /*
	Questão:
	Mostre nome, sobrenome e função de cada pessoa que seja paciente ou médico.
    As funções são "Paciente" ou "Médico".
 */
  -- 1º Solução:
  
  SELECT first_name, last_name, 'Patient' AS Role
    FROM patients
UNION ALL
  SELECT first_name, last_name, 'Doctor' AS Role
    FROM doctors



 /*
	Questão:
	Mostrar todas as alergias ordenadas por popularidade. Remova os valores NULL da consulta.
 */
  -- 1º Solução:
  
  SELECT allergies, COUNT(allergies) AS 'Total Allergies'
    FROM patients
   WHERE allergies IS NOT NULL
   GROUP BY allergies
   ORDER BY COUNT(allergies) DESC
 
 

 /*
	Questão:
	Mostrar nome, sobrenome e data de nascimento de todos os pacientes que nasceram na década de 1970. 
	Classifique a lista começando pela data de nascimento mais antiga.
 */
  -- 1º Solução:
  
SELECT first_name, last_name, birth_date
  FROM patients
 WHERE YEAR(birth_date) >= 1970
   AND YEAR(birth_date) <= 1979
 ORDER BY birth_date ASC
 
  -- 2º Solução:
 
SELECT first_name,
       last_name,
       birth_date
  FROM patients
 WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
 ORDER BY birth_date ASC;
 
  -- 3º Solução:
  
SELECT first_name,
       last_name,
       birth_date
  FROM patients
 WHERE YEAR(birth_date) LIKE '197%'
 ORDER BY birth_date ASC
 
 
 /*
	Questão:
	Queremos exibir o nome completo de cada paciente em uma única coluna. O sobrenome em letras maiúsculas deve aparecer primeiro e depois 
o primeiro nome em letras minúsculas. Separe o sobrenome e o nome com uma vírgula. Ordene a lista pelo first_name em ordem decrescente.
    EX: SMITH, Jane
 */
  -- 1º Solução:
 SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name))
   FROM patients
  ORDER BY first_name DESC
  
-- 2º Solução:

SELECT UPPER(last_name) + ',' + LOWER(first_name) AS new_name_format
  FROM patients
 ORDER BY first_name DESC;	
 

/*
	Questão:
	Mostre o(s) Province_id(s), soma da altura; onde a soma total da altura do paciente é maior ou igual a 7.000.
 */
  -- 1º Solução:
SELECT province_id, SUM(height) 'Total'
  FROM patients
 GROUP BY province_id
HAVING SUM(height) >= 7000

-- 2º Solução:
SELECT * 
  FROM (SELECT province_id
             , SUM(height) AS sum_height 
		  FROM patients 
		 GROUP BY province_id)
		 WHERE sum_height >= 7000;
		 
		 
/*
	Questão:
	Mostre a diferença entre o maior e o menor peso para pacientes com sobrenome 'Maroni'.
 */
  -- 1º Solução:
  
SELECT MAX(weight) - MIN(weight)      -- Ou  SELECT (MAX(weight) - MIN(weight)) AS 'Diferença'
  FROM patients 
 WHERE last_name = 'Maroni'
 
 
/*
	Questão:
	Mostre todos os dias do mês (1-31) e quantas datas de admissão ocorreram naquele dia. 
	Classifique por dia com mais admissões e menos admissões.
*/
  -- 1º Solução:
  
SELECT DAY(admission_date) AS 'Dia'
     , COUNT(admission_date) AS 'TotalAdmissões'
  FROM admissions
 GROUP By DAY(admission_date)
 ORDER BY COUNT(admission_date) DESC
 

/*
	Questão:
	Mostrar todas as colunas da data de admissão mais recente do patient_id 542.
*/
  -- 1º Solução:
  
SELECT *
  FROM admissions
 WHERE patient_id = 542
   AND admission_date > (SELECT admission_date
                           FROM admissions
                          WHERE patient_id = 542)
 ORDER BY admission_date DESC
 
-- 2º Solução:

SELECT *
  FROM admissions
 WHERE patient_id = 542
 GROUP BY patient_id
HAVING admission_date = MAX(admission_date);

-- 3º Solução:

SELECT *
  FROM admissions
 WHERE patient_id = '542'
   AND admission_date = (SELECT MAX(admission_date)
                           FROM admissions
						  WHERE patient_id = '542'
						)
				
-- 4º Solução:

SELECT TOP 1 *
  FROM admissions
 WHERE patient_id = 542
 ORDER BY admission_date DESC
 --LIMIT 1
 
-- 5º Solução:

SELECT *
  FROM admissions
 GROUP BY patient_id
HAVING patient_id = 542
   AND MAX(admission_date)
   
   
 /*
	Questão:
	Mostre o patient_id, o attending_doctor_id e o diagnosis para internações que correspondam a um dos dois critérios:
	1. patient_id é um número ímpar e attending_doctor_id é 1, 5 ou 19.
	2. attending_doctor_id contém 2 e o comprimento de patient_id é de 3 caracteres.
*/
  -- 1º Solução:
  
  SELECT DISTINCT patient_id, attending_doctor_id, diagnosis
    FROM admissions
   WHERE ( patient_id % 2 = 1
     AND attending_doctor_id IN (1, 5, 19)
         )
      OR ( attending_doctor_id LIKE '%2%'
          AND LEN(patient_id) = 3
         )
		 
  -- 2º Solução:
  
  SELECT patient_id,
         attending_doctor_id,
         diagnosis
    FROM admissions
   WHERE (attending_doctor_id IN (1, 5, 19)
          AND patient_id % 2 != 0
         )
      OR (attending_doctor_id LIKE '%2%'
          AND len(patient_id) = 3
         )
	
	
/*
	Questão:
	Mostrar first_name, last_name e o número total de internações atendidas de cada médico.
    Cada internação foi atendida por um médico.
*/

  -- 1º Solução:
SELECT first_name
     , last_name
     , COUNT (*) AS 'Total Atendimento'
  FROM admissions
 INNER JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id
 GROUP BY first_name, last_name  
  
  
  -- 2º Solução:
SELECT first_name
     , last_name
	 , COUNT(*) AS admissions_total
  FROM admissions a
  JOIN doctors ph ON ph.doctor_id = a.attending_doctor_id
 GROUP BY attending_doctor_id
 
 
 /*
	Questão:
	Para cada médico, exiba sua identidade, nome completo e a primeira e última data de internação que compareceu.
 */
 
  -- 1º Solução:
  
  -- AINDA NÃO TERMINADO
SELECT doctor_id
     , concat(first_name, ' ', last_name) 'Nome Completo'
     , MIN(admission_date) 'Primeira Internação'
     , MAX(discharge_date) 'Última Internação'
  FROM admissions
 INNER JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id
 GROUP BY attending_doctor_id
 
 