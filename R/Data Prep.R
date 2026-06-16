#installing packages 

install.packages(c(
  "tidyverse",
  "dplyr",
  "gtsummary",
  "survival",
  "quarto"
))

library(survival)
library(dplyr)

#importing the data
data("lung", package="survival")
df_lung <- lung

#exploring the data
head(df_lung)
str(df_lung)
summary(df_lung)

#cleaning and standardizing the data
df_lung <- df_lung %>% 
 rename( institution=inst,
         survival_days=time, 
         mortality_status=status,
         cals_consumed = meal.cal, 
         weight_loss = wt.loss
         )

df_lung <- df_lung %>% mutate(sex= ifelse (sex==2, "F", "M"))

df_lung <- df_lung %>% mutate(mortality_status= ifelse (mortality_status==2,"dead", "censored"))

df_lung %>% 
  summarise(
    min_age=min(age),
    median_age=median(age),
    mean_age=mean(age), 
    max_age=max(age)
  )

# Adding the Age Group Column
df_lung <- df_lung %>% 
  mutate(
    age_group = case_when(
      age < 55 ~ "<55",
      age >= 55 & age < 65 ~"55-64",
      age >= 65 & age < 75 ~"65-74",
      age >= 75 ~ "75+"
    )
  )

df_lung %>%
  count(age_group)

#saving cleaned data set
saveRDS(df_lung,  "R/lung_clean.rds")

