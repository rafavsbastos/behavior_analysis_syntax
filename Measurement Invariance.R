#First step: install the package
install.packages("semTools")

#Then load the packege
library(semTools)

#for information on the package use help(package = "lavaan")

# The data I'm using is called "DemoData", feel free to use another name for your data.
## Just remember to change the name of the data on the syntax
### Insert the path of the dataframe inside paranthesis
#### Change the data type: if it's excel, put "my_data <- read_excel("Path")

DemoData <- read_sav("Insert_path")
View(DemoData)
--------------------------------------------------------

# You have to say the model you are using.
## My model: two factors explained by a high order factor
### If you don't want a high order, just remove the f3 variable

model1 <- 'f1 =~ item1 + item2 + item3
          f2 =~ item4 + item5 + item6
          f3 =~ f1 + f2
          '

# Measurement Invariance goes as follows
## You have to put the name of your grouping variable inside paranthesis in "group"
###By adding the group.partial argument, you can test for partial measurement invariance by allowing a few parameters to remain free.

measurementInvariance(model1, 
                      data = DemoData, 
                      group = "grouping.variable")

