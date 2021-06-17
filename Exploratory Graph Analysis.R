#####
#Exploratory Graph Analysis (EGA)
library(devtools)
devtools::install_github('hfgolino/EGAnet', force = TRUE)
library(EGAnet)

#Selecting variables for first EGA
data <- DemoData[,c("item1","item2","item3","item4","item5")]

#Number of dimensions estimated by normal EGA
EGA.fit(data)

#png('Covid-19.1.png', pointsize=10, width=700, height=480)

#EGA
ega.DemoData <- EGA(
                 data,
                 n = NULL,
                 uni.method = "LE",
                 corr = "cor_auto",
                 model = "glasso",
                 model.args = list(),
                 algorithm = "walktrap",
                 algorithm.args = list(),
                 plot.EGA = TRUE,
                 plot.type = "qgraph",
                 plot.args = list(),
                 verbose = FALSE
                  )
#dev.off()

#Estimating the number of dimensions of n bootstraps from the empirical correlation matrix
bootdata <- bootEGA(data,
                    iter= 1000, 
                    medianStructure = TRUE, 
                    type = "resampling",
                    plot.MedianStructure = TRUE,
                    ncores = 4)

#Looking at the boostraps results
bootdata$summary.table
bootdata$frequency

#Item stability calculation
ic.DemoData <- itemStability(bootdata, orig.wc = ega.DemoData$wc, item.freq = 0.1, plot.item.rep = TRUE)

#png('ic_Covid-19.png', pointsize=10, width=700, height=480)
print(ic.DemoData)
#dev.off()

#Network Loadings
DemoData.Loads <- net.loads(ega.DemoData)
summary(DemoData.Loads)

#Fit a confirmatory factor model using an EGA object
cfa.ega.DemoData <- CFA(ega.obj = ega.DemoData, 
                     data = data, 
                     estimator = "WLSMV", 
                     plot.CFA = TRUE)

#Looking at CFA fit measures
cfa.ega.DemoData$fit.measures
