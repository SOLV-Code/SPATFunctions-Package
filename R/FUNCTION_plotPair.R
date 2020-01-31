#' plotPair
#'
#' Function to plot 2 time series with various options
#' @param X a data frame with 3 series, the first one is the time step (typically year)
#' @param labels vector with labels for the 3 columns of X. if NULL, then col names are used
#' @param type plot layout. currently includes: "default", "2axes", "2panels"
#' @param colors vector with colors. Details depend on plot type. If NULL, use a built-in default specific for that plot type.
#' @keywords plot, time series
#' @export
#' @examples
#' plotPair(SPATData_EnvCov[,c("yr","jflow","peak")])



plotPair <- function(X, labels = NULL,type= "default",colors = NULL){

x.lim <- range(X[,1],na.rm=TRUE)

if(is.null(labels)){labels <- dimnames(X)[[2]]}

# --------------------------------------------
if(type=="default"){

if(is.null(colors)){colors <- c("darkblue","red")}

y.lim <- range(X[,c(2,3)],na.rm=TRUE)

plot(X[,1],X[,2],xlim=x.lim,ylim=y.lim,bty="n", type="o",pch=19,xlab = labels[1],ylab="",col=colors[1])
lines(X[,1],X[,3],type="o",pch=21,col=colors[2],bg="white")

}

# --------------------------------------------
if(type=="2axes"){

}
# --------------------------------------------
if(type=="2panels"){
# use split.screen


}









} # end plotPair







