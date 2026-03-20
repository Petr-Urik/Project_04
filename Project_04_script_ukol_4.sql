SET
search_path TO data_academy_content;

--Výzkumný úkol č. 4

WITH letosni_lonske_ceny_cte AS (
	SELECT
		rok,
		sum(prumerna_cena) AS cena_vsech_potravin,
		lag(sum(prumerna_cena)) OVER(ORDER BY rok) AS lonska_cena,
		sum(prumerna_mzda) AS mzda_vsech_odvetvi,
		lag(sum(prumerna_mzda)) OVER(ORDER BY rok) AS lonska_mzda
	FROM
		t_petr_urik_project_sql_primary_final tpupspf
	GROUP BY
		rok
	)
SELECT
	rok,
	(cena_vsech_potravin - lonska_cena) / lonska_cena * 100
		AS celk_zmena_ceny_percent,--není vhodné zaokrouhlit -> nárůst nepřesnosti v dalších výpočtech
	(mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100
		AS celk_zmena_mzdy_percent,--není vhodné zaokrouhlit -> nárůst nepřesnosti v dalších výpočtech
	round((cena_vsech_potravin - lonska_cena) / lonska_cena * 100
	- (mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100, 2) AS rozdil_cena_mzda,
	CASE
		WHEN ((cena_vsech_potravin - lonska_cena) / lonska_cena * 100
		- (mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100) < 10
		THEN 'není výrazný rozdíl'
	END AS vysledek
FROM
	letosni_lonske_ceny_cte;