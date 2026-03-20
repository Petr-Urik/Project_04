SET
search_path TO data_academy_content;

CREATE TABLE t_petr_urik_project_sql_primary_final AS
	SELECT *
	FROM (
		SELECT
			m.rok,
			m.nazev_odvetvi,
			round(m.mzda_prumer, 2) AS prumerna_mzda,
			m.rust_mzdy_percent,
			round(e.gdp::numeric, 2) AS hdp
		FROM (
			WITH odvetvi_mzdy_cte AS (
				SELECT
					industry_branch_code,
					payroll_year::numeric AS rok,
					avg(value) AS mzda_prumer,
					round((avg(value) - lag(avg(value))
						OVER (PARTITION BY industry_branch_code
						ORDER BY payroll_year)) / lag(avg(value))
						OVER (PARTITION BY industry_branch_code
						ORDER BY payroll_year) * 100, 2)
						AS rust_mzdy_percent
				FROM
					czechia_payroll
				WHERE
					value_type_code = 5958
					AND industry_branch_code IS NOT NULL
				GROUP BY
					industry_branch_code,
					payroll_year
				)
			SELECT
				cpib.name AS nazev_odvetvi,
				omc.rok,
				omc.mzda_prumer,
				omc.rust_mzdy_percent
			FROM odvetvi_mzdy_cte omc
			JOIN czechia_payroll_industry_branch cpib
				ON omc.industry_branch_code = cpib.code
			) m
		JOIN economies e ON m.rok = e.year
		WHERE
			e.country = 'Czech Republic'
		ORDER BY m.rok
		) o
	RIGHT JOIN (
		WITH potraviny_letos_vloni_cte AS (
			SELECT
				cpc.name AS nazev_potraviny,
				date_part('year', date_from)::numeric AS rok,
				round(avg(value)::numeric, 2) AS prumerna_cena,
				lag(avg(value)) OVER(PARTITION BY cpc.name
					ORDER BY date_part('year', date_from))::NUMERIC
					AS lonsky_prumer
			FROM czechia_price cp
			JOIN czechia_price_category cpc
				ON cp.category_code = cpc.code
			GROUP BY
				cpc.name,
				date_part('year', date_from)
			)
		SELECT
			nazev_potraviny,
			rok,
			prumerna_cena,
			round((prumerna_cena - lonsky_prumer) / lonsky_prumer * 100, 2)
				AS rust_ceny_percent
		FROM potraviny_letos_vloni_cte
		) p
	USING (rok);
