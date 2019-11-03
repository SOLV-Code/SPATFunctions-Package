#' applyClassInt
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



applyClassInt <- function(x,style="fisher",breaks=3){


  options(warn=-1) # turn off warnings due to NA (just temporary, until buiding in proper NA handling)
  fit.result <- classIntervals(x , style = style, n = breaks)
  options(warn=0) # turn warnings back on
  
  fit.out <- list(
        obs = x,
        breaks = fit.result$brks,
        cluster = cut(x,fit.result$brks,labels=FALSE),
        num.na = sum(is.na(x)),
        fit = fit.result
    
        )
  
  return(fit.out)
  
} # end applyClassInt()

