% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FUNCTION_calcCorrMatrix.R
\name{calcCorrMatrix}
\alias{calcCorrMatrix}
\title{calcCorrMatrix}
\usage{
calcCorrMatrix(X, method = "pearson")
}
\arguments{
\item{X}{a matrix or a data frame with each column = 1 variable and each row 1 time step (any rows with 1 or more NA will be excluded)}

\item{method}{for now, one of "pearson" (default), "kendall", or "spearman":}
}
\description{
This function generates a correlation matrix with various options. For now, it is just a wrapper function for cor()  function from base R {stats} package. Plan is to build in alternative approaches.
}
\examples{
M <- calcCorrMatrix(mtcars)
}
\keyword{correlation}
\keyword{matrix}
