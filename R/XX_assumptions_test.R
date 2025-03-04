## ---- model-01-assumptions

# linearity

plot(log(data_imputed_pooled_all$WFI), data_imputed_pooled_all$SCON)
plot(data_input$WFI_T1, data_input$Age)

# normality of residuals
plot(fitted(test_model_01), resid(test_model_01))
hist(resid(test_model_01), breaks = 20, main = "Histogram of residuals")

qqnorm(resid(test_model_01))
qqline(resid(test_model_01), col = "red")

# homoscedasticity
plot(fitted(test_model_01), abs(resid(test_model_01)))

# multicollinearity
vif(test_model_01)

# random-effects
ranef_model <- ranef(test_model_01)
qqnorm(ranef_model$id[, "(Intercept)"])
qqline(ranef_model$id[, "(Intercept)"], col = "red")