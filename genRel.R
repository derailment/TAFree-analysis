#!/usr/bin/env Rscript


# File:		genRel.R
# Description:	Generate images of relationship between factors derived from TAFree Online Judge
# Creator:	Yu Tzu Wu <abby8050@gmail.com>
# License:      MIT


# Read input file(.csv)
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
	stop("Please supply input file(.csv) and (x, y) and (r, p) parameters.")
} else if (length(args)==1){
	stop("Please supply (x, y) and (r, p) parameters.")
} else if (length(args)==2){
	stop("Please supply y and (r, p) parameters.")	
} else if (length(args)==3){
	stop("Please supply (r, p) parameters.")	
} else if (length(args)==4){
	stop("Please supply p parameter.")	
}
input = read.csv(file=args[1], sep=",", header=TRUE)
summary(input)


# Read (r, p)
r <- args[4]
p <- args[5]


# Read (x, y)
xlab <- args[2]
ylab <- args[3]
x <- input[[xlab]]
y <- input[[ylab]]
xmax <- 0
ymax <- 0
if(xlab=="Submissions") {
	xlab <- "Avg. Sub."
	xmax <- max(x)+5 
} else if(xlab=="WA"){
	xlab <- "Avg. WA"
	xmax <- max(x)+5
} else if(xlab=="NA."){
	xlab <- "Avg. NA"
	xmax <- max(x)+5
} else if(xlab=="CE"){
	xlab <- "Avg. CE"
	xmax <- max(x)+5
} else if(xlab=="RE"){
	xlab <- "Avg. RE"
	xmax <- max(x)+5
} else if(xlab=="TLE"){
	xlab <-"Avg. TLE"
	xmax <- max(x)+5
} else if(xlab=="Score"){
	xlab <- "Score"
	xmax <- 100
} else if(xlab=="Finish_Rate..."){
	xlab <- "Finish Rate"
	xmax <- 100
} else if(xlab=="Average_Time.Min."){
	xlab <- "Avg. Int. (Min)"
	xmax <- max(x)+5
}
if(ylab=="Submissions") {
	ylab <- "Avg. Sub."
	ymax <- max(y)+5 
} else if(ylab=="WA"){
	ylab <- "Avg. WA"
	ymax <- max(y)+5
} else if(ylab=="NA."){
	ylab <- "Avg. NA"
	ymax <- max(y)+5
} else if(ylab=="CE"){
	ylab <- "Avg. CE"
	ymax <- max(y)+5
} else if(ylab=="RE"){
	ylab <- "Avg. RE"
	ymax <- max(y)+5
} else if(ylab=="TLE"){
	ylab <-"Avg. TLE"
	ymax <- max(y)+5
} else if(ylab=="Score"){
	ylab <- "Score"
	ymax <- 100
} else if(ylab=="Finish_Rate..."){
	ylab <- "Finish Rate"
	ymax <- 100
} else if(ylab=="Average_Time.Min."){
	ylab <- "Avg. Int. (Min)"
	ymax <- max(y)+5
}


# Generate an image
jpeg(paste(xlab, '_', ylab,'.jpg'))
plot(x, y, xlim=c(0, xmax), ylim=c(0, ymax), main=paste(xlab, ' vs. ', ylab), sub=paste("(r=", r,"; p<=", p, ")"), xlab=xlab, ylab=ylab)
abline(lsfit(x, y))
dev.off()
