# sources
# https://anomaly.io/detect-correlation-time-series/index.html
# https://www.r-bloggers.com/tidy-time-series-analysis-part-3-the-rolling-correlation/



# BUILDING BLOCKS FOR VIGNETTE 2: TIME-SERIES DATA

# load the packages
library(SPATFunctions)
library(tidyverse)
library(tidyr)
library(corrr)
library(corrplot)
library(TTR)

# prep a subset of the data

test.data <- SPATData_TimeSeries %>% mutate(RpS = Recruits/Spawners) %>%
  select(Stock,Year,RpS) %>%
  pivot_wider(names_from = Stock,values_from = RpS) %>% select(-Year)

test.years <- sort(unique(SPATData_TimeSeries$Year))

head(test.data)
dim(test.data)
length(test.years)


# correlation matrix using base R
# simple, but:
#  - only years with data for all stocks
#  - only for full series
#  - only exact matches

cov.mat.basic <- cov(na.omit(test.data))
cor.mat.basic <- cor(na.omit(test.data))

cor.mat.basic[1:10,1:5]


# plot the basic correlation matrix
corrplot(cor.mat.basic, type= "upper",diag = FALSE, method = "circle",
         order = "original")


# loop through pairwise comparisons instead
# - set this up to work through all pairs and produce a matrix
# - depends only on complete pairs, rather than years that are
#        complete for ALL stocks
# - include time-shifted comparison (up to some max offset)
# - for now doing in nested loops
# - need to convert to a function, then optimize fn speed


max.lag <- 4

pw.out.obj <- array(data = NA,dim = c(rep(dim(test.data)[2],2), 2*max.lag + 1),
                 dimnames = list(names(test.data),names(test.data),paste0(-max.lag:max.lag)))

for(i in names(test.data)){
  for(j in names(test.data)){


ccf.tmp <-    ccf(test.data[i], test.data[j], lag.max = max.lag , type = "correlation",
        plot = FALSE, na.action = na.omit)

pw.out.obj[i,j, 1:9] <- c(ccf.tmp$acf)


}} # end looping through pairwise tests


#pw.out.obj[,,c("-3")]
#pw.out.obj[1:5,1:5,]

# plot the correlation matrix by lag
corrplot(pw.out.obj[,,"0"], type= "upper",diag = FALSE, method = "circle",
         order = "original")







###########################################################################
# TTR Package
#########################################################################
install.packages("TTR")


data.use <- na.omit(select(test.data,Stock1, Stock2))
na.idx <-  !complete.cases(select(test.data,Stock1, Stock2))
test.fit.cov <- runCov(data.use[,1],data.use[,2], n = 10, sample = TRUE, cumulative = TRUE)
test.fit.cor <- runCor(data.use[,1],data.use[,2], n = 10, sample = TRUE, cumulative = TRUE)

plot(test.years[!na.idx], test.fit.cov,type="l")
plot(test.years[!na.idx], test.fit.cor,type="l")












######################################################
# corrr package
#####################################################


library(corrr)

test.out <- correlate(iris[-5])
network_plot(test.out)

# not working
#corrplot(test.out,is.corr=FALSE)











### Other Packages

# xts, zoo,






