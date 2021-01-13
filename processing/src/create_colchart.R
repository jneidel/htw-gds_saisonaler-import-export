# function
create_colchart <-
  function(dataframe,
           productName,
           scale,
           ordinate,
           is_Export) {
    savePath = paste("./output/", productName, "/colcharts", sep = "")
    dir.create(savePath, showWarnings = FALSE, recursive = TRUE)
    
    operationName = if (is_Export)
      "Export"
    else
      "Import"
    
    save_title <- sprintf(
      "%s_%s_%s_%s.png",
      productName,
      scale$save_scale,
      ordinate$save_ordinate,
      operationName
    )
    
    plot = ggplot(data = dataframe, aes(
      x = as.factor(scale$x_supplier(dataframe)),
      y = ordinate$y_supplier(dataframe, is_Export)
    )) +
      geom_col(linetype = g_l_linetype, fill = g_l_color) +
      #theme_bw() +
      theme(plot.title = element_text(hjust = t_hjust),
            #axis.text.x = element_text(angle = scale$angle),
            #panel.grid = element_blank()
            ) +
      labs(
        x = scale$x_label,
        y = ordinate$y_label,
        title = sprintf(
          "%s%s von %s pro %s von 2006 - 2020",
          operationName,
          ordinate$y_title,
          productName,
          scale$x_label
        )
      ) +
      scale_x_discrete(
        expand = expansion(mult = c(0, 0)),
        breaks = dataframe$timeScale,
        labels = dataframe$timeLabel
      ) +
      scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.05)))
    
    if (scale$vline != -1) {
      plot = plot + geom_vline(
        xintercept = seq(scale$x_min, scale$x_max, by = scale$vline),
        linetype = g_vl_linetype
      )
    }
    plot + ggsave(
      save_title,
      device = "png",
      path = savePath,
      width = 16,
      height = 9,
      scale = 0.75
    )
  }

create_boxPlot <-
  function(dataframe,
           productName,
           x_row,
           scale,
           scale_display,
           ordinate,
           is_Export) {
    savePath = paste("./output/", productName, "/boxPlot", sep = "")
    dir.create(savePath, showWarnings = FALSE, recursive = TRUE)
    
    operationName = if (is_Export)
      "Export"
    else
      "Import"
    
    save_title <- sprintf(
      "%s_%s_%s_%s.png",
      productName,
      scale_display$save_scale,
      ordinate$save_ordinate,
      operationName
    )
    
    plot = ggplot(data = dataframe, aes(
      x = as.factor(x_row),
      y = ordinate$y_supplier(dataframe, is_Export)
    )) +
      stat_summary(
        fun.data = function(x) {
          r <- quantile(x, probs = c(0, 0.25, 0.5, 0.75, 1))
          names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
          r
        },
        geom = "boxplot"
      ) +
      #theme_bw() +
      theme(plot.title = element_text(hjust = t_hjust),
            #panel.grid = element_blank()
            ) +
      labs(
        x = scale$x_label,
        y = ordinate$y_label,
        title = sprintf(
          "%s%s von %s pro %s von 2006 - 2020",
          operationName,
          ordinate$y_title,
          productName,
          scale$x_label
        )
      ) +
      scale_x_discrete(
        expand = expansion(mult = c(0.05, 0.05)),
        labels = scale$labels
      ) +
      scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.05)))
    
    plot + ggsave(
      save_title,
      device = "png",
      path = savePath,
      width = 16,
      height = 9,
      scale = 0.75
    )
  }
