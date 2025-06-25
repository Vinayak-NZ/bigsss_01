# Most common values for control variables
most_common_stress <- 
  names(sort(table(data_imputed_pooled_all$stress), decreasing = TRUE))[1]

most_common_age <- 
  names(sort(table(data_imputed_pooled_all$age_cat), decreasing = TRUE))[1]

most_common_sex <- 
  names(sort(table(data_imputed_pooled_all$sex), decreasing = TRUE))[1]

# Predictor grid
predictor_grid_01 <- expand.grid(
  group = c(0, 1),  
  time = c('baseline', 'follow-up'),
  stress = most_common_stress,
  age_cat = most_common_age,
  sex = most_common_sex
)

# Posterior predictions
posterior_predictions_01 <- 
  posterior_epred(model_brm_01, 
                  newdata = predictor_grid_01, 
                  re_formula = NA)

emmeans_summary_01 <- predictor_grid_01 %>%
  mutate(predicted_mean = colMeans(posterior_predictions_01),
         lower_CI = apply(posterior_predictions_01, 2, quantile, probs = 0.025),
         upper_CI = apply(posterior_predictions_01, 2, quantile, probs = 0.975))

emmeans_summary_01$group <- 
  factor(ifelse(emmeans_summary_01$group == 0, "Control", "Intervention"))

# Plot
ggplot(emmeans_summary_01, aes(x = time, y = predicted_mean, color = group)) +
  geom_point(position = position_dodge(0.5), size = 3) +  
  geom_errorbar(aes(ymin = lower_CI, ymax = upper_CI), 
                width = 0.2, position = position_dodge(0.5)) +
  labs(title = "Predicted Self-Control by Group and Time", 
       x = "Time", 
       y = "Predicted Self-Control", 
       color = "Group") + 
  scale_color_manual(values = c("red", "blue")) +  
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
