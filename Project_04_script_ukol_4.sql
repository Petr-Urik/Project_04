SET search_path TO data_academy_content;

with letosni_predesle_ceny_cte as 
	(select
		rok,
		sum(prumerna_cena) as cena_vsech_potravin,
		lag(sum(prumerna_cena)) over(order by rok) as lonska_cena,
		sum(prumerna_mzda) as mzda_vsech_odvetvi,
		lag(sum(prumerna_mzda)) over(order by rok) as lonska_mzda
	from t_petr_urik_project_sql_primary_final tpupspf 
	group by rok
	)
select
	rok,
	(cena_vsech_potravin - lonska_cena) / lonska_cena * 100  as celk_zmena_ceny_percent,
	(mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100 as celk_zmena_mzdy_percent,
	(cena_vsech_potravin - lonska_cena) / lonska_cena * 100
	- (mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100 as rozdil,
	case
		when ((cena_vsech_potravin - lonska_cena) / lonska_cena * 100
		- (mzda_vsech_odvetvi - lonska_mzda) / lonska_mzda * 100) < 10
		then 'není výrazný rozdíl'
	end as vysledek
from letosni_predesle_ceny_cte;