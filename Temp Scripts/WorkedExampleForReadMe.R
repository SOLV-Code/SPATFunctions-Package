## SCRIPT TO TEST THE PACKAGE FUNCTIONS

library(SPATFunctions)

# Note: using built-in data set of environmental covariates
head(SPATData_EnvCov)

# Calculate correlation matrix of raw data (excluding first column with years)
M <- calcCorrMatrix(SPATData_EnvCov[,-1])
head(M$cor.mat)

# plot correlation matrix
plotCorrMatrix(M$cor.mat) # original order of variables
plotCorrMatrix(M$cor.mat,order="hclust",n.groups=4)  # clustered by correlation

# repeat, with modified data:
# - shift (offset) the pdo variable by 2 years (just as an illustration, this is not meaningful)
# - transform all variables to z-score (i.e. normalize)
head(SPATData_EnvCov)
data.shifted <- shiftSeries(SPATData_EnvCov, offsets=c(0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0))
head(data.shifted)
data.z <- transformData(data.shifted,type="z-score",
                       cols=names(data.shifted)[names(data.shifted)!="yr"],
                       zero.convert = NA )
head(data.z)
M.z <- calcCorrMatrix(data.z[,-1])
plotCorrMatrix(M.z$cor.mat) # original order of variables
plotCorrMatrix(M.z$cor.mat,order="hclust",n.groups=4)


# pairwise correlations (cumulative and by time window)

vars.test <- c("jflow","pdo")

plotPair(SPATData_EnvCov[,c("yr",vars.test)],layout = "single")
plotPair(data.z[,c("yr",vars.test)],layout = "2panels")


running.corr <- comPair(SPATData_EnvCov[,c("yr",vars.test)],
                        window = 12,plot.type="print")
running.corr

running.corr.z <- comPair(data.z[,c("yr",vars.test)],
                        window = 12,plot.type="print")
running.corr.z
