splitter = function(data, prop, seed) {
  our_seed = set.seed(seed)
  shuffled_data = data[sample(1:nrow(data)), ]
  split_data = initial_split(shuffled_data, prop)
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

idpeeler = function(data) {
  data %>%
    training() %>%                                                  # pull out training data
    recipe(YY_Under_Five_Mortality_Rate_U5MR_Total_Person ~ .) %>%  # set U5MR  as our target   
    step_rm(all_predictors(), -State_District_Name) %>%             # select only the id and response variables
    step_naomit(all_predictors()) %>%                               # remove obs. /w NAs
    step_normalize(all_outcomes(), all_numeric()) %>%               # want to normalize the target(?)
    step_zv(all_predictors()) %>%                                   # remove zero variance variables 
    prep()                                                          # set above steps as basis for preprocessing
}
  
mlrify = function(input) {
  task = makeRegrTask(data = input, target = "YY_Under_Five_Mortality_Rate_U5MR_Total_Person")  # gross
}

predictor = function(learner, task, digits) { 
  initial = predict(learner, task) %>%
  .$data %>%
  mutate(truth = round(truth, digits)) %>%
  mutate(response = round(response, digits))
}


# model_list = list(results_rfor, results_ela, results_xgb, results_svm, results_glm)
# model_names = c("randomForest", "Elasticnet", "xgBoost", "SVM", "GLM")
# tibble_list = list()
# hey = function(list) {
#   for (model in model_list) {
#     inter = metrics(results_rfor, truth, response) %>%
#       select(-.estimator) %>% 
#       mutate(model = "placeholder") %>%
#       select(model, .metric, .estimate) %>%
#       spread(.metric, .estimate)
#       for (name in model_names) {
#         inter[1, 1] = name
#       }
#       tibble_list[[model]] = inter
#   }
#   bind_rows(tibble_List)






