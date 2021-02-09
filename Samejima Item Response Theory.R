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
factor_loadings <- summary(model)
factor loadings

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

#Lets make a csv table with our data

factor_table <- data.frame(factor_loadings, row.names = NULL)
r_factor_table <- round(factor_table, 3)

table <- round(coefmod1$items, 3)
inf_table <- data.frame(table, row.names = NULL)
inf_table

#Change nrow for the number of items in your scale
table <- matrix(NA, nrow = 4, ncol = 10)

#Write the label of the items bellow; just follow the pattern
table[,1] <- c("Item 1", "Item 2", "Item 3", "Item 4")
table[,2] <- r_factor_table[2,1]
table[,3] <- r_factor_table[2,2]
table[,4] <- inf_table[2,1]
table[,5] <- inf_table[2,2]
table[,6] <- inf_table[2,3]
table[,7] <- inf_table[2,4]
table[,8] <- inf_table[2,5]
table[,9] <- inf_table[2,6]
table[,10] <- inf_table[2,7]
table

#If your instrument has 7 anchors (e.g. Likert scale from 1 - 7), you do not have to change the following sintax
## However, if it's differente, set the number of b's (b1, b2 ...) to the number of anchors -1.
final_table <- rbind(c("Items","Factor_Loadings", "h2", "a", "b1", "b2", "b3","b4","b5","b6"), table)
final_table
#The file will be saved where this code is saved
write.csv2(final_table, file = "IRT.csv", sep = ",", quote = FALSE, 
           row.names = FALSE, col.names = FALSE)
