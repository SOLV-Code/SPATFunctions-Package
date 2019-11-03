#' plotKMeans2D
#'
#' Subroutine for creating diagnostic plots of the output from applyClassInt()
#' @param x object created by applyClassInt()
#' @param plot.type one of ""basic", "hist", "dens","cumul"
#' @keywords classification interval
#' @export
#' @examples
#' petals.classes <- applyClassInt(iris$Petal.Length,
#'    style="fisher",breaks=2)
#' plotClassInt(petals.classes,
#'    plot.type="cumul",
#'    label = "Petal Length")





plotKMeans2D <- function(x,plot.type="basic",label = "Var Name"){




plot(iris[,1:2],
     col = fit.out$cluster,
     pch = 20, cex = 3,
     pty = "s" # square plotting area (not working in shiny? have to do it on ui side?)
)
points(fit.out$centers, pch = 4, cex = 4, lwd = 4)
  
 } # end plotClassInt()