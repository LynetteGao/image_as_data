library(jsonlite)
library(tidyverse)
library(RVerbalExpressions)


setwd("~/Documents/GitHub/YouTube-Propaganda-Effects")

viral <- read.csv("./COVID19/English videos/En458BillGates_May23.csv",header = TRUE)


viral$video_id <- trimws(viral$video_id, which = c("left"))

trans_json <- read_json(
  ("./COVID19/English videos/transcripts/BillGates_script.json")
)


trans_raw <- purrr::flatten(purrr::flatten(trans_json))
trans_names <- names(trans_raw)

##### regex to clean up the transcripts ----------------------------------------

laughter_tag <- rx() %>%
  rx_find("[Laughter]")

music_tag <- rx() %>%
  rx_find("[Music]")

applause_tag <- rx() %>%
  rx_find("[Applause]")

html_tag <- rx() %>%
  rx_find("<") %>%
  rx_maybe("/") %>%
  rx_anything(mode = "lazy") %>%
  rx_find(">")

timestamp <- rx() %>%
  rx_digit() %>%
  rx_digit() %>%
  rx_find(":") %>%
  rx_digit() %>%
  rx_digit() %>%
  rx_find(":") %>%
  rx_digit() %>%
  rx_digit() %>%
  rx_find(",") %>%
  rx_digit() %>%
  rx_digit() %>%
  rx_digit()

arrows <- rx() %>%
  rx_digit() %>%
  rx_one_or_more() %>%
  rx_find("  -->  ")

#####  actual cleanup itself ---------------------------------------------------

trans_clean <- trans_raw %>%
  as.character() %>%
  str_trim() %>%
  str_squish() %>%
  str_remove_all(html_tag) %>%
  str_remove_all(timestamp) %>%
  str_remove_all(arrows) %>%
  str_remove_all(laughter_tag) %>%
  str_remove_all(music_tag) %>%
  str_remove_all(applause_tag) %>%
  str_trim()

transcripts <- tibble(
  video_id = trans_names,
  #raw_transcript = as.character(trans_raw),
  transcript = trans_clean,
  transcript_nchar = nchar(trans_clean)
)

transcripts$video_id <- trimws(transcripts$video_id, which = c("left"))

# transcripts %>%
#   arrange(transcript_nchar) %>%
#   slice(1:500) %>%
#   view()

# transcripts %>%
#   filter(transcript_nchar > 50) %>%
#   distinct(video_id)


with_transcript <- viral %>% left_join(transcripts, by = "video_id")

library(here)
write_csv(
  with_transcript,
  here("./COVID19/English videos/training data(top40+English+transcript)/BG_Entranscript.csv")
)
