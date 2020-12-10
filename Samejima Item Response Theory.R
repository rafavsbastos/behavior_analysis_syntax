#First step: install the package
install.packages("mirt")

#Selecting the packages
library(mirt)

# The data I'm using is called "DemoData", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis

DemoData <- read_sav("Insert_path")
View(DemoData)
#--------------------------------------------------------

# Samejima Item Response Theory
# I'm using the model with one factor (that's why the integer 1)

model <- mirt(DemoData, 1, itemtype = 'graded')
summary(model)
itemfit(model)
coefmod1<-coef(model, IRTpars=TRUE, simplify = TRUE)
coefmod1

plot(model, type="infotrace")
plot(model, type = 'infoSE',
     theta_lim=c(-4,4), main="Test information curve")
plot(model, type = 'info')


bwtheme <- standard.theme("pdf", color=FALSE)

plot(model, type = 'infoSE', par.settings = bwtheme,
     theta_lim=c(-4,4), main="Test information curve with dotted standard error", lwd=20)


#To plot the item information curve, put all the items like the syntax below
itemplot(model,1, type="trace", main="CCI item1")
itemplot(model,2, type="trace", main="CCI item2")
itemplot(model,3, type="trace", main="CCI item3")
itemplot(model,4, type="trace", main="CCI item4")
