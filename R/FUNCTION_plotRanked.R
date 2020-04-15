#' plotRanked
#'
#' Function to generate a summary plot with variables ranked by median and showing range.
#' @param data.df a data frame with numerical variables
#' @keywords ranking, range
#' @export
#' @examples
#' plotRanked(SPATData_EnvCov[,2:5])

plotRanked <- function(data.df,avg.use = "wt.Avg",num.units=12,x.lim.in=NULL,flag=NULL){

	if(length(data.df) == 1){
	
	plot(1:5,1:5, type="n", xlab="",ylab="",axes=FALSE)
	text(2.5,2.5,"Need to select at least 2 series for this plot")
	}
	
	
	
	if(length(data.df)>1){
	
	data.summary <- t(apply(data.df,MARGIN=2,FUN = quantile, probs=seq(0,1,by=0.05),na.rm=TRUE))
	
	
	}
	

	
	if(is.null(x.lim.in)){x.lim.use <- max(tmp.summary[,"Max"])}
	if(!is.null(x.lim.in)){x.lim.use <- x.lim.in}

	tick.loc <- num.units:(num.units-dim(tmp.summary)[1]+1)
	options(scipen=100000)
	plot(1:10,1:10, xlim=c(0,x.lim.use),ylim=c(1,num.units), main=var.label,type="n",bty="n",axes=FALSE,xlab= "",ylab="",cex.lab=1.5)
	
	axis(2,at=tick.loc ,labels=tmp.summary[,1],las=1,lwd=1,line=1)

	x.ticks <- pretty(c(0,x.lim.use),n=5)
	x.ticks <- x.ticks[x.ticks<x.lim.use]
	
	if(max(x.ticks)<=10^3){x.ticks.labels <- x.ticks}
	if(max(x.ticks)>10^3){x.ticks.labels <- paste(x.ticks/10^3,"k",sep="")}
	if(max(x.ticks)>10^4){x.ticks.labels <- paste(x.ticks/10^4,"*10k",sep="")}
	if(max(x.ticks)>10^5){x.ticks.labels <- paste(x.ticks/10^5,"*100k",sep="")}
	if(max(x.ticks)>10^6){x.ticks.labels <- paste(x.ticks/10^6,"M",sep="")}

	axis(1,at=x.ticks,labels=x.ticks.labels)
	
	if(!is.null(flag)){
			flag.idx <- tmp.summary[,1]==flag
			abline(h=c(tick.loc[flag.idx]+0.5,tick.loc[flag.idx]-0.5),col="tomato",lty=2,xpd=TRUE)
			}

	lines(tmp.summary[,avg.use],tick.loc,type="b",pch=19,cex=1.6,col="darkblue",xpd=NA)
	segments(tmp.summary[,"Min"],tick.loc,tmp.summary[,"Max"],tick.loc,col="darkblue")
	points(tmp.summary[,"Min"],tick.loc,pch="|",cex=0.8,col="darkblue")
	points(tmp.summary[,"Max"],tick.loc,pch="|",cex=0.8,col="darkblue")

		# custom legend
		leg.y <- num.units*0.1
		points(x.lim.use*.8,leg.y,pch=19,cex=1.6,col="darkblue")
		segments(x.lim.use*.6,leg.y,x.lim.use*.9,leg.y)
		points(x.lim.use*.6,leg.y,pch="|")
		points(x.lim.use*.9,leg.y,pch="|")
		text(x.lim.use*.75,leg.y*1.6,labels="Range and weighted avg \nacross years",cex=.9)

}




