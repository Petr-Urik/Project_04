SET
search_path TO data_academy_content;

--Výzkumný úkol č. 3

WITH pocatek_konec_cte AS (
	SELECT
		nazev_potraviny,
		min(rok) AS pocatek_obdobi,
		max(rok) AS konec_obdobi
	FROM
		t_petr_urik_project_sql_primary_final
	GROUP BY nazev_potraviny
	)
SELECT
	DISTINCT 
		pkc.nazev_potraviny,
		pkc.pocatek_obdobi,
		pf.prumerna_cena AS cena_pocatek_obdobi,
		pkc.konec_obdobi,
		kf.prumerna_cena AS cena_konec_obdobi,
		round((kf.prumerna_cena - pf.prumerna_cena) / pf.prumerna_cena * 100, 2)
			AS celkovy_rust_percent
FROM pocatek_konec_cte pkc
JOIN t_petr_urik_project_sql_primary_final pf
	ON pkc.nazev_potraviny = pf.nazev_potraviny
		AND pkc.pocatek_obdobi = pf.rok 
JOIN t_petr_urik_project_sql_primary_final kf
	ON pkc.nazev_potraviny = kf.nazev_potraviny
		AND pkc.konec_obdobi = kf.rok
ORDER BY celkovy_rust_percent
LIMIT 1;
	
	
			
	

/*		)
	SELECT
		nazev_potraviny,
		CASE
			WHEN rok = 2006 THEN prumerna_cena	
		END AS cena_pocatek_obdobi,
		CASE
			WHEN rok = 2018 THEN prumerna_cena
		END AS cena_konec_obdobi
	FROM ceny_pocatek_konec_cte
	GROUP BY
		nazev_potraviny,
		rok,
		prumerna_cena
	ORDER BY nazev_potraviny, rok;
/*	)
SELECT
	nazev_potraviny,
	round(((cena_konec_obdobi - cena_pocatek_obdobi) / cena_pocatek_obdobi * 100), 2) AS celkovy_rust_percent
FROM
	hodnoty_pocatek_konec
GROUP BY
	nazev_potraviny,
	cena_konec_obdobi,
	cena_pocatek_obdobi;
	

	
	

	
	
	--CREATE OR REPLACE
--VIEW konec_obdobi_vw AS
	SELECT
	DISTINCT
		nazev_potraviny,
		rok,
		prumerna_cena AS cena_konec
FROM
	t_petr_urik_project_sql_primary_final tpupspf
WHERE
	rok = (
	SELECT
		max(rok)
	FROM
		t_petr_urik_project_sql_primary_final tpupspf);
--výsledný pohled:
SELECT
	pov.nazev_potraviny,
	round(((kov.cena_konec - pov.cena_pocatek) / pov.cena_pocatek * 100), 2) AS celkovy_rust_percent
FROM
	pocatek_obdobi_vw pov
JOIN konec_obdobi_vw kov ON
	pov.nazev_potraviny = kov.nazev_potraviny
ORDER BY
	celkovy_rust_percent
LIMIT 1;