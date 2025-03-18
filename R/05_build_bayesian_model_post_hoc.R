## ---- bayes-post-hoc

# extract controls
most_common_stress <- 
  names(sort(table(data_imputed_long$stress), decreasing = TRUE))[1]

most_common_age <- 
  names(sort(table(data_imputed_long$age_cat), decreasing = TRUE))[1]

most_common_sex <- 
  names(sort(table(data_imputed_long$sex), decreasing = TRUE))[1]

# model-02-WFI-linear-trends
em_results <- 
  emtrends(model_brm_02, ~ group * time, var = "SCON_scaled", 
         at = list(
           SCON_scaled = seq(min(data_imputed_long$SCON_scaled), 
                             max(data_imputed_long$SCON_scaled), length.out = 3),  
           stress = most_common_stress,  
           age_cat = most_common_age,  
           sex = most_common_sex  
         ))

print(em_results)

pairs(em_results)

# quadratic-trends
em_quad_slopes <- 
  emtrends(model_brm_02, ~ group * time, 
           var = "I(SCON_scaled^2)",
           at = list(
             SCON_scaled = seq(min(data_imputed_long$SCON_scaled), 
                               max(data_imputed_long$SCON_scaled), length.out = 3),  
             stress = most_common_stress,  
             age_cat = most_common_age,  
             sex = most_common_sex  
           ))

# Display results
print(em_quad_slopes)

pairs(em_quad_slopes)
