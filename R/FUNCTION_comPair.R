#' comPair
#'
#' Function to compute and plot correlations of 2 series (cumulative and by time window). Wrapper function for the
#' the runCor() function from the TTR package.
#' @param X a data frame with 3 series, the first one is the time step (typically year)
#' @param window number of time periods to use for each time window in the retrospective. Default is 12
#' @param plot.type type of plot to generate: "none", "print", or "shiny" for use in the app. "shiny" type plots use {plotly}
#' @keywords pairwise correlation, retrospective
#' @export
#' @examples
#' comPair(SPATData_EnvCov[,c("yr","jflow","pdo")])



comPair <- function(X, window = 12 ,plot.type= "print"){


na.idx <-  !complete.cases(X[,2:3])

fit.cor.cumul <- runCor(X[!na.idx,2],X[!na.idx,3], n = window, sample = TRUE, cumulative = TRUE)
fit.cor.window <- runCor(X[!na.idx,2],X[!na.idx,3], n = window, sample = TRUE, cumulative = FALSE)


plot(1:5,1:5,type="n",bty="n",xlab=names(X)[1],ylab = "Correlation",
     ylim=c(-1,1),xlim=range(X[,1]))
abline(h=c(-0.5,0.5),col="red",lty=2)
lines(X[!na.idx,1], fit.cor.window,type="l",col="lightblue")
lines(X[!na.idx,1], fit.cor.cumul,type="o",pch=19,col="darkblue",cex=0.5)
legend("topleft",legend=c("Window","Cumulative"),pch=c(NA,19),col=c("lightblue","darkblue")
       ,ncol=2,lty=1,bty="n")
title(main = paste(names(X)[2],"vs.",names(X)[3]))






X.out <- list(End= X[!na.idx,1],cumul.corr = fit.cor.cumul,window.corr = fit.cor.window )
names(X.out)[1] <- names(X)[1]
return(X.out)

} # end plotCorrMatrix







