% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FUNCTION_transformData.R
\name{transformData}
\alias{transformData}
\title{transformData}
\usage{
transformData(x, type = "none", cols = NULL, zero.convert = NA)
}
\arguments{
\item{x}{a data frame with at least 1 numeric column}

\item{type}{one of  "none","log" ,"z-score","perc_rank"}

\item{cols}{vector with names of columns to be transformed. Use NULL to transform all numeric columns.}

\item{zero.convert}{replace 0 with this value if required by the transformation (e.g. log)}
}
\description{
This function applies various data transformations to a data frame
}
\examples{
iris.transform <- transformData(iris,
   type="log",
   cols="Sepal.Length",
   zero.convert = NA)
head(iris.transform)
}
\keyword{percent}
\keyword{rank}
\keyword{transform,}
\keyword{z-score,}
