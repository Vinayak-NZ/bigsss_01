## ----step-wise-modelling

# linear-model
model_linear <- lmer(WFI_log ~ group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                     data = data_imputed_pooled_all)

# non-linear-model
model_non_linear <- lmer(WFI_log ~ group*time*I(SCON_scaled^2) + group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                         data = data_imputed_pooled_all)

# Compare models using ANOVA
anova(model_linear, model_non_linear)

# summary of non-linear-model
summary(model_non_linear)

## ----explore-non-linear-relationship

group_labels <- c("Control", "Intervention")
names(group_labels) <- c(0, 1)

colour_vals <- c("#FFA500", "#00008B")

ggplot(data_imputed_pooled_all, aes(x = SCON, y = WFI, color = factor(time))) +
  geom_point(alpha = 0.3, size = 4) +
  scale_color_manual(values = colour_vals) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = TRUE, size = 3) +
  facet_wrap(~ group, labeller = labeller(group = group_labels)) +
  labs(
    title = "Non-Linear Relationship Between Self-Control and WFI",
    x = "Self-Control (SCON)",
    y = "Work-Family Interference (WFI)",
    color = "Time"
  ) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        plot.title = element_text(color = "#2F2E41", size = 12, face = "bold"),
        plot.subtitle = element_text(color = "#454543"),
        plot.caption = element_text(color = "#454543", face = "italic")) 
