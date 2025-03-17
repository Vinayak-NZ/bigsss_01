## ---- post-impute-single

scon_baseline <- data_imputed_pooled[, c("id", "SCON_T1")]

data_imputed_pooled_all <- cbind(data_input[, exclude_vars], data_imputed_pooled)

data_imputed_pooled_all <- data_imputed_pooled_all[, c("id", 
                                                       "Group", 
                                                       "Age", 
                                                       "v_236", 
                                                       "v_534",
                                                       "SCON_T1", 
                                                       "SCON_T2_imp", 
                                                       "WFI_T1", 
                                                       "WFI_T2_imp")]

setDT(data_imputed_pooled_all)

data_imputed_pooled_all <- melt(data_imputed_pooled_all, 
                                id.vars = c("id", 
                                            "Group", 
                                            "Age", 
                                            "v_236", 
                                            "v_534"), 
                                measure.vars = list(c("SCON_T1", "SCON_T2_imp"), c("WFI_T1", "WFI_T2_imp")),
                                variable.name = "time", 
                                value.name = c("SCON", "WFI"))


data_imputed_pooled_all$group <- as.factor(data_imputed_pooled_all$Group)

data_imputed_pooled_all[, "time"] <- ifelse(data_imputed_pooled_all[, "time"] == 1, 
                                            "baseline", "follow-up")

data_imputed_pooled_all[["time"]] <- as.factor(data_imputed_pooled_all[["time"]])

data_imputed_pooled_all[["sex"]] <- as.factor(data_imputed_pooled_all[["v_236"]])

data_imputed_pooled_all[["stress"]] <- abs(as.numeric(data_imputed_pooled_all[["v_534"]]))

data_imputed_pooled_all[["WFI"]] <- abs(as.numeric(data_imputed_pooled_all[["WFI"]]))

data_imputed_pooled_all[["SCON"]] <- abs(as.numeric(data_imputed_pooled_all[["SCON"]]))

data_imputed_pooled_all[["age_cat"]] <- 
  ifelse(data_imputed_pooled_all[["Age"]] < 31, 1, 
         ifelse(data_imputed_pooled_all[["Age"]] >= 31 & 
                  data_imputed_pooled_all[["Age"]] < 41, 2, 
                ifelse(data_imputed_pooled_all[["Age"]] >= 41 & 
                         data_imputed_pooled_all[["Age"]] < 51, 3, 4)))

data_imputed_pooled_all[["age_cat"]] <- factor(data_imputed_pooled_all[["age_cat"]], 
                                           order = TRUE, 
                                           levels = c(1, 2, 3, 4))

data_imputed_pooled_all[["stress"]] <- factor(data_imputed_pooled_all[["v_534"]], 
                                               order = TRUE, 
                                               levels = c(1, 2, 3, 4, 5))

data_imputed_pooled_all <- as.data.frame(data_imputed_pooled_all)

data_imputed_pooled_all <- data_imputed_pooled_all[, c("id", 
                                                         "group", 
                                                         "sex", 
                                                         "age_cat", 
                                                         "time", 
                                                         "stress", 
                                                         "SCON", 
                                                         "WFI")]

data_imputed_pooled_all$SCON_scaled <- scale(data_imputed_pooled_all$SCON)

data_imputed_pooled_all$WFI_log <- log(data_imputed_pooled_all$WFI + 1)

data_imputed_pooled_all <- merge(data_imputed_pooled_all, scon_baseline, by = "id")

data_imputed_pooled_all[["SCON_T1"]] <- abs(as.numeric(data_imputed_pooled_all[["SCON_T1"]]))

data_imputed_pooled_all$SCON_T1_scaled <- scale(data_imputed_pooled_all$SCON_T1)
