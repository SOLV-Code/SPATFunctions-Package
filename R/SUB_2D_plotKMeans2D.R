#' plotKMeans2D
#'
#' Subroutine for creating diagnostic plots of the output from applyKMeans2D()
#' @param x input used in call to applyKMeans2D()
#' @param fit object created by applyKMeans2D()
#' @param plot.type none yet
#' @keywords k-means, clustering, plot
#' @export
#' @examples
#' test.data <- SPATData_Samples[,c("Weight","LengthMEF")]
#' test.clusters <- applyKMeans2D(test.data,centers= 2)
#' names(test.clusters)
#' plotKMeans2D(x=test.data,fit=test.clusters)


plotKMeans2D <- function(x,fit,plot.type="basic"){


plot(na.omit(x),
     col = fit$cluster,
     pch = 20, cex = 1,
     pty = "s" # square plotting area (not working in shiny? have to do it on ui side?)
)
points(fit$centers, pch = 4, cex = 4, lwd = 4)
  
 } # end plotKMeans2D()