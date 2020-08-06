#First step: install the packages
install.packages("lavaan")
install.packages("semPlot")
install.packages("semTools")

#Selecting the packages
library(lavaan)
library(semPlot)
library(semTools)

#for information on the package use help(package = "lavaan")

# The data I'm using is called "DemoData", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis
# Change the data type: if it's excel, put "my_data <- read_excel("Path")

DemoData <- read_sav("Insert_path")
View(DemoData)
--------------------------------------------------------
# You have to say the SEM model you are using.
  
  model1 <- '
      #First, put your measurement model
          F1 =~ item1 + item2 + item3
          D2 =~ item4 + item5 + item6
          P3 -~ item7 + item8 + item9
      #Then, put the regression paths
          F1 ~ D2
          P3 ~ D2 + F1
          '

#Fit for a Structural Equation MOdel we use the function sem from lavaan
  #for more arguments, use help(package = "lavaan") and search for "sem"
sem.fit <- sem(model1, data=DemoData)
summary(sem.fit, rsquare = TRUE, standardized=TRUE, fit.measures = TRUE)

semPaths(object = sem.fit,
         layout = "tree2",
         rotation = 2,
         whatLabels = "std",
         edge.label.cex = 0.5,
         what = "std",
         edge.color = "black",
         structural = TRUE)

###Calculating reliability with Alpha and Omega and Average Mean Extratcted (AVE)
reliability(sem.fit)
