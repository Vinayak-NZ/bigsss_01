## ---- output-Bayesian-model-stats

# ---- model-01

# model-estimates
brm_model_01_output <- 
  posterior_summary(model_brm_01, 
                    probs = c(0.025, 0.975), 
                    robust = TRUE, 
                    variable = c("b_Intercept", 
                                 "b_group1", 
                                 "b_timefollowMup", 
                                 "b_stress.L", 
                                 "b_stress.Q", 
                                 "b_stress.C", 
                                 "b_stressE4", 
                                 "b_age_cat.L", 
                                 "b_age_cat.Q", 
                                 "b_age_cat.C", 
                                 "b_sex2", 
                                 "b_group1:timefollowMup", 
                                 "sd_id__Intercept", 
                                 "sigma"))

brm_model_01_output

# statistical-significance-estimates
model_brm_01_pd_values <- p_direction(model_brm_01)

print(model_brm_01_pd_values)

# practical-significance-estimates
brm_01_rope_values <- p_rope(model_brm_01)

print(brm_01_rope_values)

# explanatory-power
bayes_R2(model_brm_01, summary = TRUE, ndraws = 1000)

# general-summary
summary(model_brm_01)

# ---- model-02

# model-estimates
brm_model_02_output <- 
  posterior_summary(model_brm_02, 
                    probs = c(0.025, 0.975), 
                    robust = TRUE, 
                    variable = c("b_Intercept", 
                                 "b_group1", 
                                 "b_timefollowMup", 
                                 "b_ISCON_scaledE2", 
                                 "b_SCON_scaled",
                                 "b_stress.L", 
                                 "b_stress.Q", 
                                 "b_stress.C", 
                                 "b_stressE4", 
                                 "b_age_cat.L", 
                                 "b_age_cat.Q", 
                                 "b_age_cat.C", 
                                 "b_sex2", 
                                 "b_group1:timefollowMup", 
                                 "b_group1:ISCON_scaledE2", 
                                 "b_timefollowMup:ISCON_scaledE2", 
                                 "b_group1:SCON_scaled", 
                                 "b_timefollowMup:SCON_scaled", 
                                 "b_group1:timefollowMup:ISCON_scaledE2", 
                                 "b_group1:timefollowMup:SCON_scaled",
                                 "sd_id__Intercept", 
                                 "shape"))

brm_model_02_output

# statistical-significance-estimates
model_02_pd_values <- p_direction(model_brm_02)

print(model_02_pd_values)

# practical-significance-estimates
model_02_rope_values <- p_rope(model_brm_02)

print(model_02_rope_values)

# explanatory-power
bayes_R2(model_brm_02, summary = TRUE, ndraws = 1000)

# general-summary
summary(model_brm_02)
