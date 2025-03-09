## ---- model-01-assumptions

# linearity

plot(log(data_imputed_pooled_all$WFI), data_imputed_pooled_all$SCON)
plot(data_input$WFI_T1, data_input$Age)

# normality of residuals
plot(fitted(sd_model_01), resid(sd_model_01))
hist(resid(sd_model_01), breaks = 20, main = "Histogram of residuals")

qqnorm(resid(sd_model_01))
qqline(resid(sd_model_01), col = "red")

# homoscedasticity
plot(fitted(sd_model_01), abs(resid(sd_model_01)))

# multicollinearity
vif(sd_model_01)

# random-effects
ranef_model <- ranef(sd_model_01)
qqnorm(ranef_model$id[, "(Intercept)"])
qqline(ranef_model$id[, "(Intercept)"], col = "red")

## ---- model-02-assumptions

# linearity
plot(data_input$SCON_T1, data_input$Age)

# normality of residuals
plot(fitted(sd_model_02), resid(sd_model_02))
hist(resid(sd_model_02), breaks = 20, main = "Histogram of residuals")

qqnorm(resid(sd_model_02))
qqline(resid(sd_model_02), col = "red")

# homoscedasticity
plot(fitted(sd_model_02), abs(resid(sd_model_02)))

# multicollinearity
vif(sd_model_02)

# random-effects
ranef_model <- ranef(sd_model_02)
qqnorm(ranef_model$id[, "(Intercept)"])
qqline(ranef_model$id[, "(Intercept)"], col = "red")