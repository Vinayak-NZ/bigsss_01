## ---- edit-original-data

original_data <- data_input

original_data <- original_data[, c("id", 
                                   "Group", 
                                   "Age", 
                                   "v_236", 
                                   "v_534",
                                   "SCON_T1", 
                                   "SCON_T2", 
                                   "WFI_T1", 
                                   "WFI_T2")]

setDT(original_data)

original_data <- melt(original_data, 
                      id.vars = c("id", 
                                  "Group", 
                                  "Age", 
                                  "v_236", 
                                  "v_534"), 
                      measure.vars = list(c("SCON_T1", "SCON_T2"), c("WFI_T1", "WFI_T2")),
                      variable.name = "time", 
                      value.name = c("SCON", "WFI"))

original_data[, "time"] <- ifelse(original_data[, "time"] == 1, 
                                  "baseline", "follow-up")

original_data$group <- as.factor(original_data$Group)

original_data$time <- as.factor(original_data$time)

original_data$sex <- as.factor(original_data$v_236)

original_data[["SCON"]] <- 
  abs(as.numeric(original_data[["SCON"]]))

original_data[["WFI"]] <- 
  abs(as.numeric(original_data[["WFI"]]))

original_data[["age_cat"]] <- 
  ifelse(original_data[["Age"]] < 31, 1, 
         ifelse(original_data[["Age"]] >= 31 & 
                  original_data[["Age"]] < 41, 2, 
                ifelse(original_data[["Age"]] >= 41 & 
                         original_data[["Age"]] < 51, 3, 4)))

original_data$age_cat <- factor(original_data[["age_cat"]], 
                                order = TRUE, 
                                levels = c(1, 2, 3, 4))

original_data[["stress"]] <- factor(original_data[["v_534"]], 
                                    order = TRUE, 
                                    levels = c(1, 2, 3, 4, 5))

original_data <- as.data.frame(original_data)

original_data$.id <- original_data$id

original_data$.imp <- 0

original_data <- original_data[, c(".imp", 
                                   ".id", 
                                   "id", 
                                   "group", 
                                   "sex", 
                                   "age_cat", 
                                   "time", 
                                   "stress", 
                                   "SCON", 
                                   "WFI")]