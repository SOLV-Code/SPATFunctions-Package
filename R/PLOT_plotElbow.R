
plotElbow <- function(k.vec, sum.sq.vec , rescale = TRUE){

if(!rescale){
			plot.vals <- sum.sq.vec
			ylim.use <-  c(0,max(sum.sq.vec))
			ylab.use <- "Within Sum of Squares"
		}
			
if(rescale){ 
		plot.vals <- sum.sq.vec/max(sum.sq.vec,na.rm=TRUE) 
		ylim.use <- c(0,1)
		ylab.use <- "Rescaled Within Sum of Squares"
			}

plot(k.vec,plot.vals,type="o",bty="n", pch=19, cex=2,col="red", ylim=ylim.use,
        xlab= "Num Clusters",ylab=ylab.use)
	
		
} # end plotElbow()


