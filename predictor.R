#!/usr/bin/env Rscript


# File:		predictor.R
# Description:	Predict student scores from novice programming course by data logged via TAFree Online Judge
# Creator:	Yu Tzu Wu <abby8050@gmail.com>
# License:      MIT


# Read input file and output file
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
	stop("Please supply input file(.csv) and output file(.csv)")
} else if (length(args)==1) {
	stop("Please supply output file(.csv)")
}
input = read.csv(file=args[1], sep=",", header=TRUE)
output = read.csv(file=args[2], sep=",", header=TRUE)

# Pearson correlation coefficient matrix
drops = c("Pass...60.", "Student_Account", "Level")
df = input[, !names(input) %in% drops]
mat = round(cor(df, method="pearson"), 2)
write.table(mat, file="corr_matrix.csv", sep=",", col.names=NA)

# Ignore columns
drops = c("Pass...60.", "Student_Account", "Score")
input = input[, !names(input) %in% drops]

# Generate decision tree with a small cp
require(rpart)
set.seed(10)
tree = rpart(Level ~ ., data=input, control=rpart.control(cp=0.001))

# Pick the cp that minimizes the xerror for cross-valification
bestcp = tree$cptable[which.min(tree$cptable[, "xerror"]), "CP"]

# Prune the tree using the best cp
tree.pruned = prune(tree, cp=bestcp)

# Confusion matrix (training data)
input.real = input$Level
input.pred = predict(tree, newdata=input, type="class")
table.train = table(input.pred, input.real)
cat("Total training records:", sum(table.train), "\nCorrect Classification Ratio:", sum(diag(table.train)) * 100 / sum(table.train), "%\n");
ratio = round(sum(diag(table.train)) * 100 / sum(table.train), 2)
input.pred = predict(tree.pruned, newdata=input, type="class")
table.train = table(input.pred, input.real)
cat("Total training records:", sum(table.train), "\nCorrect Classification Ratio (pruned) :", sum(diag(table.train)) * 100 / sum(table.train), "%\n");
ratio.pruned = round(sum(diag(table.train)) * 100 / sum(table.train), 2)

# Export decision tree image
require(rpart.plot)
tot_count <- function(x, labs, digits, varlen)
{
	paste(labs, "\n\nn =", x$frame$n)
}
jpeg("level.jpg")
title = paste("Level Classifier (", ratio, "%)")
prp(tree, faclen=0, cex=0.8, node.fun=tot_count, main=title)
dev.off()
jpeg("level_pruned.jpg")
title = paste("Pruned Level Classifier (", ratio.pruned, "%)")
prp(tree.pruned, faclen=0, cex=0.8, node.fun=tot_count, main=title)
dev.off()

# Predict new data
output.pred = data.frame(output, Level=predict(tree, newdata=output, type="class"))
output.pruned = data.frame(output, Level=predict(tree.pruned, newdata=output, type="class"))

# Write to output file
write.table(output.pred, file="level_pred.csv", sep=",", row.names=FALSE)
write.table(output.pruned, file="level_pruned.csv", sep=",", row.names=FALSE)
