source("PrzygotowanieRamkiDanych.R", encoding = "UTF-8")

wykres_zarobki <- ggplot(data = dt_1_zarobki, mapping = aes(x = okres_czasu, y = zarobki, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  + geom_line(size = 1)%>%
  + scale_y_continuous(breaks = seq(2000, 38000,2000))

wyykres_cena_gazu <- ggplot(dt_1, aes(x=okres_czasu,y = cena_gazu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()
wyykres_cena_pradu <- ggplot(dt_1, aes(x=okres_czasu,y = cena_pradu, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()

dt_1$cena_wynajmu_za_miesiac


wykres_podatki <- ggplot(dt_1, aes(x=okres_czasu,y = `podatek_jako_%_dochodu`, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line() %>%
  + scale_y_continuous(breaks = seq(4, 36,2))

wykres_cany_wynajmu <- ggplot(dt_1, aes(x=okres_czasu,y = cena_wynajmu_za_miesiac, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
  +geom_line()

### różnica pomiędzy zarobkami mężczyzn a kobiet

#nie wiem czy to jest warte dla 
wyjres_rozn_kob_men <- ggplot(data = dt_1_zarobki, mapping = aes(x = okres_czasu, y = roznica_zar_men_kob, color=zakres_geograficzny, group = zakres_geograficzny)) %>%
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
#Tu sie je polaczy gdzies
#####################################################


