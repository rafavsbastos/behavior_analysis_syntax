#First step: install the packages
install.packages("lavaan")
install.packages("semPlot")
install.packages("MBESS")

#Selecting the packages
library(lavaan)
library(semPlot)
library(MBESS)
#for information on the package use help(package = "lavaan")

# The data I'm using is called "DemoData", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis
# Change the data type: if it's excel, put "my_data <- read_excel("Path")

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
  #I'm using the Robust Maximum Likelihood estimator for continuous data
  #If you have categorical data, use "estimator = wlsmv"
  #for more arguments, use help(package = "lavaan") and search for "cfa"
cfa.fit <- cfa(model = model1, data = DemoData, estimator = 'mlr')
summary(cfa.fit, fit.measures=TRUE, standardized=TRUE, rsquare = TRUE)

# Here's a visual representation of what we're doing
semPaths(object = cfa.fit,
         layout = "tree",
         rotation = 1,
         whatLabels = "std",
         edge.label.cex = 1,
         what = "std",
         edge.color = "navy")

#Maybe you got a high variance in one or more variables
 #If that happens, check the variance of the real data
  #If the variance of real data is close to the model variance, you're ok
    #substitute the second argument with the name of the problematic item)
#var(DemoData$name.of.the.problematic.item)

#You can have the fit measures in the following function
fitMeasures(cfa.fit)

#Sometimes de modification indices are huge
 #for that use the following function if you want all the results to be shown
 # change the integer to the number of rows you want to show
options(max.print=10000)

#Modification indices goes as follows
modindices(cfa.fit)

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

#________________________________________________________________________________
#If you wish to compare models, use the following syntax
##First, define the second model and it's cfa
model2 <- 'f1 =~ item1 + item2 + item3
          f2 =~ item4 + item5 + item6
          '
cfa.fit2 <- cfa(model = model2, data = DemoData, estimator = 'mlr')

#Then, you'll make the chisq diff
anova(cfa.fit, cfa.fit2)

# View the fit indices for the original model
 #Remember, for AIC/CAIC, BIC and ECVI, lower is better
fitmeasures(cfa.fit, c("aic", "bic", "ecvi"))

# View the fit indices for the updated model
fitmeasures(cfa.fit2, c("aic", "bic", "ecvi"))
