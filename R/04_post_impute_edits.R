## ---- prepare-mice-output

for (i in 1:length(data_imputed_output)){
  
  data_imputed_output[[i]] <- data_imputed_output[[i]][, c("id", 
                                                           "Group", 
                                                           "Age", 
                                                           "v_236", 
                                                           "v_534",
                                                           "SCON_T1", 
                                                           "SCON_T2", 
                                                           "WFI_T1", 
                                                           "WFI_T2")]
  
  setDT(data_imputed_output[[i]])
  
  data_imputed_output[[i]] <- melt(data_imputed_output[[i]], 
                                   id.vars = c("id", 
                                               "Group", 
                                               "Age", 
                                               "v_236", 
                                               "v_534"), 
                                   measure.vars = list(c("SCON_T1", "SCON_T2"), c("WFI_T1", "WFI_T2")),
                                   variable.name = "time", 
                                   value.name = c("SCON", "WFI"))
  
  data_imputed_output[[i]][, "time"] <- ifelse(data_imputed_output[[i]][, "time"] == 1, 
                                               "baseline", "follow-up")

  data_imputed_output[[i]]$group <- as.factor(data_imputed_output[[i]]$Group)
    
  data_imputed_output[[i]]$time <- as.factor(data_imputed_output[[i]]$time)
  
  data_imputed_output[[i]]$sex <- as.factor(data_imputed_output[[i]]$v_236)
  
  data_imputed_output[[i]][["SCON"]] <- 
    abs(as.numeric(data_imputed_output[[i]][["SCON"]]))
  
  data_imputed_output[[i]][["WFI"]] <- 
    abs(as.numeric(data_imputed_output[[i]][["WFI"]]))
  
  data_imputed_output[[i]][["age_cat"]] <- 
    ifelse(data_imputed_output[[i]][["Age"]] < 31, 1, 
           ifelse(data_imputed_output[[i]][["Age"]] >= 31 & 
                    data_imputed_output[[i]][["Age"]] < 41, 2, 
                  ifelse(data_imputed_output[[i]][["Age"]] >= 41 & 
                           data_imputed_output[[i]][["Age"]] < 51, 3, 4)))
                                                         
  data_imputed_output[[i]]$age_cat <- factor(data_imputed_output[[i]][["age_cat"]], 
                                             order = TRUE, 
                                             levels = c(1, 2, 3, 4))
  
  data_imputed_output[[i]][["stress"]] <- factor(data_imputed_output[[i]][["v_534"]], 
                                      order = TRUE, 
                                      levels = c(1, 2, 3, 4, 5))
  
  data_imputed_output[[i]] <- as.data.frame(data_imputed_output[[i]])
  
  data_imputed_output[[i]]$.id <- data_imputed_output[[i]]$id

  data_imputed_output[[i]]$.imp <- i 
  
  data_imputed_output[[i]] <- data_imputed_output[[i]][, c(".imp", 
                                                           ".id", 
                                                           "id", 
                                                           "group", 
                                                           "sex", 
                                                           "age_cat", 
                                                           "time", 
                                                           "stress", 
                                                           "SCON", 
                                                           "WFI")]
  
  
}
