## ---- outlier-test

# Compute IQR for WFI
Q1 <- quantile(data_imputed_pooled_all$WFI, 0.25, na.rm = TRUE)
Q3 <- quantile(data_imputed_pooled_all$WFI, 0.75, na.rm = TRUE)
IQR_value <- Q3 - Q1

# Define lower and upper outlier thresholds
lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

# Identify outliers
outliers <- data_imputed_pooled_all %>% 
  filter(WFI < lower_bound | WFI > upper_bound)

# View potential outliers
print(outliers)
