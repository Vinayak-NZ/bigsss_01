## ---- prepare-dataset

data_imputed_long <- do.call(rbind, data_imputed_output)

## ---- bayesian-model-01

model_brm_01 <- brm(SCON ~ group*time + stress + age_cat + sex + (1 | id), 
                    data = data_imputed_long,  
                    chains = 2, 
                    cores = 4,
                    iter = 1000, 
                    warmup = 500, 
                    backend = "rstan", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10))

saveRDS(model_brm_01, file = "output/model_brm_01_2025_03_13.rds")

## ---- bayesian-model-02

model_brm_02 <- brm(WFI_log ~ group*time*I(SCON^2) + group*time*SCON + stress + age_cat + sex + (1 | id), 
                    data = data_imputed_long,  
                    chains = 2, 
                    cores = 4,
                    iter = 1000, 
                    warmup = 500, 
                    backend = "rstan", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10))

saveRDS(model_brm_02, file = "output/model_brm_02_2025_03_13.rds")


