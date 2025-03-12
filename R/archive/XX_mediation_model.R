## ----mediation-model

# self-control-model
model_a <- lmer(SCON ~ Group*time + stress + age_cat + sex + (1 | id), 
                data = data_imputed_pooled_all)

# work-family-interference-model
model_b <- lmer(WFI ~ Group*time*I(SCON^2) + Group*time*SCON + stress + age_cat + sex + (1 | id), 
                data = data_imputed_pooled_all)

# mediation-model
med_model <- mediate(model_a, model_b, treat = "Group", mediator = "SCON", 
                     boot = FALSE, sims = 5000)

summary(model_a)

summary(model_b)

summary(med_model)
