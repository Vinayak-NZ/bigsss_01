## ---- impute-data

# exclude variables from imputation
exclude_vars <- c("id", "Group", "Age", "v_236")

# identify variables to impute
vars_to_impute <- setdiff(names(data_input), exclude_vars)

data_impute_input <- data_input[, vars_to_impute]

# impute data
data_imputed <- mice(data_impute_input, 
                     m = 5, 
                     maxit = 33, 
                     seed = 123)

# create single imputed dataset
data_imputed_pooled <- merge_imputations(data_impute_input,
                                         data_imputed,
                                         ori = data_impute_input)

# create mice output
data_imputed_output <- list()

for (i in 1:data_imputed$m){

  data_imputed_output[[i]] <- complete(data_imputed, i)

  data_imputed_output[[i]] <- cbind(data_input[, exclude_vars], data_imputed_output[[i]])

}
