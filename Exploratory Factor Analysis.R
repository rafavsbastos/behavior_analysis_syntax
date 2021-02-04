#First step: install the packages
install.packages("psych")
install.packages("MBESS")
install.packages("paran")

#Selecting the packages
library(psych)
library(MBESS)
library(lavaan)
library(haven)

# The data I'm using is called "DemoData", feel free to use another name for your data.
# Just remember to change the name of the data on the syntax
# Insert the path of the dataframe inside paranthesis
# Change the data type: if it's excel, put "my_data <- read_excel("Path")

DemoData <- read_sav("Insert_path")
View(DemoData)
#--------------------------------------------------------
variables <- DemoData[,c("item1", "item2", "item3", "item4")]

### Exploratory Factor Analysis

#Do a polychoric correlation
cor_data <- polychoric(x = variables, smooth = TRUE, global = TRUE, 
                       polycor = FALSE, ML = FALSE, std.err = FALSE,
                       weight = NULL, progress = TRUE, na.rm = TRUE,
                       delete = TRUE)
poly_cor <- cor_data$rho
###Testing the quality of the data with KMO and Bartlett

KMO(poly_cor)

#In the next line: n = number of cases in integer
cortest.bartlett(poly_cor, n=120,diag = TRUE)

# Calculate split-half reliability
splitHalf(poly_cor)

### Parallel Analysis
#fm = extraction method; I'm using maximum likelihood, but you can use another one
#for other methods, please code help(package="psych") and search for fa.parallel
#fa: if you want to use principal componentes use fa = "pc"; fa = "fa" use a principal axis factor analysis

fa.parallel(poly_cor, n.obs = NULL,fm="ml", fa="fa",
            main = "Parallel Analysis Scree Plots", n.iter=500,error.bars=FALSE,
            SMC=FALSE,ylabel=NULL,show.legend=TRUE,sim=TRUE)


#You can use paran packege too, it shows the value of simulated eigenvalues
# Put the number of participants(n) and number of iterations in the first line
paran(mat = poly_cor, n=120, iterations=500, centile=0, quietly=FALSE, 
      status=TRUE, all=TRUE, cfa=TRUE, graph=TRUE, 
      color=TRUE, col=c("black","red","blue"), 
      lty=c(1,2,3), lwd=1, legend=TRUE, file="", 
      width=640, height=640, grdevice="png", seed=0)

### Factor analysis: fit indices

#set the number of factors in "nfactors" and the number of observation in "n.obs"
#rotation methods and extraction methods vary, use help(package = "psych") and go to "fa"
fit <- fa(poly_cor, nfactors = 1, n.obs = 120, rotate = "oblimin", residuals = TRUE, cor = "poly", fm = "minres")
print(fit, sort = TRUE)

fa.diagram(fit)
summary(fit, fit.measures=TRUE, standardized=TRUE)

plot(fit)
biplot(fit)

#--------
###Calculating reliability with Alpha and Omega
  #Select the items you want to use to calculate the reliability by putting each name in paranthesis
  #It shows the upper and lower limits

r1 <- DemoData [,c("item1","item2","item3")]

ci.reliability(data=r1, type='alpha', interval.type = "41", B=500)

r2 <- DemoData [,c("item1","item2","item3")]

ci.reliability(data=r2, type='omega', interval.type = "41", B=500)
