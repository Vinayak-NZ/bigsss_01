## ---- prepare-dataset

data_imputed_long <- do.call(rbind, data_imputed_output)

## ---- bayesian-model-01

model_brm_01 <- brm(WFI ~ Group*time + SCON*time + stress + Age + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = data_imputed_long,  
                    chains = 2, 
                    iter = 1000, 
                    warmup = 500, 
                    control = list(adapt_delta = 0.8))

saveRDS(model_brm_01, file = "output/model_brm_01.rds")

model_brm_01_adj <- brm(WFI ~ Group*time + SCON + stress + age_cat + sex + (1 | id), 
                        family = Gamma(link = "log"), 
                        data = data_imputed_long,  
                        chains = 2, 
                        iter = 1000, 
                        warmup = 500, 
                        control = list(adapt_delta = 0.8))

saveRDS(model_brm_01_adj, file = "output/model_brm_01_adj.rds")

## ---- bayesian-model-02

model_brm_02 <- brm(SCON ~ Group*time + stress + Age + sex + (1 | id), 
                    family = gaussian(link = "log"), 
                    data = data_imputed_long,  
                    chains = 2, 
                    iter = 1000, 
                    warmup = 500, 
                    control = list(adapt_delta = 0.8))

saveRDS(model_brm_02, file = "output/model_brm_02.rds")