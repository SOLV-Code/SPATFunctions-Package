#' comPair
#'
#' Function to compute and plot correlations of 2 series (cumulative and by time window)
#' @param X a data frame with 2 series
#' @param order either "original" or "clustered" (for now, other options to be explored)
#' @param label plot title, default is NULL
#' @param n.groups number of groups to mark (applies only if order = "clustered"). NA produces default of round(n/3).
#' @keywords correlation matrix, plot
#' @export
#' @examples
#' M <- cor(mtcars)
#' plotCorrMatrix(M)



comPair <- function(X, order = "original",  n.groups = NA ,label = NULL){


# full or half matrix
if(order == "hclust"){type <- "full"}
if(order == "original"){type <- "upper"}

# prep for margin argument down the road
margins <- c(1, 1, 1, 1)

# do not display values in the principal diagonal
diag <- FALSE

# would we ever use other than circle? do we give an option for that?
method <- "circle"

if(is.na(n.groups)){n.groups <- round(dim(X)[1])/3}

corrplot(X, type= type,diag = diag, method = method,
          order = order,addrect = n.groups,
         mar = margins)


} # end plotCorrMatrix







