#First step: install the packages
install.packages("lavaan")

#Selecting the packages
library(lavaan)
#for information on the package use help(package = "lavaan")

# The data I'm using is called "DemoData", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis

DemoData <- read_sav("Insert_path")
View(DemoData)
--------------------------------------------------------

# You have to say the model you are using.
# My model: two factors explained by a high order factor
# If you don't want a high order, just remove the f3 variable

model1 <- 'f1 =~ item1 + item2 + item3
          f2 =~ item4 + item5 + item6
          f3 =~ f1 + f2
          '
#For Fit Confirmatory Factor Analysis Models we use the function cfa
  #I'm using the Robust Maximum Likelihood estimator
  #for more arguments, use help(package = "lavaan") and search for "cfa"
cfa1 <- cfa(model1, data=DemoData, estimator = 'mlr')
summary(cfa1, fit.measures=TRUE, standardized=TRUE)

#You can have the fit measures in the following function
fitMeasures(cfa1)

#Sometimes de modification indices are huge
 #for that use the following function if you want all the results to be shown
 # change the integer to the number of rows you want to show
options(max.print=10000)

#Modification indices goes as follows
modindices(cfa1)


###Calculating reliability with Alpha and Omega
  #Select the items you want to use to calculate the reliability by putting each name in paranthesis
  #It shows the upper and lower limits

r1 <- DemoData[,c("item1", "item2", "item3")]

ci.reliability(data=r1, type='alpha', interval.type = "41", B=500)
ci.reliability(data=r1, type='omega', interval.type = "41", B=500)


r2 <- DemoData[,c("item4", "item5", "item6")]

ci.reliability(data=r2, type='alpha', interval.type = "41", B=500)
ci.reliability(data=r2, type='omega', interval.type = "41", B=500)


r3 <- DemoData[,c("item1", "item2", "item3", "item4", "item5", "item6" )]

ci.reliability(data=r3, type='alpha', interval.type = "41", B=500)
ci.reliability(data=r3, type='omega', interval.type = "41", B=500)

