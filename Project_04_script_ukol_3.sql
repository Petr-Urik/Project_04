SET search_path TO data_academy_content;

--Výzkumný úkol č. 3

create or replace view pocatek_obdobi_vw as
	select distinct
		nazev_potraviny,
		rok,
		prumerna_cena as cena_pocatek
	from t_petr_urik_project_sql_primary_final tpupspf
	where rok = (select min(rok) from t_petr_urik_project_sql_primary_final tpupspf);

create or replace view konec_obdobi_vw as
	select distinct
		nazev_potraviny,
		rok,
		prumerna_cena as cena_konec
	from t_petr_urik_project_sql_primary_final tpupspf
	where rok = (select max(rok) from t_petr_urik_project_sql_primary_final tpupspf);
	
--výsledný pohled:
select
	pov.nazev_potraviny,
	round(((kov.cena_konec - pov.cena_pocatek) / pov.cena_pocatek * 100), 2) as celkovy_rust_percent	
from pocatek_obdobi_vw pov
join konec_obdobi_vw kov on pov.nazev_potraviny = kov.nazev_potraviny
order by celkovy_rust_percent
limit 1;