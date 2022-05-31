library(tidyverse)
library(readxl)
library(countrycode)
library(dplyr)
library(ggplot2)

#kolumny: okresy czas
cena_gazu <- read_excel('dane/cena_gazu.xlsx')
cena_pradu <- read_excel('dane/cena_pradu.xlsx')
wynajem <- read_excel('dane/wynajem.xlsx')
wartosc_podatku <- read_excel('dane/wartosc_podatku.xlsx')
inflacja <- read_csv('dane/inflacja.csv')
zarobki_kob_euro <- read_excel('dane/zarobki_kob_euro.xlsx')
zarobki_mez_euro <- read_excel('dane/zarobki_mez_euro.xlsx')
Parytety_sily_nabywczej <- read_excel('dane/Parytety_sily_nabywczej.xlsx')
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

wynajem_1 <- wynajem[-1,1]
wynajem_2 <- sapply(wynajem[-1,-1],as.numeric)
wynajem <- cbind(wynajem_1, wynajem_2)

wartosc_podatku_1 <- wartosc_podatku[-1,1]
wartosc_podatku2_2 <- sapply(wartosc_podatku[-1,-1],as.numeric)
wartosc_podatku <- cbind(wartosc_podatku_1, wartosc_podatku2_2)

bilans_zuzycia_wody2_1 <- bilans_zuzycia_wody[-1,1]
bilans_zuzycia_wody2_2 <- sapply(bilans_zuzycia_wody[-1,-1],as.numeric)
bilans_zuzycia_wody <- cbind(bilans_zuzycia_wody2_1, bilans_zuzycia_wody2_2)



#prze organizowanie ramek danych
cena_gazu <- pivot_longer(cena_gazu,cols = !TIME, names_to = "okres_czasu", values_to = "cena_gazu")
cena_pradu <- pivot_longer(cena_pradu,cols = !TIME, names_to = "okres_czasu", values_to = "cena_pradu")
wynajem <- pivot_longer(wynajem,cols = !"GEO/TIME", names_to = "okres_czasu", values_to = "cena_wynajmu_a_miesiac")
wartosc_podatku <- pivot_longer(wartosc_podatku,cols = !TIME, names_to = "okres_czasu", values_to = "podatek_jako_%_dochodu")
inflacja <- pivot_longer(inflacja,cols = !geo, names_to = "okres_czasu", values_to = "inflacja_rok_do_roku")
zarobki_kob_euro <- pivot_longer(zarobki_kob_euro[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "średnie_roczne_zarobki_kobiet")
zarobki_mez_euro <- pivot_longer(zarobki_mez_euro[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "średnie_roczne_zarobki_mężczyzn")
Parytety_sily_nabywczej <- pivot_longer(Parytety_sily_nabywczej[-1,],cols = !TIME, names_to = "okres_czasu", values_to = "średnie_roczne_zarobki_mężczyzn")
bilans_zuzycia_wody <- pivot_longer(bilans_zuzycia_wody,cols = !TIME, names_to = "okres_czasu", values_to = "żuzecie_wody_w_mil._m^3")


#zamiana nazw nagłówków ramek danych
names(cena_gazu )[1] <- 'zakres_geograficzny'
names(cena_pradu )[1] <- 'zakres_geograficzny'
names(wynajem )[1] <- 'zakres_geograficzny'
names(wartosc_podatku )[1] <- 'zakres_geograficzny'
names(inflacja )[1] <- 'zakres_geograficzny'
names(zarobki_kob_euro )[1] <- 'zakres_geograficzny'
names(zarobki_mez_euro )[1] <- 'zakres_geograficzny'
names(Parytety_sily_nabywczej )[1] <- 'zakres_geograficzny'
names(bilans_zuzycia_wody )[1] <- 'zakres_geograficzny'
names(przewidywana_dlugosc_zycia )[length(przewidywana_dlugosc_zycia)]<- 'przewidywana_dlugosc_zycia'
names(edukajca_po_populacji )[length(edukajca_po_populacji)]<- 'edukajca'
names(konsumpcja_owoce_warzywa )[length(konsumpcja_owoce_warzywa)]<- 'konsumpcja_owoce_warzywa'
names(konsumpcja_owoce_warzywa )[5]<- 'geography'
names(konsumpcja_owoce_warzywa )[6]<- 'date'


#łączenie 1 ramki danych

#redukcja precyzji do danych rocznych


#Potrzebna lepsza nazwa!!!
dt_1 <- merge(cena_gazu,cena_pradu,by = c('zakres_geograficzny','okres_czasu'), all= TRUE)
dt_1$okres_czasu <- str_remove(dt_1$okres_czasu,"-S[12]")
dt_1 <- dt_1 %>%
  group_by(okres_czasu,zakres_geograficzny) %>%
  summarise(cena_gazu = mean(cena_gazu, na.rm = FALSE),
            cena_pradu = mean(cena_pradu, na.rm = FALSE))

dt_1 <- dt_1 %>%
  merge(  wynajem, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(wartosc_podatku, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(inflacja, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(zarobki_kob_euro, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(zarobki_mez_euro, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(Parytety_sily_nabywczej, by = c('zakres_geograficzny','okres_czasu'), all= TRUE) %>%
  merge(bilans_zuzycia_wody, by = c('zakres_geograficzny','okres_czasu'), all= TRUE)

#łączenie 2 ramki danych
konsumpcja_owoce_warzywa<-konsumpcja_owoce_warzywa %>%
  group_by(unit,n_portion,sex,age,country,time) %>%
  summarise(konsumpcja_owoce_warzywa = mean(konsumpcja_owoce_warzywa, na.rm = FALSE))
przewidywana_dlugosc_zycia[1,]
edukajca_po_populacji[1,]
konsumpcja_owoce_warzywa[1,]

#Potrzebna lepsza nazwa!!!
dt_2 <- merge(konsumpcja_owoce_warzywa[,-which(names(konsumpcja_owoce_warzywa) %in% c("unit","n_portion",'age'))],edukajca_po_populacji[,-which(names(edukajca_po_populacji) %in% c("unit","isced11",'age'))],by = c('geography','date','sex')) %>%
  merge(przewidywana_dlugosc_zycia[,-which(names(przewidywana_dlugosc_zycia) %in% c("unit","statinfo"))], by = c('geography','date','sex'))
dt_1
dt_2
#sprawdzanie typu danych
sapply(dt_1, mode)
sapply(dt_2, mode)
#wyklucza NA
dt_2_NA <- na.omit(dt_2)
dt_2_NA
dt_1_NA <- na.omit(dt_1)
dt_1_NA
####################################################
#wykres kraj/obszar a konsumpcja
data_dt2 <- dt_2_NA$geography
#wiem ze z dupy ta czesc ale inaczej nie chcialo dzialac xd
konsum <- summarise(dt_2_NA, konsumpcja = konsumpcja_owoce_warzywa)
df_wykres1 <- data.frame(data_dt2, konsum )
df_wykres1
test <- aggregate(konsumpcja ~ data_dt2, df_wykres1, mean)
wykres <- ggplot(test, aes(x = konsumpcja, y = data_dt2))
wykres <- wykres + geom_point(size = 3)
wykres + labs(x = "Konsumpcja", y = "Kraj lub obszar") 
#wykres zarobki
ZarobkiM <- dt_1_NA$średnie_roczne_zarobki_mężczyzn.x
ZarobkiK <- dt_1_NA$średnie_roczne_zarobki_kobiet
Kraj <- dt_1_NA$zakres_geograficzny
df_wykres2 <- data.frame(ZarobkiK, zarobkiM, Kraj)
df_wykres2
SrZarobkiM <- aggregate(ZarobkiM ~ Kraj, df_wykres2, mean) 
SrZarobkiK <- aggregate(ZarobkiK ~ Kraj, df_wykres2, mean)
SrZarobki <- cbind(SrZarobkiK, ZarM = SrZarobkiM$ZarobkiM)
#K
p6 <- ggplot(data = SrZarobki, mapping = aes(x = ZarobkiK, y = Kraj))
p6 + geom_col()
#M
wykres2 <- ggplot() +
  geom_col(data = SrZarobki, mapping = aes(x = ZarM, y =Kraj ), color = "white", fill = 'blue', position = "dodge")
wykres2
#Tu sie je polaczy gdzies
#wykres3 - edukacja a kraj
df3_NA <- na.omit(df_3)
df3_NA
panstwa2 <- dt_2$geography
edukacja2 <- dt_2$edukajca
df_3 <- data.frame(panstwa2, edukacja2)
df_3
srednia_edukacja <- group_by(df3_NA, panstwa2)
srednia_edukacja <- summarise(srednia_edukacja,
          srednia = mean(edukacja2))
srednia_edukacja <- srednia_edukacja[-c(11, 12), ]
srednia_edukacja
wykres3 <- ggplot(srednia_edukacja, aes(x = panstwa2, y = srednia)) +
  geom_col() +
  labs(x = "Państwa", y = "Średnia wartość wykształcenia")
wykres3
#TRZEBA OGARNĄĆ JEDNOSTKE TEGO
#wykres4 - inflacja

Kraj <- dt_1$zakres_geograficzny
Inflacja <- dt_1$inflacja_rok_do_roku
Rok <- dt_1$okres_czasu
df_4 <- data.frame(Kraj, Inflacja, Rok)  
df_4
df4_NA <- na.omit(df_4)
df4_NA  
Inflacja_w_panstwach <- group_by(df4_NA, Kraj)
Inflacja_w_panstwach <- summarise(Inflacja_w_panstwach,
                                  inflacja2 = mean(inflacja),
                                  summarise(Rok)
                                  )
Inflacja_w_panstwach <- Inflacja_w_panstwach[-c(97:168),]
Inflacja_w_panstwach
  wykres4 <- ggplot(Inflacja_w_panstwach, aes(x = Rok, y = Inflacja, color = Kraj)) +
 geom_point()
wykres4
#tu linia nie chce sie dodać, zobaczymy na labach
#####################################################


