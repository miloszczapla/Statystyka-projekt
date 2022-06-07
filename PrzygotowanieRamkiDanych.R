library(tidyverse)
library(readxl)
library(countrycode)
library(dplyr)
library(ggplot2)

#kolumny: okresy czas
cena_gazu <- read_excel('dane/cena_gazu.xlsx')
cena_pradu <- read_excel('dane/cena_pradu.xlsx')
ceny_nowych_mieszkan <- read_excel('dane/ceny_nowych_mieszkan.xlsx')
ceny_uzywanych_mieszkan <- read_excel('dane/ceny_uzywanych_mieszkan.xlsx')
wartosc_podatku <- read_excel('dane/wartosc_podatku.xlsx')
inflacja <- read_csv('dane/inflacja.csv')
zarobki_kob_euro <- read_excel('dane/zarobki_kob_euro.xlsx')
zarobki_mez_euro <- read_excel('dane/zarobki_mez_euro.xlsx')
parytety_sily_nabywczej <- read_excel('dane/parytety_sily_nabywczej.xlsx')
ceny_mil_euro <- read_excel('dane/ceny_mil_euro.xlsx')
populacja_w_europie <- read_excel('dane/populacja_w_europie.xlsx')



#zmiana typów danych tam gdzie jest to potrzebne
cena_gazu_1 <- cena_gazu[-1,1]
cena_gazu_2 <- sapply(cena_gazu[-1,-1],as.numeric)
cena_gazu <- cbind(cena_gazu_1, cena_gazu_2)

cena_pradu_1 <- cena_pradu[-1,1]
cena_pradu_2 <- sapply(cena_pradu[-1,-1],as.numeric)
cena_pradu <- cbind(cena_pradu_1, cena_pradu_2)

zarobki_kob_euro_1 <- zarobki_kob_euro[-1,1]
zarobki_kob_euro_2 <- sapply(zarobki_kob_euro[-1,-1],as.numeric)
zarobki_kob_euro <- cbind(zarobki_kob_euro_1, zarobki_kob_euro_2)

zarobki_mez_euro_1 <- zarobki_mez_euro[-1,1]
zarobki_mez_euro_2 <- sapply(zarobki_mez_euro[-1,-1],as.numeric)
zarobki_mez_euro <- cbind(zarobki_mez_euro_1, zarobki_mez_euro_2)

ceny_nowych_mieszkan_1 <- ceny_nowych_mieszkan[-1,1]
ceny_nowych_mieszkan_2 <- sapply(ceny_nowych_mieszkan[-1,-1],as.numeric)
ceny_nowych_mieszkan <- cbind(ceny_nowych_mieszkan_1, ceny_nowych_mieszkan_2)

ceny_uzywanych_mieszkan_1 <- ceny_uzywanych_mieszkan[-1,1]
ceny_uzywanych_mieszkan_2 <- sapply(ceny_uzywanych_mieszkan[-1,-1],as.numeric)
ceny_uzywanych_mieszkan <- cbind(ceny_uzywanych_mieszkan_1, ceny_uzywanych_mieszkan_2)

wartosc_podatku_1 <- wartosc_podatku[-1,1]
wartosc_podatku2_2 <- sapply(wartosc_podatku[-1,-1],as.numeric)
wartosc_podatku <- cbind(wartosc_podatku_1, wartosc_podatku2_2)

populacja_w_europie_1 <- populacja_w_europie[-1,1]
populacja_w_europie_2 <- sapply(populacja_w_europie[-1,-1],as.numeric)
populacja_w_europie <- cbind(populacja_w_europie_1, populacja_w_europie_2)

#prze organizowanie ramek danych
cena_gazu <- pivot_longer(cena_gazu,cols = !TIME, names_to = "okres_czasu", values_to = "cena_gazu")
cena_pradu <- pivot_longer(cena_pradu,cols = !TIME, names_to = "okres_czasu", values_to = "cena_pradu")
wartosc_podatku <- pivot_longer(wartosc_podatku,cols = !TIME, names_to = "okres_czasu", values_to = "podatek_jako_%_dochodu")
inflacja <- pivot_longer(inflacja,cols = !geo, names_to = "okres_czasu", values_to = "inflacja_rok_do_roku")
zarobki_kob_euro <- pivot_longer(zarobki_kob_euro[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "średnie_roczne_zarobki_kobiet")
zarobki_mez_euro <- pivot_longer(zarobki_mez_euro[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "średnie_roczne_zarobki_mężczyzn")
parytety_sily_nabywczej <- pivot_longer(parytety_sily_nabywczej[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "parytety_sily_nabywczej")
ceny_nowych_mieszkan <- pivot_longer(ceny_nowych_mieszkan,cols = !TIME, names_to = "okres_czasu", values_to = "ceny_nowych_mieszkan")
ceny_uzywanych_mieszkan <- pivot_longer(ceny_uzywanych_mieszkan,cols = !TIME, names_to = "okres_czasu", values_to = "ceny_uzywanych_mieszkan")
populacja_w_europie <- pivot_longer(populacja_w_europie,cols = !TIME, names_to = "okres_czasu", values_to = "populacja_w_europie")








#zamiana nazw nagłówków ramek danych
names(cena_gazu )[1] <- 'zakres_geograficzny'
names(cena_pradu )[1] <- 'zakres_geograficzny'
names(wartosc_podatku )[1] <- 'zakres_geograficzny'
names(inflacja )[1] <- 'zakres_geograficzny'
names(zarobki_kob_euro )[1] <- 'zakres_geograficzny'
names(zarobki_mez_euro )[1] <- 'zakres_geograficzny'
names(parytety_sily_nabywczej )[1] <- 'zakres_geograficzny'
names(ceny_nowych_mieszkan )[1] <- 'zakres_geograficzny'
names(ceny_uzywanych_mieszkan )[1] <- 'zakres_geograficzny'
names(populacja_w_europie )[1] <- 'zakres_geograficzny'






#usuwanie zbędnych krajów, rejonów

ceny_mil_euro <- ceny_mil_euro[-which(ceny_mil_euro$zakres_geograficzny %in% c('European Union - 28 countries (2013-2020)','European Union - 15 countries (1995-2004)','Euro area (EA11-1999, EA12-2001, EA13-2007, EA15-2008, EA16-2009, EA17-2011, EA18-2014, EA19-2015)','Euro area - 19 countries  (from 2015)','Euro area - 19 countries  (from 2015)','Euro area - 19 countries  (from 2015)')),] 
populacja_w_europie <- populacja_w_europie[-which(populacja_w_europie$zakres_geograficzny %in% c('European Union - 27 countries (from 2020)','European Union - 28 countries (2013-2020)','Euro area - 19 countries  (from 2015)','Euro area - 18 countries (2014)','Germany (until 1990 former territory of the FRG)')),] 
#łączenie pierwszej ramki danych


ceny_mil_euro <- ceny_mil_euro %>%
  merge(populacja_w_europie, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  filter_all(all_vars(. != ':')) %>%
  na.omit()


for ( naglowek in names(ceny_mil_euro)[-c(1,2)]) {
  ceny_mil_euro[,naglowek] <- as.numeric(ceny_mil_euro[,naglowek]) / (ceny_mil_euro$populacja_w_europie /1000000) #ponieważ wartości są w milionach EURO to dzielimy przez 1000000
}
  

ramka_rok_do_roku_zmienne <- merge(cena_gazu,cena_pradu,by = c('zakres_geograficzny','okres_czasu'), all= TRUE)
ramka_rok_do_roku_zmienne$okres_czasu <- str_remove(ramka_rok_do_roku_zmienne$okres_czasu,"-S[12]")
ramka_rok_do_roku_zmienne <- ramka_rok_do_roku_zmienne %>%
  group_by(okres_czasu,zakres_geograficzny) %>%
  summarise(cena_gazu = mean(cena_gazu, na.rm = FALSE),
            cena_pradu = mean(cena_pradu, na.rm = FALSE))



ramka_rok_do_roku_zmienne <- ramka_rok_do_roku_zmienne %>%
  merge(wartosc_podatku, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(inflacja, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(zarobki_kob_euro, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(zarobki_mez_euro, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(parytety_sily_nabywczej, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(ceny_nowych_mieszkan, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(ceny_uzywanych_mieszkan, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(populacja_w_europie, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(ceny_mil_euro, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  mutate(sr_zarobki = round(średnie_roczne_zarobki_kobiet+średnie_roczne_zarobki_mężczyzn)/2) %>%
  na.omit()




write_excel_csv2(ramka_rok_do_roku_zmienne, "parsed_dane/ramka_rok_do_roku_zmienne.csv")



