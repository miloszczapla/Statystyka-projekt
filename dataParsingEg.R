library(tidyverse)
library(readxl)

ZarobkiKobEuro <- read_excel('dane/ZarobkiKobEuro.xlsx'  )
ZarobkiMezczEuro <- read_excel('dane/ZarobkiMezczEuro.xlsx')
Cena_gazu_popr <- read_excel('dane/Cena_gazu_popr.xlsx')
str(Cena_gazu_popr)
as.numeric(Cena_gazu_popr)


Cena_gazu_popr <- sapply(Cena_gazu_popr[-1,],as.numeric)
for (col in Cena_gazu_popr) {


  as.numeric(col)
}


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

