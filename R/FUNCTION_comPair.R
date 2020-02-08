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
#' comPair(SPATData_EnvCov[,c("yr","EC_jflow","EC_pdo")])



comPair <- function(X, window = 12 ,plot.type= "print"){


na.idx <-  !complete.cases(X[,2:3])

fit.cor.cumul <- runCor(X[!na.idx,2],X[!na.idx,3], n = window, sample = TRUE, cumulative = TRUE)
fit.cor.window <- runCor(X[!na.idx,2],X[!na.idx,3], n = window, sample = TRUE, cumulative = FALSE)

if(plot.type=="print"){

plot(1:5,1:5,type="n",bty="n",xlab=names(X)[1],ylab = "Correlation",
     ylim=c(-1,1),xlim=range(X[,1]))
abline(h=c(-0.5,0.5),col="red",lty=2)
lines(X[!na.idx,1], fit.cor.window,type="l",col="lightblue")
lines(X[!na.idx,1], fit.cor.cumul,type="o",pch=19,col="darkblue",cex=0.5)
legend("topleft",legend=c("Window","Cumulative"),pch=c(NA,19),col=c("lightblue","darkblue")
       ,ncol=2,lty=1,bty="n")
title(main = paste(names(X)[2],"vs.",names(X)[3]))
}

if(plot.type=="shiny"){

x.corr <- as.data.frame(cbind(X[!na.idx,1], fit.cor.cumul,fit.cor.window,lb=-0.5,ub=0.5))

names(x.corr) <- c("x_vec","Cumulative","Window","lb","ub") # plotly needs data frame names, so need to standardize
#print(x.corr)

p <- plot_ly(x.corr, x = ~x_vec, y = ~Cumulative, name = "Cumulative", type = "scatter", mode = "lines+markers") %>%
  add_trace(y = ~Window, name = "Window", mode = "lines",
            line = list(color = 'lightgrey', width = 2 )) %>%
  add_trace(y = ~lb, name = "", mode = "lines",
            line = list(color = 'red', width = 2 ,dash = 'dash'), showlegend = FALSE) %>%
  add_trace(y = ~ub, name = "", mode = "lines",
            line = list(color = 'red', width = 2 ,dash = 'dash'), showlegend = FALSE) %>%
        layout(title = "", #paste(names(X)[2],"vs.",names(X)[3]),
         xaxis = list(title = "Years"),
         yaxis = list(title = "Correlation",range=c(-1,1)),
         legend = list(orientation = 'h',x = 0.1, y = 1))


}

X.out <- list(End= X[!na.idx,1],cumul.corr = fit.cor.cumul,window.corr = fit.cor.window )
names(X.out)[1] <- names(X)[1]

if(plot.type == "print"){return(list(corr = X.out))}

if(plot.type == "shiny"){return(list(corr=X.out,plot = p))}

} # end plotCorrMatrix







