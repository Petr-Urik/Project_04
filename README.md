# Project_04: Vývoj mezd a cen potravin v ČR
Čtvrtý projekt rámci Engeto: Datová akademie s Pythonem
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

Obě tabulky jsem vytvořil a uložil v databázi Postgres, konkrétně v data_academy_content.
## Výzkumné úkoly
**Úkol č. 1:**  
**Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**  
- SQL skript pro řešení: *Project_04_script_ukol_1*
- 
