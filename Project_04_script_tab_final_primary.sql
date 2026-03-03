set search_path to data_academy_content;

--oooooooooooooooooooooooooooooooooooooooooooooooooooo

--příprava dat o mzdách

create or replace view mzdove_prumery_vw as
	select
		industry_branch_code,
		payroll_year,
		avg(value) as prumerna_mzda
	from czechia_payroll
	where value_type_code = 5958 and industry_branch_code != 'NULL'
	group by industry_branch_code, payroll_year
	order by industry_branch_code, payroll_year;

create or replace view mezirocni_rusty_vw as
	with lonske_prumery_cte as (
		select *,
    		lag(prumerna_mzda) over (
        		partition by industry_branch_code
        		order by payroll_year
    		) 	as lonsky_prumer
		from mzdove_prumery_vw
		)
	select *,
    	prumerna_mzda - coalesce(lonsky_prumer, prumerna_mzda) as mezirocni_rust
	from lonske_prumery_cte;

create or replace view odvetvi_final_vw as
	with pripojene_nazvy_odvetvi_cte as (
		select
			cpib.name as nazev_odvetvi,
			mrv.payroll_year::numeric as rok,
			mrv.prumerna_mzda,
			mrv.lonsky_prumer,
			mrv.mezirocni_rust
		from mezirocni_rusty_vw mrv
		join czechia_payroll_industry_branch cpib on mrv.industry_branch_code = cpib.code
		)
	select *,
		coalesce(round((mezirocni_rust / nullif(lonsky_prumer, 0) *100)::numeric, 2), 0) as procenta_rustu
	from pripojene_nazvy_odvetvi_cte;

create or replace view odvetvi_mzdy_final_vw as
	select *
	from odvetvi_final_vw;

--ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo

--příprava dat o potravinách

create or replace view vsechna_mereni_cen_vw as
select
	cp.category_code as kod_potraviny,
	cpc.name as nazev_potraviny,
	cp.value as jednotkova_cena,
	date_part('year', date_from) as rok	
from czechia_price cp
join czechia_price_category cpc on cp.category_code = cpc.code
order by rok, kod_potraviny;

create or replace view rocni_predrocni_ceny_vw as
select
	nazev_potraviny,
	rok::numeric,
	avg(jednotkova_cena)::numeric as prumerna_cena,
	lag(avg(jednotkova_cena)) over (
	partition by nazev_potraviny
	order by rok)::numeric as lonsky_prumer
from vsechna_mereni_cen_vw
group by nazev_potraviny, rok
order by  nazev_potraviny, rok;

create or replace view potraviny_ceny_final_vw as
	with mezirocni_rusty_cen_cte as (
		select *,
			prumerna_cena - coalesce(lonsky_prumer, prumerna_cena)
			::numeric as mezirocni_rust
		from rocni_predrocni_ceny_vw
		)
	select
		nazev_potraviny,
		rok,
		prumerna_cena,
		coalesce(round((mezirocni_rust / nullif(lonsky_prumer, 0) * 100)
		::numeric, 2), 0) as procenta_rustu
	from mezirocni_rusty_cen_cte;

--ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo

--příprava výsledné tabulky

create or replace view final_bez_hdp_vw as
	select 
    	omfv.rok,
   		omfv.nazev_odvetvi,
    	omfv.prumerna_mzda,
    	omfv.procenta_rustu as rust_mzdy_percent,
    	pcfv.nazev_potraviny,
    	pcfv.prumerna_cena,
    	pcfv.procenta_rustu as rust_ceny_percent
	from odvetvi_mzdy_final_vw omfv
	right join potraviny_ceny_final_vw pcfv
    	on omfv.rok = pcfv.rok;

create or replace view hdp_cesko_vw as
	select
		year::numeric as rok,
		gdp::numeric as hdp
	from data_academy_content.economies
	where country = 'Czech Republic'
	and year between 2006 and 2018
	order by rok;

create table t_petr_urik_project_sql_primary_final as
	select
		fbhv.*,
		hcv.hdp
	from final_bez_hdp_vw fbhv
	join hdp_cesko_vw hcv using(rok);