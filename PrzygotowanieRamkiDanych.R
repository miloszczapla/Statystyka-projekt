library(tidyverse)
library(readxl)
library(countrycode)
library(dplyr)
library(ggplot2)

#TODO: brakuje jeszcze kilku danych jak np cena jedzenia
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
bilans_zuzycia_wody <- read_excel('dane/bilans_zuzycia_wody.xlsx')

#kolumny: płeć, kraj, okres czasu, wartość
konsumpcja_owoce_warzywa <- read_csv('dane/konsumpcja_owoce_warzywa.csv')
przewidywana_dlugosc_zycia <- read_csv('dane/przewidywana_dlugosc_zycia.csv')
edukajca_po_populacji <- read_csv('dane/edukajca_po_populacji.csv')

kurs_euro_dolar <- read_csv('dane/kurs_euro_dolar.csv')

bilans_energetyczny <- read_csv('dane/bilans_energetyczny.csv')
eksport_odpadow <- read_excel('dane/eksport_odpadow.xlsx')

#najpewniej nie będziemy z nich korzystać
#fundusze_europejskie <- read_csv('dane/fundusze_europejskie.csv')
#dochod <- read_csv('dane/dochod.csv')

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

bilans_zuzycia_wody2_1 <- bilans_zuzycia_wody[-1,1]
bilans_zuzycia_wody2_2 <- sapply(bilans_zuzycia_wody[-1,-1],as.numeric)
bilans_zuzycia_wody <- cbind(bilans_zuzycia_wody2_1, bilans_zuzycia_wody2_2)



#prze organizowanie ramek danych
cena_gazu <- pivot_longer(cena_gazu,cols = !TIME, names_to = "okres_czasu", values_to = "cena_gazu")
cena_pradu <- pivot_longer(cena_pradu,cols = !TIME, names_to = "okres_czasu", values_to = "cena_pradu")
wartosc_podatku <- pivot_longer(wartosc_podatku,cols = !TIME, names_to = "okres_czasu", values_to = "podatek_jako_%_dochodu")
inflacja <- pivot_longer(inflacja,cols = !geo, names_to = "okres_czasu", values_to = "inflacja_rok_do_roku")
zarobki_kob_euro <- pivot_longer(zarobki_kob_euro[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "średnie_roczne_zarobki_kobiet")
zarobki_mez_euro <- pivot_longer(zarobki_mez_euro[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "średnie_roczne_zarobki_mężczyzn")
parytety_sily_nabywczej <- pivot_longer(parytety_sily_nabywczej[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "parytety_sily_nabywczej")
bilans_zuzycia_wody <- pivot_longer(bilans_zuzycia_wody,cols = !TIME, names_to = "okres_czasu", values_to = "żuzecie_wody_w_mil._m^3")
ceny_nowych_mieszkan <- pivot_longer(ceny_nowych_mieszkan,cols = !TIME, names_to = "okres_czasu", values_to = "ceny_nowych_mieszkan")
ceny_uzywanych_mieszkan <- pivot_longer(ceny_uzywanych_mieszkan,cols = !TIME, names_to = "okres_czasu", values_to = "ceny_uzywanych_mieszkan")



#zamiana nazw nagłówków ramek danych
names(cena_gazu )[1] <- 'zakres_geograficzny'
names(cena_pradu )[1] <- 'zakres_geograficzny'
names(wartosc_podatku )[1] <- 'zakres_geograficzny'
names(inflacja )[1] <- 'zakres_geograficzny'
names(zarobki_kob_euro )[1] <- 'zakres_geograficzny'
names(zarobki_mez_euro )[1] <- 'zakres_geograficzny'
names(parytety_sily_nabywczej )[1] <- 'zakres_geograficzny'
names(bilans_zuzycia_wody )[1] <- 'zakres_geograficzny'
names(ceny_nowych_mieszkan )[1] <- 'zakres_geograficzny'
names(ceny_uzywanych_mieszkan )[1] <- 'zakres_geograficzny'
names(przewidywana_dlugosc_zycia )[length(przewidywana_dlugosc_zycia)]<- 'przewidywana_dlugosc_zycia'
names(edukajca_po_populacji )[length(edukajca_po_populacji)]<- 'edukajca'
names(konsumpcja_owoce_warzywa )[length(konsumpcja_owoce_warzywa)]<- 'konsumpcja_owoce_warzywa'
names(konsumpcja_owoce_warzywa )[5]<- 'geography'
names(konsumpcja_owoce_warzywa )[6]<- 'date'


#łączenie pierwszej ramki danych

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
  merge(bilans_zuzycia_wody, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(ceny_nowych_mieszkan, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(ceny_uzywanych_mieszkan, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  mutate(sr_zarobki = round(średnie_roczne_zarobki_kobiet+średnie_roczne_zarobki_mężczyzn)/2) %>%
na.omit()


#łączenie drugiej ramki danych
konsumpcja_owoce_warzywa<-konsumpcja_owoce_warzywa %>%
  group_by(unit,n_portion,sex,age,geography,date) %>%
  summarise(konsumpcja_owoce_warzywa = mean(konsumpcja_owoce_warzywa, na.rm = FALSE))

ramka_co_piec_lat <- merge(konsumpcja_owoce_warzywa[,-which(names(konsumpcja_owoce_warzywa) %in% c("unit","n_portion",'age'))],edukajca_po_populacji[,-which(names(edukajca_po_populacji) %in% c("unit","isced11",'age'))],by = c('geography','date','sex')) %>%
  merge(przewidywana_dlugosc_zycia[,-which(names(przewidywana_dlugosc_zycia) %in% c("unit","statinfo"))], by = c('geography','date','sex')) %>%
  na.omit()

ramka_co_piec_lat <- ramka_co_piec_lat %>%
  group_by(geography,date,sex) %>%
  summarise(konsumpcja_owoce_warzywa = round(mean(konsumpcja_owoce_warzywa)),
  edukajca = round(mean(edukajca)),
  przewidywana_dlugosc_zycia = round(mean(przewidywana_dlugosc_zycia)))
ramka_co_piec_lat <- ramka_co_piec_lat[-which(ramka_co_piec_lat$geography %in% c('EU27_2020','EU28')),] 

ramka_co_piec_lat$geography <-countrycode(ramka_co_piec_lat$geography,origin = 'eurostat',destination = 'country.name')

#eksport ramkkek danych
write_excel_csv2(ramka_rok_do_roku_zmienne, "parsed_dane/ramka_rok_do_roku_zmienne.csv")
write_excel_csv2(ramka_co_piec_lat, "parsed_dane/ramka_co_piec_lat.csv")


