## ---- bayes-post-hoc

# model-02-WFI
em_results <- 
  emtrends(model_brm_02, ~ group * time, var = "SCON_scaled")

print(em_results)

pairs(em_results)