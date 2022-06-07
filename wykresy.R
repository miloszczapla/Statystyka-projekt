  source("PrzygotowanieRamkiDanych.R", encoding = "UTF-8")
wykres_zarobki <- ggplot(data = ramka_rok_do_roku_zarobki, mapping = aes(x = okres_czasu, y = zarobki, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line(size = 1)%>%
  + scale_y_continuous(breaks = seq(2000, 38000,2000))
#sprawdzić czy co względem polski? Jeśli małe wachania to uśrenienie? maksima minima?

wyykres_cena_gazu <- ggplot(ramka_rok_do_roku_zmienne, aes(x=okres_czasu,y = cena_gazu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()

wyykres_cena_pradu <- ggplot(ramka_rok_do_roku_zmienne, aes(x=okres_czasu,y = cena_pradu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()

wykres_podatki <- ggplot(ramka_rok_do_roku_zmienne, aes(x=okres_czasu,y = `podatek_jako_%_dochodu`, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  + scale_y_continuous(breaks = seq(4, 36,2))

wykres_cany_wynajmu <- ggplot(ramka_rok_do_roku_zmienne, aes(x=okres_czasu,y = cena_wynajmu_za_miesiac, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()

### różnica pomiędzy zarobkami mężczyzn a kobiet
#nie wiem czy to jest warte dla 
wyjres_rozn_kob_men <- ggplot(ramka_rok_do_roku_zarobki, mapping = aes(x = okres_czasu, y = roznica_zar_men_kob, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line()
####################################################
#wykres kraj/obszar a konsumpcja
Kraj <- ramka_co_piec_lat$geography
ZarobkiM <- ramka_rok_do_roku_zmienne$średnie_roczne_zarobki_mężczyzn
ZarobkiK <- ramka_rok_do_roku_zmienne$średnie_roczne_zarobki_kobiet
#wiem ze z dupy ta czesc ale inaczej nie chcialo dzialac xd
konsumcja <- summarise(ramka_co_piec_lat, konsumpcja = konsumpcja_owoce_warzywa)
ramka_kraj_konsumcja <- data.frame(Kraj, konsumcja )
ramka_kraj_konsumcja <- aggregate(konsumpcja ~ Kraj, ramka_kraj_konsumcja, mean)
wykres_kraj_konsumcja <- ggplot(ramka_kraj_konsumcja, aes(x = konsumpcja, y = Kraj))
wykres_kraj_konsumcja <- wykres_kraj_konsumcja + geom_point(size = 3) %>%
     + labs(x = "Konsumpcja", y = "Kraj lub obszar") 
#wykres zarobki

df_wykres2 <- data.frame(ZarobkiK, ZarobkiM, Kraj)

df_wykres2
SrZarobkiM <- aggregate(ZarobkiM ~ Kraj, df_wykres2, mean) 
SrZarobkiK <- aggregate(ZarobkiK ~ Kraj, df_wykres2, mean)
SrZarobki <- cbind(SrZarobkiK, ZarM = SrZarobkiM$ZarobkiM)
p6 <- ggplot(data = SrZarobki, mapping = aes(x = ZarobkiK, y = Kraj))
p6 + geom_col()
#M
wykres2 <- ggplot(SrZarobki,aes(x = ZarM, y =Kraj ), color = "white", fill = 'blue', ) +
  geom_col(position = "dodge")
wykres2
#wykres_kraj_edukacja - edukacja a kraj
ramka_kraj_edukacja <- data.frame(ramka_co_piec_lat$geography, ramka_co_piec_lat$edukajca) %>%
      na.omit(ramka_kraj_edukacja) %>%
      group_by(panstwa) %>%
      summarise(edukacja = mean(edukacja))

wykres_kraj_edukacja <- ggplot(ramka_kraj_edukacja, aes(x = panstwa, y = edukacja)) +
  geom_col() +
  labs(x = "Państwa", y = "Średnia wartość wykształcenia")

#TRZEBA OGARNĄĆ JEDNOSTKE TEGO
#wykres4 - inflacja
Inflacja <- ramka_rok_do_roku_zmienne$inflacja_rok_do_roku
Rok <- ramka_rok_do_roku_zmienne$okres_czasu
Inflacja_w_panstwach <- data.frame(Kraj, Inflacja, Rok) %>%
  na.omit()

wykres4 <- ggplot(Inflacja_w_panstwach, aes(x = Rok, y = Inflacja, color = Kraj, group= Kraj)) %>%
  #+geom_point() %>% 
  # +geom_point(data = Inflacja_w_panstwach[which.max(Inflacja_w_panstwach$Inflacja)],color ='RED') %>% 
 +geom_point() %>% 
 +geom_line()

#Wykres 3_2 - Wyksztalcenie a edukacja |||IMO NIE POTRZEBNE!!!||| Nie wiemy jaka jednostka i jak to jest mierzone
Wlochy <- filter(srednia_edukacja, panstwa == "Italy")
Slowacja <- filter(srednia_edukacja, panstwa == "Slovakia")
Czechy <- filter(srednia_edukacja, panstwa == "Czechia")
PolskaTlo7 <- filter(srednia_edukacja, panstwa == "Poland")%>%
  rbind(Wlochy)%>%
  rbind(Czechy)%>%
  rbind(Slowacja)

PolskaTloEdukacja <- ggplot(PolskaTlo7, aes(x = panstwa, y = srednia)) +
  geom_col() +
  labs(x = "Państwa", y = "Średnia wartość wykształcenia")

#Polska na tle Chorwacji(Bo srednio najnizej), Turcji(Bo najwyzej), i Czech(Bo podobna kultura)
#Nowe tabele tworze po to, by mozna bylo porownac zaleznosci w tabeli na dany rok, moze sie przyda
#Jak nie to moge to zedytowac by pobieralo prosto z ramka_rok_do_roku_zmienne
Turcja <- filter(Inflacja_w_panstwach, Kraj == "Turkey")
Chorwacja <- filter(Inflacja_w_panstwach, Kraj == "Croatia")
Czechy <- filter(Inflacja_w_panstwach, Kraj == "Czechia")
PolskaTlo1 <- filter(Inflacja_w_panstwach, Kraj == "Poland") %>%
  rbind(Turcja)%>%
  rbind(Chorwacja)%>%
  rbind(Czechy)
PolskaTloInflacja <- ggplot(PolskaTlo1, aes(x = Rok, y = Inflacja, color = Kraj, group= Kraj)) %>%
  +geom_point() %>% 
  +geom_line() %>%
  +labs(x = "Lata", y = "Inflacja (%)")

###############################################################################################
#Tu sie je polaczy gdzies
#####################################################
#ZAROBKI (ROCZNE W EURO?????)

Luksemburg <-  filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Luxembourg")
Czechy2 <-  filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Czechia")
Rumunia <-  filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Romania")
PolskaTlo2 <-  filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Poland") %>%
  rbind(Luksemburg)%>%
  rbind(Czechy2)%>%
  rbind(Rumunia)

PolskaTloZarobki <- ggplot(data = PolskaTlo2, mapping = aes(x = okres_czasu, y = zarobki, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line(size = 1) %>%
  + scale_y_continuous(breaks = seq(2000, 38000,2000)) %>%
  + labs(x = "Lata", y = "Średnie zarobki w euro")

wyykres_cena_gazu
Rumunia2 <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Romania")
Hiszpania <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Spain")
Czechy3 <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Czechia")
PolskaTlo3 <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Poland") %>%
  rbind(Rumunia2)%>%
  rbind(Hiszpania)%>%
  rbind(Czechy3)
PolskaTlo3
PolskaTloGaz <- ggplot(PolskaTlo3, aes(x=okres_czasu,y = cena_gazu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  +labs(x = "Lata", y = "Cena gazu w KW/h")
PolskaTloGaz

Bulgaria <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Bulgaria")
Hiszpania <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Spain")
PolskaTlo4 <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Poland") %>%
  rbind(Bulgaria)%>%
  rbind(Hiszpania)%>%
  rbind(Czechy3)


PolskaTloPrad <- ggplot(PolskaTlo4, aes(x=okres_czasu,y = cena_pradu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  +labs(x = "Lata", y = "Cena prądu w KW/h")

Wegry <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Hungary")
Estonia <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Estonia")
PolskaTlo5 <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Poland")%>%
  rbind(Wegry)%>%
  rbind(Estonia)%>%
  rbind(Rumunia2)%>%
  rbind(Czechy3)


PolskaTloPodatki <- ggplot(PolskaTlo5, aes(x=okres_czasu,y = `podatek_jako_%_dochodu`, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  + scale_y_continuous(breaks = seq(4, 36,2)) %>%
  +labs(x = "Lata", y = "Podatek (% dochodów)")

Turcja2 <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Turkey")
Hiszpania <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Spain")
PolskaTlo6 <- filter(ramka_rok_do_roku_zmienne, zakres_geograficzny == "Poland")%>%
  rbind(Turcja2)%>%
  rbind(Czechy3)%>%
  rbind(Hiszpania)

PolskaTloWynajem <- ggplot(PolskaTlo6, aes(x=okres_czasu,y = cena_wynajmu_za_miesiac, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  +labs(x = "Cena wynajmu za miesiąc", y = "Lata")

Belgia <- filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Belgium")
Rumunia <- filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Romania")
Dania <- filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Denmark")
Holandia <- filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Netherlands")
PolskaTlo8  <- filter(ramka_rok_do_roku_zarobki, zakres_geograficzny == "Poland") %>%
  rbind(Belgia)%>%
  rbind(Dania)%>%
  rbind(Czechy2)%>%
  rbind(Rumunia)%>%
  rbind(Holandia)

PolskaRoznicaZar <- ggplot(PolskaTlo8, mapping = aes(x = okres_czasu, y = roznica_zar_men_kob, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line() %>%
  + labs(x = "Lata", y = "Różnica w zarobkach kobiet a mężczyzn")
