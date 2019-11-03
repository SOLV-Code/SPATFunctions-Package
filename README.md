# SPATFunctions-Package
Functions for the Salmon Pattern Analysis Tool

**Important Note**

This package is under development. Functions will change rapidly and substantially.
Do not use these if you are not part of the development team!


## Install

To install this package directly from github, use

```
install.packages("devtools") # Install the devtools package
library(devtools) # Load the devtools package.
install_github("SOLV-Code/SPATFunctions-Package", 
				dependencies = TRUE,
                build_vignettes = FALSE)
library(SPATFunctions)				
```

## Data Conventions

* *category columns* need to be coded as text. For example is areas in the raw data are coded as 1-17, revise the values to "A1", "A2", "A3", etc., using something like  *raw.df$area <- paste0("A",raw.df$area)*
* *numerical columns*: assumed to be meaningful as numbers (i.e. for calculating means, logs etc)
* there should be no factors in the input object. If reading in from a csv file, include 
*stringsAsFactors = FALSE*



## Current Functions

### Data Treatment Functions
* *summarizeData():* function to generate a summary of the variables in a data frame (incl. checking for skewness, multimodality, correlation, and proportion of missing values)
* *transformData():* function to apply various transformations to the input data. Currently includes
 the options "none","log" ,"z-score", and "perc_rank".

### Clustering Functions

* TBI

### Plotting Functions

* TBI

## Planned Functions

### Data Treatment Functions

* *fixData():* function that uses *summarizeData()* and some general rules to automatically apply *transformData()* as needed, as well as drop any highly correlated variables (e.g. would remove one of size and weight).


### Clustering Functions

* *cluster_1D()*: function to apply various methods for clustering on a single variables (i.e. on a histogram)
* *cluster_2D()*: function to apply various methods for bivariate clustering (i.e. on a scatterplot)
* *cluster_nD()*: function to apply various methods for clustering on a 3 or more variables
* *cluster_timeseries()*: function to apply various methods for clustering on a 3 or more variables

### Plotting Functions

* TBI







