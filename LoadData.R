rm(list=ls())  # free up memory for the download of the data sets

# Create Data Directory if not exist
if (!file.exists("data")){
     dir.create("data")
}

# Download file from the web
fileURL_Training <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
fileURL_Testing <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

download.file(fileURL_Training, destfile = "./data/plm-training.csv")
download.file(fileURL_Testing, destfile = "./data/plm-testing.csv")

# LoadFile
train <- read.csv("./data/plm-training.csv")
test <- read.csv("./data/plm-testing.csv")

# Clean Data and remove invalid predictors
trainData <- train[,colSums(is.na(train)) == 0]
testData <- test[,colSums(is.na(test)) == 0]

# Remove first seven variables
trainData <- trainData[,-c(1:7)]
testData <- testData[,-c(1:7)]

# Cleaning nearZeroVar
NZV <- nearZeroVar(trainData)
trainData <- trainData[,-NZV]

dim(trainData)
dim(testData)

colnames(trainData)
colnames(testData)

# clean and remove invalid predictors
