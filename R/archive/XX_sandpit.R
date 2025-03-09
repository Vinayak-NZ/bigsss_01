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
