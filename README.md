# Project_04: Vývoj mezd a cen potravin v ČR
Čtvrtý projekt v rámci Engeto: Datová akademie s Pythonem
## Popis projektu
Projekt představuje soubor několika SQL skriptů a řešení zadaných výzkumných úkolů.
SQL skripty slouží k vytvoření vhodných základních tabulek, ze kterých lze dalšími SQL příkazy získat odpovědi na výzkumné úkoly.
## Základní tabulky
**1. t_petr_urik_project_SQL_primary_final**  
- Obsahuje data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období 2006-2018.
- SQL skript pro její vytvoření má název *Project_04_script_tab_final_primary*.
- jako zdroje dat sloužily především tabulky *czechia_payroll* a *czechia_price*.
- zdrojová tabulka *czechia_payroll* obsahovala kromě hodnot mezd přiřazených k jednotlivým ekonomickým odvětvím také hodnoty k žádnému odvětví nepřiřazené. Ty jsem právě proto vyřadil.

**2. t_petr_urik_project_SQL_secondary_final**
- Obsahuje hodnoty HDP, GINI koeficientu a počet obyvatel evropských zemí pro období 2006-2018.
- SQL skript pro tuto tabulku se jmenuje *Project_04_script_tab_final_secondary*.
- zdroji dat byly tabulky *countries* a *economies*.

Obě tabulky jsem vytvořil a uložil v databázi Postgres, konkrétně v data_academy_content.
## Výzkumné úkoly
**Úkol č. 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**  
- SQL skript pro řešení: *Project_04_script_ukol_1*

**Řešení:**

a)  Obrázek ukazuje odvětví a roky, ve kterých tato odvětví měla záporný meziroční růst mezd, tedy pokles mezd:

<img width="635" height="614" alt="image" src="https://github.com/user-attachments/assets/19b2c15f-d6b5-4c7f-928c-5486efbe4397" />  

##
b) Pořadí odvětví podle četnosti záporných roků (roků s meziročním poklesem mezd): 

<img width="739" height="414" alt="image" src="https://github.com/user-attachments/assets/d603d355-a1a9-45a1-84b6-f48d3990a64d" />  

**Nejvíce záporných roků** (celekm 4) mělo odvětví **Těžba a dobývání**, u kterého došlo k poklesu mezd v letech 2009, 2013, 2014 a 2016.  

Dále pak **Kulturní, zábavní a rekreační činnosti** (2x, 2011 a 2013), **Profesní, vědecké a technické činnosti** (2x, 2010 a 2013), **Ubytování, stravování a pohostinství** (2x, 2009 a 2011), **Veřejná správa a obrana; povinné sociální zabezpečení** (2x, 2010 a 2011), **Výroba a rozvod elektřiny, plynu, tepla a klimat. vzduchu** (2x, 2013 a 2015).  

Zbývající obory z tabulky pak mají po jednom záporném roce.

##
c) Odvětví, která ve sledovaném období nezaznamenala žádný meziroční pokles mezd:  

<img width="277" height="145" alt="image" src="https://github.com/user-attachments/assets/62ea957c-6083-4677-9cc4-b08343d72862" />






##  
**Úkol č. 2:**
**Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**  
- SQL skript pro řešení: *Project_04_script_ukol_2*.

**Řešení:**

<img width="1031" height="143" alt="image" src="https://github.com/user-attachments/assets/f4ae2c76-3988-405e-9eb3-9edae0e6d0a3" />

Ze sloupce *koupeschopnost* je vidět, že na počátku sledovaného období, tedy v roce 2006, bylo možné si za průměrnou mzdu koupit **1287 kg chleba** nebo **1437 litrů mléka**. Na konci období, tedy v roce 2018, to pak bylo **1342 kg chleba** nebo **1641 litrů mléka**.  

Poznámka k zaokrouhlování:  
Sloupec *koupeschopnost* je zaokrouhlen dolů na nejbližší celé číslo, protože mléko se prodává v baleních po 1 litru. Podobně chléb je nejčastěji po 1 kilogramu.

##
**Úkol č. 3:**
**Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
- SQL skript pro řešení: *Project_04_script_ukol_3*.

**Řešení:**

<img width="1310" height="63" alt="image" src="https://github.com/user-attachments/assets/10674ce7-94cf-463e-98a6-31be55b8a23a" />

Za sledované období v letech 2006-2018 byl potravinou s nejmenším (dokonce záporným) růstem **cukr krystal**, jehož cena se celkově snížila o **27,51 %**.

##
**Úkol č. 4:**
**Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
- SQL skript pro řešení: *Project_04_script_ukol_4*.

**Řešení:**

<img width="1033" height="363" alt="image" src="https://github.com/user-attachments/assets/1c6f851b-9882-4d6e-b5c1-a7cd6a4d5169" />

Tabulka ukazuje, že ani v jednom sledovaném roce nebyl rozdíl růstu cen a mezd víc jak 10 %, tedy že **růst cen potravin nebyl v žádném roce výrazně vyšší než růst mezd**.  

Pro rok 2006 nejsou známy hodnoty, protože pro předchozí rok nabyla k dispozici data o cenách potravin.  

Poznámka k zaokrouhlování:  
Sloupce *celkova_zmena_ceny_percent* a *celkova_zmena_mzdy_percent* záměrně nejsou zaokrouhleny, protože při dalších výpočtech by vlivem zaokrouhlování mohly vzniknout nepřesnosti ve výsledcích. Zaokrouhlen je až sloupec *rozdil_cena_mzda*, protože vzniká po posledním výpočtu.

##
**Úkol č. 5:**
**Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**
- SQL skript pro řešení: *Project_04_script_ukol_5*.

**Řešení:**

<img width="974" height="360" alt="image" src="https://github.com/user-attachments/assets/61cdf922-0147-492a-a239-82a5e365c549" />

**a) HDP vs. mzdy**  
Mezi změnami HDP a růstem mezd existuje silná vazba, která se však projevuje s určitým zpožděním (půl roku až rok). Pokud HDP výrazněji naroste v jednom roce, mzdy dosahují maxima růstu často až v roce příštím. Například výraznější růst HDP v 2007 (+5,57 %) -> maximum růstu mezd až v 2008 (+7,87 %), podobně růst HDP v 2017 (+5,17 %) -> maximum růstu mezd v 2018 (+7,62 %). Částečná reakce je ale vidět už i ve stejném roce. Příčiny: Růst HDP = firmy více produkují -> na další produkci potřebují větší výkon nebo počet zaměstnanců -> růst mezd.  

**b) HDP vs. ceny potravin**  
Přestože i mezi růstem HDP a růstem cen zboží (inflací) existuje souvislost, tak konkrétně u cen potravin se mnohem více uplatňují jiné vlivy jako je počasí, daně (politická rozhodnutí) a situace na globálních trzích. Z tabulky je sice vidět náznak vlivu HDP v období 2007-2008 (HDP +5,57 % -> potraviny +6,76 % resp. 6,19 %), popřípadě propad v roce 2009 (HDP -4,66 % -> potraviny -6,42 %), později však pozorovatelná souvislost mizí a trendy jsou někdy dokonce i opačné (pokles HDP -> růst cen a naopak).  

Absence dat pro rok 2006 je opět způsobena tím, že se jedná o počáteční rok období a nejsou k dispozici hodnoty pro předešlý rok.







