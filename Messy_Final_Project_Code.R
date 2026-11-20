library(tidyverse)
library(ggplot2)

FluvPHL = read.csv('FluViewPhase2Data/ICL_NREVSS_Public_Health_Labs.csv', quote = "\"", skip = 1)
str(FluvPHL)
View(FluvPHL)
str_remove(FluvPHL$REGION)

FluvCL = read.csv('FluViewPhase2Data/ICL_NREVSS_Clinical_Labs.csv', quote = "\"", skip = 1)
str(FluvCL)
View(FluvCL)

FluvCL_clean = FluvCL %>%
  select(-REGION)
View(FluvCL_clean)

FluvPHL_clean = FluvPHL %>%
  select(-REGION)
View(FluvPHL_clean)

Fluv_Complete = full_join(FluvCL_clean, FluvPHL_clean)
View(Fluv_Complete)
