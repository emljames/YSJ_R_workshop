# Load libraries
library(tidyverse)

# Read in participant information (valid only) & picture naming data
ppt_info <- read.csv("./data/original/backgroundInfo.csv") %>% 
  filter(validData == 1)
pic_name <- read.csv("./data/original/picName.csv") %>% 
  filter(task == "PNT", time == 1 | time == 2)

# Select relevant descriptive variables
ppt_info <- select(ppt_info, ID, WASI.vocab.raw)

# Merge datasets together, keep relevant columns only
full_data <- left_join(ppt_info, pic_name) %>% 
  select(ID,  WASI.vocab.raw, learnTime, time, item, acc, RT) %>% 
  set_names(c("ID", "vocab", "sleep_wake", "session", "item", "acc", "RT")) %>% 
  mutate(sleep_wake = ifelse(sleep_wake == "PM", "sleep", "wake"))


# Write csv file
write.csv(full_data, "./data/AMPM_subset.csv", row.names = FALSE)
