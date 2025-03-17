## ---- prepare-dataset

data_imputed_long <- do.call(rbind, data_imputed_output)

## ---- bayesian-model-01

model_brm_01 <- brm(SCON ~ group*time + stress + age_cat + sex + (1 | id), 
                    family = gaussian(link = "log"), 
                    data = data_imputed_long,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10))

saveRDS(model_brm_01, file = paste0("output/model_brm_01_", date.today, ".rds"))

sink(paste0("output/model_brm_01_", date.today, ".txt"))
print(summary(model_brm_01))
sink()

## ---- bayesian-model-02

model_brm_02 <- brm(WFI ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = data_imputed_long,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10))

saveRDS(model_brm_02, file = paste0("output/model_brm_02_", date.today, ".rds"))

sink(paste0("output/model_brm_02_", date.today, ".txt"))
print(summary(model_brm_02))
sink()
