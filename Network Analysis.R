library(psych)
library(lavaan)
library(foreign)
library(semTools)
library(equaltestMI)
library(MplusAutomation)
library(ggplot2)
library(semPlot) 
library(qgraph)
library(bootnet)
library(networktools)
library(NetworkComparisonTest)

#Loading the data
##The sintax must be on the same folder as the data
###I'm loading a SPSS data, you can change to .csc with read.csv(etc etc)
mydata <- read.spss(file = "DemoData.sav", to.data.frame = TRUE, use.value.labels = FALSE)

#Now, lets calculate the factor scores

Factor_scores <- 'Factor1 =~ item1 + item2 + item3
                  Factor2 =~ item4 + item5 + item6
                  Factor3 =~ item7 + item8 + item9'

#Indices of the CFA
fitFactorScores <- cfa(Factor_scores, data = mydata, estimator = "DWLS", orthogonal = FALSE) 

#Results of the CFA
Ind_fitFactorScores <- summary(fitFactorScores, fit.measures=TRUE, ci = TRUE, standardized = T, rsquare = TRUE)


# Now, we have to put the factor scores into the data
##It will create a data file in your folder
NetworkScores <- predict(fitFactorScores)
NetworkDataset <- cbind(DemoData,NetworkScores)
write.csv(NetworkDataset,"NetworkDataset.csv")

#Select the variables you wish to remove from your dataset
##Substitute the number with the number of the column of your variables
NewNetworkDataset <- NetworkDataset[,-c(8,11)]

#Then, we have to make a correlation matrix
##First, we transform the data in a matrix
GeneralNetwork <- as.matrix(NewNetworkDataset)
CorGeneralNetwork <- cor(GeneralNetwork)
GeneralSDS <- sqrt(diag(CorGeneralNetwork))

#Final object
networkMatrix <- cor2cov(CorGeneralNetwork, GeneralSDS)

# If you wish to put colors on your network plot, you must say which variables are which column
##Substitute the number with the number of the column of your variables
groups <- list("F1"=c(1), "F2"=c(2), "F3"=c(3))

#Now we are going to make the plot
##Substitute the sampleSize argument with your sample size
networkGraph <- qgraph(abs(networkMatrix), directed = FALSE, layout = "spring", 
                             graph = "glasso", sampleSize = 100, groups = groups)

networkGraph

# Value of the items relations
networkMagnitudes <- getWmat(networkGraph)
networkMagnitudes

# Correlation table of the items
plotMagnitudes <- cor.plot(networkMagnitudes, numbers = TRUE)

# Centrality measures
centrality <- centrality_auto(networkGraph)

nodeCentrality <- centrality$node.centrality
edge <- centralityGeral$edge.betweenness.centrality
centralityPlot(networkGraph, labels = colnames(GeneralNetwork))

centralityPlot(networkGraph, include = c("Strength","Closeness","Betweenness"), orderBy = "Strength")

#Constructing a partial correlation matrix
Nledges <- getWmat(mynetwork)

print(Nledges)

#Estimating Network Stability
b1 <- bootnet(mynetwork, boots = 1000, nCores = 4, statistics = c("strength","expectedInfluence","edge"))
plot(b1, labels = FALSE, order = "sample")


b2 <- bootnet(mynetwork, boots = 1000, nCores = 4, type = "case", statistics = c("strength","expectedInfluence","edge"))
plot(b2, labels = FALSE, order = "sample")

#Get centrality stability coefficient
corStability(b2)

#Testing for significant differences
differenceTest(b1, 3, 4, "strength")

plot(b1, "edge", plot = "difference", onlyNonZero = TRUE, order = "sample")