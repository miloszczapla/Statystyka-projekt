library(tidyverse)
library(readxl)

zarobki_kob_euro <- read_excel('dane/zarobki_kob_euro.xlsx'  )
zarobki_mez_euro <- read_excel('dane/zarobki_mez_euro.xlsx')
cena_gazu <- read_excel('dane/cena_gazu.xlsx')
cena_pradu <- read_excel('dane/cena_pradu.xlsx')
wynajem <- read_excel('dane/wynajem.xlsx')
wartosc_podatku <- read_excel('dane/wartosc_podatku.xlsx')
konsumpcja_owoce_warzywa <- read_csv('dane/konsumpcja_owoce_warzywa.csv')

przewidywana_dlugosc_zycia <- read_csv('dane/przewidywana_dlugosc_zycia.csv')
edukajca_po_populacji <- read_csv('dane/edukajca_po_populacji.csv')
Parytety_sily_nabywczej <- read_excel('dane/Parytety_sily_nabywczej.xlsx')

inflacja <- read_csv('dane/inflacja.csv')
fundusze_europejskie <- read_csv('dane/fundusze_europejskie.csv')
kurs_euro_dolar <- read_csv('dane/kurs_euro_dolar.csv')
eksport_odpadow <- read_excel('dane/eksport_odpadow.xlsx')
bilans_zuzycia_wody <- read_excel('dane/bilans_zuzycia_wody.xlsx')
bilans_energetyczny <- read_csv('dane/bilans_energetyczny.csv')
dochod <- read_csv('dane/dochod.csv')

#CENA GAZU
#doprowadzenie, by cala tabela byla widoczna
cena_gazu_1 <- cena_gazu[-1,1]
cena_gazu_2 <- sapply(cena_gazu[-1,-1],as.numeric)
cena_gazu <- cbind(cena_gazu_1, cena_gazu_2)
cena_gazu
#CENA PRADU
cena_pradu_1 <- cena_pradu[-1,1]
cena_pradu_2 <- sapply(cena_pradu[-1,-1],as.numeric)
cena_pradu <- cbind(cena_pradu_1, cena_pradu_2)
cena_pradu
#wynajem
wynajem_1 <- wynajem[-1,1]
wynajem_2 <- sapply(wynajem[-1,-1],as.numeric)
wynajem <- cbind(wynajem_1, wynajem_2)
wynajem
#wartosc podatku
wartosc_podatku_1 <- wartosc_podatku[-1,1]
wartosc_podatku2_2 <- sapply(wartosc_podatku[-1,-1],as.numeric)
wartosc_podatku <- cbind(wartosc_podatku_1, wartosc_podatku2_2)
wartosc_podatku
#przewidywana dlugosc zycia
przewidywana_dlugosc_zycia
#populacja/poziom wykształcenia
edukajca_po_populacji
#parytet sily nabywczej
Parytety_sily_nabywczej
#inflacja
inflacja
#fundusze europejskie
fundusze_europejskie
#euro i dolar
kurs_euro_dolar
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
