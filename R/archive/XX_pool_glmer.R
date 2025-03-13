
extract_results <- function(model) {
  coef_est <- fixef(model)  # Extract fixed effects coefficients
  coef_se <- sqrt(diag(summary(model)$vcov))  # Extract standard errors safely
  return(data.frame(Estimate = coef_est, SE = coef_se))
}

# Apply the function to all models
model_results <- lapply(model_01_pool$analyses, extract_results)

# Combine results into a single data frame
results_combined <- do.call(rbind, model_results)

# Pool estimates using `mitools`
library(mitools)

results_pooled <- MIcombine(model_01_pool$analyses)

# Print pooled results
summary(results_pooled)


data(smi)
models<-with(smi, glm(drinkreg~wave*sex,family=binomial()))
summary(MIcombine(models))
models

library(mitml)
results_pooled <- testEstimates(model_02_pool$analyses)




test <- mitools::MIextract(model_02_pool$analyses, fun = coef)
test2 <- lapply(model_02_pool$analyses, FUN=function(mm){
  smm <- summary(mm)
  smm <- smm$coefficients[,"Std. Error"]
} )
test3 <- mitools::MIextract(model_02_pool$analyses, fun = vcov)
test4 <- miceadds::pool_mi(qhat = test, u = test3)
test4 <- miceadds::pool_mi(qhat = test, se = test2)
test5 <- mitools::MIcombine(results = test, variances = test3)


test3 <- lapply(model_02_pool$analyses, function(mm) {
  smm <- summary(mm)
  diag(smm$vcov)
})

blah <- summary(model_02_pool$analyses[[1]])
blah2 <- blah$coefficients[, "Std. Error"]
diag(blah)

pool_glm_mi
