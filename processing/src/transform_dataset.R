transform_dataset_yearly <- function(dataframe, columnDefinition, transform_function) {
  # global variables
  lowerBound <- min(dataframe$Jahr)
  upperBound <- max(dataframe$Jahr)

  timeScale <- c() # year
  timeLabel <- c() # year

  for (i in 0:(upperBound - lowerBound)) {
    timeScale[i + 1] = lowerBound + i
    timeLabel[i + 1] = lowerBound + i
  }
  
  returnval <- data.frame(timeScale, timeLabel)
  colnames(returnval) <- c("timeScale", "timeLabel")
  
  for (column in columnDefinition) {
    data <- c()
    for (i in lowerBound:upperBound) {
      data[i - lowerBound + 1] = transform_function(subset(dataframe, Jahr == i, select = column$row))
    }
    returnval[column$name] <- data
  }

  return(returnval)
}

transform_dataset_monthly <- function(dataframe, columnDefinition, transform_function) {
  # global variables
  lowerBound <- 0
  upperBound <- 12
  
  #                   Order & Jahr
  order <- c()
  timeScale <- c()  # month.nr
  timeLabel <- c()  # month
  
  for (i in 1:(upperBound - lowerBound)) {
    order[i] = i - 1
    timeScale[i] = i
    timeLabel[i] = dataframe$Monat[dataframe$Monat.Nr. == i][1]
  }
  
  returnval <- data.frame(order, timeScale, timeLabel)
  colnames(returnval) <- c("Order", "timeScale", "timeLabel")

  for (column in columnDefinition) {
    data <- c()
    for (i in (lowerBound:upperBound)) {
      data[i - lowerBound] = transform_function(subset(dataframe, Monat.Nr. == i, select = column$row))
    }
    returnval[column$name] <- data
  }
  
  return(returnval)
}