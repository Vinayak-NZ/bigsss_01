## ---- build-gam-model-01

model_gam_01 <- gam(WFI ~ Group*time + 
                   s(SCON, by = time) + 
                   stress + 
                   Age + 
                   sex + 
                   s(id, bs = "re"), 
                 data = data_imputed_pooled_all, 
                 method = "REML")

summary(model_gam_01)

## ---- build-gam-model-02

model_gam_02 <- gam(SCON ~ Group*time + 
                      stress + 
                      Age + 
                      sex + 
                      s(id, bs = "re"), 
                    data = data_imputed_pooled_all, 
                    method = "REML")

summary(model_gam_02)