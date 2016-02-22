## Correcting upper/lowercase discrepancies. 
stdata$EVTYPE <- toupper(stdata$EVTYPE)

## Removing the SUMMARIES from the EVTYPE.
ind_sum <- grep("SUMMARY", stdata$EVTYPE)
stdata <- stdata[-ind_sum,]

## Creating a new data frame with only the variables to be used.
newstdata <- select(stdata, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP,
                    CROPDMG, CROPDMGEXP)