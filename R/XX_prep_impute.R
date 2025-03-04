## ---- prepare-mice-output

for (i in 1:length(data_imputed_output)){
  
  data_imputed_output[[i]] <- data_imputed_output[[i]][, c("id", 
                                                           "Group", 
                                                           "Age", 
                                                           "v_236", 
                                                           "SCON_T1", 
                                                           "SCON_T2", 
                                                           "WFI_T1", 
                                                           "WFI_T2")]
  
  setDT(data_imputed_output[[i]])
  
  data_imputed_output[[i]] <- melt(data_imputed_output[[i]], 
                                   id.vars = c("id", 
                                               "Group", 
                                               "Age", 
                                               "v_236"), 
                                   measure.vars = list(c("SCON_T1", "SCON_T2"), c("WFI_T1", "WFI_T2")),
                                   variable.name = "time", 
                                   value.name = c("SCON", "WFI"))
  
  data_imputed_output[[i]][, "time"] <- ifelse(data_imputed_output[[i]][, "time"] == 1, 
                                               "baseline", "follow-up")
  
  data_imputed_output[[i]]$time <- as.factor(data_imputed_output[[i]]$time)
  
  data_imputed_output[[i]]$sex <- as.factor(data_imputed_output[[i]]$v_236)
  
  data_imputed_output[[i]][["SCON"]] <- abs(as.numeric(data_imputed_output[[i]][["SCON"]]))
  
  data_imputed_output[[i]][["WFI"]] <- abs(as.numeric(data_imputed_output[[i]][["WFI"]]))
  
  data_imputed_output[[i]] <- as.data.frame(data_imputed_output[[i]])
  
}
