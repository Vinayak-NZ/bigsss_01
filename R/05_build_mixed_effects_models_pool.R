## ---- mixed-effects-pool

# model-02

model_01_pool <- with(mids_object, 
                      glmer(SCON ~ group*time + stress + age_cat + sex + (1 | id), 
                            family = gaussian(link = "log"),
                            control = glmerControl(optimizer = "nloptwrap", 
                                                   calc.derivs = FALSE)))

model_01_summary <- summary(pool(model_01_pool))

sink("output/mixed_effects_model_01_summary.txt")
print(model_01_summary)
sink()

# model-02

model_02_pool <- with(mids_object, 
                 glmer(WFI ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + 
                         stress + age_cat + sex + (1 | id), 
                       family = Gamma(link = "log"), 
                 control = glmerControl(optimizer = "nloptwrap", 
                                        calc.derivs = FALSE)))

model_02_summary <- summary(pool(model_02_pool))

sink("output/mixed_effects_model_02_summary.txt")
print(model_02_summary)
sink()
