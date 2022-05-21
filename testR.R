library(tidyverse)
library(readxl)

ZarobkiKobEuro <- read_excel('dane/ZarobkiKobEuro.xlsx'  )
ZarobkiMezczEuro <- read_excel('dane/ZarobkiMezczEuro.xlsx')
Cena_gazu_popr <- read_excel('dane/Cena_gazu_popr.xlsx')
Cena_pradu <- read_excel('dane/Cena_pradu.xlsx')
wynajem <- read_excel('dane/wynajem.xlsx')
wartosc_podatku <- read_excel('dane/wartosc_podatku.xlsx')
IT_zarobki_2019 <- read_csv('dane/IT_salary_2019.csv')
przewidywana_dlugosc_zycia <- read_csv('dane/przewidywana_dlugosc_zycia.csv')
population_by_education_level <- read_csv('dane/population_by_education_level.csv')
Parytety_sily_nabywczej <- read_excel('dane/Parytety_sily_nabywczej.xlsx')
IT_zarobki_2018 <- read_csv('dane/IT_zarobki_2018.csv')
IT_zarobki_2020 <- read_csv('dane/IT_zarobki_2020.csv')
inflacja <- read_csv('dane/inflacja.csv')
fundusze_europejskie <- read_csv('dane/European_funds.csv')
euro_dolar <- read_csv('dane/euro_dolar.csv')
eksport_odpadow <- read_excel('dane/eksport_odpadow.xlsx')
konsumpcja_owoce_warzywa <- read_csv('dane/daily_consumption_fruit_vegetables_eu.csv')
bilans_zuzycia_wody <- read_excel('dane/bilans_zuzycia_wody_mln_m^3.xlsx')
bilans_energetyczny <- read_csv('dane/bilans_energetyczny.csv')
dochod <- read_csv('dane/basic_income_dataset_dalia.csv')
#CENA GAZU
#doprowadzenie, by cala tabela byla widoczna
Cena_gazu_popr2_1 <- Cena_gazu_popr[-1,1]
Cena_gazu_popr2_2 <- sapply(Cena_gazu_popr[-1,-1],as.numeric)
Cena_gazu_popr <- cbind(Cena_gazu_popr2_1, Cena_gazu_popr2_2)
Cena_gazu_popr
#CENA PRADU
Cena_pradu2_1 <- Cena_pradu[-1,1]
Cena_pradu2_2 <- sapply(Cena_pradu[-1,-1],as.numeric)
Cena_pradu <- cbind(Cena_pradu2_1, Cena_pradu2_2)
Cena_pradu
#wynajem
wynajem2_1 <- wynajem[-1,1]
wynajem2_2 <- sapply(wynajem[-1,-1],as.numeric)
wynajem <- cbind(wynajem2_1, wynajem2_2)
wynajem
#wartosc podatku
wartosc_podatku2_1 <- wartosc_podatku[-1,1]
wartosc_podatku2_2 <- sapply(wartosc_podatku[-1,-1],as.numeric)
wartosc_podatku <- cbind(wartosc_podatku2_1, wartosc_podatku2_2)
wartosc_podatku
#IT zarobki 2018
IT_zarobki_2018
#IT zarobki 2019
IT_zarobki_2019
#IT zarobki 2020
IT_zarobki_2020
#przewidywana dlugosc zycia
przewidywana_dlugosc_zycia
#populacja/poziom wykształcenia
population_by_education_level
#parytet sily nabywczej
Parytety_sily_nabywczej
#inflacja
inflacja
#fundusze europejskie
fundusze_europejskie
#euro i dolar
euro_dolar
#eksport odpadow
eksport_odpadow
#dzienna konsumpcja owocow i warzyw
konsumpcja_owoce_warzywa
#bilans zuzycia wody w mln^3
bilans_zuzycia_wody2_1 <- bilans_zuzycia_wody[-1,1]
bilans_zuzycia_wody2_2 <- sapply(bilans_zuzycia_wody[-1,-1],as.numeric)
bilans_zuzycia_wody <- cbind(bilans_zuzycia_wody2_1, bilans_zuzycia_wody2_2)
bilans_zuzycia_wody
#bilans energetyczny
bilans_energetyczny
#dochod ankieta
dochod
