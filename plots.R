library(ggplot2)

##top_fatal <- stdata_pubdmg %>%
##  arrange(desc(FATALITIES)) %>%
##  top_n(50, FATALITIES)

##top_injuries <- stdata_pubdmg %>%
##    arrange(desc(INJURIES)) %>%
##    top_n(50, INJURIES)

top_total <- stdata_pubdmg %>%
   arrange(desc(TOTAL)) %>%
    top_n(50, TOTAL)

p1 <- ggplot(data = top_total_pub, aes(EVTYPE, TOTAL))
p1 + geom_bar(stat = "identity") + 
    labs(title = "Total Public Health Damage", 
         x = "Weather Event", 
         y = "Total injured or killed") +
    coord_flip()

top_total_eco <- stdata_ecodmg %>%
    mutate(TOTAL = CROPDMG_TOT + PROPDMG_TOT) %>%
    arrange(desc(TOTAL)) %>%
    top_n(50, TOTAL)

p2 <- ggplot(data = top_total_eco, aes(EVTYPE, TOTAL))
p2 + geom_bar(stat = "identity") + 
    labs(title = "Total Financial Damage", 
         x = "Weather Event"
         y = "Total Damages in USD")
    coord_flip()
