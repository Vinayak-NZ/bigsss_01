## ---- specify-models

model_01 <- SCON ~ Group*time + stress + age_cat + sex + (1 | id)
  
model_02 <- WFI ~ Group*time*I(SCON^2) + Group*time*SCON + stress + age_cat + sex + (1 | id)

## ---- run-models

mice_models_01 <- list()

mice_models_02 <- list()

mice_models_summary_01 <- list()

mice_models_summary_02 <- list()

M <- length(data_imputed_output)

for (mm in 1:M){
  
  mice_models_01[[mm]] <- lme4::lmer(model_01, data = data_imputed_output[[mm]], REML=FALSE)
  
  mice_models_summary_01[[mm]] <- summary(mice_models_01[[mm]])$coefficients[2]
  
  mice_models_02[[mm]] <- lme4::lmer(model_02, data = data_imputed_output[[mm]], REML=FALSE)
  
  mice_models_summary_02[[mm]] <- summary(mice_models_02[[mm]])$coefficients[2]
  
}

## ---- pool-models

mice_pooled_model_01 <- lmer_pool(mice_models_01, level = .95)

mice_pooled_model_02 <- lmer_pool(mice_models_02, level = .95)

mice_pooled_output_model_01 <- summary(mice_pooled_model_01)

mice_pooled_output_model_02 <- summary(mice_pooled_model_02)

mice_treatment_effect_model_01 <- unlist(mice_models_summary_01, use.names=FALSE)

mice_treatment_effect_model_02 <- unlist(mice_models_summary_02, use.names=FALSE)

## ---- single-data-models-01

sd_model_01 <- lme4::lmer(SCON ~ Group*time + stress + Age + sex + (1 | id), 
                            data = data_imputed_pooled_all, 
                            REML=FALSE)

## ---- single-data-models-02

sd_model_02 <- lme4::lmer(WFI ~ Group*time*I(SCON^2) + Group*time*SCON + stress + age_cat + sex + (1 | id), 
                            data = data_imputed_pooled_all, 
                            REML=FALSE)