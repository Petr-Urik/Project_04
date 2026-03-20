SET
search_path TO data_academy_content;

CREATE TABLE t_petr_urik_project_sql_secondary_final AS
	SELECT
		c.country AS zeme,
		e.YEAR::numeric AS rok,
		e.gdp::numeric AS hdp,
		e.gini::numeric,
		e.population::numeric AS pocet_obyvatel
FROM
	countries c
JOIN economies e ON c.country = e.country
WHERE
	YEAR BETWEEN 2006 AND 2018
	AND c.continent = 'Europe'
ORDER BY
	zeme,
	rok;
