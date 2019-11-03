#' applyKMeans2D
#'
#' Subroutine for applying k-means clustering based on to 2 variables. This is simply a wrapper
#'    for the kmeans() function from the {stats} package.
#' @param x data frame with 2 numeric columns.  
#' @param centers number of clusters
#' @param algorithm  one of  "Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"
#' @keywords k-means, clustering
#' @export
#' @examples
#' petals.classes <- applyClassInt(iris$Petal.Length,
#'    style="fisher",breaks=3)
#' petals.classes


applyKMeans2D <- function(x,centers= 3, iter.max = 100, nstart = 5,
                  algorithm = "Hartigan-Wong"){

if(dim(x)[2] != 2 |  sum(unlist(lapply(x,is.numeric))) !=2 ){warning("input data must have exactly 2 numeric columns"); stop()}


fit.out <- kmeans(x = x, centers = centers, iter.max = iter.max, nstart = nstart, algorithm = "Hartigan-Wong")

#for now just feed it out.
# when we have others, create a consistent object

 return(fit.out)
  
} # end applyKMeans2D()

