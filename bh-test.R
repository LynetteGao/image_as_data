library(rstatix)
df <- read.csv('ten_seconds_featureclimate.csv')
head(df, 3)

df$conspiracy <- factor(df$conspiracy) 
df %>% cohens_d(median_bright_sd ~ conspiracy, var.equal = FALSE)

df %>% cohens_d(median_s ~ conspiracy, var.equal = FALSE)

df %>% cohens_d(median_bright ~ conspiracy, var.equal = FALSE)
df %>% cohens_d(median_h ~ conspiracy, var.equal = FALSE)
df %>% cohens_d(median_b ~ conspiracy, var.equal = FALSE)
df %>% cohens_d(var_contrast ~ conspiracy, var.equal = TRUE)
df %>% cohens_d(median_contrast ~ conspiracy, var.equal = FALSE)

 t.test(df[, 13] ~ df$conspiracy)
 