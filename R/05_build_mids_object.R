## ---- create-mids-object

data_imputed_long <- do.call(rbind, data_imputed_output)

mids_input <- rbind(original_data, data_imputed_long)

mids_input$.id <- NULL

mids_object <- as.mids(mids_input)