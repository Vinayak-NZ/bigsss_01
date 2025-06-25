## ---- plot-model-estimates

# model-01
model_01_df <- 
  broom.mixed::tidy(model_brm_01, effects = "fixed", conf.int = TRUE)

model_01_df$term <- recode(model_01_df$term,
                          "(Intercept)" = "Intercept",
                          "group1" = "Intervention",
                          "timefollowMup" = "Time (Follow-up)",
                          "group1:timefollowMup" = "Intervention × Time",
                          "stress.L" = "Stress (Linear)",
                          "stress.Q" = "Stress (Quadratic)",
                          "stress.C" = "Stress (Cubic)",
                          "stressE4" = "Stress (4th order)",
                          "age_cat.L" = "Age (Linear)",
                          "age_cat.Q" = "Age (Quadratic)",
                          "age_cat.C" = "Age (Cubic)",
                          "sex2" = "Gender (Female)"
)

ggplot(model_01_df, aes(x = estimate, y = reorder(term, estimate))) +
  geom_point(color = "#205B87", size = 2) +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), 
                 height = 0.2, color = "#205B87") +
  labs(title = "Pooled Posterior Estimates",
       subtitle = "95% Credible Intervals (from multiply imputed model)",
       x = "Estimate",
       y = NULL) +
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


# model-02

model_02_df <- 
  broom.mixed::tidy(model_brm_02, effects = "fixed", conf.int = TRUE)

model_02_df$term <- recode(model_02_df$term,
                          "(Intercept)" = "Intercept",
                          "group1" = "Intervention",
                          "timefollowMup" = "Time (Follow-up)",
                          "group1:timefollowMup" = "Intervention × Time",
                          "SCON_scaled" = "Self-Control (Linear)",
                          "ISCON_scaledE2" = "Self-Control (Quadratic)",
                          "group1:SCON_scaled" = "Intervention × Self-Control",
                          "group1:ISCON_scaledE2" = "Intervention × Self-Control²",
                          "timefollowMup:SCON_scaled" = "Time × Self-Control",
                          "timefollowMup:ISCON_scaledE2" = "Time × Self-Control²",
                          "group1:timefollowMup:SCON_scaled" = "Intervention × Time × Self-Control",
                          "group1:timefollowMup:ISCON_scaledE2" = "Intervention × Time × Self-Control²",
                          "stress.L" = "Stress (Linear)",
                          "stress.Q" = "Stress (Quadratic)",
                          "stress.C" = "Stress (Cubic)",
                          "stressE4" = "Stress (4th Order)",
                          "age_cat.L" = "Age (Linear)",
                          "age_cat.Q" = "Age (Quadratic)",
                          "age_cat.C" = "Age (Cubic)",
                          "sex2" = "Gender (Female)"
)

ggplot(model_02_df, aes(x = estimate, y = reorder(term, estimate))) +
  geom_point(color = "#205B87", size = 2) +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), 
                 height = 0.2, color = "#205B87") +
  labs(title = "Pooled Posterior Estimates",
       subtitle = "95% Credible Intervals (from multiply imputed model)",
       x = "Estimate",
       y = NULL) +
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
