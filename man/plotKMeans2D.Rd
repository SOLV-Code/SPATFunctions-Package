% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SUB_2D_plotKMeans2D.R
\name{plotKMeans2D}
\alias{plotKMeans2D}
\title{plotKMeans2D}
\usage{
plotKMeans2D(x, fit, plot.type = "basic")
}
\arguments{
\item{x}{input used in call to applyKMeans2D()}

\item{fit}{object created by applyKMeans2D()}

\item{plot.type}{none yet}
}
\description{
Subroutine for creating diagnostic plots of the output from applyKMeans2D()
}
\examples{
test.data <- SPATData_Samples[,c("Weight","LengthMEF")]
test.clusters <- applyKMeans2D(test.data,centers= 2)
names(test.clusters)
plotKMeans2D(x=test.data,fit=test.clusters)
}
\keyword{clustering,}
\keyword{k-means,}
\keyword{plot}
