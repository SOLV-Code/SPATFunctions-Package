#' applyKMeans
#'
#' Subroutine for calculating classification intervals (uses the classInt package)
#' @param x numeric vector.  NA will be removed, but count is included as num.na in the output
#' @param type one of  one of "fixed", "sd", "equal", "pretty", "quantile", "kmeans", "hclust", "bclust", "fisher", "jenks" or "dpih"
#' @param breaks number of classes required (details depend on selected style)
#' @keywords classification interval, breaks
#' @export
#' @examples
#' petals.classes <- applyClassInt(iris$Petal.Length,
#'    style="fisher",breaks=3)
#' petals.classes



applyKMeans <- function(x,style="fisher",breaks=3){



fit.out <- kmeans(x = iris[,1:2], centers = 6,
                  iter.max = 100, nstart = 5,
                  algorithm = "Hartigan-Wong")




  
  return(fit.out)
  
} # end applyClassInt()

