### R Script for Emotion Paper on YouTube
# Author : Lynette Gao
# June 2021 - May 2021

## Import required packages
# library(plotly)
library(tm)
library(wordcloud)
library(xlsx)
library(dplyr)
# library(stargazer)

## PART I : loading data and cleaning up 

# Read the input data & clean up
#video_list <- read.xlsx("emotional_videos.xlsx", sheetIndex = 1, header=TRUE)
video_list <- read.xlsx("inputfile", sheetIndex = 1, header=TRUE)
raw <- video_list # save a copy of data
video_list $ transcript <- as.character(video_list $ transcript)
video_list$transcript_nchar <- as.numeric(video_list$transcript_nchar) 

## Running the NRC dictionaries 
# running NRC functions to get sentiments for each YouTube video trancript
library(syuzhet)
emotions <- get_nrc_sentiment(video_list$transcript)
colnames(emotions) <- paste("raw", colnames(emotions), sep = "_")
res <- bind_cols(video_list,emotions)

res$emotion <- res$anger + res$anticipation + res$disgust + res$fear + res$joy + res$sadness + res$surprise + res$trust + res$negative + res $positive


# normalize the NRC by the # of length of the transcript
res$anger <- res$anger/res$transcript_nchar
res$anticipation <- res$anticipation/res$transcript_nchar
res$disgust <- res$disgust/res$transcript_nchar
res$fear <- res$fear/res$transcript_nchar
res$joy <- res$joy/res$transcript_nchar
res$sadness <- res$sadness/res$transcript_nchar
res$surprise <- res$surprise/res$transcript_nchar
res$trust <- res$trust/res$transcript_nchar
res$negative <- res$negative/res$transcript_nchar
res$positive <- res$positive/res$transcript_nchar

res$emotion <- res$emotion / res$transcript_nchar


# write.xlsx(res, file = "./modified.xlsx", sheetName = "Sheet1", 
#            col.names = TRUE, row.names = FALSE, append = FALSE) # saving the result
