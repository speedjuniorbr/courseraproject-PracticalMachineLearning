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

## Random Forest Model.
# 1.model fit
controlRF <- trainControl(method="cv", number=3, verboseIter=FALSE)
mod_rf <- train(classe ~ ., data=training, method="rf", trControl=controlRF)
mod_rf$finalModel

# 2. prediction
pred_rf <- predict(mod_rf, testing)
confM_rf <- confusionMatrix(table(pred_rf, testing$classe))

# 3. ploting matrix result
plot(confM_rf$table, col=confM_rf$byClass, main = paste("Random Forest - Accurancy = ", round(confM_rf$overall['Accuracy'], 4)))

