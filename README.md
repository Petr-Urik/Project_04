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

<img width="458" height="415" alt="image" src="https://github.com/user-attachments/assets/9e8c1c72-7f72-494e-8fcf-1f173656127a" />  
<img width="225" height="137" alt="image" src="https://github.com/user-attachments/assets/c8607f4c-f94a-4353-aa30-bffa95e3e28d" />  

##  
**Úkol č. 2:**
**Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**  
- SQL skript pro řešení: *Project_04_script_ukol_2*.

**Řešení:**

<img width="984" height="135" alt="image" src="https://github.com/user-attachments/assets/b48c6167-f763-4e47-b102-b97841488c8f" />

Ze sloupce *koupeschopnost* je vidět, že na počátku sledovaného období, tedy v roce 2006, bylo možné si za průměrnou mzdu koupit **1287 kg chleba** a **1437 litrů mléka**. Na konci období, tedy v roce 2018, to pak bylo **1342 kg chleba** a **1641 litrů mléka**.

##
**Úkol č. 3:**
**Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
- SQL skript pro řešení: *Project_04_script_ukol_3*.

**Řešení:**

<img width="420" height="62" alt="image" src="https://github.com/user-attachments/assets/b7741f15-b17d-4641-abcc-6e245993565a" />  

Za sledované období v letech 2006-2018 byl potravinou s nejmenším (dokonce záporným) růstem **cukr krystal**, jehož cena se celkově snížila o **27,51 %**.

##
**Úkol č. 4:**
**Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
- SQL skript pro řešení: *Project_04_script_ukol_4*.

**Řešení:**

<img width="902" height="361" alt="image" src="https://github.com/user-attachments/assets/0ec8c59a-d836-4564-85f3-c0f693d94e59" />  

Tabulka ukazuje, že ani v jednom sledovaném roce nebyl rozdíl růstu cen a mezd víc jak 10 %, tedy že **růst cen potravin nebyl v žádném roce výrazně vyšší než růst mezd**.  

Pro rok 2006 nejsou známy hodnoty, protože pro předchozí rok nabyla k dispozici data o cenách potravin.  

##
**Úkol č. 5:**
**Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**
- SQL skript pro řešení: *Project_04_script_ukol_5*.

**Řešení:**

<img width="925" height="360" alt="image" src="https://github.com/user-attachments/assets/c051aa7f-9146-4a2c-ab95-3c071fa73c60" />  

**a) HDP vs. mzdy**  
Mezi změnami HDP a růstem mezd existuje silná vazba, která se však projevuje s určitým zpožděním (půl roku až rok). Pokud HDP výrazněji naroste v jednom roce, mzdy dosahují maxima růstu často až v roce příštím (např. výraznější růst HDP v 2007 -> maximum růstu mezd až v 2008, podobně růst HDP v 2017 -> maximum růstu mezd v 2018). Částečná reakce je ale vidět už i ve stejném roce. Příčiny: Růst HDP = firmy více produkují -> na další produkci potřebují větší výkon nebo počet zaměstnanců -> růst mezd.  

**b) HDP vs. ceny potravin**  
Přestože i mezi růstem HDP a růstem cen (inflací) existuje souvislost, konkrétně u cen potravin se mnohem více uplatňují jiné vlivy jako je počasí, daně (politická rozhodnutí) a situace na globálních trzích. Z tabulky je sice vidět náznak vlivu HDP v období 2007-2008, později však pozorovatelná souvislost mizí.  

Absence dat pro rok 2006 je opět způsobena tím, že se jedná o počáteční rok období a nejsou k dispozici hodnoty pro předešlý rok.







