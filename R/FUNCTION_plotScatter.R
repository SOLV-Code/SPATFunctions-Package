#' plotScatter
#'
#' Function to generate a scatter plot of 2 time series with a linear regression. NA are filtered out.
#' @param X a data frame with 3 series (the first one is the time step, typically "yr", used for optional coloring,
#' and to keep the input object consistent with the other plotting functions)
#' @param labels vector with labels for the 2 series. if NULL, then col names are used
#' @param colors one of NULL, "fade", "recent" NOT YET IMPLEMENTED
#' @param recent.window number to specify how many recent points to highlight. Default is 10 (i.e. last 10yrs)
#' @keywords plot, time series, scatter plot
#' @export
#' @examples
#' plotScatter(SPATData_EnvCov[,c("EC_jflow","EC_pdo")], labels = NULL, colors = "fade",recent.window = 10)



plotScatter <- function(X, labels = NULL, colors = "fade",recent.window = 10){


# stop if more than 3 columns
if(length(X) > 3){warning("Too many variables!"); stop()}

# stop if first col is not "yr"
if(names(X)[1] != "yr"){warning("First variable must be: 'yr' "); stop()}

# filter NA
X <- na.omit(X)



if(is.null(labels)){labels <- dimnames(X)[[2]]}
if(is.null(colors)){colors <- c("darkblue","red")}

names(X) <- c("yr","L1_vec","L2_vec") # plotly needs data frame names, so need to standardize

fit <- lm(L2_vec ~ L1_vec, data = X)

p <- plot_ly(X, x = ~L1_vec, y = ~L2_vec, name = "Data" , type = "scatter", mode = "markers",
  text = ~paste("Year: ", yr)) %>%
  #,
  #marker = list(size = 4,
  #                color = ~yr,
  #                line = list(color = "darkblue",
  #                           width = 2)))  %>%
    add_trace(x = ~L1_vec, y = fitted(fit), name = "Fit",mode="lines") %>%
    layout(title = "",
         xaxis = list(title = labels[2]),
         yaxis = list (title = labels[3]),
         legend = list(orientation = 'h',x = 0.1, y = 1))






return(p)


} # end plotScatter()







