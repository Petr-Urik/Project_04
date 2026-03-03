SET search_path TO data_academy_content;

--Výzkumný úkol č. 2

create or replace view ceny_chleba_mleka_vw as
	select
		rok,
		nazev_potraviny,
		prumerna_cena
	from t_petr_urik_project_sql_primary_final tpupspf
	where (tpupspf.nazev_potraviny ilike '%chléb%'
		or tpupspf.nazev_potraviny ilike '%mléko%')
		and rok in (
		(select min(rok) from t_petr_urik_project_sql_primary_final tpupspf),
		(select max(rok) from t_petr_urik_project_sql_primary_final tpupspf))
	group by nazev_potraviny, rok, prumerna_cena
	order by rok;

create or replace view celkove_prumerne_mzdy_vw as
	select
		rok,
			avg(prumerna_mzda) as vseobecna_prumerna_mzda
	from t_petr_urik_project_sql_primary_final tpupspf
	group by rok
	order by rok;

--výsledný pohled:
select
	ccmvw.nazev_potraviny,
	ccmvw.rok,
	cpmv.vseobecna_prumerna_mzda,
	ccmvw.prumerna_cena,
	floor(cpmv.vseobecna_prumerna_mzda / ccmvw.prumerna_cena) as koupeschopnost
from ceny_chleba_mleka_vw ccmvw
left join celkove_prumerne_mzdy_vw cpmv on ccmvw.rok = cpmv.rok
order by ccmvw.nazev_potraviny, ccmvw.rok;