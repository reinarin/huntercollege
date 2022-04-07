# Homework Assignment 1b, Data Analysis and Visualization in R, spring 2022

# Q1.
# Make two integer vectors of length 5 named "houseprice" and "lotsize", as follows
houseprice <- c(350, 830, 475, -734, 630)
lotsize <- c(100, 500, 250, 325, 410)

# Q2.
# Make a string vector of length 5 named "ownername" that has these five names: "al", "bob", "carl", "diana", and "ella"
ownername <- c("al", "bob", "carl", "diana", "ella")

# Q3.
# Calculate a boolean vector that identifies which houses have a negative house price (we interpret a negative house price to mean that there is a typo, and the information for that house should be set to "missing")
identify_negative_houseprice <- houseprice < 0

# Q4.
# For any houses with a negative price, replace the values of houseprice, lotsize, and ownername with NA
houseprice[identify_negative_houseprice] <- NA    # for any houses with a negative price, replace values of houseprice with NA
lotsize[identify_negative_houseprice] <- NA       # for any houses with a negative price, replace values of lotsize with NA
ownername[identify_negative_houseprice] <- NA     # for any houses with a negative price, replace values of ownername with NA

# Q5.
# Use the "which.min()" and "which.max()" commands to print out the owner name, houseprice, and lotsize of the houses with the minimum and maximum prices
ownername[which.min(houseprice)]; houseprice[which.min(houseprice)]; lotsize[which.min(houseprice)]   # print out the ownername, houseprice, and lotsize of the house with minimum price
ownername[which.max(houseprice)]; houseprice[which.max(houseprice)]; lotsize[which.max(houseprice)]   # print out the ownername, houseprice, and lotsize of the house with maximum price

# Q6.
# Calculate and print out the mean house price and mean lotsize of all houses that have no missing values
mean(houseprice, na.rm = T) # print mean houseprice of all houses that have no missing values
mean(lotsize, na.rm = T) # print mean lotsize of all houses that have no missing values

# Q7.
# Make a boolean vector that identifies which houses have price > 400; and print out the names of the owners of houses that meet the criteria (your list of names might have "NA" in it; don't worry about that)
identify_houseprice_gt400 <- houseprice > 400
ownername[identify_houseprice_gt400] # print ownername which houseprice is greater than 400

# Q8.
# Make a boolean vector that identifies which houses have lot size < 500; and print out the names of the owners of houses that meet the criteria (your list of names might have "NA" in it; don't worry about that)
identify_lotsize_lt500 <- lotsize < 500
ownername[identify_lotsize_lt500] # print ownername which lotsize is less than 500

# Q9.
# Make a boolean vector that identifies all houses with price > 400 and lotsize < 500, and print out the names of the owners of houses that meet both the criteria (your list of names might have "NA" in it; don't worry about that)
identify_houseprice_gt400_lotsize_lt500 <- houseprice > 400 & lotsize < 500
ownername[identify_houseprice_gt400_lotsize_lt500] # print ownername which houseprice is greater than 400 and lotsize is less than 500

# Q10.
# Calculate and print out the mean price and mean lot size of houses that meet both criteria from the instruction before this one
mean(houseprice[identify_houseprice_gt400_lotsize_lt500], na.rm = T) # print mean houseprice which houseprice is greater than 400 and lotsize is less than 500
mean(lotsize[identify_houseprice_gt400_lotsize_lt500], na.rm = T) # print mean lotsize which houseprice is greater than 400 and lotsize is less than 500
