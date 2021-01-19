# function
create_linechart <-
  function(Data,
           Product,
           scale,
           ordinate,
           is_Export) {
    savePath = paste("./output/linecharts/", Product, "", sep = "")
    dir.create(savePath, showWarnings = FALSE, recursive = TRUE)
    
    save_title <- sprintf("%s_%s_%s_%s.png",
                          Product,
                          scale[["save_scale"]],
                          ordinate[["save_ordinate"]],
                          (if (is_Export)
                            "Export"
                           else
                             "Import"))
    
    ggplot(data = Data, aes(x = scale[["x_supplier"]](Data), y = ordinate[["y_supplier"]](Data, is_Export))) +
      geom_line(linetype = g_l_linetype, color = g_l_color) +
      geom_point(size = g_p_size) +
      theme_bw() +
      theme(
        plot.title = element_text(hjust = t_hjust),
        axis.text.x = element_text(angle = scale[["angle"]]),
        panel.grid = element_blank()
      ) +
      geom_vline(xintercept = seq(scale[["x_min"]], scale[["x_max"]], by = scale[["vline"]]),
                 linetype = g_vl_linetype) +
      labs(
        x = scale[["x_label"]],
        y = ordinate[["y_label"]],
        title = sprintf(
          "%sport%s von %s pro %s von 2008 - 2020",
          (if (is_Export)
            "Ex"
           else
             "Im"),
          ordinate[["y_title"]],
          Product,
          scale[["x_label"]]
        )
      ) +
      scale_x_continuous(expand = expansion(mult = c(0, 0)),
                         breaks = seq(0, scale[["x_max"]], by = scale[["x_scale"]])) +
      scale_y_continuous(expand = expansion(mult = c(0, .05))) +
      ggsave(
        save_title,
        device = "png",
        path = savePath,
        width = 16,
        height = 9,
        scale = 0.75
      )
  }