# SPATFunctions-Package
Functions for the Salmon Pattern Analysis Toolkit (SPAT). **Important Note:** This package is under development. Functions will change rapidly and substantially. Do not use these if you are not part of the development team!

To get up and running with some examples, follow the *Quick Start* steps below. For more about the project (e.g. design principles, completed and planned functionality), go to the [wiki pages](https://github.com/SOLV-Code/SPATFunctions-Package/wiki). Leave any comments, feature requests, or bug reports on the [issues page](https://github.com/SOLV-Code/SPATFunctions-Package/issues).

Active shiny apps using the *SPATFunctions* Package:
* SPAT Correlation Analysis ([online](https://solv-code.shinyapps.io/spat_correlationanalysis/),[run locally](https://github.com/SOLV-Code/SPATApps)): Compare data series side-by-side, explore correlations over time between 2 series, and cluster series in a correlation matrix. Data format is a table with a **yr** column and 2 or more variable columns. The built-in data set for illustration is *SPATData_EnvCov*, which includes R/S for 18 stocks of Fraser River Sockeye Salmon and various environmental covariates (e.g. river discharge, sea surface temperature).

Planned shiny apps using the *SPATFunctions* Package:
* *SPAT Cluster Analysis*: model-based clustering based on finite normal mixture modelling, built as a front-end for functions in the {mclust} package. Data format is a table where each row is an individual record and each column is a numeric variable for that record (e.g. tag location, tag date, tag id, age, size) 
* *SPAT Tree Analysis*: clustering based on recursive partitioning (Classification and Regression Trees, CART). Data format is a table where each row is an individual record and each column is a numeric or categorical variable for that record (e.g. CU Name, Status Category, AvgSpn, ProbDecl) 


## Quick Start

### Install

To install this package directly from github, use

```
install.packages("devtools") # Install the devtools package
library(devtools) # Load the devtools package.
install_github("SOLV-Code/SPATFunctions-Package", 
				dependencies = TRUE,
                build_vignettes = FALSE)
library(SPATFunctions)				
```



### Worked Examples


```
library(SPATFunctions)

# Note: using built-in data set of environmental covariates
head(SPATData_EnvCov)

# Calculate correlation matrix of raw data (excluding first column with years)
M <- calcCorrMatrix(SPATData_EnvCov[,-1])
head(M$cor.mat)

# plot correlation matrix
plotCorrMatrix(M$cor.mat) # original order of variables
plotCorrMatrix(M$cor.mat,order="hclust",n.groups=4)  # clustered by correlation

# repeat, with modified data:
# - shift (offset) the pdo variable by 2 years (just as an illustration, this is not meaningful)
# - transform all variables to z-score (i.e. normalize)
head(SPATData_EnvCov)
data.shifted <- shiftSeries(SPATData_EnvCov, offsets=c(0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,rep(0,18)))
head(data.shifted)
data.z <- transformData(data.shifted,type="z-score",
                       cols=names(data.shifted)[names(data.shifted)!="yr"],
                       zero.convert = NA )
head(data.z)
M.z <- calcCorrMatrix(data.z[,-1])
plotCorrMatrix(M.z$cor.mat) # original order of variables
plotCorrMatrix(M.z$cor.mat,order="clustered",n.groups=4)


# pairwise correlations (cumulative and by time window)

vars.test <- c("EC_jflow","EC_pdo")

plotPair(SPATData_EnvCov[,c("yr",vars.test)],layout = "single")
plotPair(data.z[,c("yr",vars.test)],layout = "2panels")


running.corr <- comPair(SPATData_EnvCov[,c("yr",vars.test)],
                        window = 12,plot.type="print")
running.corr

running.corr.z <- comPair(data.z[,c("yr",vars.test)],
                        window = 12,plot.type="print")
running.corr.z
```

