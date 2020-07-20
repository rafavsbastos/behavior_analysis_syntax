#HISTOGRAM
#I'm creating a fake dataset so we can make a histogram
DemoData=c(91,49,76,112,97,42,70, 100, 8, 112, 95, 90, 78, 62, 56, 94, 65, 58, 109, 70, 109, 91, 71, 76, 68, 62, 134, 57, 83, 66)

hist(DemoData, xlab='Data Points', main='Title of Histogram', freq=TRUE, col='white', breaks=10)

hist(DemoData, xlab='Data Points', main='Title of Histogram', freq=FALSE, col='white', breaks=10)
lines(density(DemoData), col='red', lwd=2)

#-----

#SCATTERPLOT

set.seed(2016)

#Let's generate some data so we can make a scatterplot
#First argument = number of data points
#Second argument = avarage
#Third argument = standard deviation
Data1=round(rnorm(50, 78, 10))
Data2=round(rnorm(50, 78, 14))

#Now, let's see the data we generated
Data1
Data2

#Let's generate the scatterplot with the syntax bellow
plot(Data1~Data2, main='Scores for X (50 participants)', xlab='Data1 data', ylab='Data2 data', col='black')
