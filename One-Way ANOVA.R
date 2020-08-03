#First step: install packages
install.packages("apaTables")

#Selecting the packages
library(dplyr)
library(apaTables)

# The data I'm using is called "my_data", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis
# Change the data type: if it's excel, put "my_data <- read_excel("Path")

my_data <- read_sav("Insert_path")
View(my_data)

#my_data = data argument
#variable2 = numerical variable argument, like age, the one you want to see 
  #if there's difference
#group_variable: the group variable, like sexual orientation


#Compute summary statistics (N, Mean, SD)
  # First argument (my_data): dataset
  # Second argument (group_variable): group category
  # Third argument (variable2): variable you wish to diferenciate, such as age...

group_by(my_data, group_variable) %>%
  summarise(
    count = n(),
    mean = mean(variable2, na.rm = TRUE),
    sd = sd(variable2, na.rm = TRUE)
  )

#Doing a boxplot; 
  #you can put in the horizontal too, just change FALSE to TRUE
boxplot(my_data$variable2~my_data$group_variable, 
        main="Type the name of the title here", 
        col= rainbow(4), 
        horizontal = FALSE)


# Compute the analysis of variance
res.aov <- aov(variable2 ~ group_variable, data = my_data)
# Summary of the analysis
summary(res.aov)

#For post-hoc tests, use the following syntax
  #put your data name replacing "my data"
  #I'm adjusting the p value with bonferroni method

pairwise.t.test(my_data$variable2, my_data$group_variable, p.adjust.method = "bonferroni")

# Making an APA table
  #Put the filename and the number of the table bellow
apa.aov.table(res.aov, filename = "Table1_APA.doc", table.number = 1)

apa.d.table(iv = group_variable, dv = variable2, data = my_data, 
            filename = "Table6_APA.doc", 
            table.number = 6)

