SET
search_path TO data_academy_content;

--Výzkumný úkol č. 5

WITH zmeny_cen_mezd_rozdil_cte AS (
	SELECT
		rok,
		hdp,
		lag(hdp) OVER(ORDER BY rok) AS lonske_hdp,
		sum(prumerna_cena) AS cena_vsech_potravin,
		lag(sum(prumerna_cena)) OVER(ORDER BY rok) AS lonska_cena,
		sum(prumerna_mzda) AS mzda_vsech_odvetvi,
		lag(sum(prumerna_mzda)) OVER(ORDER BY rok) AS lonska_mzda
	FROM
		t_petr_urik_project_sql_primary_final tpupspf
	GROUP BY
		rok,
		hdp
	)
SELECT
	rok,
	round((hdp - lonske_hdp) / lonske_hdp * 100, 2) AS mezirocni_zmena_hdp_percent,
	round((mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100, 2) AS celk_zmena_mzdy_percent,
	round((cena_vsech_potravin - lonska_cena) / lonska_cena * 100, 2) AS celk_zmena_ceny_percent
FROM
	zmeny_cen_mezd_rozdil_cte;