# Homework Assignment 4a, Data Analysis and Visualization in R, spring 2022

# load in iris data set
data(iris)

# Version 1.
# Simple scatter plot using all default values
plot(Sepal.Length~Sepal.Width, data=iris)

# Version 2.
# Enhance version 1 by adding the following:
# Symbols: Choose one symbol that is not the default symbol to use for all data points.
# Colors: Show each species using a different color.
# Linear model: Show one linear model line, including all data points for all species, in black.
plot(Sepal.Length~Sepal.Width, data=iris, pch=21, bg=c("red","green","blue")[as.integer(Species)])   # choose symbol 21- filled circle (default is 1- empty circle)
lm_iris <- lm(Sepal.Length~Sepal.Width, data=iris)
abline(lm_iris, col="black")

# Version 3.
# Enhance version 2 by adding the following:
# Linear model: remove the linear model from version 2, and add a linear model line for each species
# individually, colored the same as the data points for each species
# Also include a lowess smoother for each species, colored the same as the linear line, but using
# a different line type.
plot(Sepal.Length~Sepal.Width, data=iris, pch=21, bg=c("red","green","blue")[as.integer(Species)])
lm_iris_setosa <- lm(Sepal.Length~Sepal.Width, data=iris[which(iris$Species=="setosa"),])
lm_iris_versicolor <- lm(Sepal.Length~Sepal.Width, data=iris[which(iris$Species=="versicolor"),])
lm_iris_virginica <- lm(Sepal.Length~Sepal.Width, data=iris[which(iris$Species=="virginica"),])
abline(lm_iris_setosa$coefficients, col="red")             # linear model for setosa (solid red line)
abline(lm_iris_versicolor$coefficients, col="green")       # linear model for versicolor (solid green line)
abline(lm_iris_virginica$coefficients, col="blue")         # linear model for virginica (solid blue line)
lines(lowess(iris$Sepal.Length[iris$Species=="setosa"]~iris$Sepal.Width[iris$Species=="setosa"]), col="red", lty=2)              # lowess smoother for setosa (dashed red line)
lines(lowess(iris$Sepal.Length[iris$Species=="versicolor"]~iris$Sepal.Width[iris$Species=="versicolor"]), col="green", lty=2)    # lowess smoother for versicolor (dashed green line)
lines(lowess(iris$Sepal.Length[iris$Species=="virginica"]~iris$Sepal.Width[iris$Species=="virginica"]), col="blue", lty=2)       # lowess smoother for virginica (dashed blue line)

# Version 4.
# Final version. Enhance version 3 by adding the following:
# Labels and title: add appropriate x and y labels, and a plot title
# Legend: Add a legend showing the symbol/color for each species
# Text and arrows: add text for each linear model indicating its adjusted R2 value, and draw an
# arrow from your text to the line.
plot(Sepal.Length~Sepal.Width, data=iris, pch=21, bg=c("red","green","blue")[as.integer(Species)], 
     xlab="Sepal width", ylab="Sepal length", main="Iris sepal length vs width grouped by species")
abline(lm_iris_setosa$coefficients, col="red")             # linear model for setosa (solid red line)
abline(lm_iris_versicolor$coefficients, col="green")       # linear model for versicolor (solid green line)
abline(lm_iris_virginica$coefficients, col="blue")         # linear model for virginica (solid blue line)
lines(lowess(iris$Sepal.Length[iris$Species=="setosa"]~iris$Sepal.Width[iris$Species=="setosa"]), col="red", lty=2)              # lowess smoother for setosa (dashed red line)
lines(lowess(iris$Sepal.Length[iris$Species=="versicolor"]~iris$Sepal.Width[iris$Species=="versicolor"]), col="green", lty=2)    # lowess smoother for versicolor (dashed green line)
lines(lowess(iris$Sepal.Length[iris$Species=="virginica"]~iris$Sepal.Width[iris$Species=="virginica"]), col="blue", lty=2)       # lowess smoother for virginica (dashed blue line)
legend(x="bottomright", legend=c("Linear Model- Setosa", "Linear Model- Versicolor", "Linear Model- Virginica", "Lowess Smoother- Setosa", "Lowess Smoother- Versicolor", "Lowess Smoother- Virginica"), 
       col=c("red","green","blue"), lty=c(1,1,1,2,2,2), cex=0.6)  # make a plot legend
lm_sum_setosa <- summary(lm_iris_setosa)              # save summary of linear model
lm_sum_versicolor <- summary(lm_iris_versicolor)
lm_sum_virginica <- summary(lm_iris_virginica)
adr2_setosa <- lm_sum_setosa$adj.r.squared            # save the adjusted R2 value
adr2_versicolor <- lm_sum_versicolor$adj.r.squared
adr2_virginica <- lm_sum_virginica$adj.r.squared
arrows(x0=4.4, y0=5.3, x1=4.4, y1=5.7,length=0.1)
text(4.4,5.4,round(adr2_setosa,3),pos=1, cex=0.75)          # setosa linear model- adjusted R2 value = 0.542
arrows(x0=4.4, y0=6.5, x1=4.4, y1=7.4,length=0.1)
text(4.4,6.5,round(adr2_versicolor,3),pos=1, cex=0.75)      # versicolor linear model- adjusted R2 value = 0.262
arrows(x0=4.0, y0=7.7, x1=4.2, y1=7.7,length=0.1)
text(4.0,7.7,round(adr2_virginica,3),pos=2, cex=0.75)       # virginica linear model- adjusted R2 value = 0.193
