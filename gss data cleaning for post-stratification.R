library(tidyverse)
raw_data <- read.csv("gss.csv")
raw_data

table(raw_data$income_family)

table(raw_data$age)
reduced_data <- 
  raw_data %>% 
  select(age, 
         sex, 
         province, 
         education)

reduced_data

# table(reduced_data$age)
# table(reduced_data$sex)
# table(reduced_data$province)
# table(reduced_data$education)



#mutate age: young and old 
reduced_data$age <- ifelse(reduced_data$age >=60  ,1,0) # use 60 as an age bound 

# reduced_data <- 
#   reduced_data %>% 
#   filter(age>= 18) %>% # filter out people who are less than 18 
#   mutate(
#     age = case_when(
#       age >= 18 & age <= 29 ~ "18-29", 
#       age  >= 30 & age <= 44 ~ "30-44", 
#       age >= 45 & age <= 64 ~ "45-64", 
#       age >= 65 ~ "65+"))


reduced_data <- 
  reduced_data %>% 
  mutate(
    education= case_when(
      education == "Trade certificate or diploma" ~ "College, CEGEP or other non-university certificate or trade",
      education == "College, CEGEP or other non-university certificate or di..." ~ "College, CEGEP or other non-university certificate or trade",
      education == "Less than high school diploma or its equivalent"  ~ "Less than high school diploma or its equivalent",
      education == "High school diploma or a high school equivalency certificate" ~ "High school diploma or a high school equivalency certificate",
      education == "University certificate or diploma below the bachelor's level" ~ "University certificate or diploma below the bachelor’s level",
      education == "Bachelor's degree (e.g. B.A., B.Sc., LL.B.)" ~ "Bachelor’s degree (e.g. B.A., B.Sc., LL.B.)",
      education == "University certificate, diploma or degree above the bach..." ~ "University certificate, diploma or degree"
      
    )
  )


reduced_data <- reduced_data %>% na.omit()

reduced_data <- 
  reduced_data %>%
  count(age, sex, province, education)

View(reduced_data)

write_csv(reduced_data, "gss.csv")

