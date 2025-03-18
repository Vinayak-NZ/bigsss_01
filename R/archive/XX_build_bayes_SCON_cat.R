
data_imputed_pooled_all$SCON_cat <- factor(ifelse(data_imputed_pooled_all$SCON %in% c(1, 2, 3, 4), 
                                           "Low", 
                                           ifelse(data_imputed_pooled_all$SCON %in% c(5, 6, 7, 8), 
                                                  "Moderate", "High")), 
                                           order = TRUE, 
                                           levels = c("Low", "Moderate", "High"))

wfi_model_cat <- brm(WFI ~ group*time*SCON_cat + stress + age_cat + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = data_imputed_pooled_all,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10), 
                    save_pars = save_pars(all = TRUE))

summary(wfi_model_cat)
