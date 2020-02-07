#' plotPair
#'
#' Function to plot 2 time series with various options
#' @param X a data frame with 3 series, the first one is the time step (typically year)
#' @param labels vector with labels for the 3 columns of X. if NULL, then col names are used
#' @param layout plot layout. currently includes: "single", "2axes", "2panels"
#' @param plot.type plot style. Currently includes "print" as the default, and "shiny" for use in apps.
#' @param colors vector with colors. Details depend on plot type. If NULL, use a built-in default specific for that plot type.
#' @keywords plot, time series
#' @export
#' @examples
#' plotPair(SPATData_EnvCov[,c("yr","jflow","pdo")])



plotPair <- function(X, labels = NULL,layout = "single",plot.type = "print", colors = NULL){

x.lim <- range(X[,1],na.rm=TRUE)

if(is.null(labels)){labels <- dimnames(X)[[2]]}
if(is.null(colors)){colors <- c("darkblue","red")}

if(plot.type == "print"){lwd.use <- 1;cex.axis.use <- 1}


if(plot.type == "shiny"){names(X) <- c("x_vec","L1_vec","L2_vec")} # plotly needs data frame names, so need to standardize

# --------------------------------------------
if(layout == "single"){

if(plot.type == "print"){
y.lim <- range(X[,c(2,3)],na.rm=TRUE)
plot(X[,1],X[,2],xlim=x.lim,ylim=y.lim,bty="n", type="o",pch=19,
     xlab = labels[1],ylab="",col=colors[1],lwd = lwd.use, cex.axis = cex.axis.use)
lines(X[,1],X[,3],type="o",pch=21,col=colors[2],bg="white",lwd = lwd.use)
legend("top",legend = labels[2:3],pch=c(19,21),col=colors,bg=c(NA,"white"),
       ncol=2,bty="n")
} # end print single

if(plot.type == "shiny"){

p <- plot_ly(X, x = ~x_vec, y = ~L1_vec, name = labels[2], type = "scatter", mode = "lines+markers") %>%
    add_trace(y = ~L2_vec, name = labels[3], mode = "lines+markers") %>%
    layout(title = "",
         xaxis = list(title = labels[1]),
         yaxis = list (title = ""),
         legend = list(orientation = 'h',x = 0.1, y = 1))

} # end shiny single





}

# --------------------------------------------
if(layout %in% c("2axes","2panels") & plot.type == "print"){

if(layout == "2panels"){split.screen(figs=c(2,1));screen(n=1)}

plot(X[,1],X[,2],xlim=x.lim,bty="n", type="o",
      pch=19,xlab = labels[1],ylab=labels[2],col=colors[1],lwd = lwd.use, cex.axis = cex.axis.use)

if(layout == "2panels"){screen(n=2);axes.plot <- TRUE ; y.lab <- labels[3]}

if(layout == "2axes"){  par(new = TRUE);axes.plot <- FALSE; y.lab <- ""  }

plot(X[,1],X[,3],xlim=x.lim,bty="n", type="o",
       pch=21,xlab = labels[1],ylab=y.lab,col=colors[2],bg="white",axes=axes.plot,
       lwd = lwd.use, cex.axis = cex.axis.use)

if(layout == "2axes"){axis(4); mtext(side = 4, line = 2, y.lab ,cex=cex.axis.use,col=colors[2])}
if(layout == "2panels"){close.screen(all.screens = TRUE)}

}


if(layout == "2panels" & plot.type == "shiny"){
# https://plot.ly/r/subplots/
p1 <- plot_ly(X, x = ~x_vec, y = ~L1_vec, name = labels[2], type = "scatter", mode = "lines+markers") %>%
      layout(title = "", xaxis = list(title = labels[1]), yaxis = list (title = labels[2]),
             legend = list(orientation = 'h',x = 0.1, y = 1))


p2 <- plot_ly(X, x = ~x_vec, y = ~L2_vec, name = labels[3], type = "scatter", mode = "lines+markers") %>%
  layout(title = "", xaxis = list(title = labels[1]), yaxis = list (title = labels[3]))

p <- subplot(p1, p2,nrows = 2, shareX = TRUE)


} # end shiny 2 panels


if(layout == "2axes" & plot.type == "shiny"){
#https://plot.ly/r/multiple-axes/


  y2.axis <- list(tickfont = list(color = "red"), overlaying = "y", side = "right",
                  title = labels[3] )

  p <- plot_ly(X, x = ~x_vec, y = ~L1_vec, name = labels[2], type = "scatter", mode = "lines+markers") %>%
    add_lines(x = ~x_vec, y = ~L2_vec, name = labels[3], yaxis = "y2") %>%
    layout(
      title = list(title = labels[1]), yaxis2 = y2.axis, yaxis = list(title=labels[2]),
      xaxis = list(title=labels[1]),
      legend = list(orientation = 'h',x = 0.1, y = 1)
    )



} # end shiny 2 panels



if(plot.type == "shiny"){return(p)}


} # end plotPair







