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

inTrain <- createDataPartition(y=trainData$classe, p=0.7, list = FALSE)

training <- trainData[inTrain,]
testing <- trainData[-inTrain,]

set.seed(1235)


# GBM Method
# 1. model fit
ctrl_gbm <- trainControl(method="repeatedcv", number = 5, repeats = 1)
mod_gbm <- train(classe ~ ., data=training, method = "gbm", trControl = ctrl_gbm, verbose=FALSE)
mod_gbm$finalModel

# 2. prediction
pred_gbm <- predict(mod_gbm, newdata=testing)
confM_gbm <- confusionMatrix(pred_gbm,testing$classe)

# 3. ploting matrix result
plot(confM_gbm$table, col=confM_gbm$byClass, main = paste("GBM - Accuracy = ", round(confM_gbm$overall['Accuracy'], 4)))