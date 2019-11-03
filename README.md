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

## Design Principles

The goal is to build a tool kit for guided exploration of salmon data, not an automated data mining tool that blindly searches through vast data sets.

The plan is to develop a generalized flow chart of steps, build package functions for each step, and then connect the functions in a shiny app.


## Data Conventions


### Required Identifier Variables

Column Label | Description
-- | --
*Year* | numeric value identifying the year. Need this even if all data is from the same year. Will be used in plot labels and to populate filters in the app. The *Year* column is excluded from  any data treatment and analysis functions.
*Pop* | character string identifying the names of the basic units (e.g. conservation unit, stock). SPAT is designed to explore patterns across different populations, so need at least 2 populations. 


### Optional Identifier Variables

Column Label | Description
-- | --
*Grp_XYZ* | character string identifying various groupings of the basic units (e.g. area, watershed). *Important:* these need to be coded as text. For example if areas in the raw data are coded as 1-17, revise the values to "A1", "A2", "A3", etc., using something like  *raw.df$area <- paste0("A",raw.df$area)*
*Date* | Will probably not build in any app responsiveness to this in the first round, but could have this in the data file to filter records before applying any of the functions 
*SampleID* | character string to identify individual samples (e.g. if have 500 length measurements from each year, give each an ID like *S-2010-001*,*S-2010-002*,etc)

*Note:* there should be no factors in the input object. If reading in from a csv file, include 
*stringsAsFactors = FALSE*. 

### Value Variables


* *numerical columns*: assumed to be meaningful as numbers (i.e. for calculating means, logs etc)
* *character columns*: assumed to be meaningful as qualitative information, unless the column label starts with *Grp_*. 

**Need to think some more about how to handle qualitative data vs. grouping variables, because some analyses can also use the grouping variables (e.g. recursive partitioning).**

### 3 Levels of Data Resolution

The data structure described above allows for 3 levels of resolution in a consistent framework. 
Note that not all analysis methods will work at all 3 levels.

Resolution  | Required Identifier Columns |   Analysis Example
-- | -- | --
*Samples* |  Year, Pop, Date, Sample_ID  |  check for differences in size distribution between years for each population, then match populations based on the pattern of changes
*Time Series* | Year, Pop  |  match populations based on the pattern of standardized deviations from long-term mean size
*Summary*  |   Year, Pop  |  pick a year, then fit a classification tree based on multiple numeric and qualitative variables (e.g. productivity, area, status).

The package includes an example of each data type. 

We are planning to eventually build a function that allows for easy roll-ups (*rollupData()*), but for now you have to do that step on your own.




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
* *rollupData():* function that rolls up a data set from individual samples to annual values, and from annual values to various summaries. For example, go from a file with individual size records to a time series of annual medians, to a classification of Large vs. Small. The idea is to basically build a case-specific user-friendly wrapper for the dplyr functionality of *group_by() %>% summarise()*

### Clustering Functions

* *cluster_1D()*: function to apply various methods for clustering on a single variables (i.e. on a histogram)
* *cluster_2D()*: function to apply various methods for bivariate clustering (i.e. on a scatterplot)
* *cluster_nD()*: function to apply various methods for clustering on a 3 or more variables
* *cluster_timeseries()*: function to apply various methods for clustering on a 3 or more variables

### Plotting Functions

* TBI







