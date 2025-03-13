

install.packages("emmeans")

library(emmeans)

# Compute slopes of SCON within each Group and Time
em_results <- emtrends(model_brm_02, ~ group * time, var = "SCON")

# Print results
print(em_results)

pairs(em_results)

# Compute slopes of SCON within each Group and Time
em_results <- emtrends(model_brm_02, ~ group, var = "SCON")

# Print results
print(em_results)

pairs(em_results)

library(ggeffects)

# Generate predicted values for SCON across Group and Time
plot_data <- ggpredict(model_brm_02, terms = c("SCON [all]", "group", "time"))

ggplot(plot_data, aes(x = x, y = predicted, color = facet)) +
  geom_line(size = 1.2) +
  geom_ribbon(aes(ymin = conf.low, ymax = conf.high, fill = facet), alpha = 0.2) +
  facet_wrap(~ group) +  # Separate plots for each group
  theme_minimal() +
  labs(
    title = "Effect of SCON on WFI_log in Control vs. Intervention Groups",
    x = "Self-Control (SCON)",
    y = "Predicted WFI_log",
    color = "Time Period",
    fill = "Time Period"
  ) +
  scale_color_manual(values = c("#1b9e77", "#7570b3"))  # Custom colors

plot(conditional_effects(model_brm_02, conditions = "SCON:group:time"), points = TRUE)

