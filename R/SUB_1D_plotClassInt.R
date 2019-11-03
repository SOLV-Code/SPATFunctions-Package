#' plotClassInt
#'
#' Subroutine for creating diagnostic plots of the output from applyClassInt()
#' @param x object created by applyClassInt()
#' @param plot.type one of ""basic", "hist", "dens","cumul"
#' @keywords classification interval
#' @export
#' @examples
#' length.classes <- applyClassInt(SPATData_Samples$LengthMEF,
#'    style="fisher",breaks=3)
#' plotClassInt(length.classes,
#'    plot.type="cumul",
#'    label = "Length (Mid-eye to Fork,mm)")





plotClassInt <- function(x,plot.type="basic",label = "Var Name"){
# x = 
# 

  label <- paste0(label," (",x$num.na," NA)")
  
  
  if(plot.type=="basic"){
  plot(x$obs,rep(1,length(x$obs)),pch=19,col="darkblue",bty="n",xlab=label,ylab="",axes=FALSE)
  axis(1)
  title(main="Basic",cex.main=1)
    segments(x$obs,rep(1,length(x$obs)),x$obs,rep(0,length(x$obs)))
  abline(v=tail(head(x$breaks,-1),-1),col="red", lwd=2) # remove first and last break
  }
  
  if(plot.type=="dens"){
  d <- density(na.omit(x$obs))
  plot(d,col="darkblue",bty="n", main= "Density",xlab=label)
  polygon(d, col="lightblue", border="blue") 
  abline(v=tail(head(x$breaks,-1),-1),col="red", lwd=2) # remove first and last break
  # NEED TO ADD AXIS LABEL
  }
  
  
  if(plot.type=="hist"){
  hist.out <- hist(na.omit(x$obs),freq=TRUE, col="lightblue",border="lightblue", main="Histogram",
                      cex.main=1,xlab = label )
  abline(v=tail(head(x$breaks,-1),-1),col="red", lwd=2) # remove first and last break
  }
  
  
  if(plot.type=="cumul"){
    
  
    #  could use built in plot from classInt package
    # but it chokes on the NA obs that are not filtered out in the wrapper
    # easier to just make our own
    # plot(tmp.out$fit,pal=c("yellow","red")) 
    
      plot(ecdf(x$obs),verticals=FALSE,bty="n",ylab="Cumulative Density",
                  main="Cumulative Density",cex.main=1,xlab=label)
      #should convert this to a line plot, rather than the step function
    
    abline(v=tail(head(x$breaks,-1),-1),col="red", lwd=2) # remove first and last break
    
    }
  
 } # end plotClassInt()