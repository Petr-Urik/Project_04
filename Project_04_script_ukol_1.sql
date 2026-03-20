SET
search_path TO data_academy_content;

--Výzkumný úkol č. 1

--a) Odvětví s výskytem meziročních poklesů mezd (tj. záporných roků):
SELECT
	DISTINCT
		nazev_odvetvi AS odvetvi_s_poklesem,
		rok,
		rust_mzdy_percent
FROM
	t_petr_urik_project_sql_primary_final tpupspf
WHERE
	rust_mzdy_percent < 0
ORDER BY
	nazev_odvetvi,
	rok;

--b) Pořadí odvětví se zápornými roky dle počtu těchto roků:
WITH odvetvi_zaporne_roky_cte AS (
	SELECT
		DISTINCT
			nazev_odvetvi,
			rok,
			rust_mzdy_percent
	FROM
		t_petr_urik_project_sql_primary_final tpupspf
	WHERE
		rust_mzdy_percent < 0
	)
SELECT 
    nazev_odvetvi, 
    COUNT(*)::numeric AS pocet_zapornych_roku
FROM odvetvi_zaporne_roky_cte 
GROUP BY nazev_odvetvi
ORDER BY
	pocet_zapornych_roku  DESC,
	nazev_odvetvi;
--LIMIT 1; -> získali bychom odvětví s maximálním počtem záporných roků

--c) Odvětví bez poklesu mezd:
SELECT
	DISTINCT	
		nazev_odvetvi AS odvetvi_bez_poklesu
FROM
	t_petr_urik_project_sql_primary_final tpupspf
WHERE nazev_odvetvi NOT IN (
	SELECT
		nazev_odvetvi
	FROM
	t_petr_urik_project_sql_primary_final tpupspf
	WHERE rust_mzdy_percent < 0
	)	
ORDER BY nazev_odvetvi;
