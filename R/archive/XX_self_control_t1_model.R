data_imputed_pooled_test <- cbind(data_input[, exclude_vars], data_imputed_pooled)

data_imputed_pooled_test <- data_imputed_pooled_test[, c("id", 
                                                       "Group", 
                                                       "Age", 
                                                       "v_236", 
                                                       "v_534",
                                                       "SCON_T1", 
                                                       "WFI_T1", 
                                                       "WFI_T2_imp")]

setDT(data_imputed_pooled_test)

data_imputed_pooled_test <- melt(data_imputed_pooled_test, 
                                id.vars = c("id", 
                                            "Group", 
                                            "Age", 
                                            "v_236", 
                                            "v_534", 
                                            "SCON_T1"), 
                                measure.vars = c("WFI_T1", "WFI_T2_imp"), 
                                variable.name = "time", 
                                value.name = "WFI")

data_imputed_pooled_test[, "time"] <- ifelse(data_imputed_pooled_test[, "time"] == "WFI_T1", 
                                            "baseline", "follow-up")

data_imputed_pooled_test[["group"]] <- as.factor(data_imputed_pooled_test[["Group"]])

data_imputed_pooled_test[["time"]] <- as.factor(data_imputed_pooled_test[["time"]])

data_imputed_pooled_test[["sex"]] <- as.factor(data_imputed_pooled_test[["v_236"]])

data_imputed_pooled_test[["stress"]] <- abs(as.numeric(data_imputed_pooled_test[["v_534"]]))

data_imputed_pooled_test[["WFI"]] <- abs(as.numeric(data_imputed_pooled_test[["WFI"]]))

data_imputed_pooled_test[["age_cat"]] <- 
  ifelse(data_imputed_pooled_test[["Age"]] < 31, 1, 
         ifelse(data_imputed_pooled_test[["Age"]] >= 31 & 
                  data_imputed_pooled_test[["Age"]] < 41, 2, 
                ifelse(data_imputed_pooled_test[["Age"]] >= 41 & 
                         data_imputed_pooled_test[["Age"]] < 51, 3, 4)))

data_imputed_pooled_test[["age_cat"]] <- factor(data_imputed_pooled_test[["age_cat"]], 
                                               order = TRUE, 
                                               levels = c(1, 2, 3, 4))

data_imputed_pooled_test[["stress"]] <- factor(data_imputed_pooled_test[["v_534"]], 
                                              order = TRUE, 
                                              levels = c(1, 2, 3, 4, 5))

data_imputed_pooled_test <- as.data.frame(data_imputed_pooled_test)

data_imputed_pooled_test <- data_imputed_pooled_test[, c("id", 
                                                         "group", 
                                                         "sex", 
                                                         "age_cat", 
                                                         "time", 
                                                         "stress", 
                                                         "SCON_T1", 
                                                         "WFI")]

test_model_02 <- lme4::glmer(WFI ~ group*time + I(SCON_T1^2) + stress + age_cat + sex + (1 | id), 
                           data = data_imputed_pooled_test, 
                           family = Gamma(link = "log"), 
                           control = glmerControl(optimizer = "nloptwrap", calc.derivs = FALSE))

summary(test_model_02)
