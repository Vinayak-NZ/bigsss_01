## ---- check-relationship-nature

# WFI-vs-SCON

ggplot(data_imputed_pooled_all, aes(x = SCON, y = WFI)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "loess", color = "blue", se = TRUE) +
  geom_smooth(method = "lm", color = "red", linetype = "dashed") +
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

# by-group

group_labels <- c("Control", "Intervention")
names(group_labels) <- c(0, 1)

colour_vals <- c("#FFA500", "#00008B")

ggplot(data_imputed_pooled_all, aes(x = SCON, y = WFI, color = factor(time))) +
  geom_point(alpha = 0.3, size = 4) +
  scale_color_manual(values = colour_vals, labels = c("Baeline", "Follow-up")) +
  geom_smooth(method = "loess", se = TRUE, size = 3) +
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

# by-group-SCON

group_labels <- c("Control", "Intervention")
names(group_labels) <- c(0, 1)

time_labels <- c("Baseline", "Follow-up")
names(time_labels) <- c("baseline", "follow-up")

colour_vals <- c("#FFA500", "#00008B")

ggplot(data_imputed_pooled_all, aes(x = SCON, y = WFI)) +
  geom_point(alpha = 0.3, size = 4) +
  geom_smooth(method = "loess", color = "blue", se = TRUE) +
  scale_color_manual(values = colour_vals) +
  facet_grid(group ~ time, labeller = labeller(group = group_labels, time = time_labels)) +
  labs(
    title = "Relationship Between Self-Control and WFI",
    x = "Time",
    y = "Work-Family Interference (WFI)",
    color = "Group"
  ) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        plot.title = element_text(color = "#2F2E41", size = 12, face = "bold"),
        plot.subtitle = element_text(color = "#454543"),
        plot.caption = element_text(color = "#454543", face = "italic")) 
