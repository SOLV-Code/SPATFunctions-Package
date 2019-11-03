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


## Current Features


* *transformData():* function to apply various transformations to the input data. Currently includes
 the options "none","log" ,"z-score", and "perc_rank".















