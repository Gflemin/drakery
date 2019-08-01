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

# ela_params = makeParamSet(
#   makeDiscreteParam("lambda", seq(0.0, 0.9, 0.1))),

# ela_tuning = tuneParams(learners_ela,
#                                task = mlr_task_train_data,
#                                resampling = resample,
#                                measures = measure,
#                                par.set = ela_params,
#                                control = ctrl_others),

# ela_tuned = setHyperPars(learner = learners_ela,
#                           par.values = ela_tuning$x),


### NOTE:
# loadd(train_data)
# glimpse(train_data)
# train_data$LL_Total_Fertility_Rate_Urban
# pulled above code out because I was getting a strange error with the train task due to columns of all NAs. fixed
# by adding a line to recipes to remove variables /w zero variance

### NOTE: 
# Still need to figure more about how to use transform() within drake 

### NOTE:
# Check what a MLR model's hyperparameters are via getParamSet(makeLearner("regr.glmnet")) or similar for other 
# models

### NOTE:
# Drake::make() will sometimes rerun old targets if you add enough new targets that are early in the pipelinel
# still unsure why this occurs 

### NOTE:
# Ought to look into using mlr::benchmark() in the future 

### NOTE:
# Still need to merge district names onto our results dataframe 

### NOTE:
# Still need to functionalize/loop over the yardstick tibbles for cleanliness sake

### NOTE:
# Not sure where elastic net is getting the lambda values that its using prior to tuning 

### ERROR:
# Can't get tuned lambda values for glmnet to feed in correctly to setHyperPars

### ERROR:
# Unsure if vis_drake_graph can expand beyond 15 entries per column due to it not being able to show an additional
# learner on top of what we have now 

### ERROR:
# Still unable to include id variables in the training datasets when they proceed to modeling. There has to be some
# way to make MLR ignore them! 

### ERROR:
# Still need to get stepwise selection working with GLM, because otherwise we have a serious overfitting issue!

### ERROR:
# Function targets aren't showing up as outdated when I update them? 

### ERROR:
# We have 85 observations in testing(split_data), so why do we only have 56 in the actual results after predicting?

### BUG:
# In current xgboost version that makes it act all weird when I try to do feature importance for it. pull github
# version when I can 

# need to do something about how long and wide this plan is getting, or at least find a way to do good indents


