#' shiftSeries
#'
#' This function applies offsets to the series in a data frame.
#' @param X a data frame with at least 2 numeric columns
#' @param offsets vector with offsets for each column in X
#' @keywords shift, lag, lead, offset
#' @export
#' @examples
#' iris.shifted <- shiftSeries(iris,
#'    offsets =  c(0,2,-1,0,0,0),
#' head(iris.shifted)


shiftSeries <- function(X,offsets=NULL){

if(is.null(offsets)){offsets <- rep(0,dim(X)[2])}
if(length(offsets) != dim(X)[2]){warning("length of offset vector must match columns in input data frame"); stop()}

# can use apply() here? would need different input value for each column.
# do loop for now, and see if it becomes a speed issue...
# See: https://github.com/SOLV-Code/SPATFunctions-Package/issues/31

for(i in 1:dim(X)[2]){
    X[,i] <- .offset.fn(X[,i],offsets[i])
  }



return(X)

}



.offset.fn <- function(x,offset){
  #' .offset.fn
  #'
  #' This function applies offsets to a single vector
  #' @param X vector
  #' @param offset offset value
  #' @keywords shift, lag, lead, offset
  #' @export
  #' @examples
  #' iris[,1]
  #' .offset.fn(iris[,1],2)

if(offset == 0 ) {x.out <- x}
if(offset < 0 ) { x.out <- dplyr::lag(x,-offset)}
if(offset > 0 ) { x.out <- dplyr::lead(x,offset)}

return(x.out)

}


