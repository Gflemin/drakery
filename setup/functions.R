
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

plotter = function(metrics) { 
  metrics %>% 
    gather(key = "metric", "value", 2:4) %>%
    ggplot(aes(metric, value, color = model, group = model)) + 
    geom_line() + geom_point() + labs(title = "Model Performance Metrics",
                                      x = "Metric",
                                      y = "Performance")
}

glm_featureimport = function(glm, data) {
  feature_object = getFeatSelResult(glm)
  features = feature_object$x
  target_id = data %>%
    select(target, features) %>%
    select(contains(target)) %>%
    mutate(id = row_number()) %>%
    select(id, target, everything()) 
  features_id = data %>%
    select(features) %>%
    mutate(id = row_number()) %>%
    select(id, everything())
  sub_features = features_id %>%
    left_join(target_id, by = "id") %>%
    select(-id) %>%
    select(target, everything())
  pred = Predictor$new(glm, data = sub_features, 
                       y = glm$task.desc$target)
  importance = FeatureImp$new(pred, loss = "mae")
  importance$results %>%
    arrange(desc(importance)) %>%
    select(feature, importance) %>%
    top_n(15) %>%
    ggplot(aes(importance, reorder(feature, importance))) + 
    geom_point() + geom_segment(aes(x = 0, xend = importance, 
                                    y = feature, yend = feature)) 
}

other_featureimport = function(trained_model, data) {
  features = trained_model$features
  target_id = data %>%
    select(target, features) %>%
    select(contains(target)) %>%
    mutate(id = row_number()) %>%
    select(id, target, everything()) 
  features_id = data %>%
    select(features) %>%
    mutate(id = row_number()) %>%
    select(id, everything())
  sub_features = features_id %>%
    left_join(target_id, by = "id") %>%
    select(-id) %>%
    select(target, everything())
  pred = Predictor$new(trained_model, data = sub_features, 
                       y = trained_model$task.desc$target)
  importance = FeatureImp$new(pred, loss = "mae", n.repetitions = 10)
  importance$results %>%
    arrange(desc(importance)) %>%
    select(feature, importance) %>%
    top_n(15) %>%
    ggplot(aes(importance, reorder(feature, importance))) + 
    geom_point() + geom_segment(aes(x = 0, xend = importance, 
                                    y = feature, yend = feature)) + 
    theme_minimal() #+
    #theme(axis.text.y = element_blank()) 
  
}

