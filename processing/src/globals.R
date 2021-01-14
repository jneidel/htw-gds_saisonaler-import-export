# Style
g_l_color <- "#3498db" #"steelblue"
g_l_color2 <- "#f39c12"
g_l_linetype <- 1
g_p_size <- 1
t_hjust <- 0.5
g_vl_linetype <- 3

get_scales <- function() {
  return(
    list(
      "combined" = list(
        x_supplier = function(Data) {
          return(purrr::map_dbl(Data$Order, function(a)
            (a / 12) + 2006))
        },
        x_label = "Jahr",
        x_min = 12.5,
        x_max = 12 * 15,
        vline = 12,
        angle = 0,
        save_scale = "combined"
      ),
      "yearly" = list(
        x_supplier = function(Data) {
          return(Data$timeScale)
        },
        x_label = "Jahr",
        x_min = 2006,
        x_max = 2020,
        vline = -1,
        angle = 0,
        save_scale = "yearly",
        labels = c(
          "2006",
          "2007",
          "2008",
          "2009",
          "2010",
          "2011",
          "2012",
          "2013",
          "2014",
          "2015",
          "2016",
          "2017",
          "2018",
          "2019",
          "2020"
        )
      ),
      "monthly" = list(
        x_supplier = function(Data) {
          return(Data$timeScale)
        },
        x_label = "Monat",
        x_min = 1,
        x_max = 12,
        vline = -1,
        angle = 0,
        save_scale = "monthly",
        labels = c(
          "Januar",
          "Februar",
          "M\u00E4rz",
          "April",
          "Mai",
          "Juni",
          "Juli",
          "August",
          "September",
          "Oktober",
          "November",
          "Dezember"
        )
      ),
      
      
      
      
      "normalized_m" = list(
        x_supplier = function(Data) {
          return(purrr::map_dbl(Data$Order, function(a)
            (a / 12) + 2006))
        },
        x_label = "Jahr",
        x_min = 2006,
        x_max = 2020,
        vline = 1,
        nudge = 1 / 2,
        angle = 0,
        save_scale = "M_normalized"
      ),
      "normalized_y" = list(
        x_supplier = function(Data) {
          return(purrr::map_dbl(Data$Order, function(a)
            (a / 12) + 2006))
        },
        x_label = "Jahr",
        x_min = 2006,
        x_max = 2020,
        vline = 1,
        nudge = 1 / 2,
        angle = 0,
        save_scale = "Y_normalized"
      ),
      "normalized_ym" = list(
        x_supplier = function(Data) {
          return(purrr::map_dbl(Data$Order, function(a)
            (a / 12) + 2006))
        },
        x_label = "Jahr",
        x_min = 2006,
        x_max = 2020,
        vline = 1,
        nudge = 1 / 2,
        angle = 0,
        save_scale = "YM_normalized"
      )
    )
  )
}

get_ordinates <- function() {
  return(list(
    "weight" = function(Dataframe, is_Export, ignoreDividing) {
      if (is_Export) {
        row = Dataframe$Ausfuhr..Gewicht
      }
      else {
        row = Dataframe$Einfuhr..Gewicht
      }
      
      if (is.na(max(row, na.rm = TRUE)) == FALSE &&
          max(row, na.rm = TRUE) >= 1000 && ignoreDividing == FALSE) {
        divider = 1
      }
      else {
        divider = 1
      }
      
      list(
        y_supplier = function(Data) {
          return(purrr::map_dbl(row, function(a)
            a / divider))
        },
        y_label = "Masse in t",
        y_title = "menge in Tonnen",
        save_ordinate = "weight"
      )
    },
    "euro" = function(Dataframe, is_Export, ignoreDividing) {
      if (is_Export) {
        row = Dataframe$Ausfuhr..Wert
      }
      else {
        row = Dataframe$Einfuhr..Wert
      }
      
      if (is.na(max(row, na.rm = TRUE)) == FALSE &&
          max(row, na.rm = TRUE) >= 1000 && ignoreDividing == FALSE) {
        divider = 1000
        y_label = "Volumen in Mio. \u20AC"
        y_title = "volumen in Euro"
      }
      else {
        divider = 1
        y_label = "Volumen in Tsd. \u20AC"
        y_title = "volumen in Euro"
      }
      list(
        y_supplier = function(Data) {
          return(purrr::map_dbl(row, function(a)
            a / divider))
        },
        y_label = y_label,
        y_title = y_title,
        save_ordinate = "Euro"
      )
    },
    "euro_per_weight" = function(Dataframe, is_Export, ignoreDividing) {
      if (is_Export) {
        row = Dataframe$Ausfuhr..Wert.Gewicht
      }
      else {
        row = Dataframe$Einfuhr..Wert.Gewicht
      }
      
      if (is.na(max(row, na.rm = TRUE)) == FALSE &&
          max(row, na.rm = TRUE) >= 1000 && ignoreDividing == FALSE) {
        divider = 1
      }
      else {
        divider = 1
      }
      list(
        y_supplier = function(Data) {
          return(purrr::map_dbl(row, function(a)
            a / divider))
        },
        y_label = "Wert in \u20AC/t",
        y_title = "wert in Euro pro Tonnen",
        save_ordinate = "Euro_per_weight"
      )
    }
  ))
}

getColumns <- function() {
  columnEntry <- function(row, name) {
    return(list("row" = row, "name" = name))
  }
  
  return(
    list(
      columnEntry("Ausfuhr..Gewicht", "Ausfuhr..Gewicht"),
      columnEntry("Ausfuhr..Wert", "Ausfuhr..Wert"),
      columnEntry("Ausfuhr..Wert.Gewicht", "Ausfuhr..Wert.Gewicht"),
      columnEntry("Einfuhr..Gewicht", "Einfuhr..Gewicht"),
      columnEntry("Einfuhr..Wert", "Einfuhr..Wert"),
      columnEntry("Einfuhr..Wert.Gewicht", "Einfuhr..Wert.Gewicht")
    )
  )
}
