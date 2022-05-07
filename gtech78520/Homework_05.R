# Homework ----------------------------------------------------------------

# A few MUST DOs: 
# DO NOT change the name of the .csv file in your script.  
# Store all your data and scripts in the same folder
# When you submit your code, title the file by your last name and homework 
#        (i.e., SMITH_Homework_5.R).
# Only submit your code as an R script file, nothing else is necessary. 
# Do not hard code the path to the .csv file: make use of the rstudioapi library. 
# Start the script with the following code: "wd <- dirname(getActiveDocumentContext()$path)".
# setwd(wd)

# TASK 1 ------------------------------------------------------------------

# Write a R function that uses the Olympic database to print out the names 
# of all athletes that won medals of choice in an Olympic sport. The printout  
# provides the name of the athletes, the year of the  Olympics, the medal achieved
# the sport and the country of their origin.
#
# You are limited to using conditional and control flow methods (if statements, loops, 
# logical and relational operators). You cannot use the tidyverse technique in this task.  
# Turn your algorithm into a function so that we can use it for any sport and 
# any of three medals (Gold, Silver or Bronze).  The function should have three or less
# arguments.
#
# The function helps to answer the question: Which athletes, from which countries, received 
# a ____ medal in sport ____?

# Hints: 
# 1) Cut the data frame down in size (less rows) to practice on a smaller 
#       set of inputs; 
# 2) Create a script that works for say (sport = "Cycling" and medal = "Gold");
# 3) Once it works, wrap the script into a functional syntax;
# 4) Make the sport and medal arguments of the function;
# 5) You could import the data frame within the function or include it as a third argument;
# 6) Within the function, consider using the "which()" function that results in 
#       an index for selecting rows (that is, the sport and medal of choice);
# 7) Perhaps use a "for loop" that will iterate through the index.  This can help 
#       to identify other elements in the same row (i.e., name of athlete, year, country); 
# 8) Use the print(paste()) combination to print out your results.  There is 
#       no need to store data; 
# 9) The function should work when the data and the script are in the same folder;
# 10) Of course, there are many ways that will work to create this output. Please don't
#       be shy to use your own creativity! 
# 11) The function should run with the database given (do not change that file!)
#       You will be graded on whether the function runs when I run it.    



# ---------- Task 1 (without using tidyverse) ----------
library("rstudioapi")
wd <- dirname(getActiveDocumentContext()$path)
setwd(wd)
getwd()

olympicsDatabase <- read.csv(file = 'OLYMPICS_athlete_events.csv')   # read in csv file

length(unique(olympicsDatabase$Sport))
# The code above calculated that there are 66 different sports.

sportList <- unique(olympicsDatabase$Sport)   # make list of different sports
medalList <- c("Gold", "Silver", "Bronze")     # make list of different medals

printOlympicData <- function(sportType, medalType) {
  for (i in 1:66) {
    if (sportType == sportList[i]) {
      for (j in 1:3) {
        if (medalType == medalList[j]) {
          searchRow <- which(olympicsDatabase$Sport == sportList[i] & olympicsDatabase$Medal == medalList[j])
          for (k in 1:length(searchRow)) {
            print(paste("Output", k, ":", olympicsDatabase$Name[searchRow[k]], ", from the country of", olympicsDatabase$Team[searchRow[k]], ", received a", olympicsDatabase$Medal[searchRow[k]], "medal , in the sport of", olympicsDatabase$Sport[searchRow[k]]))
          }
        }
      }
    }
  }
  }

# ----- Example 1 -----
# sport = "Tug-Of-War" and medal = "Bronze"
length(which(olympicsDatabase$Sport == "Tug-Of-War" & olympicsDatabase$Medal == "Bronze"))
# The code above checks how many rows where the sport is "Tug-Of-War" AND the medal is "Bronze"
printOlympicData("Tug-Of-War", "Bronze")

# ----- Example 2 -----
# sport = "Speed Skating" and medal = "Gold"
length(which(olympicsDatabase$Sport == "Speed Skating" & olympicsDatabase$Medal == "Gold"))
# The code above checks how many rows where the sport is "Speed Skating" AND the medal is "Gold"
printOlympicData("Speed Skating", "Gold")



# TASK 2 ------------------------------------------------------------------

# Use tidyverse for a similar task.  In this case, create a function 
# that prints out the athlete's name, sport, event, team/county, medal
# and year in chronological order (earliest year to most recent).  In this 
# task use your new knowledge and skills of working with tidyverse 
# verbs to handle the data in the data frame.  The function should have 
# two arguments.     



# ---------- Task 2 (using tidyverse) ----------
library("tidyverse")
library("janitor")

printTask2 <- function(sportType, medalType) {
  olympicsDatabase %>%
    filter(Sport == sportType, Medal == medalType) %>%
    select(Name, Sport, Event, Team, Medal, Year) %>%
    arrange(Year)
}

# ----- Example 1 -----
# sport = "Tug-Of-War" and medal = "Bronze"
length(which(olympicsDatabase$Sport == "Tug-Of-War" & olympicsDatabase$Medal == "Bronze"))
# The code above checks how many rows where the sport is "Tug-Of-War" AND the medal is "Bronze"
printTask2("Tug-Of-War", "Bronze")

# ----- Example 2 -----
# sport = "Speed Skating" and medal = "Gold"
length(which(olympicsDatabase$Sport == "Speed Skating" & olympicsDatabase$Medal == "Gold"))
# The code above checks how many rows where the sport is "Speed Skating" AND the medal is "Gold"
printTask2("Speed Skating", "Gold")
