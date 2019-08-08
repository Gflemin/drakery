
# Put in our model target from the dataset
target = "YY_Under_Five_Mortality_Rate_U5MR_Total_Person"

# Prevent mlr from spitting out certain warnings during the tuning step we don't care about 
configureMlr(on.par.without.desc = "quiet")

# Prevent drake from throwing out the r_make interactive prompt when make() is run for the first time in a session
options(drake_make_menu = FALSE)