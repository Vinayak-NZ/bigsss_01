

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

data_imputed_pooled_all[, "time"] <- ifelse(data_imputed_pooled_all[, "time"] == 1, 
                                             "baseline", "follow-up")

data_imputed_pooled_all$time <- as.factor(data_imputed_pooled_all$time)

data_imputed_pooled_all$sex <- as.factor(data_imputed_output[[i]]$v_236)

data_imputed_pooled_all[["stress"]] <- abs(as.numeric(data_imputed_pooled_all[["v_534"]]))

data_imputed_pooled_all[["SCON"]] <- abs(as.numeric(data_imputed_pooled_all[["SCON"]]))

data_imputed_pooled_all[["WFI"]] <- abs(as.numeric(data_imputed_pooled_all[["WFI"]]))

data_imputed_pooled_all <- as.data.frame(data_imputed_pooled_all)

data_imputed_pooled_all$SCON_Cat <- cut(data_imputed_pooled_all$SCON, 
                       breaks = c(1, 4, 7, 11), 
                       labels = c("Low", "Medium", "High"),
                       include.lowest = TRUE)

test_model_01 <- lme4::lmer(WFI ~ Group*time*SCON + stress + Age + sex + (1 | id), 
                            data = data_imputed_pooled_all, 
                            REML=FALSE)

test_model_01_cat <- lme4::lmer(WFI ~ Group*time*SCON_Cat + stress + Age + sex + (1 | id), 
                            data = data_imputed_pooled_all, 
                            REML=FALSE)

test_model_02 <- lme4::lmer(SCON ~ Group*time + stress + Age + sex + (1 | id), 
                            data = data_imputed_pooled_all, 
                            REML=FALSE)

