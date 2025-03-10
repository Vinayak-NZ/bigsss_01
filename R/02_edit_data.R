## ---- subset-data

data_input_merged$id <- 1:nrow(data_input_merged)

data_input <- data_input_merged[, c("id", 
                                    "Group", 
                                    "Age", 
                                    "v_236",
                                    "v_534", 
                                    "v_534_P1", 
                                    "v_3",
                                    "v_4",
                                    "v_5",
                                    "v_6",
                                    "v_7",
                                    "v_8",
                                    "v_9",
                                    "v_10",
                                    "v_11",
                                    "v_12",
                                    "v_13",
                                    "v_14",
                                    "v_15",
                                    "v_16",
                                    "v_17",
                                    "v_18",
                                    "v_19",
                                    "v_20",
                                    "v_21",
                                    "v_22",
                                    "v_23",
                                    "v_24",
                                    "v_25",
                                    "v_449",
                                    "v_531", 
                                    "v_286", 
                                    "v_287", 
                                    "WFI_T1", 
                                    "WFI_T2", 
                                    "SCON_T1", 
                                    "SCON_T2")]

data_input$SCON_T2 <- ifelse(data_input$SCON_T2 < 0, NA, 
                             data_input$SCON_T2)

data_input$v_534 <- factor(data_input$v_534, order = TRUE, levels = c(1, 2, 3, 4, 5))

data_input$v_534_P1 <- factor(data_input$v_534_P1, order = TRUE, levels = c(1, 2, 3, 4, 5))

rownames(data_input) <- NULL