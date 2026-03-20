SET
search_path TO data_academy_content;

--Výzkumný úkol č. 2

SELECT
	rok,
	nazev_potraviny,
	prumerna_cena,
	round(avg(prumerna_mzda), 2) AS vseobecna_prumerna_mzda,
	floor(avg(prumerna_mzda) / prumerna_cena) AS koupeschopnost
FROM
	t_petr_urik_project_sql_primary_final
WHERE
	(nazev_potraviny ILIKE '%chléb%'
		OR nazev_potraviny ILIKE '%mléko%')
	AND rok IN (
			(
		SELECT
			min(rok)
		FROM
			t_petr_urik_project_sql_primary_final),
			(
		SELECT
			max(rok)
		FROM
			t_petr_urik_project_sql_primary_final)
		)
GROUP BY
	nazev_potraviny,
	rok,
	prumerna_cena
ORDER BY
	rok,
	nazev_potraviny;
