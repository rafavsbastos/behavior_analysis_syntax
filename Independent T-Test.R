#Independent groups t-test

#First step: install the packages
install.packages("ggplot2")
install.packages("psych")
install.packages("effsize")

#Selecting the packages
library(ggplot2)
library(psych)
library(effsize)

# The data I'm using is called "my_data", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis
# cont_variable = continuous variable you want to see if there's difference
# group_variable = grouping variable

my_data <- read_sav("Insert_path")
View(my_data)

#Treating missing values
plotdata = na.omit(my_data[,c("continuous_variable","group_variable")])

#Plotting a histogram
ggplot(plotdata, aes(x = continuous_variable)) +
  geom_histogram(aes(y = ..density..),col="black",binwidth = 0.2,alpha=0.7) + 
  geom_density(size=2) +
  theme_bw()+labs(x = "Numerical variable by Categorical Variable")+ facet_wrap(~ group_variable)+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=14,face="bold"))


#Descriptive statistics
descrpt=with(my_data,describeBy(group_variable, cont_variable,mat=T,digits = 2))
descrpt


#F-test to test equality of variance
var.test(continuous_variable ~ group_variable, my_data, 
         alternative = "two.sided")

#Here is the  two samplet t-test statistics
  #You can change de p value level, i'm using 0.95
t.test(continuous_variable ~ group_variable,data=my_data,var.equal=T,
       alternative="two.sided",
       conf.level=0.95)

#EFFECT SIZES
  #Cohen's d
  cohen.d(continuous_variable ~ group_variable, data=my_data, paired=FALSE, 
        conf.level=0.95,noncentral=FALSE)

  #Hedge's g
  cohen.d(continuous_variable ~ group_variable, data=my_data, paired=FALSE, 
        conf.level=0.95,noncentral=FALSE, hedges.correction=TRUE)


