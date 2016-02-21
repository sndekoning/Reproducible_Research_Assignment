## Correcting upper/lowercase discrepancies. 
sdata$EVTYPE <- toupper(sdata$EVTYPE)

## Removing the SUMMARIES from the EVTYPE.
ind_sum <- grep("SUMMARY", sdata$EVTYPE)
sdata <- sdata[-ind_sum,]

## Creating