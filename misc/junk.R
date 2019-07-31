##### Storage for junk code #####

### Functions

# idpeeler = function(data) {
#   data %>%
#     training() %>%                                                  # pull out training data
#     recipe(YY_Under_Five_Mortality_Rate_U5MR_Total_Person ~ .) %>%  # set U5MR  as our target   
#     step_rm(all_predictors(), -State_District_Name) %>%             # select only the id and response variables
#     step_naomit(all_predictors()) %>%                               # remove obs. /w NAs
#     step_normalize(all_outcomes(), all_numeric()) %>%               # want to normalize the target(?)
#     step_zv(all_predictors()) %>%                                   # remove zero variance variables 
#     prep()                                                          # set above steps as basis for preprocessing
# }

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

# loadd(train_data)
# loadd(glm_trained)
# loadd(rfor_trained)
# rfor_trained$features
# 
# hey = glm_featureimport(train_data)
# meh2 = train_data %>%
#   select(target, boof) %>%
#   select(contains(target)) %>%
#   mutate(id = row_number()) %>%
#   select(id, target, everything())
# 
# meh2
# target = "YY_Under_Five_Mortality_Rate_U5MR_Total_Person"
# 
# 
# boofier = train_data %>%
#   select(boof) %>%
#   mutate(id = row_number()) %>%
#   select(id, everything())
# 
# merged = boofier %>%
#   left_join(meh, by = "id") %>%
#   select(-id)
# 
# hey = getFeatSelResult(glm_trained)
# 
# boof = hey$x

### Modeling

# glm_params = makeParamSet()  need to figure out stepwise selection in MLR 
# makeFeatSelControlSequential  ?????
# results = target(
#   train(learner, task),
#   transform = cross(leaner, task))

# meh = as_tibble(t(as.data.frame(metrics(results_rfor, truth, response)))) %>%
#   rename(rmse = V1, rsq = V2, mae = V3) %>%
#   filter(rmse <= 1 | rsq <= 1 | mae <= 1) %>%
#   mutate(model = "randomForest") %>%
#   select(model, rmse, rsq, mae)
# meh

# metrics(results_rfor, truth, response) %>%
#   select(-.estimator) %>%
#   gather(key = .estimate, value = .metric)
# 
# metrics(results_rfor, truth, response) %>%
#   mutate(name = "randomForest") %>%
#   select(-.estimator) 

# model_list = list(results_rfor, results_ela, results_xgb, results_svm, results_glm)
# tibble_list = list()
# hey = function(list) {
#   for (model in model_list){
#     inter = as_tibble(t(as.data.frame(metrics(model, truth, response)))) %>%
#       rename(rmse = V1, rsq = V2, mae = V3) %>%
#       filter(rmse <= 1 | rsq <= 1 | mae <= 1) %>%
#       mutate(model = "randomForest") %>%
#       select(model, rmse, rsq, mae)
#     tibble_list = c(tibble_list, inter)
#   bind_rows(tibble_list)
#   }
# }




