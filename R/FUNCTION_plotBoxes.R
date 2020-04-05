#' plotBoxes
#'
#' Function to generate side-by-side boxplots with various layout options. Note that
#' NA values are always dropped.
#' @param list.in a list with numerical vectors
#' @param y.lab label for the y axis
#' @param fill.vec vector with fill colors, one for each element of list.in
#' @param col.vec vector with border colors, one for each element of list.in
#' @param labels if TRUE, show median values
#' @param violin if TRUE, replace half the box plot with a violin plot
#' @param y.lim  NULL, or a vector with y axis limits
#' @param y.lim.trim if y.lim is NULL, should the automatic y limit be trimmed? (skip for large outliers)
#' @param show.n if TRUE, show the sample size for each box
#' @keywords pairwise correlation, retrospective
#' @export
#' @examples
#' plotBoxes(list.in = list(Var1 = rnorm(200,0,1),Var2 = rnorm(200,0.5,3)))



plotBoxes <- function(list.in= NULL,y.lab = "Axis Label",fill.vec = NULL ,border.vec= NULL,
				labels=TRUE,violin=TRUE,y.lim=NULL,y.lim.trim = FALSE, show.n = TRUE){


# 
if(is.null(fill.vec)){ fill.vec <- rep("lightgrey",length(list.in))}
if(is.null(border.vec)){ border.vec <- rep("darkgrey",length(list.in))}
if(is.null(y.lim)){
			y.lim <- range(list.in ,na.rm=TRUE)
			
			if(y.lim.trim){y.lim <- c(y.lim[1]*0.9,y.lim[2]*1.1)}
			
			}
	
	
	
	plot(1:5,1:5,type="n",ylim = y.lim,xlim=c(0,length(list.in)+1), ylab= y.lab, xlab="" , axes=FALSE, bty="n" )
	axis(2)

	#lines(1:length(list.in),lapply(list.in, median,na.rm=TRUE),col="darkblue")

	for(i in 1:length(list.in)){

		vec.use <- list.in[[i]]
		quants.use <- quantile(vec.use,probs=c(0.1,0.25,0.5,0.75,0.9),na.rm=TRUE)

		points(rep(i,2),range(vec.use,na.rm=TRUE),pch=19,cex=0.7,col=border.vec[i])

		segments(i ,quants.use[1],i, quants.use[5],col=border.vec[i])
		rect(i - 0.2 ,quants.use[2],i+0.2, quants.use[4],border=border.vec[i],col = fill.vec[i])
		segments(i - 0.2 ,quants.use[3],i+0.2, quants.use[3],col=border.vec[i])

		
		if(sum(!is.na(vec.use))>5 & violin){
		
				#"erase" half the boxplot
				rect(i - 0.2 ,par("usr")[3],i-0.04, par("usr")[4],border="white",col = "white")	
				# calculate the kernel density (i.e. shape of the violin half
				tmp <- density(list.in[[i]],na.rm=TRUE)
				
				# "rotate the violin"
				y.new <- -tmp$y/max(tmp$y)*0.4
					
				# plot it
				polygon(y.new+i-0.04,tmp$x,col=fill.vec[i],border="white")
				lines(y.new+i-0.04,tmp$x,type="l",xlim=c(0,8),col="white")

				} #end violin
		
		
		
		
		
		if(labels){
		
			if(min(abs(quants.use[3])) > 10 ){ med.labels.use <- round(quants.use[3],1)}
			if(min(abs(quants.use[3])) > 1 & min(abs(quants.use[3]))<= 10){ med.labels.use <- round(quants.use[3],2)}
			if(min(abs(quants.use[3])) <= 1){ med.labels.use <- round(quants.use[3],3)}
				
			text(i+0.22,quants.use[3], labels=med.labels.use,cex=0.8,adj=0,col="darkgrey")
			#text(i+0.22,quants.use, labels=quants.use,cex=0.8,adj=0,col="darkgrey")
			#text(i+0.22,range(vec.use,na.rm=TRUE), labels=range(vec.use,na.rm=TRUE),cex=0.8,adj=0,col="darkgrey")
			
			

			
			}
				
	

		} # end looping through vectors


	#legend(0,par("usr")[4]+(par("usr")[4]-par("usr")[3])*.05,legend= names(list.in)
	#	             ,bty="n",cex=0.8,fill=fill.vec,col=border.vec,xpd=NA)

	# label x axis instead of legend
	axis(1,at = 1:length(list.in),labels=names(list.in))


	# add n obs above axis ticks
	
	if(show.n){
	n.obs <- unlist(lapply(list.in,FUN = function(x) sum(!is.na(x))))
	text(1:length(list.in),par("usr")[3],labels=n.obs,adj=c(0.5,-0.3),cex=0.8,col="red")
	text(0.5,par("usr")[3],labels="n=",adj=c(0.5,-0.3),cex=0.8,col="red")
	}

}