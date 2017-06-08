#!/usr/bin/env Rscript


# File:		genRel.R
# Description:	Generate images of relationship between factors derived from TAFree Online Judge
# Creator:	Yu Tzu Wu <abby8050@gmail.com>
# License:      MIT


# Read input file and output file
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
	stop("Please supply input file(.csv) and output file(.csv)")
}
input = read.csv(file=args[1], sep=",", header=TRUE)
summary(input)

# Generate images
x <- input[['WA']]
y <- input[['Finish_Rate...']]
jpeg('WA_FIN.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, 100), main='Finish Rate vs. Avg. WA', xlab='Avg. WA', ylab='Finish Rate (%)')
abline(lsfit(x, y))
dev.off()
