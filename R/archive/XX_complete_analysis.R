

scon_model_comp <- brm(SCON ~ group*time + stress + age_cat + sex + (1 | id), 
                      family = gaussian(link = "log"), 
                      data = original_data,  
                      chains = 4, 
                      cores = 4,
                      iter = 4000, 
                      warmup = 500, 
                      backend = "cmdstanr", 
                      control = list(adapt_delta = 0.8, max_treedepth = 10), 
                      save_pars = save_pars(all = TRUE))

summary(scon_model_comp)

wfi_model_comp <- brm(WFI ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = original_data,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10), 
                    save_pars = save_pars(all = TRUE))

summary(wfi_model_comp)
