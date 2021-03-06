% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SUB_nD_plotRpart.R
\name{plotRpart}
\alias{plotRpart}
\title{plotRpart}
\usage{
plotRpart(x, label = "Var Name")
}
\arguments{
\item{x}{object created by applyRpart()}

\item{label}{plot title}
}
\description{
Subroutine for creating tree plots of the output from applyRpart()
}
\examples{
formula.use <- as.formula("Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width")
test.fit <- applyRpart(formula.use, data = iris,minsplit = 10)
plot(test.fit,label="Species Identification Tree")
}
\keyword{partitioning,}
\keyword{recursive}
\keyword{tree}
