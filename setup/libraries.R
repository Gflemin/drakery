### NOTE: 
# Packages for using markdown/R notebooks should be installed by interacting with with the analysis.Rmd document

# Install the required packages if packrat fails for some reason
# packages = c("drake", "knitr", "visNetwork", "readr", "dplyr", "recipes", "yardstick", "mlr", "ggplot2", "stringr", "here",
#            "rsample", "iml", "randomForest", "xgboost", "e1071", "tidyr", "tibble", "devtools", "iml",
#            "BH",  "plogr")
# install.packages(packages)

# Restore packrat packages
packrat::restore()

# Load the packages
library(drake)
library(knitr)
library(visNetwork)
library(readr)
library(dplyr)
library(recipes)
library(yardstick)
library(mlr)
library(ggplot2)
library(stringr)
library(here)
library(rsample)
library(iml)
library(randomForest)
library(xgboost)
library(e1071)
library(tidyr)
library(tibble)
library(devtools)
library(iml)
library(BH)
library(plogr)

# Setting paths with here
functions = here("setup", "functions.R")
district_path = here("data", "Key_indicator_districtwise.csv")
targeter = here("setup", "targeter.R")

# Removing packages object because its no longer needed
rm(packages)             

# Prevent mlr from spitting out certain warnings during the tuning step we don't care about 
configureMlr(on.par.without.desc = "quiet")

