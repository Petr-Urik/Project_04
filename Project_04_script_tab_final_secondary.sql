set search_path to data_academy_content;

create or replace view evropske_zeme_vw as
	select
		country
	from countries
	where continent = 'Europe';

create table t_petr_urik_project_sql_secondary_final as
	select
		ezv.country as zeme,
		e.year as rok,
		e.gdp as hdp,
		e.gini,
		e.population as pocet_obyvatel
	from evropske_zeme_vw ezv
	join economies e on ezv.country = e.country
	where year between 2006 and 2018
	order by zeme, rok;
