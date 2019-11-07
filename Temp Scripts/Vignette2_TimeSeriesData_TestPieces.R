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


do.pdf <- TRUE

if(do.pdf){pdf("Vignette2_TestingPlots.pdf",onefile = TRUE, height=8.5, width=11)}

# prep a subset of the data

test.data <- SPATData_TimeSeries %>% mutate(RpS = Recruits/Spawners) %>%
  select(Stock,Year,RpS) %>%
  pivot_wider(names_from = Stock,values_from = RpS) %>%
# left_join(rename(SPATData_EnvCov,Year=yr), by="Year") %>%
  select(-Year)



test.years <- sort(unique(SPATData_TimeSeries$Year))

head(test.data)
dim(test.data)
length(test.years)


# STEP 1: simple correlation matrix using base R
# simple, but:
#  - only years with data for all stocks
#  - only for full series
#  - only exact matches

cov.mat.basic <- cov(na.omit(test.data))
cor.mat.basic <- cor(na.omit(test.data))

cor.mat.basic[1:10,1:5]


# plot the basic correlation matrix
par(mai=rep(1,4))
corrplot(cor.mat.basic, type= "upper",diag = FALSE, method = "circle",
         order = "original")


# STEP 2: loop through pairwise comparisons instead
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


par(mfrow=c(3,3),mai=rep(0.5,4))

for(lag in dimnames(pw.out.obj)[[3]]){

corrplot(pw.out.obj[,,lag], type= "upper",diag = FALSE, method = "circle",
         order = "original")

title(main=paste("Shift =",lag),line=-2)

} # end looping through lags



# STEP 3: Look at pairwise running and cumulative correlations


data.use <- na.omit(select(test.data,Stock1, Stock6))
na.idx <-  !complete.cases(select(test.data,Stock1, Stock6))

test.fit.cov.cumul <- runCov(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = TRUE)
test.fit.cor.cumul <- runCor(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = TRUE)

test.fit.cov.window <- runCov(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = FALSE)
test.fit.cor.window <- runCor(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = FALSE)


par(mfrow=c(1,1))
plot(test.years[!na.idx], test.fit.cor.cumul,type="l",bty="n")
plot(test.years[!na.idx], test.fit.cor.window,type="l", bty="n")






if(do.pdf){dev.off()}





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






