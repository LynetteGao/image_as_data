### Github repo for *Visual Framing of Science Conspiracy Videos: Integrating Machine Learning with Communication Theories to Study the Use of Color*

#### Figure 2: Saturation comparison between conspiracy vs debunking videos

- run t-test and generate boxplot: running statistics test/t-test.R
- input: latest_video_feature.csv


#### Table 1: Significant results on COVID-19 conspiracy-related videos: using first 10 seconds

- run t-test and calculate p-value: statistics test/t-test.R with input latest_ten_seconds_features.csv

- run Benjamini-Hochberg test: statistics test/bh-test.R with input latest_ten_seconds_features.csv

- calculate Cohen's d: statistics test/cohen.R with input latest_ten_seconds_features.csv

#### Table 2: Significant results on COVID-19 conspiracy-related videos: using thumbnails

- run t-test and calculate p-value: statistics test/t-test.R with input COVID19_thumbnails_low_aesthetics.xlsx

- run Benjamini-Hochberg test: statistics test/bh-test.R with input COVID19_thumbnails_low_aesthetics.xlsx

- calculate Cohen's d: statistics test/cohen.R with input COVID19_thumbnails_low_aesthetics.xlsx

#### Table 3: Significant results on climate change conspiracy-related videos

- run t-test and calculate p-value: statistics test/t-test.R with input climate_feature.csv,ten_seconds_featureclimate.csv, Climatechange_thumbnails_low_aesthetics.csv,

- run Benjamini-Hochberg test: statistics test/bh-test.R with input climate_feature.csv,ten_seconds_featureclimate.csv, Climatechange_thumbnails_low_aesthetics.csv,
- calculate Cohen's d: statistics test/cohen.R with input climate_feature.csv,ten_seconds_featureclimate.csv, Climatechange_thumbnails_low_aesthetics.csv,

#### Table 4(a). Performance comparison in identifying conspiracy videos from correction videos. 

You can find all the model setups under latest models/models-debunk. .ipynb files are holders to train the models. Within each ipynb folder, you can find the corresponding models and their performance. h5 files are the output models.

#### Appendix IV. Correlation matrix of the visual features used in Model 4


