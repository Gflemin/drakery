
splitter = function(data, prop, seed) {
  our_seed = set.seed(seed)                                         # set a seed to ensure our splits are consistent
  shuffled_data = data[sample(1:nrow(data)), ]                      # shuffle our data randomly  
  split_data = initial_split(shuffled_data, prop)                   # actually build a split data obj. for the data
}

preprocessor = function(data) {
  data %>%
    training() %>%                                                  # pull out training data
    recipe(YY_Under_Five_Mortality_Rate_U5MR_Total_Person ~ .) %>%  # set U5MR  as our target   
    step_rm(all_nominal()) %>%                                      # drop cols. that will cause modeling issues
    step_normalize(all_outcomes(), all_numeric()) %>%               # want to normalize the target(?)
    step_zv(all_predictors()) %>%                                   # remove zero variance variables 
    step_naomit(all_predictors()) %>%                               # remove obs. /w NAs
    prep()                                                          # set above steps as basis for preprocessing
}
  
mlrify = function(input) {
  task = makeRegrTask(                                              # wraps data in a mlr "task" for compatibility
    data = input,                                                   # whatever data we want to wrap
    target = "YY_Under_Five_Mortality_Rate_U5MR_Total_Person")      # our chosen target from the data
}

predictor = function(learner, task, digits) {              
  initial = predict(learner, task) %>%                              # use mlr model to make predictions on the task
  .$data %>%                                                        # pull data as a dataframe out from predict obj.
  mutate(truth = round(truth, digits)) %>%                          # rounding the 'truth' value to set digits
  mutate(response = round(response, digits))                        # rounding the 'response' value to set digits
}

