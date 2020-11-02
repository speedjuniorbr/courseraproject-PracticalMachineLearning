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


# Decision Tree Method
# 1. model fit
ctrl_dt <- trainControl(method="repeatedcv", number = 10, repeats = 3)
mod_dt <- train(classe ~ ., data=training, method="rpart", trControl = ctrl_dt)
fancyRpartPlot(mod_dt$finalModel)

# 2. prediction
pred_dt <- predict(mod_dt, testing)
confM_dt <- confusionMatrix(table(pred_dt,testing$classe))

# 3. ploting matrix result
plot(confM_dt$table, col=confM_dt$byClass, main = paste("Decision Trees - Accuracy = ", round(confM_dt$overall['Accuracy'], 4)))