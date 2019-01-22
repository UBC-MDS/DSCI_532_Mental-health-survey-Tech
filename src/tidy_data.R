# tidy_data.R
# Sabrina Kakei Tse and Ting Pan, Jan 18 2019
#
# This script imports the data from survey.csv
# clean 'Gender'
# then stored the tidy version of the data in data folder
# 

# load package
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(magrittr))

# load data
data <- read.csv("../data/survey.csv")

# filter all company employees
data <- data %>% filter (self_employed == 'No')

# filter all tech companys
data <- data %>% filter (tech_company == 'Yes')

# clean 'Gender'
data$Gender %<>% str_to_lower()

unique(data$Gender)
male_str <- c("male", "m", "male-ish", "maile", "mal", "male (cis)", "make", "male ", "man","msle", "mail", "malr", "cis man", "cis male")
other_str <- c("trans-female", "something kinda male?", "queer/she/they", "non-binary","nah", "all", "enby", "fluid", "genderqueer", "androgyne", "agender", "male leaning androgynous", "guy (-ish) ^_^", "trans woman", "neuter", "female (trans)", "queer", "ostensibly male, unsure what that really means" )
female_str <- c("cis female", "f", "female", "woman",  "femake", "female ","cis-female/femme", "female (cis)", "femail")
data$Gender <- sapply(as.vector(data$Gender), function(x) if(x %in% male_str) "Male" else x )
data$Gender <- sapply(as.vector(data$Gender), function(x) if(x %in% female_str) "Female" else x )
data$Gender <- sapply(as.vector(data$Gender), function(x) if(x %in% other_str) "Other" else x )
data %<>% filter(Gender != "a little about you")
data %<>% filter(Gender != "guy (-ish) ^_^")
data %<>% filter(Gender != "p")
unique(data$Gender)

# save the tidy data as a csv file
write.csv(data, file = "../data/tidy_data.csv")