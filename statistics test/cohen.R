library(rstatix)
library(xlsx)
df <- read.xlsx("COVID19_thumbnails_low_aesthetics.xlsx", sheetIndex = 1, header=TRUE) 
df <- read.csv('Climatechange_thumbnails_low_aesthetics.csv')
head(df, 3)

df$conspiracy <- factor(df$conspiracy) 

df %>% cohens_d(rgbB~ Attitude, var.equal = FALSE)
df %>% cohens_d(X.saturation~ Attitude, var.equal = FALSE)
df %>% cohens_d(X.value~ Attitude, var.equal = FALSE)
df %>% cohens_d(rgbB~ Attitude, var.equal = FALSE)
df %>% cohens_d(colorful~ Attitude, var.equal = FALSE)


df %>% cohens_d(var_bright_sd ~ conspiracy, var.equal = FALSE)

df %>% cohens_d(median_s ~ conspiracy, var.equal = FALSE)

df %>% cohens_d(median_bright ~ conspiracy, var.equal = FALSE)
df %>% cohens_d(median_h ~ conspiracy, var.equal = FALSE)
df %>% cohens_d(median_b ~ conspiracy, var.equal = FALSE)
df %>% cohens_d(var_contrast ~ conspiracy, var.equal = TRUE)
df %>% cohens_d(median_contrast ~ conspiracy, var.equal = FALSE)


df %>% cohens_d(rgbB ~ conspiracy, var.equal = FALSE)


 t.test(df[, 13] ~ df$conspiracy)
 
 df2 <- read.csv('ten_seconds_featureclimate.csv')
 df2$conspiracy <- factor(df2$conspiracy)
 df2 %>% cohens_d(median_s ~ conspiracy, var.equal = FALSE)
 