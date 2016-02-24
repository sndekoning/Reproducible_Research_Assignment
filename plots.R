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

p <- ggplot(data = top_total, aes(EVTYPE, TOTAL))
p + geom_bar(stat = "identity") + 
    labs(title = "Total Public Health Damage", 
         x = "Weather Event", 
         y = "Total injured or killed") +
    coord_flip()
    