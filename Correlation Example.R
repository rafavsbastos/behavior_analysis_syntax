#First step: install the packages
install.packages("apaTables")
install.packages("corrplot")
install.packages("PerformanceAnalytics")
install.packages("psych")

#Selecting the packages
library(PerformanceAnalytics)
library(corrplot)
library(apaTables)
library(psych)
library(haven)

# The data I'm using is called "DemoData", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis
# Change the data type: if it's excel, put "my_data <- read_excel("Path")
DemoData <- read_sav("Insert_path")
View(DemoData)


#Selecting variables to be correlated;
  #In paranthesis, list the names as follows

variables <- DemoData[, c('q1', 'q2', 'q3', "q4")]

#distribution in diagonal, bivariate scatter plots(bottom)
  #top of the diagonal the correlation value
  # Each significance level is associated to a symbol:
        # p-values(0, 0.001, 0.01, 0.05, 0.1, 1)
        # <=> symbols("***", "**", "*", ".", " ")
chart.Correlation(variables, histogram=TRUE, pch=19)

#For a more simple analysis, I used pearson correlation
  #but you can substitute for spearman of kendall
  #See help(cor)
cor_data = cor(variables, method = c("pearson"))

#If you are dealing with ordinal data, use psychoric correlation and uncomment the next lines

# cor_data <- polychoric(x = variables,smooth=TRUE,global=TRUE,polycor=FALSE, ML = FALSE,
#           std.err=FALSE,weight=NULL,progress=TRUE,na.rm=TRUE, delete=TRUE)

#Here's a correlogram
corrplot(cor_data)

#Rounding output to 2 digits only
rounded = round(cor_data, 2)

#To hide the upper triangle use the following syntax
upper<-rounded
upper[upper.tri(rounded)]<-""
upper<-as.data.frame(upper)
upper

#To hide the lower triangle use the following syntax
lower<-cor_data
lower[lower.tri(cor_data, diag=TRUE)]<-""
lower<-as.data.frame(lower)
lower

#An APA table format
  #If you put the filename = something it'll create a document with the table

apa.cor.table(variables, filename= "Correlation_Tables.doc", table.number=1,
              show.conf.interval = FALSE, landscape = TRUE)
