## ---- bayes-post-hoc

# model-02-WFI
em_results <- 
  emtrends(model_brm_02, ~ group * time, var = "SCON_scaled")

print(em_results)

pairs(em_results)

library(tidyverse)
library(modelr)

# Generate estimated marginal means (predicted WFI)
# Extract unique imputation identifiers from MICE dataset
imputation_ids <- unique(data_imputed_long$.imp)  # MICE stores imputations in `.imp`

# Create a smaller prediction grid for each imputation
pred_grid <- expand_grid(
  SCON_scaled = seq(min(data_imputed_long$SCON_scaled, na.rm = TRUE), 
                    max(data_imputed_long$SCON_scaled, na.rm = TRUE), 
                    length.out = 10),  # Reduce to 10 points
  id = unique(data_imputed_long$id),
  group = unique(data_imputed_long$group),
  time = unique(data_imputed_long$time),
  .imp = imputation_ids  # Keep imputation identifier
)

data_imputed_long_sub <- data_imputed_long[data_imputed_long$, 
                                           c("id", 
                                             ".imp", 
                                             "group", 
                                             "time", 
                                             "sex", 
                                             "stress",
                                             "age_cat")]

# Generate predictions for each imputation
pred_data <- pred_grid %>%
  left_join(data_imputed_long_sub, by = c("id", ".imp", "group", "time")) %>%  # Match imputation IDs
  add_predicted_draws(model_brm_02)

test <- add_predicted_draws(data_imputed_long, model_brm_02)

data_imputed_long %>%
  data_grid(hp = seq_range(hp, n = 101), am) %>%    # add am to the prediction grid
  add_predicted_draws(m_mpg_am) %>%
  ggplot(aes(x = hp, y = mpg)) +
  stat_lineribbon(aes(y = .prediction), .width = c(.99, .95, .8, .5), color = "#08519C") +
  geom_point(data = mtcars) +
  scale_fill_brewer() +
  facet_wrap(~ am)                                  # facet by am