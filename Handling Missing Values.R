#Testing for missing values

is.na(DemoData) # returns TRUE of x is missing

#Recoding values to missing
# recode 99 to missing for variable v1
# select rows where v1 is 99 and recode column v1
DemoData$v1[DemoData$v1==99] <- NA

# list rows of data that have missing values
DemoData[!complete.cases(DemoData),]

# create new dataset without missing data
newdataset <- na.omit(DemoData)