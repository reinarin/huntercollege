# Homework Assignment 1a, Data Analysis and Visualization in R, spring 2022

# Basics of R and Rstudio, scalars and vectors 

# Comment lines:
# all characters on a line following the "#" symbol are considered comments,
# and are ignored by R. They are for you to explain what you are doing
# to other people looking at your code, and to yourself when you look at your
# code in the future.

# Instructions. 
# 1. Set your default directory using the "Session" tab
# 2. Save this file under the name "xxx_hw1a.R", where xxx is your last name
# 3. Go through each question and type in the code in the lines 
# following the question. 

########################################################################
# NOTE: you should feel free to cut, paste, borrow, and steal code from any
# other course material (the .R files that I provide to you, lecture notes),
# or from any on line source. If I previously gave you code to perform some
# analysis that is similar to the homework question, you should copy from the
# other source, and then edit it to fit the homework!
########################################################################

# Q1.  lines
# type a comment line after this line telling me your name
# Reina Li

# Q2. Using mathematical operators
# write one line of code for each of the following calculations:
#   add 2 and 7
#   subtract 7 from 2
#   multiply 2 and 7
#   divide 7 by 2
#   7 raised to the second power
2 + 7     # add 2 and 7
2 - 7     # subtract 7 from 2
2 * 7     # multiply 2 and 7
7 / 2     # divide 7 by 2
7 ^ 2     # 7 raised to second power

# Q3. Making Scalars
# run the following lines of code in order, by putting the cursor on the top line
# and hitting the RStudio "run" button, and in a comment on the right
# of each line of code explain what it does
a <- 3            # assigns 3 to a
a                 # print the value stored in a   
b <- 4 + 5        # assign the addition of 4 and 5 to b
b                 # print the value stored in b
bsum <- b + 3     # assign the addition of b and 3 to bsum
bsum              # print the value stored in bsum
str(bsum)         # display the structure of bsum

# Q4. select the six lines above at the same time, and hit the "run" button,
# and explain what happened.
# The lines of code ran in order, and the line prompts and system responses were printed in order right after each line of code

# Q5. assigning values to vectors. Make one line of code for each of these.
# make a numerical vector with the values 1, 2, and 3 using the "c()" command
# make a numerical vector with the values 1, 2, and 3 using the "seq()" command
# make a numerical vector with the values 1, 2, and 3 using the ":" operator
# make a string vector with two values, your first and last names using "c()"
# make a logical vector with the values T, F, T, F using "c()"
c(1, 2, 3)               # numerical vector using c() command
seq(1, 3, length = 3)    # numerical vector using seq() command
1:3                      # numerical vector using : command
c("Reina", "Li")         # string vector using c()
c(T, F, T, F)            # boolean vector using c()

# Q6. working with numerical vectors
# make a vector named "Allan1" with 5 integers, and write code to print
# to the console the following information:
#   the length of the vector
#   all values in the vector
#   the second value in the vector
#   the 3rd through 5th values in the vector
#   the minimum value of the vector
#   the maximum value of the vector
Allan1 <- c(10, 20, 30, 40, 50)     # make Allan1 vector
length(Allan1)                      # print length of Allan1 vector
Allan1                              # print all values of Allan1 vector
Allan1[2]                           # print second value of Allan1 vector
Allan1[3:5]                         # print third to 5th values of Allan1 vector
min(Allan1)                         # print minimum value of Allan1 vector
max(Allan1)                         # print maximum value of Allan1 vector

# Q7. using the vector from the previous question, print the following:
#   the element number of the minimum value (use the "which.min()" command)
#   the element number of the maximum value (use the "which.max()" command)
which.min(Allan1)    # print element number of minimum value of Allan1 vector
which.max(Allan1)    # print element number of maximum value of Allan1 vector

# Q8. making numerical matrices
#  make a matrix of dimensions 5x2,called "Allan2" using the following steps
#   make a numerical vector of length 5 called "a"
#   make a numerical vector of length 5 called "b"
#   use the "cbind()" command to make a matrix called Allan2, with ****CORRECTED****
#                     with a in the first column, and b in the second column
#   print the matrix to the console, and take note of the names of the columns
#   print the results of the command str(Allan2), and explain what it tells you
a <- c(6, 2, 9, 29, 26)    # make "a" vector
b <- c(9, 2, 3, 23, 29)    # make "b" vector
Allan2 <- cbind(a, b)      # column bind a and b and name it Allan2
Allan2                     # I notice there are two column names ("a" and "b")
str(Allan2)                # str(Allan2) tells me the structure of Allan2; data type is numeric, matrix with 5 rows and 2 columns, and it prints all the values of the matrix, and that there are no row names, and there are 2 character type column names

# Q9. another method of making numerical matrices
#  First, use the "matrix" command to make a 10x3 matrix called Frei1, 
#         with all values initialized to NA
#  Second, use the "matrix" command to make a 10x3 matrix called Frei2,
#         with all values initialized to zero
#  Third, use the "matrix" command to make a 10x3 matrix called Frei3,
#         with values initialized to the sequence of numbers from 1 to 30
#         (hint: google "how to make a matrix in r" as described in the lecture)
Frei1 <- matrix(NA, nrow = 10, ncol = 3)                       # make 10 row, 3 column matrix, all NA values using matrix() command and name the matrix Frei1
Frei2 <- matrix(0, nrow = 10, ncol = 3)                        # make 10 row, 3 column matrix, all 0 values using matrix() command and name the matrix Frei2
Frei3 <- matrix(seq(1, 30, length = 30), nrow = 10, ncol = 3)  # make 10 row, 3 column matrix, sequential values from 1 to 30 using matrix() command and name the matrix Frei3

# Q10 Working with matrices
#  write a line of code to print out each of the following values of Frei3 
#  (one line of code for each question)
#        the value in the second row / third column
#        all values in the second column
#        all values in the 9th row
#        all values in rows 2 through 4 (inclusive)
#        the minimum value in the matrix
Frei3[2, 3]                  # print Frei3 value in row 2, column 3
Frei3[, 2]                   # print all Frei3 values in column 2
Frei3[9,]                    # print all Frei3 values in row 9
Frei3[2:4,]                  # print all Frei3 values in rows 2 to 4
Frei3[which.min(Frei3)]      # print minimum value of Frei3

# Q11. access specific elements of a matrix.
# write a line of code to do each of the following for Frei3:
#        set the value of row 9, column 2 to 7 
#        calculate the mean of column2 
#        set the value of row 9, column 2 to NA
#        calculate the mean of all non-missing values in column2 
#        change the minimum value to NA
Frei3[9, 2] <- 7                # change Frei3 row 9, column 2 to 7
mean(Frei3[, 2])                # calculate and print mean of Frei3 column 2
Frei3[9, 2] <- NA               # change Frei3 row 9, column 2 to NA
mean(Frei3[, 2], na.rm = T)     # calculate and print mean of Frei3 column 2 without NA values
Frei3[which.min(Frei3)] <- NA   # change the minimum value of Frei3 to NA

# Q12. Relational operators to evaluate values of a matrix
# write a line of code to do each of the following:
# use the "matrix" command to make a 10x3 matrix called m30,
#     with values initialized to the sequence of numbers from 1 to 30
# Print out either "T" or "F" indicating whether: 
#     the 5th row, 3rd column of m30 is equal to 5
#     the 5th row, 3rd column of m30 is greater than to 5
#     the 8th row, 2nd column of m30 is greater than or equal to 15
# Make a matrix called m30_gt15 that has a T or F indicating 
#     whether each element of m30 is greater than 15
# Make a vector called m30_gt15_c1 that has a T or F indicating 
#     whether each element of the first column of m30 is greater than 3
m30 <- matrix(seq(1, 30, length = 30), nrow = 10, ncol = 3)      # make 10 row 3 column matrix called m30 with sequential number from 1 to 30 
m30[5, 3] == 5                                                   # check if value in m30 row 5, column 3 is equal to 5
m30[5, 3] > 5                                                    # check if value in m30 row 5, column 3 is greater than 5
m30[8, 2] >= 15                                                  # check if value in m30 row 8, column 2 is greater than or equal to 15
m30_gt15 <- m30 > 15                                             # make boolean vector called m30_gt15 that identify the elements of m30 that is greater than 15
m30_gt15_c1 <- m30[, 1] > 3                                      # make boolean vector called m30_gt15_c1 that identify the elements of m30 column 1 that is greater than 3

# Q13. Relational operators to assign values to elements of a matrix
# write a line of code to do each of the following:
#   make a 5x5 matrix called m55 with the sequence of values from 1 to 25
#   calculate the mean of all values of m55
#   Set all values of m55 that are greater than 23 to NA
#   calculate the mean of all non missing values of m55
m55 <- matrix(seq(1, 25, length = 25), nrow = 5, ncol = 5)     # make 5 row 5 column matrix called m55 with sequential value from 1 to 25
m55                                                            # Q14; print the original matrix
mean(m55)                                                      # calculate mean of all m55 values
m55[m55 > 23] <- NA                                            # change all m55 values that are greater than 23 to NA
m55                                                            # Q14; print the changed matrix
mean(m55, na.rm = T)                                           # calculate mean of m55 without NA values

# Q14. keeping the original version of the matrix
#   In the previous question you cannot see the original values of m55
#     after you have changed some of the values. Add a line of code 
#     to your answer to the previous question to keep copies of the original matrix
#     and the changed matrix