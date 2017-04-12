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


# Preparing 70% training and 30% testing data from training file
drops = c("Level", "Student_Account", "Pass...60.")
input = input[, !names(input) %in% drops]
test.ids = sample(1:nrow(input), 0.3 * nrow(input))
input.train = input[-test.ids,] 
input.test = input[test.ids,]


# Generate decision tree
#install.packages("rpart", repos="http://cran.csie.ntu.edu.tw/")
library(rpart)
input.tree = rpart(Score ~ ., data=input.train)
jpeg("tree.jpg")
plot(input.tree)
text(input.tree)
dev.off()
