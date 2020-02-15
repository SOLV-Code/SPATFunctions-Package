#' plotGroup
#'
#' Function to generate a plot of multiple time series in a group, and optionally include an aggregate index.
#' @param X a data frame with at least 2 series, the first one is the time step (for now MUST be "yr")
#' @param agg.idx function to be used for an aggregate index across series. Default is "none". Options include any function that works in apply(). Typical examples are "mean", "median". Plan is to include various custom options.
#' @param plot.type type of plot to generate: "none","print", or "shiny" for use in the app. "shiny" type plots use {plotly}
#' @keywords line plot, index
#' @export
#' @examples
#' plotGroup(SPATData_EnvCov[,1:5],agg.idx="median",plot.type="print")


plotGroup <- function(X,agg.idx="none",plot.type="print"){

if(agg.idx !="none"){
agg.idx.df <- data.frame(yr = X$yr, idx = apply(select(X,-yr),MARGIN = 1,FUN=agg.idx  ))
}

if(plot.type != "none"){
if(plot.type=="print"){

col.list <- c("blue","green","firebrick1","lightblue","grey")
pch.list <- 19:22

y.lim <- c(0,max(select(X,-1),na.rm=TRUE))

plot(1:5,1:5,type="n",bty="n",xlim=range(X$yr),ylim=y.lim,xlab="Year",ylab="")
n.series <- dim(X)[2] -1
col.vec <- sample(col.list,n.series,replace=TRUE)
pch.vec<- sample(pch.list,n.series,replace=TRUE)
for(i in 1:n.series){
	lines(X$yr,X[,i],type="o",pch=pch.vec[i],col=col.vec[i],bg="white",cex=0.5)
}
legend("topright",legend= unlist(names(X))[-1],bty="n",pch=pch.vec,col=col.vec,lty=1)
if(agg.idx !="none"){lines(agg.idx.df$yr,agg.idx.df$idx,col="red",lwd=7,type="l")}

} # and plot.type = "print"

if(plot.type=="shiny"){

p <- plot_ly(X, type = 'scatter', mode = 'lines+markers') %>%
  layout(#title = "abbb",
    xaxis = list(title = "Year"),
    yaxis = list (title = "Value"),
    legend = list(orientation = 'v'),
    autosize=TRUE)

for(trace in colnames(X)[2:ncol(X)]){
  p <- p %>% plotly::add_trace(x = X[['yr']], y = X[[trace]], name = trace)
}
if(agg.idx !="none"){p <- p %>% plotly::add_trace(x = agg.idx.df$yr, y = agg.idx.df$idx, name = "index",mode="lines",line = list(color = 'red',width=8))}

} # end if plot.type = "Shiny"

} # end if plot.type != "none"

#old
#X.out <- list()
#if(agg.idx !="none"){X.out <- c(X.out,list(agg.idx = agg.idx.df ))}
#if(plot.type == "shiny"){X.out <- c(X.out,list(plot = p))}

# new test -> always get some agg.idx output
if(agg.idx =="none"){ agg.idx.df<- data.frame(yr = X$yr, idx = rep(NA, length(X$yr))) }

X.out <- list()
X.out <- c(X.out,list(agg.idx = agg.idx.df ))
if(plot.type == "shiny"){X.out <- c(X.out,list(plot = p))}


return(X.out)

} # end plotGroup







