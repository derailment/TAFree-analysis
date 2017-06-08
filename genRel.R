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
# Take Avg. Sub. as y label
y <- input[['Submissions']]
x <- input[['WA']]
jpeg('SUB_WA.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, max(y)+5), main='Avg. Sub. vs. Avg. WA', xlab='Avg. WA', ylab='Submissions')
abline(lsfit(x, y))
dev.off()
x <- input[['CE']]
jpeg('SUB_CE.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, max(y)+5), main='Avg. Sub. vs. Avg. CE', xlab='Avg. CE', ylab='Submissions')
abline(lsfit(x, y))
dev.off()
x <- input[['RE']]
jpeg('SUB_RE.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, max(y)+5), main='Avg. Sub. vs. Avg. RE', xlab='Avg. RE', ylab='Submissions')
abline(lsfit(x, y))
dev.off()
x <- input[['NA.']]
jpeg('SUB_NA.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, max(y)+5), main='Avg. Sub. vs. Avg. NA', xlab='Avg. NA', ylab='Submissions')
abline(lsfit(x, y))
dev.off()

# Take Finish Rate as y label
y <- input[['Finish_Rate...']]
x <- input[['CE']]
jpeg('FIN_CE.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, 100), main='Finish Rate vs. Avg. CE', xlab='Avg. CE', ylab='Finish Rate (%)')
abline(lsfit(x, y))
dev.off()

# Take Score as y label
y <- input[['Score']]
x <- input[['Finish_Rate...']]
jpeg('SCO_FIN.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, 100), main='Score vs. Finish Rate', xlab='Finish Rate (%)', ylab='Score')
abline(lsfit(x, y))
dev.off()
x <- input[['TLE']]
jpeg('SCO_TLE.jpg')
plot(x, y, xlim=c(0, max(x)+5), ylim=c(0, 100), main='Score vs. Avg. TLE', xlab='Avg. TLE', ylab='Score')
abline(lsfit(x, y))
dev.off()

