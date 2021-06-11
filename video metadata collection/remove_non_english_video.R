# setwd("~/Documents/GitHub/YouTube-Propaganda-Effects/COVID19/output")

library(tidyverse)
library(textcat)
require(dplyr)
library(cld2)



## load example data
# lks <- list.files(path = '.', full.names = FALSE, recursive = F)

# for (ii in lks){
  # print(paste0('Running ',ii))
  raw <- read.csv('input.csv',header = TRUE)

  fctr.cols <- sapply(raw, is.factor)
  raw[, fctr.cols] <- sapply(raw[, fctr.cols], as.character)


  #raw$language <- textcat(raw$video_title)
  #raw$cld3 <- detect_language(raw$video_title,plain_text = FALSE)
  raw$cld2 <- detect_language(raw$video_title, plain_text = FALSE)
  #raw$decription <-detect_language(raw$video_description, plain_text = FALSE)

  processed <- raw %>% filter(cld2 == "en")

  write.csv(processed, file = paste0("./","proccessed",nrow(processed),ii)
            ,row.names = FALSE)
# }
