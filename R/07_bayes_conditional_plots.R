## ---- conditional-effects-plots

# ---- WFI

# create data frame of predictions (control for age, sex, stress)
most_common_stress <- 
  names(sort(table(data_imputed_pooled_all$stress), decreasing = TRUE))[1]

most_common_age <- 
  names(sort(table(data_imputed_pooled_all$age_cat), decreasing = TRUE))[1]

most_common_sex <- 
  names(sort(table(data_imputed_pooled_all$sex), decreasing = TRUE))[1]

scale_SCON <- seq(min(data_imputed_pooled_all$SCON_scaled), 
                  max(data_imputed_pooled_all$SCON_scaled), length.out = 3)

predictor_grid <- expand.grid(
  group = c(0, 1),  
  time = c('baseline', 'follow-up'),
  SCON_scaled = seq(min(data_imputed_pooled_all$SCON_scaled), 
                    max(data_imputed_pooled_all$SCON_scaled), length.out = 3),
  stress = most_common_stress,
  age_cat = most_common_age,
  sex = most_common_sex
)

posterior_predictions <- 
  posterior_epred(model_brm_02, 
                  newdata = predictor_grid, 
                  re_formula = NA)

emmeans_summary <- predictor_grid %>%
  mutate(predicted_mean = colMeans(posterior_predictions),
         lower_CI = apply(posterior_predictions, 2, quantile, probs = 0.025),
         upper_CI = apply(posterior_predictions, 2, quantile, probs = 0.975))

emmeans_summary$SCON_group <- 
  as.factor(ifelse(emmeans_summary$SCON_scaled == scale_SCON[1], "Low", 
                   ifelse(emmeans_summary$SCON_scaled == scale_SCON[2], 
                          "Moderate", "High")))

emmeans_summary$SCON_group <- 
  factor(emmeans_summary$SCON_group, 
         levels = c("Low", "Moderate", "High"))

emmeans_summary$group <- 
  as.factor(ifelse(emmeans_summary$group == 0, "Control", "Intervention"))

emmeans_summary <- 
  emmeans_summary[, c("group", "time", "SCON_group", "predicted_mean", 
                      "lower_CI", "upper_CI")]

# plot conditional effects
ggplot(emmeans_summary, aes(x = time, y = predicted_mean, color = factor(group))) +
  geom_point(position = position_dodge(0.5), size = 3) +  
  geom_errorbar(aes(ymin = lower_CI, ymax = upper_CI), 
                width = 0.2, position = position_dodge(0.5)) +
  facet_wrap(~ SCON_group) +  
  labs(title = "Predicted WFI by Self-Control, Group, and Time", 
       x = "Time", 
       y = "Predicted Work-Family Interference (WFI)", 
       color = "Group") + 
  scale_color_manual(values = c("red", "blue"), labels = c("Control", "Intervention")) +  
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.background = element_blank(), 
    axis.line = element_line(colour = "black"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 14),
    legend.text = element_text(size = 14),
    legend.title = element_text(size = 14),
    plot.title = element_text(color = "#2F2E41", size = 12, face = "bold"),
    plot.subtitle = element_text(color = "#454543"),
    plot.caption = element_text(color = "#454543", face = "italic")
  )




