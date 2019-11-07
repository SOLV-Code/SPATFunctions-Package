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

for(data.use in c("Ex1","Ex2")){


if(do.pdf){pdf(paste0("Vignette2_TestingPlots_",data.use,".pdf"),onefile = TRUE, height=8.5, width=11)}

# prep a subset of the data

if(data.use == "Ex1"){
test.data <- SPATData_TimeSeries %>% mutate(RpS = Recruits/Spawners) %>%
  select(Stock,Year,RpS) %>%
  pivot_wider(names_from = Stock,values_from = RpS) %>%
  select(-Year)
}

if(data.use == "Ex2"){
test.data <- SPATData_TimeSeries %>% mutate(RpS = Recruits/Spawners) %>%
  select(Stock,Year,RpS) %>%
  pivot_wider(names_from = Stock,values_from = RpS) %>%
  left_join(rename(SPATData_EnvCov,Year=yr), by="Year") %>%
  select(Stock1,Stock3,Stock6,apesst,maesst,jnesst,pdo)
}


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

#cor.mat.basic[1:10,1:5]


# plot the basic correlation matrix

corrplot(cor.mat.basic, type= "upper",diag = FALSE, method = "circle",
         order = "original",mar = c(2, 2, 2, 2))

title(main= "Basic Correlation Matrix",line=3)

corrplot(cor.mat.basic, order = "hclust", addrect = round(dim(cor.mat.basic)[1]/3),
          diag = FALSE,   mar = c(2, 2, 2, 2))
title(main= "Clustered Correlation Matrix",line=3)

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
         order = "original", mar = c(2, 2, 2, 2))

title(main=paste("Shift =",lag),line=3)

} # end looping through lags



# STEP 3: Look at pairwise running and cumulative correlations

par(mfrow=c(3,3))


for(i in names(test.data)){
  for(j in names(test.data)){

data.use <- na.omit(test.data[,c(i,j)])
na.idx <-  !complete.cases(test.data[,c(i,j)])

#test.fit.cov.cumul <- runCov(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = TRUE)
test.fit.cor.cumul <- runCor(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = TRUE)

#test.fit.cov.window <- runCov(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = FALSE)
test.fit.cor.window <- runCor(data.use[,1],data.use[,2], n = 12, sample = TRUE, cumulative = FALSE)

if(i!=j){

plot(1:5,1:5,type="n",bty="n",xlab="Year",ylab = "Correlation",
          ylim=c(-1,1),xlim=c(min(test.years)-10,max(test.years)))
abline(h=c(-0.5,0.5),col="red",lty=2)
lines(test.years[!na.idx], test.fit.cor.window,type="l",col="lightblue")
lines(test.years[!na.idx], test.fit.cor.cumul,type="o",pch=19,col="darkblue",cex=0.5)
legend("topleft",legend=c("Window","Cumul"),pch=c(NA,19),col=c("lightblue","darkblue"),lty=1,bty="n")

title(main = paste(i,"vs.",j))

  }



}} # end looping through pairs




if(do.pdf){dev.off()}

} # end looping through examples





######################################################
# corrr package
#####################################################


library(corrr)

test.out <- correlate(test.data)
network_plot(test.out,min_cor=0)

# not working












### Other Packages

# xts, zoo,






