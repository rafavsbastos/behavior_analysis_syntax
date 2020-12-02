#First step: install the packages
install.packages("lavaan")
install.packages("semTools")

#Selecting the packages
library(lavaan)
library(semTools)
#for information on the package use help(package = "lavaan")

# The data I'm using is called "DemoData", feel free to use another name for your data.
DemoData <- read_sav("Insert_path")
View(DemoData)
#--------------------------------------------------------
#Convert GENDER variable from double to string
DemoData <- transform(DemoData, GENDER = as.character(GENDER))


#We will create a matrix to put our results
all.results<-matrix(NA, nrow = 3, ncol = 6)


#Specifying the baseline model with all items; based on the exploratory factor analysis
model1 <- 'F1 =~ item1 + item2 + item3 + item4'

#Baseline model: no constraints across groups
baseline <- measEq.syntax(configural.model = model1,
                          data = DemoData,
                          ordered = c("item1",
                                      "item2",
                                      "item3",
                                      "item4"),
                          parameterization = "delta",
                          ID.fac = "std.lv",
                          ID.cat = "Wu.Estabrook.2016",
                          group = "GENDER",
                          group.equal = "configural")

summary(baseline)

#To see all of the constraints in the model
cat(as.character(baseline))

# Have to specify as.character to submit to lavaan
model.baseline <- as.character(baseline)

# Fitting baseline model in lavaan via cfa function
fit.baseline <- cfa(model.baseline,
                    data = DemoData,
                    group = "GENDER",
                    ordered = c("item1",
                                "item2",
                                "item3",
                                "item4"))

# Obtaining results from baseline model
summary(fit.baseline)

# Extracting fit indices into the first row of all.results matrix
all.results[1,]<-round(data.matrix(fitmeasures(fit.baseline,
                                               fit.measures = c("chisq.scaled",
                                                                "df.scaled","pvalue.scaled",
                                                                "rmsea.scaled",
                                                                "cfi.scaled",
                                                                "tli.scaled"))),
                       digits=3)
#---------------------------------------------------------------

prop4 <- measEq.syntax(configural.model = model1,
                       data = DemoData,
                       ordered = c("item1",
                                   "item2",
                                   "item3",
                                   "item4")
                       ,parameterization = "delta",
                       ID.fac = "std.lv",
                       ID.cat = "Wu.Estabrook.2016",
                       group = "GENDER",
                       group.equal = c("thresholds"))

model.prop4 <- as.character(prop4)

# Fitting thresholds invariance model in lavaan via cfa function

fit.prop4 <- cfa(model.prop4,
                 data = DemoData,
                 group = "GENDER",
                 ordered = c("item1",
                             "item2",
                             "item3",
                             "item4"),
)

# Obtaining results from thresholds invariance model
summary(fit.prop4)

#Extracting fit indices into the second row of all.results matrix

all.results[2,]<-round(data.matrix(fitmeasures(fit.prop4,
                                               fit.measures = c("chisq.scaled",
                                                                "df.scaled","pvalue.scaled",
                                                                "rmsea.scaled",
                                                                "cfi.scaled",
                                                                "tli.scaled"))),
                       digits=3)

#In order to examine relative model fit and compare the chisquare statistics between baseline model with the model
##where threshold equality constraints are employed, we use
##lavTestLRT function.

lavTestLRT(fit.baseline,fit.prop4)

#------------------------------

prop7 <- measEq.syntax(configural.model = model1,
                       data = DemoData,
                       ordered = c("item1",
                                   "item2",
                                   "item3",
                                   "item4"),
                       parameterization = "delta",
                       ID.fac = "std.lv",
                       ID.cat = "Wu.Estabrook.2016",
                       group = "GENDER",
                       group.equal = c("thresholds", "loadings"))

model.prop7 <- as.character(prop7)

fit.prop7 <- cfa(model.prop7,
                 data = DemoData,
                 group = "GENDER",
                 ordered = c("item1",
                             "item2",
                             "item3",
                             "item4"),
)

summary(fit.prop7)

all.results[3,] <- round(data.matrix(fitmeasures(fit.prop7,
                                                 fit.measures = c("chisq.scaled",
                                                                  "df.scaled",
                                                                  "pvalue.scaled",
                                                                  "rmsea.scaled",
                                                                  "cfi.scaled",
                                                                  "tli.scaled"))),
                         digits = 3)

all.results

#We can conduct chi-square difference test between the
#models that put equality constraints of thresholds (proposition 4) and thresholds and loadings (proposition 7) to
#evaluate attainability of ME/I.

lavTestLRT(fit.prop4, fit.prop7)

#Reference
#DOI: 10.1080/10705511.2019.1602776