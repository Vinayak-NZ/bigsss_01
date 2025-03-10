## ---- check-relationship-nature

ggplot(data_imputed_pooled_all, aes(x = SCON, y = WFI)) +
  geom_point(alpha = 0.4) +  # Scatterplot
  geom_smooth(method = "loess", color = "blue", se = TRUE) +  # LOESS smoother
  geom_smooth(method = "lm", color = "red", linetype = "dashed") +  # Linear model
  labs(title = "WFI vs. SCON: Checking Linearity", 
       x = "Self-Control (SCON)", 
       y = "Work-Family Interference (WFI)") + 
  ylab("Work family interference") + 
  xlab("Self-control") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        plot.title = element_text(color = "#2F2E41", size = 12, face = "bold"),
        plot.subtitle = element_text(color = "#454543"),
        plot.caption = element_text(color = "#454543", face = "italic"), 
        legend.position = "none") 