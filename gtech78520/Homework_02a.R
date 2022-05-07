# Homework Assignment 2a, Data Analysis and Visualization in R, spring 2022

# Working with Data, and numerical EDA

# Comment lines:
# all characters on a line following the "#" symbol are considered comments,
# and are ignored by R. They are for you to explain what you are doing
# to other people looking at your code, and to yourself when you look at your
# code in the future.

# Instructions. 
# 1. Set your default directory using the "Session" tab
# 2. Save this file under the name "xxx_hw2a.R", where xxx is your last name
# 3. Go through each question and type in the code in the lines 
# following the question. 

# Q1. making data frames
# make a dataframe called "mypeople" dimension 4x3 (4 rows, 3 columns)
# (hint: first make a vector for each column, then use the data.frame command to combine)
# the first column will contain names of people you know (character)
# the second column will contain their ages (numerical)
# the third column will contain the relationship of that
# person to you (e.g. friend, parent, spouse, ...)
# Set the column names to "name", "age", and "relationship"
name <- c("Deanna", "Avy", "Huan", "Jake")
age <- c(23, 24, 54, 25)
relationship <- c("friend", "spouse", "parent", "friend")
mypeople <- data.frame(name, age, relationship)

# Q2. retrieving the column names
# write code to print out the column names
colnames(mypeople)

# Q3. working with specific columns
# copy the "age" column of "mypeople" into a new vector
mypeople$age

# Q4. write the dataframe to output files
# save mypeople to a file in csv format, include the row.names=F option!
write.csv(mypeople,"C:\\Users\\Reina\\Desktop\\GTECH78520\\mypeople.csv", row.names = F)

# Q5. reading dataframes
# read in the csv file that you made into a new variable called mypeople_2
# print out the contents of 
# both mypeople and mypeople_2 to make sure that they are the same
# use the "identical" command to check if they are the same
# (use the str() command to see how they are different)
mypeople_2 <- read.csv("C:\\Users\\Reina\\Desktop\\GTECH78520\\mypeople.csv")
mypeople                         # print out contents of mypeople
mypeople_2                       # print out contents of mypeople_2
identical(mypeople, mypeople_2)  # they are different
str(mypeople)                    # age is numeric
str(mypeople_2)                  # age is integer

# Q6. Look at the structure of the built-in data set "iris"
# Use the summary command to print out information about each column.
str(iris)
summary(iris)

# Q7. Make a copy of iris called iris2 that has only the first four columns, but
# not the "species" column
iris2 <- iris[, 1:4]

# Q8 
# Use the apply command to calculate the median of each column of iris2, and then
# print out the medians. Make sure that they agree with the information 
# in the summary command.
apply(iris2, 2, median)
summary(iris2)             # they agree with the information in the summary command

# Q9
# Use the aggregate command on the iris dataframe (NOT iris2)
# to calculate the mean sepal length for each species of iris
aggregate(iris$Sepal.Length, list(iris$Species), mean)

# Q10 EXTRA CREDIT!
# use the aggregate command on the mtcars dataframe
# calculate the mean miles-per-gallon for cars with every 
# combination of "gear" and "vs". Save your results to 
# a dataframe named ag_out, and set the names of the columns of ag_out
# to "gear", "vs", "mean_mpg".
# Then, print the dataframe ag_out to the console
ag_out <- aggregate(mtcars$mpg, list(mtcars$gear, mtcars$vs), mean)
colnames(ag_out) <- c("gear", "vs", "mean_mpg")
ag_out
