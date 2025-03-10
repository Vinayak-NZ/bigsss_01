## ---- prepare-dataset

data_imputed_long <- do.call(rbind, data_imputed_output)

## ---- bayesian-model-01

model_brm_01 <- brm(WFI ~ Group*time + SCON*time + stress + Age + sex + (1 | id), 
                 family = Gamma(link = "log"), 
                 data = data_imputed_long,  
                 chains = 2, 
                 iter = 1000, 
                 warmup = 500)

## ---- bayesian-model-02

model_brm_02 <- brm(SCON ~ Group*time + stress + Age + sex + (1 | id), 
                 family = Gamma(link = "log"), 
                 data = data_imputed_long,  
                 chains = 2, 
                 iter = 1000, 
                 warmup = 500)