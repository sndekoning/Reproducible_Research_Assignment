## Correcting upper/lowercase discrepancies. 
stdata_corr <- stdata %>% mutate(EVTYPE = toupper(EVTYPE), 
                 PROPDMGEXP = toupper(PROPDMGEXP), 
                 CROPDMGEXP = toupper(CROPDMGEXP))

## Removing the SUMMARIES from the EVTYPE.
ind_sum <- grep("SUMMARY", stdata_corr$EVTYPE)
stdata_corr <- stdata_corr[-ind_sum,]

## Creating a new data frame with only the variables to be used.
stdata_corr <- select(stdata_corr, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP,
                    CROPDMG, CROPDMGEXP)
    
stdata_pubdmg <- stdata_corr %>% select(EVTYPE, FATALITIES, INJURIES) %>%
    filter(FATALITIES != 0 | INJURIES != 0)

## Function to transform the exponential variables.
exp_transform <- function(damages, exponential){
    if(exponential == ""){
        damages * 1
    }
    else if(exponential == "K"){
        damages * 1000
    }
    else if(exponential == "M"){
        damages * 1E6
    }
    else if(exponential == "B"){
        damages * 1E9
    }
}

stdata_ecodmg <- stdata_corr %>% 
    select(EVTYPE, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP) %>%
    filter(PROPDMG != 0 | CROPDMG != 0)

mutate(stdata_ecodmg, PROPDMG_TOT = exp_transform(stdata_ecodmg$PROPDMG, stdata_ecodmg$PROPDMGEXP), 
           CROPDMG_TOT = exp_transform(stdata_ecodmg$CROPDMG, stdata_ecodmg$CROPDMGEXP))

