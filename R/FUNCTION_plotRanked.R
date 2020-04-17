#' plotRanked
#'
#' Function to generate a summary plot with variables ranked by median and showing range.
#' @param data.df a data frame with numerical variables
#' @param trim a value between 0 and 50, specifying the percentile to trim on each side of the whiskers (0 = show range from min to max, 10 = show 10th to 90th percentile), Default is 25.
#' @param xlim a vector with numeric values to bound the x axis
#' @param maxvars max number of variables to display, default is NULL (i.e. show all).
#' @keywords ranking, range
#' @export
#' @examples
#' plotRanked(SPATData_EnvCov[,16:33],maxvars=NULL,flag=names(SPATData_EnvCov)[19])


plotRanked <- function(data.df,trim = 25, maxvars=NULL,xlim=NULL,flag=NULL){

	options(scipen=100000)


	if(length(data.df) == 1){

	plot(1:5,1:5, type="n", xlab="",ylab="",axes=FALSE)
	text(2.5,2.5,"Need to select at least 2 series for this plot")
	}



	if(length(data.df)>1){

	data.summary <- as.data.frame(t(apply(data.df,MARGIN=2,FUN = quantile, probs=seq(0,1,by=0.01),na.rm=TRUE))) #%>% arrange(desc("50%")) # not working

	# do it the old-fashioned way...
	data.summary <- data.summary[order(data.summary[,"50%"],decreasing = TRUE),]


	# keep only the median and the trimmed bounds
	data.summary <- data.summary[,c(paste0(trim,"%"),"50%",paste0(100-trim,"%"))]


	if(is.null(xlim)){xlim <- range(data.summary)}
	if(!is.null(maxvars)){num.units <- maxvars}
	if(is.null(maxvars)){num.units <- length(data.df)}

	tick.loc <- num.units:(num.units-length(data.df)+1)


	}

  par(mar=c(5,11,4,2)+0.1)

	plot(1:10,1:10, xlim=xlim,ylim=c(1,num.units), #main="Ranked By Median",
		cex.main=0.8, 	type="n",bty="n",axes=FALSE,xlab= "",ylab="",cex.lab=1.5)

	axis(2,at=tick.loc ,labels=dimnames(data.summary)[[1]],las=1,lwd=1,line=1)

	x.ticks <- pretty(xlim,n=5)
	x.ticks <- x.ticks[x.ticks<xlim[2] & x.ticks > xlim[1]]

	if(max(x.ticks)<=10^3){x.ticks.labels <- x.ticks}
	if(max(x.ticks)>10^3){x.ticks.labels <- paste(x.ticks/10^3,"k",sep="")}
	if(max(x.ticks)>10^4){x.ticks.labels <- paste(x.ticks/10^4,"*10k",sep="")}
	if(max(x.ticks)>10^5){x.ticks.labels <- paste(x.ticks/10^5,"*100k",sep="")}
	if(max(x.ticks)>10^6){x.ticks.labels <- paste(x.ticks/10^6,"M",sep="")}

	axis(3,at=x.ticks,labels=x.ticks.labels)


	if(!is.null(flag)){
			flag.idx <- names(data.df) ==flag
			abline(h=c(tick.loc[flag.idx]+0.5,tick.loc[flag.idx]-0.5),col="tomato",lty=2,xpd=TRUE)
			}


	lines(data.summary[,"50%"],tick.loc,type="b",pch=19,cex=1.6,col="darkblue",xpd=NA)
	segments(data.summary[,paste0(trim,"%")],tick.loc,data.summary[,paste0(100-trim,"%")],tick.loc,col="darkblue")
	#points(tmp.summary[,"Min"],tick.loc,pch="|",cex=0.8,col="darkblue")
	#points(tmp.summary[,"Max"],tick.loc,pch="|",cex=0.8,col="darkblue")

		# custom legend
		#leg.y <- num.units*0.1
		#points(x.lim.use*.8,leg.y,pch=19,cex=1.6,col="darkblue")
		#segments(x.lim.use*.6,leg.y,x.lim.use*.9,leg.y)
		#points(x.lim.use*.6,leg.y,pch="|")
		#points(x.lim.use*.9,leg.y,pch="|")
		#text(x.lim.use*.75,leg.y*1.6,labels="Range and weighted avg \nacross years",cex=.9)

return(data.summary)

}




