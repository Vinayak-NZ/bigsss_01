## ----step-wise-modelling

data_imputed_pooled_all$SCON_scaled <- scale(data_imputed_pooled_all$SCON)

# linear-model
model_linear <- glmer(WFI ~ Group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                     family = Gamma(link = "log"), 
                     data = data_imputed_pooled_all, 
                     control = glmerControl(optimizer = "bobyqa"))

# non-linear-model
model_non_linear <- glmer(WFI ~ Group*time*I(SCON_scaled^2) + Group*time*SCON_scaled + stress + age_cat + sex + (1 | id), 
                         family = Gamma(link = "log"), 
                         data = data_imputed_pooled_all, 
                         control = glmerControl(optimizer = "nloptwrap", calc.derivs = FALSE))

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
  facet_wrap(~ Group, labeller = labeller(Group = group_labels)) +
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
        plot.caption = element_text(color = "#454543", face = "italic"), 
        legend.position = "none") 
