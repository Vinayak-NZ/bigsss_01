## ---- core-code

source("R/00_load_packages.R")
source("R/00_set_date.R")
source("R/00_load_models.R")
source("R/01_load_data.R")
source("R/02_edit_data.R")
source("R/03_impute_data.R")
source("R/04_post_impute_edits.R")
source("R/04_post_impute_single.R")
source("R/04_data_edit_outliers.R")

## ---- build-mixed-effects-models

source("R/04_original_data_edit.R")
source("R/05_build_mids_object.R")
source("R/05_build_mixed_effects_models_pool.R")
source("R/06_assumptions_test_mixed_effects.R")

## ---- build-bayesian-models

source("R/05_bayes_model_input.R")
source("R/05_build_bayesian_models_select_wfi.R")
source("R/05_build_bayesian_models.R")
source("R/05_build_bayesian_models_post_hoc.R")
source("R/07_output_bayes_model_stats.R")

## ---- build-gam-models

source("R/05_build_gam_models.R")

## ---- visualise

source("R/07_plot_relationship_wfi_scon.R")