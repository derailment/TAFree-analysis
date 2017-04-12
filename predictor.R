#!/usr/bin/env Rscript


# File:		predictor.R
# Description:	Predict student scores from novice programming course by data logged via TAFree Online Judge
# Creator:	Yu Tzu Wu <abby8050@gmail.com>
# License:      MIT


# Read training file and predictable file
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
	stop("Please supply training file(.csv) and predictable file(.csv)")
} else if (length(args)==1) {
	stop("Please supply predictable file(.csv)")
}
input = read.csv(file=args[1], sep=",", header=TRUE)
output = read.csv(file=args[2], sep=",", header=TRUE)


# Preparing 90% training and 10% testing data from training file
drops = c("Score", "Student_Account", "Level")
input = input[, !names(input) %in% drops]
test.ids = sample(1:nrow(input), 0.1 * nrow(input))
input.train = input[-test.ids,] 
input.test = input[test.ids,]


# Generate decision tree
#install.packages("rpart", repos="http://cran.csie.ntu.edu.tw/")
#install.packages("rpart.plot", repos="http://cran.csie.ntu.edu.tw/")
library(rpart)
library(rpart.plot)
input.tree = rpart(Pass...60. ~ ., data=input.train)
#jpeg("tree.jpg")
#prp(input.tree, faclen=0, fallen.leaves=TRUE, shadow.col="gray")
#dev.off()


# Train confusion matrix
train.pred = predict(input.tree, newdata=input.train, type="class")
train.real = input$Pass...60.[-test.ids]
table.train = table(train.real, train.pred)
cat("Total training records:", sum(table.train), "\nCorrect classification Ratio:", sum(diag(table.train)) * 100 / sum(table.train), "%\n");


# Test confusion matrix
test.pred = predict(input.tree, newdata=input.test, type="class")
test.real = input$Pass...60.[test.ids]
table.test = table(test.real, test.pred)
cat("Total test records:", sum(table.test), "\nCorrect classification Ratio:", sum(diag(table.test)) * 100 / sum(table.test), "%\n");


