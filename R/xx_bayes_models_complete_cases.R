## ---- cc-bayesian-model-01

cc_model_brm_01 <- brm(SCON ~ group*time + stress + age_cat + sex + (1 | id), 
                    family = gaussian(link = "log"), 
                    data = original_data,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10))

saveRDS(cc_model_brm_01, file = paste0("output/cc_model_brm_01", date.today, ".rds"))

sink(paste0("output/cc_model_brm_01", date.today, ".txt"))
print(summary(cc_model_brm_01))
sink()

## ---- cc-bayesian-model-02

cc_model_brm_02 <- brm(WFI ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = original_data,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10))

saveRDS(cc_model_brm_02, file = paste0("output/cc_model_brm_02", date.today, ".rds"))

sink(paste0("output/cc_model_brm_02", date.today, ".txt"))
print(summary(cc_model_brm_02))
sink()
