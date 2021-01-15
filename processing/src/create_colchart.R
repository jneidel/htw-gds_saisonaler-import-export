library(ggplot2)
library(reshape2)

# function
create_colchart <-
  function(dataframe,
           productName,
           annotations,
           scale,
           ordinateProvider,
           is_Export) {
    ordinate = ordinateProvider(dataframe, is_Export, FALSE)
    operationName = if (is_Export)
      "Export"
    else
      "Import"
    
    plot = ggplot(data = dataframe, aes(
      x = as.factor(scale$x_supplier(dataframe)),
      y = ordinate$y_supplier(dataframe)
    ))
    plot = applyAnnotations(plot, annotations, scale$x_supplier(dataframe))
    plot = plot + geom_col(fill = g_l_color) +
      theme(plot.title = element_text(hjust = t_hjust),
            axis.line = element_line(linetype = 1)) +
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
      scale_x_discrete(expand = expansion(add = .5),
                       labels = scale$labels) +
      scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.05)))
    
    plot = applyVLine(plot, scale)
    
    savePng("colcharts",
            plot,
            productName,
            scale,
            ordinate,
            operationName)
  }

create_im_and_export_colchart <-
  function(dataframe,
           productName,
           annotations,
           scale,
           ordinateProvider) {
    ordinateExport = ordinateProvider(dataframe, TRUE, TRUE)
    ordinateImport = ordinateProvider(dataframe, FALSE, TRUE)
    data_src = melt(
      data.frame(
        Import = ordinateImport$y_supplier(),
        Export = ordinateExport$y_supplier(),
        x = as.factor(scale$x_supplier(dataframe))
      ),
      id.vars = 'x'
    )
    plot = ggplot(data = data_src, aes(x = x, y = value, fill = variable))
    plot = applyAnnotations(plot, annotations, scale$x_supplier(dataframe))
    plot = plot + geom_col(position = "dodge") +
      theme(plot.title = element_text(hjust = t_hjust),
            axis.line = element_line(linetype = 1)) +
      labs(
        x = scale$x_label,
        y = ordinateExport$y_label,
        title = sprintf(
          "%s%s von %s pro %s von 2006 - 2020",
          "Im-/Export",
          ordinateExport$y_title,
          productName,
          scale$x_label
        )
      ) +
      scale_x_discrete(expand = expansion(mult = c(0, 0)),
                       labels = scale$labels) +
      scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.05))) +
      scale_fill_manual(values = c(g_l_color, g_l_color2), name = "Legende")
    
    plot = applyVLine(plot, scale)
    
    savePng("colcharts_combined",
            plot,
            productName,
            scale,
            ordinateExport,
            "Im-Export")
  }

create_boxPlot <-
  function(dataframe,
           productName,
           annotations,
           x_row,
           scale,
           ordinateProvider,
           is_Export) {
    ordinate = ordinateProvider(dataframe, is_Export, FALSE)
    operationName = if (is_Export)
      "Export"
    else
      "Import"
    
    plot = ggplot(data = dataframe, aes(x = as.factor(x_row),
                                        y = ordinate$y_supplier()))
    plot = applyAnnotations(plot, annotations, scale$x_supplier(dataframe))
    plot = plot + stat_boxplot(geom = "errorbar",
                               width = 0.4,
                               linetype = 1) +
      geom_boxplot(fill = g_l_color, coef = 1.5) +
      theme(plot.title = element_text(hjust = t_hjust),
            axis.line = element_line(linetype = 1)) +
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
      scale_x_discrete(expand = expansion(mult = c(0.05, 0.05)),
                       labels = scale$labels) +
      scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.05)))
    
    savePng("boxplots",
            plot,
            productName,
            scale,
            ordinate,
            operationName)
  }

create_im_and_export_boxPlot <-
  function(dataframe,
           productName,
           annotations,
           x_row,
           scale,
           ordinateProvider) {
    ordinateExport = ordinateProvider(dataframe, TRUE, TRUE)
    ordinateImport = ordinateProvider(dataframe, FALSE, TRUE)
    
    data_src = melt(
      data.frame(
        Import = ordinateImport$y_supplier(),
        Export = ordinateExport$y_supplier(),
        x = as.factor(x_row)
      ),
      id.vars = "x"
    )
    
    plot = ggplot(data = data_src, aes(x = x, y = value, fill = variable))
    plot = applyAnnotations(plot, annotations, x_row)
    plot = plot + stat_boxplot(geom = "errorbar",
                               #width = 0.4,
                               linetype = 1) +
      geom_boxplot(coef = 1.5) +
      theme(plot.title = element_text(hjust = t_hjust),
            axis.line = element_line(linetype = 1)) +
      labs(
        x = scale$x_label,
        y = ordinateExport$y_label,
        title = sprintf(
          "%s%s von %s pro %s von 2006 - 2020",
          "Im-/Export",
          ordinateExport$y_title,
          productName,
          scale$x_label
        )
      ) +
      scale_x_discrete(expand = expansion(mult = c(0.05, 0.05)),
                       labels = scale$labels) +
      scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.05))) +
      scale_fill_manual(values = c(g_l_color, g_l_color2), name = "Legende")
    
    savePng("boxplots_combined",
            plot,
            productName,
            scale,
            ordinateExport,
            "Im-Export")
  }

applyVLine = function(plot, scale) {
  if (scale$vline != -1) {
    plot = plot + geom_vline(
      xintercept = seq(scale$x_min, scale$x_max, by = scale$vline),
      linetype = g_vl_linetype
    )
  }
  return(plot)
}
applyAnnotations = function(plot, annotations, data_x) {
  if (is.null(annotations) == FALSE) {
    if (length(data_x) == 12 || length(data_x) == 178) {
      for (i in 1:(ceiling(length(data_x) / 12))) {
        for (annotation in annotations) {
          plot = plot + annotate(
            "rect",
            xmin = annotation$xmin - 0.5 + (12 * (i - 1)),
            xmax = annotation$xmax + 0.5 + (12 * (i - 1)),
            ymin = -Inf,
            ymax = Inf,
            alpha = 0.2,
            fill = "#1e8449"
          )
        }
      }
    }
  }
  return(plot)
}
savePng = function(dirName,
                   plot,
                   productName,
                   scale_display,
                   ordinate,
                   operationName) {
  save_title <- sprintf(
    "%s_%s_%s_%s.png",
    productName,
    scale_display$save_scale,
    ordinate$save_ordinate,
    operationName
  )
  
  savePath = paste("./output/", productName, "/", dirName, sep = "")
  dir.create(savePath, showWarnings = FALSE, recursive = TRUE)
  
  plot + ggsave(
    save_title,
    device = "png",
    path = savePath,
    width = 16,
    height = 9,
    scale = 0.75
  )
}
