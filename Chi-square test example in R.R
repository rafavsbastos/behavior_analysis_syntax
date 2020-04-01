#First step: install the packages
install.packages("gplots")

#Selecting the packages
library(gplots)
library(haven)

# The data I'm using is called "my_data", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis

my_data <- read_sav("Insert_path")
View(my_data)
--------------------------------------------------------
#Transform your categorical variables in a table first
  #Change my_data to your data name
  #Change variable1 and variable2 to your categorical data names
table1 <- table(my_data$"variable1", my_data$"variable1")
print(table1)

#A contigent table can be visualized with the code bellow
balloonplot(t(table1), main ="Title name", xlab ="Variable name", ylab="Variable name",
            label = FALSE, show.margins = FALSE)

# Here is the chi-square test
chisq_test <- chisq.test(table1)
chisq_test

# Observed data
chisq_test$observed

# Expected data
round(chisq_test$expected,2)

# Pearson Residuals
round(chisq_test$residuals, 3)
