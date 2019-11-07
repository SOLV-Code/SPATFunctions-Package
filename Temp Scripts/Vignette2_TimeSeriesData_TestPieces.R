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















# do pairwise cross-correlation or cross-variance
# -> could set this up to work through all pairs and produce a matrix
# -> how would this differ from basic Cov(), Cor()? -> would use different subsets
# depending on complete pairs, rather tham years that are complete for ALL stocks

tmp.out <- ccf(test.data$Stock1, test.data$Stock2, lag.max = 5, type = "correlation",
               plot = TRUE, na.action = na.omit)
tmp.out



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



##########################################
# corrplot package
###################################






##########################################
#roll_cor: Rolling Correlation Matrices
########################################









### Other Packages

# xts, zoo,






