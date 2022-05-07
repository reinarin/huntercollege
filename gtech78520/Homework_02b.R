# Homework Assignment 2b, Data Analysis and Visualization in R, spring 2022

# Working with Data and Graphical EDA


# PRELIMINARY. Look at the data in a text file named "catskill_daily_tmax.txt"
# Put the data file in your R working directory, and "look at" the data: 
# double click on it so that it opens in a text editor. 
# Just visually look at it, and scroll down and across, 
# to get a feel for how many stations are included in the file, 
# what the time domain (i.e. beginning and ending dates) is, 
# and whether the numbers look reasonable and the formatting 
# looks ok (i.e. nothing looks totally crazy). 

# Q1. read in the data
# Read the data into a data frame, and set the missing values to "NA." 
# I am providing you the code to do this.
# Explain in a comment here what each of these lines of code does
fn <- "catskill_daily_tmax.txt"                        # assign the name of the text file to fn
catskill_tmax <- read.delim(fn, header=TRUE, sep="")   # read in the text file and keep the column names, delimited using spaces
catskill_tmax[catskill_tmax==99999.] <- NA             # assign missing value markers (99999.) to NA

# Q2. examine the structure of a dataframe
# Use the str command to examine the structure of the data frame.
# Based on the results of the str command, how many rows and 
# how many columns are in this file? What are the two "types" of variables
# in this file?
str(catskill_tmax)   # based on the str() command, there are 46752 rows, 16 columns in this file. int and num are the two types of variables in this file

# Q3. Subset the data by row
# Make a copy called "catskill_tmax_2" that includes 
# data only from 1950 through 2016 (inclusive).You may either use the
# subset command, or just use the square brackets. Use the head and tail commands 
# to make sure it worked. Explain what the results of the head and tail commands
# showed you about whether your command worked.
catskill_tmax_2 <- subset(catskill_tmax, year >= 1950 & year <= 2016)
head(catskill_tmax_2)        # shows me the first six rows, and they are from year 1950
tail(catskill_tmax_2)        # shows me the last six rows, and they are from year 2016

# **** FROM THE NEXT SET OF QUESTIONS, USE catskill_tmax_2

# Q4. statistics of the data by column, part 1
# use the summary command to print out the summary statistics of each column 
summary(catskill_tmax_2)

# Q5. Statistics of the data by column, part 2
# use the apply command twice, first to make a vector containing the mean value 
# of each column, and second to make a vector containing the standard deviation
# of each column. Name your vectors "mean_vec" and "sd_vec".
# make sure that you consider the fact that there are missing values.
mean_vec <- apply(catskill_tmax_2, 2, mean, na.rm=TRUE)
sd_vec <- apply(catskill_tmax_2, 2, sd, na.rm=TRUE)

# Q6. Pick a station, subsetting the data by column
# Make a vector called "catskill_tmax_mohonk" that includes only the column
# with data from the MOHONK station.
# Use the str command to make
# sure that the vector looks like you think it should
catskill_tmax_mohonk <- catskill_tmax_2$MOHONK
str(catskill_tmax_mohonk)

# Q7. 
# print to the console the number of missing values in catskill_tmax_mohonk,
# the fraction of missing values in catskill_tmax_mohonk,
# and the fraction of non-missing values in catskill_tmax_mohonk
print(sum(is.na(catskill_tmax_mohonk)))                                        # number of missing values = 78
print(sum(is.na(catskill_tmax_mohonk)) / length(catskill_tmax_mohonk))         # number of missing values/total number of values = 78/24472
print(sum(!is.na(catskill_tmax_mohonk)) / length(catskill_tmax_mohonk))        # number of non-missing values/total number of values = 24394/24472

# Q.8 Calculate annual means
# For this question, use the catskill_tmax_2 dataframe
# Calculate the annual mean values of tmax for your the Mohonk station
# for each year in the dataframe. Make sure that you consider the fact that
# there are missing values, and name the columns appropriately.
# Use the aggregate command, in a format similar to this:
#           aggregate(mtcars$mpg, list(Carb = mtcars$carb), mean, na.rm=T) 
# Put the results into a variable called catskill_tmax_mohonk_ann.
# Name the columns  "year", "mean_tmax"
# Use the str command to see the format of the resulting dataframe,
# and describe what the str command tells you
catskill_tmax_mohonk_ann <- aggregate(catskill_tmax_2$MOHONK, list(catskill_tmax_2$year), "mean", na.rm=TRUE)
colnames(catskill_tmax_mohonk_ann) <- c("year", "mean_tmax")
str(catskill_tmax_mohonk_ann)  # the str command tells me there are 67 rows, 2 columns. the column names are "year" and "mean_tmax"

# Q9. same as previous question except aggregate by month
# Name the columns "month", "mean_tmax"
catskill_tmax_mohonk_ann_month <- aggregate(catskill_tmax_2$MOHONK, list(catskill_tmax_2$month), "mean", na.rm=TRUE)
colnames(catskill_tmax_mohonk_ann_month) <- c("month", "mean_tmax")
str(catskill_tmax_mohonk_ann_month)  # the str command tells me there are 12 rows, 2 columns. the column names are "month" and "mean_tmax"

# Q10
# based on the results of the previous questions,
# make a boxplot of the annual mean temperatures
boxplot(catskill_tmax_mohonk_ann$mean_tmax~catskill_tmax_mohonk_ann$year, main="MOHONK annual mean temperature", xlab="year", ylab="tmax at MOHONK station")
