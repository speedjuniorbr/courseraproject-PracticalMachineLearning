library(caret)
library(knitr)
library(rpart)
library(rpart.plot)
library(rattle)
library(randomForest)
library(e1071)
library(RColorBrewer)
library(corrplot)
library(gbm)

# create correlation matrix and plot
cor_matrix <- cor(trainData[,-53])
corrplot(cor_matrix, order = "FPC", method="color", type="upper", tl.cex=0.8, tl.col=rgb(0,0,0))

# get the highly correlated variables
highCorr <- findCorrelation(cor_matrix, cutoff = 0.85)

#show the highly correlated variables in training data set.
names(trainData)[highCorr]