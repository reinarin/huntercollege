# Homework Assignment 3a, Data Analysis and Visualization in R, spring 2022

# In this assignment you will perform a number of bivariate EDA analyses (scatterplot
# overlaid with lowess and linear models) and OLS regression analyses, including outlier
# analysis. Report on what your scatter plot suggests about the relationship. If you
# identify an outlier, make a graph overlaying the regression model including the outlier,
# the lowess model, and the regression model excluding the outlier (each line in a
# different color); and report your regression results for the model excluding the outlier.

# 3a1. mtcars
# Perform bivariate EDA and OLS regression analysis on the data from the built-in
# mtcars dataframe evaluating the relationship between mpg as a function of wt. Make
# sure you get the same results shown in the lecture slides.
data(mtcars)           # load in mtcars dataset
plot(mtcars$wt, mtcars$mpg, main = "lm and lowess(mtcars)")     # scatterplot overlaid with both lowess and linear models
lines(lowess(mtcars$mpg~mtcars$wt), col="red")
abline(lm(mtcars$mpg~mtcars$wt), col="blue")                    # regression model including the outlier (solid blue)
# The scatterplot suggests there is a linear, monotonic relationship.
# Assumptions are met and there is a negative slope.
ols_mpg <- lm(mtcars$mpg~mtcars$wt)       # OLS regression
summary(ols_mpg)
# results: MPG decreases at a rate of -5.3445 miles per gallon per weight in 1000 pounds. The decrease is significant at p<0.05
# slope: -5.3445 mpg/1000 lbs
# p-value: 1.294e-10 (<0.05, so significant)
# adjusted-r2: 0.7446 (close to 1, so a strong relationship)
# deleted any outliers: I identified two outliers from looking at the boxplot of 'wt'
out <- boxplot.stats(mtcars$wt)$out          # identify which values are outliers and save to 'out'
out_ind <- which(mtcars$wt %in% c(out))      # idenitfy which rows contain the outliers
out_ind
mtcars[out_ind,] <- NA                       # change them to NA
abline(lm(mtcars$mpg~mtcars$wt), col="blue", lty=2)             # regression model excluding the outlier (dashed blue)

# 3a2. trees
# Perform analyses on an R built-in dataset called trees, which has measurements of
# tree girth, height, and volume from an analysis of black cherry trees. First look at the
# meta data to understand the data (type in ?trees). Perform EDA and OLS regression on
# tree volume as a function of tree height (volume~height), and then on volume as a function
# of girth (volume~girth). For each analysis report on the scatterplot results, slope,
# p-value, and adjusted-r2, and whether you deleted any outliers. Also, tell which
# variable you think provides the best model for volume and explain why you think so. Make
# sure you refer to the graphical as well as the numerical results to explain your
# answer. [Just for fun, run this function: plot(trees).]
data(trees)
?trees
plot(trees$Height, trees$Volume, main = "lm and lowess(trees)")     # scatterplot overlaid with both lowess and linear models
lines(lowess(trees$Volume~trees$Height), col="red")                 # of volume as a function of height
abline(lm(trees$Volume~trees$Height), col="blue")
ols_height <- lm(trees$Volume~trees$Height)     # OLS regression
summary(ols_height)
# results: Volume increases at a rate of 1.5433 cubic feet per height in feet. The increase is significant at p<0.05
# slope: 1.5433 cubic ft/ft
# p-value: 0.0003784 (<0.05, so significant)
# adjusted-r2: 0.3358 (not close to 1, so not a strong relationship)
# deleted any outliers: none (I looked at the boxplot of Height, and there were no outliers)
plot(trees$Girth, trees$Volume, main = "lm and lowess(trees)")     # scatterplot overlaid with both lowess and linear models
lines(lowess(trees$Volume~trees$Girth), col="red")                 # of volume as a function of girth
abline(lm(trees$Volume~trees$Girth), col="blue")
ols_girth <- lm(trees$Volume~trees$Girth)       # OLS regression
summary(ols_girth)
# results: Volume increases at a rate of 5.0659 cubic feet per Girth in inches. The increase is significant at p<0.05
# slope: 5.0659 cubic ft/inch
# p-value: <2.2e-16 (<0.05, so significant)
# adjusted-r2: 0.9331
# deleted any outliers: none (I looked at the boxplot of Girth and there were no outliers)
# I think that "girth" provides the best model for 'volume' because 'girth' had a stronger relationship with 'volume' by looking at the adjusted-r2 value, which was closer to 1.
# Also, looking at the scatterplot, the plot had less scatter, so I think 'girth' provides the best model for 'volume'
plot(trees)

# 3a3. xy_hw3
# Perform the analysis on the x and y variables provided to you in the file xy_hw3.csv.
# Report on the scatterplot results, slope, p-value, and adjusted-r2, and whether you
# deleted any outliers.
fn <- "xy_hw3.csv"                    # assign the name of the text file to fn
hw3 <- read.csv(fn, header=TRUE)      # read in the text file and keep the column names, delimited using spaces
plot(hw3$y, hw3$x, main = "lm and lowess(hw3)")                    # scatterplot overlaid with both lowess and linear models
lines(lowess(hw3$x~hw3$y), col="red")                              # of x as a function of y
abline(lm(hw3$x~hw3$y), col="blue")
ols_hw3 <- lm(hw3$x~hw3$y)       # OLS regression
summary(ols_hw3)
# results: X decreases at a rate of -0.32748 units per Y units. The decrease is significant at p<0.05
# slope: -0.32748 units/units
# p-value: 0.000198 (<0.05, so significant)
# adjusted-r2: 0.5208
# deleted any outliers: none (I looked at the boxplot and there were no outliers)
