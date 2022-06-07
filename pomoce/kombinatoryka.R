pcgAll <- (.packages(all.available = TRUE))
if (!"RcppAlgos" %in% pcgAll)
    stop("Nie masz zainstalowanego pakietu RcppAlgos. Zainstaluj go!", call. = FALSE)
if (!"RcppAlgos" %in% (.packages()))
    stop("Pakiet RcppAlgos jest zainstalowany, ale nie jest wczytany. Wczytaj go!", call. = FALSE)

    
PokazKombinacje <- function(zbior, k, powtorz = FALSE) {
    # Wyświetla kombinacje bez powtórzeń i z powtórzeniami
    RcppAlgos::comboGeneral(zbior, m = k, repetition = powtorz) 
}


PokazWariacje <- function(zbior, k, powtorz = FALSE) {
    # Wyświetla wariacje bez powtórzeń i z powtórzeniami
    
    RcppAlgos::permuteGeneral(zbior, m = k, repetition = powtorz)
}


PokazPermutacje <- function(zbior, ileRazyPowt = NULL) {
    
 # Wyświetla permutacje z powtórzeniami i z bez powtórzeń
 # zbior - wektor elementow (math: zbiór)
 # ileRazyPowt - wektor o długości = lengtth(zbior). Wartość to liczba powtóżeń
    
    if(is.null(ileRazyPowt)) {
        
        RcppAlgos::permuteGeneral(zbior)
        
    } else {
        if (!is.numeric(ileRazyPowt) || length(ileRazyPowt) != length(zbior))
            stop(paste0("\nileRazyPowt musi być wektorem:\n1. Numerycznym\n2. Długość wektora musi być równa: ",
                        length(zbior)), call. = FALSE)
        
        RcppAlgos::permuteGeneral(zbior, freq = ileRazyPowt, repetition = TRUE)
        }
}



