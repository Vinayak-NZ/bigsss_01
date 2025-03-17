## ---- build-bayes-WFI-model

# build-baseline-scon

wfi_model_01 <- brm(WFI ~ group*time + I(SCON_T1_scaled^2) + SCON_T1_scaled + stress + age_cat + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = data_imputed_pooled_all,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10),
                    save_pars = save_pars(all = TRUE))

# build-interaction-baseline-scon

wfi_model_02 <- brm(WFI ~ group*time*I(SCON_T1_scaled^2) + group*time*SCON_T1_scaled + stress + age_cat + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = data_imputed_pooled_all,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10), 
                    save_pars = save_pars(all = TRUE))

# compare-model-baseline-main-baseline-interaction

waic_wfi_model_01 <- waic(wfi_model_01)
waic_wfi_model_02 <- waic(wfi_model_02)

loo_compare(waic_wfi_model_02, waic_wfi_model_01)

# build-time-all-interaction-scon

wfi_model_03 <- brm(WFI ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = data_imputed_pooled_all,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10), 
                    save_pars = save_pars(all = TRUE))

# compare-model-baseline-interaction-time-all-interaction

waic_wfi_model_02 <- waic(wfi_model_02)
waic_wfi_model_03 <- waic(wfi_model_03)

loo_compare(waic_wfi_model_03, waic_wfi_model_02)
