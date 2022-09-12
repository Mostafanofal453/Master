#install required packages
install.packages("rpart.control")

install.packages("rpart.plot")

install.packages("party")


library(ggplot2)
library(ggthemes)
library(plyr)
library(gridExtra)
library(caret)
library(caTools)
library(MASS)
library(randomForest)
library(party)
library(rpart)
library(rpart.plot)
library(rpart.control)
library(dplyr)
library(rpart)
library(tidyverse)
library(readxl)
library(xgboost)
library(neuralnet)
library(pROC)




# Read the churn Dataset
churn <- read.csv("Churn Dataset.csv")
str(churn)
glimpse(churn)

#PartA

  #1.Scatter plot
  churn <- read.csv("Churn Dataset.csv")
  
  
  pairs(~TotalCharges+ MonthlyCharges+tenure,data=Filter(is.numeric, na.exclude(distinct(churn))),
        main="Simple Scatterplot Matrix")
  
  #Heat Map

  l = subset(as.matrix(Filter(is.numeric, na.exclude(distinct(churn)))),
             select = c(TotalCharges,MonthlyCharges, tenure))
  heatmap(l)
  
  source("http://www.sthda.com/upload/rquery_cormat.r") # to use rquery.cormat
  cormat<-rquery.cormat(churn[,c(6,19,20)], graphType="heatmap")
  
  
  #2.Ensure data is in the correct format
  #check if there is missing values in columns
  sapply(churn, function(x) sum(is.na(x)))
  #remove all rows with missing values.
  churn <- churn[complete.cases(churn), ]
  
  #"No internet service" to "No" 
  cols_recode1 <- c(10:15)
  for(i in 1:ncol(churn[,cols_recode1])) {
    churn[,cols_recode1][,i] <- as.factor(mapvalues
                                          (churn[,cols_recode1][,i],
                                            from =c("No internet service"),to=c("No")))
  }
  #change "No phone service" to "No"
  churn$MultipleLines <- as.factor(mapvalues(churn$MultipleLines, 
                                             from=c("No phone service"),
                                             to=c("No")))
  
  #Remove Redundant Data
  new_customer_data = unique(churn, fromLast=T)
 
  #Drop customerID column 
  new_customer_data = select(new_customer_data,-1)
  head(new_customer_data)
  
  #categorical values to numerical values.
  
  #Create labels encoders variables
  library(superml)
  lbl_1 = LabelEncoder$new()
  lbl_2 = LabelEncoder$new() 
  lbl_3 = LabelEncoder$new()
  lbl_4 = LabelEncoder$new()
  lbl_5 = LabelEncoder$new()
  lbl_6 = LabelEncoder$new()
  lbl_7 = LabelEncoder$new()
  lbl_8 = LabelEncoder$new()
  lbl_9 = LabelEncoder$new()
  lbl_10 = LabelEncoder$new()
  lbl_11 = LabelEncoder$new()
  lbl_12 = LabelEncoder$new()
  lbl_13 = LabelEncoder$new()
  lbl_14 = LabelEncoder$new()
  lbl_15 = LabelEncoder$new()
  lbl_16 = LabelEncoder$new()
  lbl_16 = LabelEncoder$new()
  
  
  #Convert categorical data to numerical data
  new_customer_data$gender = lbl_1$fit_transform(new_customer_data$gender)
  new_customer_data$Partner = lbl_2$fit_transform(new_customer_data$Partner)
  new_customer_data$Dependents = lbl_3$fit_transform(new_customer_data$Dependents)
  new_customer_data$PhoneService = lbl_4$fit_transform(new_customer_data$PhoneService)
  new_customer_data$MultipleLines = lbl_5$fit_transform(new_customer_data$MultipleLines)
  new_customer_data$InternetService = lbl_6$fit_transform(new_customer_data$InternetService)
  new_customer_data$OnlineSecurity = lbl_7$fit_transform(new_customer_data$OnlineSecurity)
  new_customer_data$OnlineBackup = lbl_8$fit_transform(new_customer_data$OnlineBackup)
  new_customer_data$DeviceProtection = lbl_9$fit_transform(new_customer_data$DeviceProtection)
  new_customer_data$TechSupport = lbl_10$fit_transform(new_customer_data$TechSupport)
  new_customer_data$StreamingTV = lbl_11$fit_transform(new_customer_data$StreamingTV)
  new_customer_data$StreamingMovies = lbl_12$fit_transform(new_customer_data$StreamingMovies)
  new_customer_data$Contract = lbl_13$fit_transform(new_customer_data$Contract)
  new_customer_data$PaperlessBilling = lbl_14$fit_transform(new_customer_data$PaperlessBilling)
  new_customer_data$PaymentMethod = lbl_15$fit_transform(new_customer_data$PaymentMethod)
  new_customer_data$PaymentMethod = lbl_16$fit_transform(new_customer_data$PaymentMethod)
  
  
  new_customer_data$Churn = lbl_16$fit_transform(new_customer_data$Churn)
  head(new_customer_data)
  #-
  
  #Recall and precision function
  
  measurePrecisionRecall <- function(actual_labels, predict){
    conMatrix = table(actual_labels, predict)
    precision <- conMatrix['0','0'] / ifelse(sum(conMatrix[,'0'])== 0, 1, sum(conMatrix[,'0']))
    recall <- conMatrix['0','0'] / ifelse(sum(conMatrix['0',])== 0, 1, sum(conMatrix['0',]))
    fmeasure <- 2 * precision * recall / ifelse(precision + recall == 0, 1, precision + recall)
    
    cat('precision:  ')
    cat(precision * 100)
    cat('%')
    cat('\n')
    
    cat('recall:     ')
    cat(recall * 100)
    cat('%')
    cat('\n')
    
    cat('f-measure:  ')
    cat(fmeasure * 100)
    cat('%')
    cat('\n')
  }
  
  
  #3.Split the dataset into 80 training and 20 test set 
  set.seed(147)
  sample_data = sample.split(new_customer_data, SplitRatio = 0.8)
  train_data = subset(new_customer_data, sample_data == TRUE)
  test_data = subset(new_customer_data, sample_data == FALSE)
  

  #Decision tree
  model <- rpart(Churn~., train_data,method = "class")
  rpart.plot(model,type=5)
  
  pred_tree <- predict(model, test_data,type = 'class')
  Confusion_Matrix <- table(Predicted = pred_tree, Actual = test_data$Churn)
  print("Confusion Matrix for Decision Tree"); Confusion_Matrix
  
  accuracy_Test <- sum(diag(Confusion_Matrix)) / sum(Confusion_Matrix)
  print(paste('Decision Tree Accuracy', accuracy_Test))
  
  rpart.plot(model)
  
  measurePrecisionRecall(test_data[,15],pred_tree)
  
  #ROC
  roc(test_data$Churn,as.numeric(pred_tree))
  
  #Plot ROC Graph
  plot(roc(test_data$Churn,as.numeric(pred_tree)), col = 1, lty = 2, main = "ROC")
  
  
  #4.improve Decision Tree
  #Split the data to 70% train and 30% test.
  set.seed(50)
  sample_data_2 = sample.split(new_customer_data, SplitRatio = 0.7)
  train_data_2 = subset(new_customer_data, sample_data_2 == TRUE)
  test_data_2 = subset(new_customer_data, sample_data_2 == FALSE)
  
  #* apply decision tree
  model_2 <- rpart(Churn~., train_data_2,method = "class")
  rpart.plot(model_2,type=5)
  
  pred_tree <- predict(model_2, test_data_2,type = 'class')
  Confusion_Matrix <- table(Predicted = pred_tree, Actual = test_data_2$Churn)
  print("Confusion Matrix for Decision Tree"); Confusion_Matrix
  
  accuracy_Test <- sum(diag(Confusion_Matrix)) / sum(Confusion_Matrix)
  print(paste('Decision Tree Accuracy', accuracy_Test))
  
  rpart.plot(model_2)
  
 
  #ROC
  roc(test_data_2$Churn,as.numeric(pred_tree))
  
 #Try another split 60% training and 40% test
    set.seed(50)
  sample_data_3 = sample.split(new_customer_data, SplitRatio = 0.6)
  train_data_3 = subset(new_customer_data, sample_data_3 == TRUE)
  test_data_3 = subset(new_customer_data, sample_data_3 == FALSE)
  
  model_3 <- rpart(Churn~., train_data_3,method = "class")
  rpart.plot(model_3,type=5)
  
  pred_tree <- predict(model_3, test_data_3,type = 'class')
  Confusion_Matrix <- table(Predicted = pred_tree, Actual = test_data_3$Churn)
  print("Confusion Matrix for Decision Tree"); Confusion_Matrix
  
  accuracy_Test <- sum(diag(Confusion_Matrix)) / sum(Confusion_Matrix)
  print(paste('Decision Tree Accuracy', accuracy_Test))
  
  rpart.plot(model_3)
  
  
  #ROC
  roc(test_data_3$Churn,as.numeric(pred_tree))
  
  #prune model
  # Examine the complexity plot
  printcp(model)
  plotcp(model)
  

  
  model_pruned <- prune(model, cp = 0.024 )
  
  #Pruned tree accuracy
  test_set$pred <- predict(model_pruned, test_data, type = "class")
  accuracy_postprun <- mean(test_data$pred == test_data$Churn)
  print(accuracy_postprun)
  
  y_pred_pruned = predict(model_pruned, newdata = test_data,
                          type = 'class')
  
  #Confusion Matrix and accuracy
  Confusion_Matrix_pruned = table(test_data$Churn, y_pred_pruned)
  accuracy_pruned=sum(diag(Confusion_Matrix_pruned))/sum(Confusion_Matrix_pruned)
  accuracy_pruned
  
  # Grow a tree with minimum split of 100 and max depth of 8
  hr_model_preprun <- rpart(train_data$Churn ~ ., data = train_data[,1:19], method = "class", 
                            control = rpart.control(cp = 0, maxdepth = 8,minsplit = 100))
  plot(hr_model_preprun)
  
  
  #5.XGboost
  xgb_model <- xgboost(data = as.matrix(train_data[, 1:19]),label = train_data$Churn,max_depth = 3,
                       nrounds = 70, objective = "binary:logistic")
  
  
  xgb_pred <- predict(xgb_model,  as.matrix(test_data[,1:19]))
  xgb_pred[xgb_pred>=.5] = 1
  xgb_pred[xgb_pred<.5] = 0
  
  Confusion_Matrix_GB = table(test_data$Churn, xgb_pred)
  print("Confusion_Matrix_GB for Decision Tree"); Confusion_Matrix_GB
  accuracy_Gb=sum(diag(Confusion_Matrix_GB))/sum(Confusion_Matrix_GB)
  accuracy_Gb

  #ROC
  roc(test_data$Churn,as.numeric(xgb_pred))
  plot(roc(test_data$Churn,as.numeric(xgb_pred)))
  measurePrecisionRecall(test_data$Churn, xgb_pred)
 

  #6.Deep Learning
  install.packages("devtools")
  
  devtools::install_github("rstudio/keras")
  devtools::install_github("rstudio/reticulate")
  
  install.packages("tensorflow")
  install.packages("keras")
  library(tensorflow)
  library(reticulate)
  library(keras)
  
  reticulate::use_python("/home/sarah/anaconda3/bin/python3")
  install_tensorflow()
  install_tensorflow(gpu=TRUE)
  
  #data:
  deep_train = as.matrix(train_data)
  deep_test = as.matrix(test_data)
  dimnames(deep_train) = NULL
  
  model <- keras_model_sequential()
    
    model %>%
      layer_dense(units = 19, activation = 'relu', input_shape = 19) %>% 
      layer_dropout(rate = 0.1) %>% 
      layer_dense(units = 10, activation = 'relu') %>%
      layer_dropout(rate = 0.1) %>%
      layer_dense(units = 1, activation = 'sigmoid')
    #----------
    model %>%
      layer_dense(units = 19, activation = 'tanh', input_shape = 19) %>% 
      layer_dropout(rate = 0.1) %>% 
      layer_dense(units = 10, activation = 'tanh') %>%
      layer_dropout(rate = 0.1) %>%
      layer_dense(units = 1, activation = 'sigmoid')
    #----------
  
  summary(model)
  
  model %>% compile(
    loss      = 'mean_squared_error',
    optimizer = 'adam',
    metrics = c('accuracy')
  )
  
  
  history = fit(model,data.matrix(train_data[,1:19]), train_data$Churn, epochs = 50, 
                batch_size = 128)
  plot(history)

  size_sum(test_data)
  pred_data = predict(model, data.matrix(test_data[,1:19]))
  pred_data[pred_data>=.5] = 1
  pred_data[pred_data<.5] = 0
  typeof(pred_data)
  
  Confusion_Matrix_Dnn = table(test_data$Churn, pred_data)
  accuracy_Dnn=sum(diag(Confusion_Matrix_Dnn))/sum(Confusion_Matrix_Dnn)
  accuracy_Dnn
  
  measurePrecisionRecall(test_data$Churn,pred_data)
  roc(test_data$Churn,as.numeric(pred_data))
  plot(roc(test_data$Churn,as.numeric(pred_data)), col = 1, lty = 2, main = "ROC")

  
------------------------------
  #PartB
  #A
  library(arules)
  library(arulesViz)
  t <- read.transactions("transactions.csv", header=FALSE,sep = ',', rm.duplicates = TRUE)
  
  itemFrequencyPlot(t, topN = 10)
  
  #B
  r1 <- apriori(t, parameter = list(support = 0.002, confidence =0.20, maxlen = 3))
  inspect(sort(r1, by = "lift",decreasing = TRUE))
  
  #C
  rule1 <- sort(r1, by = "lift",decreasing = TRUE)[0:1]
  
  r2 <- apriori(t, parameter = list(support = 0.002, confidence =0.20, maxlen = 2))
  rule2 <- sort(r2, by = "lift",decreasing = TRUE)[0:1]
  
  if(rule1@quality$lift > rule2@quality$lift){
    print("Rule1 with maximum length of 3 has a better Lift") 
  }else{
    print("Rule2 with maximum length of 2 has a better Lift")
  }
  
  
  if(rule1@quality$support > rule2@quality$support){
    print("Rule1 with maximum length of 3 has a greater Support") 
  }else{
    print("Rule2 with maximum length of 2 has a greater Support")
  }
  

  
  #Tree with minimum split of 100 and max depth of 8
  hr_model_preprun <- rpart(train_data$Churn ~ ., data = train_data[,-15], method = "class", 
                            control = rpart.control(cp = 0, maxdepth = 8,minsplit = 100))
