# Homework Assignment 4b, Data Analysis and Visualization in R, spring 2022

# PNG File 1.
# Make a figure for a report or a powerpoint presentation that includes the four plots
# that you made in 4a stacked vertically, and save the results to a PNG file.
# Make the height and weight of the figure, which has 4 plots, so that it looks good on
# a page of a report. The size should be approximately the size of a page, and the
# resolution should be at least 300dpi.
# Play with the height/width, and pointsize to get the figure and text to look ok.
# Near the top left of each panel, use the text() function to put "(a)" on the first
# plot, "(b)" on the second plot, etc... to the fourth plot.

data(iris)                 # load data
png("myfigure1.png", width=8.5, height=11, units="in", res=300, pointsize=14) 
par(mfcol=c(4,1), mar = c(2, 4, 1, 4))          # 4 row, 1 column to stack them vertically

# version 1
plot(Sepal.Length~Sepal.Width, data=iris)
text(2.0,8.0,"(a)",pos=1, cex=1)

# version 2
plot(Sepal.Length~Sepal.Width, data=iris, pch=21, bg=c("red","green","blue")[as.integer(Species)])   # choose symbol 21- filled circle (default is 1- empty circle)
lm_iris <- lm(Sepal.Length~Sepal.Width, data=iris)
abline(lm_iris, col="black")
text(2.0,8.0,"(b)",pos=1, cex=1)

# version 3
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
text(2.0,8.0,"(c)",pos=1, cex=1)

# version 4
plot(Sepal.Length~Sepal.Width, data=iris, pch=21, bg=c("red","green","blue")[as.integer(Species)], 
     xlab="Sepal width", ylab="Sepal length", main="Iris sepal length vs width grouped by species")
abline(lm_iris_setosa$coefficients, col="red")             # linear model for setosa (solid red line)
abline(lm_iris_versicolor$coefficients, col="green")       # linear model for versicolor (solid green line)
abline(lm_iris_virginica$coefficients, col="blue")         # linear model for virginica (solid blue line)
lines(lowess(iris$Sepal.Length[iris$Species=="setosa"]~iris$Sepal.Width[iris$Species=="setosa"]), col="red", lty=2)              # lowess smoother for setosa (dashed red line)
lines(lowess(iris$Sepal.Length[iris$Species=="versicolor"]~iris$Sepal.Width[iris$Species=="versicolor"]), col="green", lty=2)    # lowess smoother for versicolor (dashed green line)
lines(lowess(iris$Sepal.Length[iris$Species=="virginica"]~iris$Sepal.Width[iris$Species=="virginica"]), col="blue", lty=2)       # lowess smoother for virginica (dashed blue line)
legend(x="bottomright", legend=c("Linear Model- Setosa", "Linear Model- Versicolor", "Linear Model- Virginica", "Lowess Smoother- Setosa", "Lowess Smoother- Versicolor", "Lowess Smoother- Virginica"), 
       col=c("red","green","blue"), lty=c(1,1,1,2,2,2), cex=0.6, text.width=0.4)  # make a plot legend
lm_sum_setosa <- summary(lm_iris_setosa)              # save summary of linear model
lm_sum_versicolor <- summary(lm_iris_versicolor)
lm_sum_virginica <- summary(lm_iris_virginica)
adr2_setosa <- lm_sum_setosa$adj.r.squared            # save the adjusted R2 value
adr2_versicolor <- lm_sum_versicolor$adj.r.squared
adr2_virginica <- lm_sum_virginica$adj.r.squared
arrows(x0=4.2, y0=6.0, x1=4.4, y1=5.7,length=0.1)
text(4.2,6.0,round(adr2_setosa,3),pos=2, cex=0.75)          # setosa linear model- adjusted R2 value = 0.542
arrows(x0=4.4, y0=6.5, x1=4.4, y1=7.4,length=0.1)
text(4.4,6.5,round(adr2_versicolor,3),pos=1, cex=0.75)      # versicolor linear model- adjusted R2 value = 0.262
arrows(x0=4.0, y0=7.7, x1=4.2, y1=7.7,length=0.1)
text(4.0,7.7,round(adr2_virginica,3),pos=2, cex=0.75)       # virginica linear model- adjusted R2 value = 0.193
text(2.0,8.0,"(d)",pos=1, cex=1)
dev.off()   # return to console
par(mfrow=c(1,1))  # return to default

# PNG File 2.
# Make a fifure for a powerpoint presentation that includes only the fourth (best)
# plot, and save the results to a PNG file.
# Make the height and width of the figure, which has only 1 plot, so that it looks good
# on a slide presentation.

png("myfigure2.png", width=12, height=6, units="in", res=300, pointsize=14)

plot(Sepal.Length~Sepal.Width, data=iris, pch=21, bg=c("red","green","blue")[as.integer(Species)], 
     xlab="Sepal width", ylab="Sepal length", main="Iris sepal length vs width grouped by species")
abline(lm_iris_setosa$coefficients, col="red")             # linear model for setosa (solid red line)
abline(lm_iris_versicolor$coefficients, col="green")       # linear model for versicolor (solid green line)
abline(lm_iris_virginica$coefficients, col="blue")         # linear model for virginica (solid blue line)
lines(lowess(iris$Sepal.Length[iris$Species=="setosa"]~iris$Sepal.Width[iris$Species=="setosa"]), col="red", lty=2)              # lowess smoother for setosa (dashed red line)
lines(lowess(iris$Sepal.Length[iris$Species=="versicolor"]~iris$Sepal.Width[iris$Species=="versicolor"]), col="green", lty=2)    # lowess smoother for versicolor (dashed green line)
lines(lowess(iris$Sepal.Length[iris$Species=="virginica"]~iris$Sepal.Width[iris$Species=="virginica"]), col="blue", lty=2)       # lowess smoother for virginica (dashed blue line)
legend(x="bottomright", legend=c("Linear Model- Setosa", "Linear Model- Versicolor", "Linear Model- Virginica", "Lowess Smoother- Setosa", "Lowess Smoother- Versicolor", "Lowess Smoother- Virginica"), 
       col=c("red","green","blue"), lty=c(1,1,1,2,2,2), cex=0.6, text.width=0.4)  # make a plot legend
lm_sum_setosa <- summary(lm_iris_setosa)              # save summary of linear model
lm_sum_versicolor <- summary(lm_iris_versicolor)
lm_sum_virginica <- summary(lm_iris_virginica)
adr2_setosa <- lm_sum_setosa$adj.r.squared            # save the adjusted R2 value
adr2_versicolor <- lm_sum_versicolor$adj.r.squared
adr2_virginica <- lm_sum_virginica$adj.r.squared
arrows(x0=4.2, y0=6.0, x1=4.4, y1=5.7,length=0.1)
text(4.2,6.0,round(adr2_setosa,3),pos=2, cex=0.75)          # setosa linear model- adjusted R2 value = 0.542
arrows(x0=4.4, y0=6.5, x1=4.4, y1=7.4,length=0.1)
text(4.4,6.5,round(adr2_versicolor,3),pos=1, cex=0.75)      # versicolor linear model- adjusted R2 value = 0.262
arrows(x0=4.0, y0=7.7, x1=4.2, y1=7.7,length=0.1)
text(4.0,7.7,round(adr2_virginica,3),pos=2, cex=0.75)       # virginica linear model- adjusted R2 value = 0.193
dev.off()   # return to console
par(mfrow=c(1,1))  # return to default