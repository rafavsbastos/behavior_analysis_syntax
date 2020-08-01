#First step: install packages
install.packages("apaTables")
install.packages("lsr")
install.packages("car")
install.packages("ggplot2")
install.packages("hrbrthemes")

#Selecting the packages
library(apaTables)
library(lsr)
library(car)
library(ggplot2)
library(hrbrthemes)


# The data I'm using is called "my_data", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis
# Change the data type: if it's excell, put "my_data <- read_excel("Path")

my_data <- read_sav("Insert_path")
View(my_data)


#For a simple regression, put the outcome variable name in the firts argument
  #and predictors in the second, third...
basic.reg <- lm(formula = outcome ~ predictor1 + predictor2, data = my_data)
print(basic.reg)

#I'm using backward elimination, you can use forward elimination too
step(object = basic.reg, direction = "backward")

#Calculating residuals and coefficients
summary(basic.reg)


#Calculating standardised regression coefficients
standardCoefs(basic.reg)


#Residuals
residuals(object = basic.reg)
rstandard(model = basic.reg)


#Checking the normality of the residuals
hist( x = residuals(basic.reg),
      xlab = "Value of residual",
      main = "",
      breaks = 20)

qqnorm(residuals(basic.reg))
qqline(residuals(basic.reg))


#Checking the linearity of the relationship
  #Put the name of the outcome variable in "outcome_variable"
fit1 <- fitted.values(object = basic.reg)
plot( x = fit1, 
      y = my_data$outcome_variable,
      xlab = "Fitted Values",
      ylab = "Observed Values" 
)
plot(x = basic.reg, which = 1)

# Plot linear trend + confidence interval
p3 <- ggplot(DemoData, aes(x=var_x, y=var_y)) +
  geom_point() +
  geom_smooth(method=lm , color="red", fill="#69b3a2", se=TRUE) +
  theme_ipsum()

print(p3)


#Collinearity
vif(mod = basic.reg)


#Making an APA Table
  #Change the table number in the table.number
apa.reg.table(basic.reg, filename = "Table2_APA.doc", table.number = 2)
