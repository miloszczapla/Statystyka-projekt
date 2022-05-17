library(dplyr)

zzz <- merge(ZarobkiKobEuro, ZarobkiMezczEuro, by = "TIME")
#dodawanie kolumn
#merge two data frames by ID and Country
#total <- merge(data frameA,data frameB,by=c("ID","Country"))
zzz
#dodawanie wierszy
total <- rbind(ZarobkiKobEuro, ZarobkiMezczEuro)
total
#rbind podobne do tego co chcemy, ale nie do końca
#dodawanie kolumn #2
ds3 <- cbind(ZarobkiKobEuro, share = ZarobkiMezczEuro$TIME)

nazwa <- (ZarobkiKobEuro$TIME[1:2])
k2012 <- (ZarobkiKobEuro$`2012`[1:2])
k2013 <- (ZarobkiMezczEuro$`2013`[1:2])
polger <- data.frame(nazwa, k2012, k2013)

