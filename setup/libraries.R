### NOTE: 
# Packages for using markdown/R notebooks should be installed by interacting with with the notebook document

# Install the required packages
# packages = c("drake", "visNetwork", "readr", "dplyr", "recipes", "yardstick", "mlr", "ggplot2", "stringr", "here",
#            "rsample", "iml", "randomForest", "e1071", "tidyr", "tibble", "devtools", "iml")
# install.packages(packages)

# Load the packages
library(drake)
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

# Setting paths with here
functions = here("setup", "functions.R")
district_path = here("data", "Key_indicator_districtwise.csv")
targeter = here("setup", "targeter.R")

# Removing packages object because its no longer needed
rm(packages)             

# ???
configureMlr(on.par.without.desc = "quiet")

