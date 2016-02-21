if(!file.exists("storm_data.csv.bz2")){
  file_url <- paste("https://d396qusza40orc.cloudfront.net/",
                    "repdata%2Fdata%2FStormData.csv.bz2",
                    sep = "")
  download.file(file_url, "storm_data.csv.bz2")
}

sdata <- read.csv("storm_data.csv.bz2")