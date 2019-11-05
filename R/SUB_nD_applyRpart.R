#' applyRpart
#'
#' Subroutine for applying classification trees using the rpart package
#' @param formula a text string of the general structure 
#'    "Response ~ Var1 + Var2". Converted to a formula inside the function
#' @param data  data frame for the response and predictor variables. predictor variables can be numeric or categorical, and can include missing values.
#' @param minsplit smallest number of records for attempting a split. default is 20.
#' @keywords classification and regression trees, CART, recursive partitioning
#' @export
#' @examples
#' formula.use <- as.formula("Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width")
#' test.fit <- applyRpart(formula.use, data = iris,minsplit = 10)
#' summary(test.fit)


applyRpart <- function(formula,data,minsplit=20){


fit.out <- rpart(as.formula(formula),data = data, method = "class", minsplit=minsplit)


# for now just pass the result. Later make it a consistent output
# object across methods.  
  return(fit.out)
  
} # end applyRpart()

