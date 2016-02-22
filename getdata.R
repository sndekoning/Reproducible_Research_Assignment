library(ggplot2)
library(dplyr)

## Checking if data is present, and downloading data if it isn't.
if(!file.exists("storm_data.csv.bz2")){
  file_url <- paste("https://d396qusza40orc.cloudfront.net/",
                    "repdata%2Fdata%2FStormData.csv.bz2",
                    sep = "")
  download.file(file_url, "storm_data.csv.bz2")
}

## Storing the data in a table data frame. 
stdata <- tbl_df(read.csv(bzfile("storm_data.csv.bz2")))