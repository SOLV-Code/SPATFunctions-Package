#' calcCorrMatrix
#'
#' This function generates a correlation matrix with various options. For now, it is just a wrapper function for cor()  function from base R {stats} package. Plan is to build in alternative approaches.
#' @param X a matrix or a data frame with each column = 1 variable and each row 1 time step (any rows with 1 or more NA will be excluded)
#' @param method  for now, one of "pearson" (default), "kendall", or "spearman":
#' @keywords correlation matrix
#' @export
#' @examples
#' M <- calcCorrMatrix(mtcars)



calcCorrMatrix <- function(X, method = "pearson"){


# need to discuss this!
X <- na.omit(X)

cor.out <- cor(x = X, method=method)

# for now only 1 output element, but setting up for future (e.g. diagnostics)
out.list <- list(cor.mat = cor.out)
return(out.list)


} # end plotCorrMatrix







