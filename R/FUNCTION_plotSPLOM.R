#' plotSPLOM
#'
#' Function to generate scatterplot of matrix columns (SPLOM). For now this is using 
#' the pairs() function from base R. 
#' @param data.df a data frame with numerical variables
#' @keywords pairwise scatterplot
#' @export
#' @examples
#' plotSPLOM(SPATData_EnvCov[,2:5])


plotSPLOM <- function(data.df){


pairs(data.df,
lower.panel = scatter.spark  ,
upper.panel	= scatter.spark2,
diag.panel = dens.spark
)


}


scatter.spark <- function(x,y){
  par(new = TRUE)
x.vec <- unlist(x)
y.vec <- unlist(y)

plot(x.vec,y.vec,bty="n",axes=FALSE,pch=21,col="darkblue",xlab="",ylab="",cex=0.8,bty="n")
abline(lm(y.vec~x.vec),col="red")

}


scatter.spark2 <- function(x,y){
  par(new = TRUE)
  x.vec <- unlist(x)
  y.vec <- unlist(y)

  plot(x.vec,y.vec,bty="n",axes=FALSE,type="n",bty="n")
  abline(lm(y.vec~x.vec),col="red",lwd=3)

}


dens.spark <- function(x){
par(new = TRUE)
dens <- density(unlist(x),na.rm=TRUE)

plot(dens$x,dens$y,type="l",col="darkblue")
#lines(dens$x,dens$y,type="l",col="white")
}



