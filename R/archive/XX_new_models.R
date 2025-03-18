
data_sub <- data_input_merged[, c("id", "v_354", "HiEdu_DE", "v_531", "v_286", "v_287")]

data_sub$v_354 <- factor(data_sub$v_354, 
                         ordered = TRUE, 
                         levels = c(1, 2, 3, 4, 5, 6))

data_new <- merge(data_imputed_pooled_all, data_sub, by = "id")

wfi_model_new <- brm(WFI ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + v_354 + HiEdu_DE + v_531 + v_286 + v_287 + (1 | id), 
                    family = Gamma(link = "log"), 
                    data = data_new,  
                    chains = 4, 
                    cores = 4,
                    iter = 4000, 
                    warmup = 500, 
                    backend = "cmdstanr", 
                    control = list(adapt_delta = 0.8, max_treedepth = 10),
                    save_pars = save_pars(all = TRUE))

summary(wfi_model_new)

data_new$v_286_cat <- factor(ifelse(data_new$v_286 %in% c(1, 2), "Low", 
                                   ifelse(data_new$v_286 == 3, "Moderate", "High")), 
                         ordered = TRUE, levels = c("Low", "Moderate", "High"))

wfi_model_new_02 <- brm(WFI ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + v_286_cat + (1 | id), 
                     family = Gamma(link = "log"), 
                     data = data_new,  
                     chains = 4, 
                     cores = 4,
                     iter = 4000, 
                     warmup = 500, 
                     backend = "cmdstanr", 
                     control = list(adapt_delta = 0.8, max_treedepth = 10),
                     save_pars = save_pars(all = TRUE))

summary(wfi_model_new_02)
