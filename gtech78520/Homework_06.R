# Homework ----------------------------------------------------------------

# A few MUST DOs: 
# DO NOT change the name of the csv files.  
# Store all your data and scripts in the same folder
# When you submit your code, title the file by your last name and homework # 
#        (i.e., SMITH_Homework_9.R)
# Only submit your code as an R script file, nothing else is necessary 
# Make use you use the rstudioapi library 
# Start the script with the following code: "wd <- dirname(getActiveDocumentContext()$path)"
# There are two tasks for this homework and an extra credit bonus problem.
# Answer the questions as explained

library("rstudioapi")
library("tidyverse")
library("janitor")
wd <- dirname(getActiveDocumentContext()$path)
setwd(wd)
getwd()

# Task 1 ------------------------------------------------------------------
# What are the 5 counties that had the highest cumulative COVID-19 cases at 
# four different, equally-interval (approximately) periods during the pandemic?  
#
# Some things to consider:
#     Use the covid-19 data by county in the USA for cases.  
#     How would you divide up the time period? (think of dividing 
#         lengths of vectors)
#     Once divided you can select the last date of each period and pull 
#         out the 5 counties with highest cumulative covid-19 values on that day
#     Your answer for this task should be a data frame with 
#         20 rows (5 counties for each period) and the cumulative COVID-19 
#         case numbers for each county and the dates

covidData <- read.csv(file = './covid_confirmed_usafacts.csv')   # read in csv file

# there are 769 dates, divided by 4 equals 192.25
# so I divided the four periods with 193, 192, 192, and 192 dates in each period, respectively
# first day of period 1 : Jan 22, 2020
# names(covidData)[5] 
# last day of period 1 : Aug 1, 2020
# names(covidData)[5+192] 
# first day of period 2 : Aug 2, 2020
# names(covidData)[5+193] 
# last day of period 2 : Feb 9, 2021
# names(covidData)[5+193+191] 
# first day of period 3: Feb 10, 2021
# names(covidData)[5+193+192] 
# last day of period 3 : Aug 20, 2021
# names(covidData)[5+193+192+191] 
# first day of period 4 : Aug 21, 2021
# names(covidData)[5+193+192+192] 
# last day of period 4 : Feb 28, 2022
# names(covidData)[5+193+192+192+191] 

# dataframe for period 1: jan 22, 2020 to aug 1, 2020
task1_Q1 <- covidData %>%
  transmute(County.Name, State, 
         Cases = 
           X8.1.2020,
         Dates = 
           'Jan22.2020_Aug1.2020') %>%
  arrange(desc(Cases)) %>%
  head(5) 

# dataframe for period 2: aug 2, 2020 to feb 9, 2021
task1_Q2 <- covidData %>%
  transmute(County.Name, State, 
            Cases = 
              X2.9.2021,
            Dates = 
              'Aug2.2020_Feb9.2021') %>%
  arrange(desc(Cases)) %>%
  head(5)

# dataframe for period 3: feb 10, 2021 to aug 20, 2021
task1_Q3 <- covidData %>%
  transmute(County.Name, State, 
            Cases = 
              X8.20.2021,
            Dates = 
              'Feb10.2021_Aug20.2021') %>%
  arrange(desc(Cases)) %>%
  head(5)

# dataframe for period 4: aug 21, 2021 to feb 28, 2022
task1_Q4 <- covidData %>%
  transmute(County.Name, State, 
            Cases = 
              X2.28.2022,
            Dates = 
              'Aug21.2021_Feb28.2022') %>%
  arrange(desc(Cases)) %>%
  head(5)

# row bind the four dataframes
task1 <- rbind(task1_Q1,task1_Q2,task1_Q3,task1_Q4)
task1

# Task 2 ------------------------------------------------------------------
# Provide a dataframe which include all fifty states with COVID-19 cases per 
# 10 thousands persons and COVID-19 deaths per 100 thousand persons during 
# the entire pandemic period.  The data frame should include three columns: 
# the state abbreviation and the cases per 10 thousand and deaths per 100 thousand.   

# Things to consider
#   You'll need the population data for each county 
#   You'll need to group and summarize data 
#   join all the files together after making them tidy 
#   Calculate your values 
#   You should have one dataframe of 50 rows and three columns  

covidDeathData <- read.csv(file = './covid_deaths_usafacts.csv')   # read in csv file

covidData$StateFIPS <- as.character(covidData$StateFIPS) # convert from numeric to character to use summarise_if
covidData$countyFIPS <- as.character(covidData$countyFIPS)
covidDeathData$StateFIPS <- as.character(covidDeathData$StateFIPS)
covidDeathData$countyFIPS <- as.character(covidDeathData$countyFIPS)

test1 <- covidData %>%
  group_by(State) %>%
  summarise_if(is.numeric,sum)
test1a <- test1[,2:770]
test2 <- test1a %>%
  transmute(Cases_per_10000 = rowSums(.)/10000)
test1 <- test1[,1]

test3 <- covidDeathData %>%
  group_by(State) %>%
  summarise_if(is.numeric,sum)
test3a <- test3[,2:770]
test4 <- test3a %>%
  transmute(Deaths_per_100000 = rowSums(.)/100000)

# column bind the four dataframes
task2 <- cbind(test1,test2,test4)
task2

# Extra credit ------------------------------------------------------------
# What are the 10 counties that had the highest single day increase (day-on-day) 
# in new daily COVID-19 cases and deaths?  The result should be two data frames
# or two print outs of the name of the county, state and increase in day-on-day daily 
# cases or deaths.

# Meta-data
# Information on the covid files can be found here: 
# https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/ 

