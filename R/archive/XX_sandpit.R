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

library(mgcv)

model_gam <- gam(WFI ~ Group*time + s(SCON, by = time) + stress + Age + sex + s(id, bs = "re"), 
                 data = data_imputed_pooled_all, method = "REML")

summary(model_gam)

ggplot(data_imputed_pooled_all, aes(x = SCON, y = WFI)) +
  geom_point(alpha = 0.4) + 
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "red") + 
  theme_minimal() +
  labs(title = "Quadratic Relationship Between Self-Control and WFI", 
       x = "Self-Control (SCON)", 
       y = "Work-Family Interference (WFI)")

model_brm_quad_interaction <- brm(WFI ~ Group * time + SCON + I(SCON^2) + 
                                    time:SCON + time:I(SCON^2) + 
                                    stress + Age + sex + (1 | id), 
                                  family = Gamma(link = "log"), 
                                  data = data_imputed_long, 
                                  chains = 4, 
                                  iter = 4000)

model_brm_quad_test <- brm(WFI ~ I(SCON^2), 
                                  family = Gamma(link = "log"), 
                                  data = data_imputed_long, 
                                  chains = 2, 
                                  iter = 1000)

summary(model_brm_quad_test)

library(mediation)

# Path a: Does the intervention increase self-control?
model_a <- lmer(SCON ~ Group*time + (1 | id), data = data_imputed_pooled_all)

# Path b: Does self-control affect WtFI?
model_b <- lmer(WFI ~ SCON*time + Group*time + (1 | id), data = data_imputed_pooled_all)

# Multilevel mediation model
med_model <- mediate(model_a, model_b, treat = "Group", mediator = "SCON",
                     boot = FALSE, sims = 5000)

# Summary of mediation results
summary(med_model)

cor(data_imputed_pooled_all$WFI, data_imputed_pooled_all$SCON)

library(lavaan)

model_multigroup <- '
  # Structural paths
  WFI_T2_imp ~ WFI_T1 + SCON_T1 + v_534 + SCON_T2_imp
  
  # Covariances among predictors
  SCON_T1 ~~ v_534
  SCON_T1 ~~ WFI_T1
  v_534 ~~ WFI_T1
  
  # Explicit variances (helps with estimation issues)
  WFI_T1 ~~ WFI_T1
  SCON_T1 ~~ SCON_T1
  v_534 ~~ v_534
  SCON_T2_imp ~~ SCON_T2_imp
'

data_imputed_pooled$v_534 <- factor(data_imputed_pooled$v_534, 
                                       order = TRUE, 
                                       levels = c(1, 2, 3, 4, 5))

# Fit model with group comparison
fit_multi <- sem(model_multigroup, 
                 data = data_imputed_pooled, 
                 group = "Group", 
                 estimator = "WLSMV")

fit <- sem(model_multigroup, data = data_imputed_pooled, representation = "RAM")


# Show group comparison results
summary(fit_multi, fit.measures = TRUE, standardized = TRUE, ci = TRUE)


library(lavaan)

# Define the model explicitly
model_multigroup <- 

# Run model in lavaan with robust estimation
fit <- sem(model_multigroup, data = mydata, estimator = "MLM", fixed.x = TRUE)

# Show summary with standardized estimates and confidence intervals
summary(fit, fit.measures = TRUE, standardized = TRUE, ci = TRUE)

model_poly_interaction <- lmer(WFI ~ SCON + I(SCON^2) + 
                                 Group * time * SCON + 
                                 Group * time * I(SCON^2) + 
                                 stress + Age + sex + (1 | id), 
                               data = data_imputed_pooled_all)

library(lmerTest)
summary(model_poly_interaction)

anova(test_model_01, model_poly_interaction)




model_stress <- lmer(WFI ~ Group*time*stress + age_cat + sex + (1 | id), 
                     data = data_imputed_pooled_all)

summary(model_stress)


data_imputed_pooled_all$WFI_log <- log(data_imputed_pooled_all$WFI + 1)

model_trans <- lmer(WFI_log ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                               data = data_imputed_pooled_all)

summary(model_trans)


data_imputed_pooled_all$SCON_group <- 
  ifelse(data_imputed_pooled_all$SCON %in% c(1,2,3,4), "Low", 
         ifelse(data_imputed_pooled_all$SCON %in% c(5,6,7,8), "Medium", 
                "High"))




