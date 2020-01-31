#' plotPair
#'
#' Function to plot 2 time series with various options
#' @param X a data frame with 3 series, the first one is the time step (typically year)
#' @param labels vector with labels for the 3 columns of X. if NULL, then col names are used
#' @param layout plot layout. currently includes: "single", "2axes", "2panels"
#' @param style plot style. Currently includes "print" as the default, and "shiny" for use in apps.
#' @param colors vector with colors. Details depend on plot type. If NULL, use a built-in default specific for that plot type.
#' @keywords plot, time series
#' @export
#' @examples
#' plotPair(SPATData_EnvCov[,c("yr","jflow","peak")])



plotPair <- function(X, labels = NULL,layout = "single",style = "print", colors = NULL){

x.lim <- range(X[,1],na.rm=TRUE)

if(is.null(labels)){labels <- dimnames(X)[[2]]}
if(is.null(colors)){colors <- c("darkblue","red")}

if(style == "print"){
lwd.use <- 1
cex.axis.use <- 1
}


if(style == "shiny"){
lwd.use <- 2
cex.axis.use <- 2
}


# --------------------------------------------
if(layout == "single"){

y.lim <- range(X[,c(2,3)],na.rm=TRUE)
plot(X[,1],X[,2],xlim=x.lim,ylim=y.lim,bty="n", type="o",pch=19,
     xlab = labels[1],ylab="",col=colors[1],lwd = lwd.use, cex.axis = cex.axis.use)
lines(X[,1],X[,3],type="o",pch=21,col=colors[2],bg="white",lwd = lwd.use)
legend("top",legend = labels[2:3],pch=c(19,21),col=colors,bg=c(NA,"white"),
       ncol=2,bty="n")

}

# --------------------------------------------
if(layout %in% c("2axes","2panels")){

if(layout == "2panels"){split.screen(figs=c(2,1));screen(n=1)}

plot(X[,1],X[,2],xlim=x.lim,bty="n", type="o",
      pch=19,xlab = labels[1],ylab=labels[2],col=colors[1],lwd = lwd.use, cex.axis = cex.axis.use)

if(layout == "2panels"){screen(n=2);axes.plot <- TRUE ; y.lab <- labels[3]}

if(layout == "2axes"){  par(new = TRUE);axes.plot <- FALSE; y.lab <- ""  }

plot(X[,1],X[,3],xlim=x.lim,bty="n", type="o",
       pch=21,xlab = labels[1],ylab=y.lab,col=colors[2],bg="white",axes=axes.plot,
       lwd = lwd.use, cex.axis = cex.axis.use)

if(layout == "2axes"){axis(4); mtext(side = 4, line = 2, y.lab ,cex=cex.axis.use,col=colors[2])}
if(layout == "2panels"){close.screen(all.screens = TRUE)}

}










} # end plotPair







