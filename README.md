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
- zdroji dat byly tabulky *countries* a *economies*.

Obě tabulky jsem vytvořil a uložil v databázi Postgres, konkrétně v data_academy_content.
## Výzkumné úkoly
**Úkol č. 1:**  
**Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**  
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


Ze sloupce *koupeschopnost* je vidět, že na počátku sledovaného období, tedy v roce 2006, bylo možné si za průměrnou mzdu koupit **1287 kg chleba** a **1437 litrů mléka**. Na konci období, tedy v roce 2018 to pak bylo **1342 kg chleba** a **1641 litrů mléka**.




