#' plotRpart
#'
#' Subroutine for creating tree plots of the output from applyRpart()
#' @param x object created by applyRpart()
#' @param label plot title
#' @keywords recursive partitioning, tree
#' @export
#' @examples
#' formula.use <- as.formula("Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width")
#' test.fit <- applyRpart(formula.use, data = iris,minsplit = 10)
#' plot(test.fit,label="Species Identification Tree")




plotRpart <- function(x,label = "Var Name"){
  
par(mai = rep(1, 4))

plot(x,branch = 0.3, compress = TRUE)
text(x,all=FALSE,use.n=TRUE,xpd=NA)

title(main=label)
  
  
 } # end plotClassInt()