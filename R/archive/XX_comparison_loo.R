
loo_model_01 <- loo(wfi_model_01, moment_match = TRUE, k_threshold = 1)
loo_model_02 <- loo(wfi_model_02, moment_match = TRUE, k_threshold = 1)
loo_model_03 <- loo(wfi_model_03, moment_match = TRUE, k_threshold = 1)
loo_compare(loo_model_01, loo_model_02, loo_model_03)
