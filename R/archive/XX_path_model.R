## ----path-model

data_path_input <- data_imputed_pooled[, 
                                    c("id", 
                                      "Group",
                                      "v_534",
                                      "SCON_T1", 
                                      "SCON_T2_imp",
                                      "WFI_T1", 
                                      "WFI_T2_imp")]

data_path_input <- data_path_input[complete.cases(data_path_input),]

data_path_input$id <- as.factor(data_path_input$id)

data_path_input$SCON_T1_sq <- data_path_input$SCON_T1^2

data_path_input$SCON_T2_sq <- data_path_input$SCON_T2_imp^2

# model_01

model_01 <- "

  WFI_T2_imp ~ SCON_T2_sq + SCON_T2_imp + SCON_T1_sq + SCON_T1 + WFI_T1 + v_534


"

model_01_effect <- sem(model_01, 
                       data = data_path_input, 
                       group = "Group", 
                       estimator = "MLM")


summary(model_01_effect, fit.measures = TRUE, standardized = TRUE, ci = TRUE)

lavInspect(model_01_effect, "cov.ov")

cor(data_path_input[, c("SCON_T1", "SCON_T2_imp", "WFI_T1", "WFI_T2_imp", "SCON_T1_sq", "SCON_T2_sq")], 
    use = "pairwise.complete.obs")

apply(data_path_input[, c("SCON_T1", "SCON_T2_imp", "v_534", "WFI_T1", "WFI_T2_imp",  "SCON_T1_sq", "SCON_T2_sq")], 
      2, var)
