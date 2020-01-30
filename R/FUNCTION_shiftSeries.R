#' shiftSeries
#'
#' This function applies offsets to the series in a data frame. For now, this is a wrapper for the
#' shift() function from the {data.table} package.
#' @param x a data frame with at least 1 numeric column
#' @param type one of  "none","log" ,"z-score","perc_rank"
#' @param cols vector with names of columns to be transformed. Use NULL to transform all numeric columns.
#' @param zero.convert replace 0 with this value if required by the transformation (e.g. log)
#' @keywords transform, z-score, percent rank
#' @export
#' @examples
#' iris.transform <- transformData(iris,
#'    type="log",
#'    cols="Sepal.Length",
#'    zero.convert = NA)
#' head(iris.transform)


shiftSeries <- function(x,type= "none", cols=NULL,zero.convert = NA){

# To Do
# - expand to handle single vectors as well


cols.idx <-  unlist(lapply(x, is.numeric))

x.out <- NA  # this way it doesn't give any output if the type is not recognized

if(!is.null(cols)){ cols.idx <- cols.idx & names(x) %in% cols }

if(type=="none"){ x.out <- x }

if(type=="log"){
				x.out <- x
				x.out[,cols.idx] <- x.out[,cols.idx] %>% replace(. == 0, zero.convert) %>% log()
				# still need to handle negative values! -> create a warning for now
		 }

if(type=="perc_rank"){

				x.out <- x
				x.out[,cols.idx] <-  sapply(x.out[,cols.idx],dplyr::percent_rank)


			}


if(type=="z-score"){
				x.out <- x
				x.out[,cols.idx] <- x.out[,cols.idx] %>% scale() %>% as.data.frame()
			}





return(x.out)

}





