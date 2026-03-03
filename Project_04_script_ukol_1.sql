set search_path to data_academy_content;

--Výzkumný úkol č. 1

--Odvětví s výskytem poklesu mezd:
create or replace view odvetvi_pokles_vw as
	select distinct
		rok,
		nazev_odvetvi,
		rust_mzdy_percent
	from t_petr_urik_project_sql_primary_final tpupspf
	where rust_mzdy_percent < 0
	order by rok, nazev_odvetvi;

select distinct	
	nazev_odvetvi as odvetvi_s_poklesem
from odvetvi_pokles_vw
order by nazev_odvetvi;

--Odvětví bez poklesu mezd:
with odvetvi_vyskyt_poklesu_cte as (
	select distinct	
		nazev_odvetvi
	from odvetvi_pokles_vw opv
	order by nazev_odvetvi
	)
select
	nazev_odvetvi as odvetvi_bez_poklesu
from t_petr_urik_project_sql_primary_final tpupspf
except
select 
	nazev_odvetvi
from odvetvi_vyskyt_poklesu_cte;
