set search_path to data_academy_content;

--Výzkumný úkol č. 5

with zmeny_cen_mezd_rozdil_cte as 
	(select
		rok,
		hdp,
		lag(hdp) over(order by rok) as lonske_hdp,
		sum(prumerna_cena) as cena_vsech_potravin,
		lag(sum(prumerna_cena)) over(order by rok) as lonska_cena,
		sum(prumerna_mzda) as mzda_vsech_odvetvi,
		lag(sum(prumerna_mzda)) over(order by rok) as lonska_mzda
	from t_petr_urik_project_sql_primary_final tpupspf 
	group by rok, hdp)
select
	rok,
	round((hdp - lonske_hdp) / lonske_hdp * 100, 2) as mezirocni_zmena_hdp_percent,
	round((mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100, 2) as celk_zmena_mzdy_percent,
	round((cena_vsech_potravin - lonska_cena) / lonska_cena * 100, 2)  as celk_zmena_ceny_percent
from zmeny_cen_mezd_rozdil_cte;