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

## Public health data table with a total variable added and zero damages removed.    
stdata_pubdmg <- stdata_corr %>% 
    select(EVTYPE, FATALITIES, INJURIES) %>%
    filter(FATALITIES != 0 | INJURIES != 0) %>%
    mutate(TOTAL = FATALITIES + INJURIES)

## Function to transform the exponential variables.
exp_transform <- function(damages, exponential){
    if(exponential == ""){
        damages * 1
    }
    else if(exponential == "K"){
        damages * 1000
    }
    else if(exponential == "M"){
        damages * 1E+06
    }
    else if(exponential == "B"){
        damages * 1E+09
    }
}

## Subsetting the variables to be used, and dropping the zero-damage entries.
stdata_ecodmg <- stdata_corr %>% 
    select(EVTYPE, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP) %>%
    filter(PROPDMG != 0 | CROPDMG != 0)
 
## Dropping the non-standard exponential variables.
stdata_ecodmg <- stdata_ecodmg %>%
    filter(PROPDMGEXP == "" | PROPDMGEXP == "K" | PROPDMGEXP == "M" | PROPDMGEXP == "B") %>% 
    filter(CROPDMGEXP == "" | CROPDMGEXP == "K" | CROPDMGEXP == "M" | CROPDMGEXP == "B")

## Broken code. Prop mutates, Crop doesnt.
## stdata_ecodmg <- mutate(stdata_ecodmg, 
##                        PROPDMG_TOT = exp_transform(stdata_ecodmg$PROPDMG, stdata_ecodmg$PROPDMGEXP))
## stdata_ecodmg <- mutate(stdata_ecodmg, 
##                        CROPDMG_TOT = exp_transform(stdata_ecodmg$CROPDMG, stdata_ecodmg$CROPDMGEXP))

## Proper code to apply the exponentials to the damages variables.
stdata_ecodmg$CROPDMG_TOT <- mapply(exp_transform, stdata_ecodmg$CROPDMG, stdata_ecodmg$CROPDMGEXP)
stdata_ecodmg$PROPDMG_TOT <- mapply(exp_transform, stdata_ecodmg$PROPDMG, stdata_ecodmg$PROPDMGEXP)          

