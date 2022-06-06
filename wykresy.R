  source("PrzygotowanieRamkiDanych.R", encoding = "UTF-8")
wykres_zarobki <- ggplot(data = dt_1_zarobki, mapping = aes(x = okres_czasu, y = zarobki, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line(size = 1)%>%
  + scale_y_continuous(breaks = seq(2000, 38000,2000))
#sprawdzić czy co względem polski? Jeśli małe wachania to uśrenienie? maksima minima?
wyykres_cena_gazu <- ggplot(dt_1, aes(x=okres_czasu,y = cena_gazu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()
wyykres_cena_pradu <- ggplot(dt_1, aes(x=okres_czasu,y = cena_pradu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()
wykres_podatki <- ggplot(dt_1, aes(x=okres_czasu,y = `podatek_jako_%_dochodu`, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  + scale_y_continuous(breaks = seq(4, 36,2))
wykres_cany_wynajmu <- ggplot(dt_1, aes(x=okres_czasu,y = cena_wynajmu_za_miesiac, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()
### różnica pomiędzy zarobkami mężczyzn a kobiet
#nie wiem czy to jest warte dla 
wyjres_rozn_kob_men <- ggplot(dt_1_zarobki, mapping = aes(x = okres_czasu, y = roznica_zar_men_kob, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line()
####################################################
#wykres kraj/obszar a konsumpcja
data_dt2 <- dt_2$geography
#wiem ze z dupy ta czesc ale inaczej nie chcialo dzialac xd
konsum <- summarise(dt_2, konsumpcja = konsumpcja_owoce_warzywa)
df_wykres1 <- data.frame(data_dt2, konsum )
df_wykres1
test <- aggregate(konsumpcja ~ data_dt2, df_wykres1, mean)
wykres <- ggplot(test, aes(x = konsumpcja, y = data_dt2))
wykres <- wykres + geom_point(size = 3)
wykres + labs(x = "Konsumpcja", y = "Kraj lub obszar") 
#wykres zarobki
ZarobkiM <- dt_1$średnie_roczne_zarobki_mężczyzn
ZarobkiK <- dt_1$średnie_roczne_zarobki_kobiet
Kraj <- dt_1$zakres_geograficzny
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
Inflacja_w_panstwach <- data.frame(Kraj, Inflacja, Rok) %>%
  na.omit()
wykres4 <- ggplot(Inflacja_w_panstwach, aes(x = Rok, y = Inflacja, color = Kraj, group= Kraj)) %>%
  #+geom_point() %>% 
  # +geom_point(data = Inflacja_w_panstwach[which.max(Inflacja_w_panstwach$Inflacja)],color ='RED') %>% 
 +geom_point() %>% 
 +geom_line()
wykres4
#Wykres 3_2 - Wyksztalcenie a edukacja |||IMO NIE POTRZEBNE!!!||| Nie wiemy jaka jednostka i jak to jest mierzone
Wlochy <- filter(srednia_edukacja, panstwa2 == "Italy")
Slowacja <- filter(srednia_edukacja, panstwa2 == "Slovakia")
Czechy5 <- filter(srednia_edukacja, panstwa2 == "Czechia")
PolskaTlo7 <- filter(srednia_edukacja, panstwa2 == "Poland")%>%
  rbind(Wlochy)%>%
  rbind(Czechy5)%>%
  rbind(Slowacja)
PolskaTlo7
PolskaTloEdukacja <- ggplot(PolskaTlo7, aes(x = panstwa2, y = srednia)) +
  geom_col() +
  labs(x = "Państwa", y = "Średnia wartość wykształcenia")
PolskaTloEdukacja
#Polska na tle Chorwacji(Bo srednio najnizej), Turcji(Bo najwyzej), i Czech(Bo podobna kultura)
#Nowe tabele tworze po to, by mozna bylo porownac zaleznosci w tabeli na dany rok, moze sie przyda
#Jak nie to moge to zedytowac by pobieralo prosto z dt_1
Turcja <- filter(Inflacja_w_panstwach, Kraj == "Turkey")
Chorwacja <- filter(Inflacja_w_panstwach, Kraj == "Croatia")
Czechy <- filter(Inflacja_w_panstwach, Kraj == "Czechia")
PolskaTlo1 <- filter(Inflacja_w_panstwach, Kraj == "Poland") %>%
  rbind(Turcja)%>%
  rbind(Chorwacja)%>%
  rbind(Czechy)
PolskaTlo1
PolskaTloInflacja <- ggplot(PolskaTlo1, aes(x = Rok, y = Inflacja, color = Kraj, group= Kraj)) %>%
  +geom_point() %>% 
  +geom_line() %>%
  +labs(x = "Lata", y = "Inflacja (%)")
PolskaTloInflacja
###############################################################################################
#Tu sie je polaczy gdzies
#####################################################
#ZAROBKI (ROCZNE W EURO?????)
wykres_zarobki
Luksemburg <-  filter(dt_1_zarobki, zakres_geograficzny == "Luxembourg")
Czechy2 <-  filter(dt_1_zarobki, zakres_geograficzny == "Czechia")
Rumunia <-  filter(dt_1_zarobki, zakres_geograficzny == "Romania")
PolskaTlo2 <-  filter(dt_1_zarobki, zakres_geograficzny == "Poland") %>%
  rbind(Luksemburg)%>%
  rbind(Czechy2)%>%
  rbind(Rumunia)
PolskaTlo2
PolskaTloZarobki <- ggplot(data = PolskaTlo2, mapping = aes(x = okres_czasu, y = zarobki, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line(size = 1) %>%
  + scale_y_continuous(breaks = seq(2000, 38000,2000)) %>%
  + labs(x = "Lata", y = "Średnie zarobki w euro")
PolskaTloZarobki
#
wyykres_cena_gazu
Rumunia2 <- filter(dt_1, zakres_geograficzny == "Romania")
Hiszpania <- filter(dt_1, zakres_geograficzny == "Spain")
Czechy3 <- filter(dt_1, zakres_geograficzny == "Czechia")
PolskaTlo3 <- filter(dt_1, zakres_geograficzny == "Poland") %>%
  rbind(Rumunia2)%>%
  rbind(Hiszpania)%>%
  rbind(Czechy3)
PolskaTlo3
PolskaTloGaz <- ggplot(PolskaTlo3, aes(x=okres_czasu,y = cena_gazu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  +labs(x = "Lata", y = "Cena gazu w KW/h")
PolskaTloGaz
#
wyykres_cena_pradu
Bulgaria <- filter(dt_1, zakres_geograficzny == "Bulgaria")
Hiszpania <- filter(dt_1, zakres_geograficzny == "Spain")
PolskaTlo4 <- filter(dt_1, zakres_geograficzny == "Poland") %>%
  rbind(Bulgaria)%>%
  rbind(Hiszpania)%>%
  rbind(Czechy3)
PolskaTlo4
PolskaTloPrad <- ggplot(PolskaTlo4, aes(x=okres_czasu,y = cena_pradu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  +labs(x = "Lata", y = "Cena prądu w KW/h")
PolskaTloPrad
#
wykres_podatki
Wegry <- filter(dt_1, zakres_geograficzny == "Hungary")
Estonia <- filter(dt_1, zakres_geograficzny == "Estonia")
PolskaTlo5 <- filter(dt_1, zakres_geograficzny == "Poland")%>%
  rbind(Wegry)%>%
  rbind(Estonia)%>%
  rbind(Rumunia2)%>%
  rbind(Czechy3)
PolskaTlo5
PolskaTloPodatki <- ggplot(PolskaTlo5, aes(x=okres_czasu,y = `podatek_jako_%_dochodu`, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  + scale_y_continuous(breaks = seq(4, 36,2)) %>%
  +labs(x = "Lata", y = "Podatek (% dochodów)")
PolskaTloPodatki
#
wykres_cany_wynajmu
Turcja2 <- filter(dt_1, zakres_geograficzny == "Turkey")
Hiszpania <- filter(dt_1, zakres_geograficzny == "Spain")
PolskaTlo6 <- filter(dt_1, zakres_geograficzny == "Poland")%>%
  rbind(Turcja2)%>%
  rbind(Czechy3)%>%
  rbind(Hiszpania)
PolskaTlo6
PolskaTloWynajem <- ggplot(PolskaTlo6, aes(x=okres_czasu,y = cena_wynajmu_za_miesiac, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  +labs(x = "Cena wynajmu za miesiąc", y = "Lata")
PolskaTloWynajem
#
Belgia <- filter(dt_1_zarobki, zakres_geograficzny == "Belgium")
Rumunia <- filter(dt_1_zarobki, zakres_geograficzny == "Romania")
Dania <- filter(dt_1_zarobki, zakres_geograficzny == "Denmark")
Holandia <- filter(dt_1_zarobki, zakres_geograficzny == "Netherlands")
PolskaTlo8  <- filter(dt_1_zarobki, zakres_geograficzny == "Poland") %>%
  rbind(Belgia)%>%
  rbind(Dania)%>%
  rbind(Czechy2)%>%
  rbind(Rumunia)%>%
  rbind(Holandia)
PolskaTlo8
PolskaRoznicaZar <- ggplot(PolskaTlo8, mapping = aes(x = okres_czasu, y = roznica_zar_men_kob, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line() %>%
  + labs(x = "Lata", y = "Różnica w zarobkach kobiet a mężczyzn")
PolskaRoznicaZar
wyjres_rozn_kob_men
#
