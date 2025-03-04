## ---- sand-pit

library(glmmTMB)

model_glmm <- glmmTMB(WFI ~ Group*time + SCON*time + stress + Age + sex + (1 | id), 
                      family = Gamma(link = "log"), 
                      data = data_imputed_pooled_all)

summary(model_glmm)

library(brms)

data_imputed_long <- do.call(rbind, data_imputed_output)

model_brm <- brm(WFI ~ Group*time + SCON*time + stress + Age + sex + (1 | id), 
                 family = Gamma(link = "log"), 
                 data = data_imputed_long,  # Use your dataset
                 chains = 2, 
                 iter = 1000, 
                 warmup = 500, 
                 control = list(adapt_delta = 0.8))
