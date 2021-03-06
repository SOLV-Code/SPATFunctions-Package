% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SUB_1D_plotClassInt.R
\name{plotClassInt}
\alias{plotClassInt}
\title{plotClassInt}
\usage{
plotClassInt(x, plot.type = "basic", label = "Var Name")
}
\arguments{
\item{x}{object created by applyClassInt()}

\item{plot.type}{one of ""basic", "hist", "dens","cumul"}
}
\description{
Subroutine for creating diagnostic plots of the output from applyClassInt()
}
\examples{
length.classes <- applyClassInt(SPATData_Samples$LengthMEF,
   style="fisher",breaks=3)
plotClassInt(length.classes,
   plot.type="cumul",
   label = "Length (Mid-eye to Fork,mm)")
}
\keyword{classification}
\keyword{interval}
