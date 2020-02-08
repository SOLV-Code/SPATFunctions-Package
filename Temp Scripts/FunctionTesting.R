## SCRIPT TO TEST THE PACKAGE FUNCTIONS

library(SPATFunctions)

# calcCorrMatrix() and plotCorrMatrix()
M <- calcCorrMatrix(mtcars)
plotCorrMatrix(M$cor.mat)
plotCorrMatrix(M$cor.mat,order="hclust",n.groups=4)


cor(mtcars)
cor(mtcars[,1], mtcars[,2])

cor(mtcars[1:31,1],mtcars[2:32,2])
cor(mtcars[1:30,1],mtcars[3:32,2])
cor(mtcars[2:31,1],mtcars[1:30,2])

ccf(mtcars[,1], mtcars[,2], lag.max = 4 , type = "correlation",
    plot = FALSE, na.action = na.omit)


# transformData()

iris.transform <- transformData(iris, type="log", cols="Sepal.Length", zero.convert = NA)
head(iris)
head(iris.transform)


# shiftSeries()

# internal fn
iris[,1]
.offset.fn(iris[,1],2)
.offset.fn(iris[,1],-2)

head(iris)
iris.shifted <- shiftSeries(iris, offsets=c(0,-2,1,2,0))
head(iris.shifted)



#---------------
M <- calcCorrMatrix(SPATData_EnvCov)
plotCorrMatrix(M$cor.mat)
plotCorrMatrix(M$cor.mat,order="hclust",n.groups=4)



head(SPATData_EnvCov)
SPATData_EnvCov.shifted <- shiftSeries(SPATData_EnvCov, offsets=c(0,-2,1,2,0,3,0,0,0,0,0,0,0,0,0))
head(SPATData_EnvCov.shifted)

plotPair(SPATData_EnvCov[,c("yr","jflow","peak")])

tmp.log <- transformData(SPATData_EnvCov[,c("yr","jflow","peak")],type="log",
                     cols=c("jflow","peak"), zero.convert = NA )
plotPair(tmp.log)

tmp.z <- transformData(SPATData_EnvCov[,c("yr","jflow","peak")],type="z-score",
                         cols=c("jflow","peak"), zero.convert = NA )
plotPair(tmp.z,layout = "single")
plotPair(tmp.z,layout = "2axes")
plotPair(tmp.z,layout = "2panels")


plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "single",style = "print", colors = NULL)
plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "single",style = "shiny", colors = NULL)

plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2axes",style = "print", colors = NULL)
plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2axes",style = "shiny", colors = NULL)

plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2panels",style = "print", colors = NULL)
plotPair(SPATData_EnvCov[,c("yr","jflow","jnesst")],
         labels = NULL,layout = "2panels",style = "shiny", colors = NULL)



###################################

running.corr <- comPair(SPATData_EnvCov[,c("yr","jflow","pdo")],
        window = 8,plot.type="print")

running.corr



#################################################
library(SPATFunctions)
library(tidyverse)
group.df <- SPATData_EnvCov[,1:5]


agg.idx <- mean # "median"

if(!is.null(agg.idx)){
agg.idx.df <- data.frame(yr = group.df$yr,
                         idx = apply(select(group.df,-yr),MARGIN = 1,FUN=agg.idx  ))
}



# basic plot
col.list <- c("blue","green","firebrick1","lightblue","grey")
pch.list <- 19:22

y.lim <- c(0,max(select(group.df,-1),na.rm=TRUE))

plot(1:5,1:5,type="n",bty="n",xlim=range(group.df$yr),ylim=y.lim,xlab="Year",ylab="")
n.series <- dim(group.df)[2] -1
col.vec <- sample(col.list,n.series,replace=TRUE)
pch.vec<- sample(pch.list,n.series,replace=TRUE)
for(i in 1:n.series){
lines(group.df$yr,group.df[,i],type="o",pch=pch.vec[i],col=col.vec[i],bg="white",cex=0.5)
}
legend("topright",legend= unlist(names(group.df))[-1],bty="n",pch=pch.vec,col=col.vec,lty=1)
if(!is.null(agg.idx)){lines(agg.idx.df$yr,agg.idx.df$idx,col="red",lwd=7,type="l")}


# plotly plot
library(plotly)
p <- plot_ly(group.df, type = 'scatter', mode = 'lines+markers',
              width = 1) %>%
  layout(#title = "abbb",
    xaxis = list(title = "Time"),
    yaxis = list (title = "Value"),
    legend = list(orientation = 'v'))
for(trace in colnames(group.df)[2:ncol(group.df)]){
  p <- p %>% plotly::add_trace(x = group.df[['yr']], y = group.df[[trace]], name = trace)
}
if(!is.null(agg.idx)){p <- p %>% plotly::add_trace(x = agg.idx.df$yr, y = agg.idx.df$idx, name = "index",mode="lines",
                             line = list(color = 'red',width=8))}
p




















