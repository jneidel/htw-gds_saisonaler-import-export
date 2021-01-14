source("src/transform_dataset.R")

create_datasets <- function(dataset, columnDefinition, name) {
  returnval <- list()

  returnval[["csv"]] <- dataset
  returnval[["name"]] <- name
  returnval[["yearly_sum"]] <- transform_dataset_yearly(dataset, columnDefinition, colSums)
  returnval[["yearly_avg"]] <- transform_dataset_yearly(dataset, columnDefinition, colMeans)
  returnval[["monthly_sum"]] <- transform_dataset_monthly(dataset, columnDefinition, colSums)
  returnval[["monthly_avg"]] <- transform_dataset_monthly(dataset, columnDefinition, colMeans)
  #returnval[["normalized_m"]] <- create_normalized_by_month_dataset(dataset, datasets["monthly"])
  #returnval[["normalized_ym"]] <- create_normalized_by_year_and_month_dataset(dataset, datasets["yearly"], datasets["monthly"])

  return(returnval)
}

define_dataset = function(list, columnDefinition, name) {
  list[[name]] <- create_datasets(read.csv2(paste("./data/new/51000-0014_", name, ".csv", sep=""), na.strings = "0"), columnDefinition, name)
  return(list)
}

create_all_datasets <- function(columnDefinition) {
  returnval <- list()
  
  returnval = define_dataset(returnval, columnDefinition, "Aepfel")
  returnval = define_dataset(returnval, columnDefinition, "Birnen")
  returnval = define_dataset(returnval, columnDefinition, "Cornichons")
  returnval = define_dataset(returnval, columnDefinition, "Erbsen")
  returnval = define_dataset(returnval, columnDefinition, "Gurken")
  returnval = define_dataset(returnval, columnDefinition, "Himbeeren")
  returnval = define_dataset(returnval, columnDefinition, "Karotten")
  returnval = define_dataset(returnval, columnDefinition, "Kurbisse")
  returnval = define_dataset(returnval, columnDefinition, "Spinat")
  returnval = define_dataset(returnval, columnDefinition, "Steinpilze")
  returnval = define_dataset(returnval, columnDefinition, "Tomaten")
  returnval = define_dataset(returnval, columnDefinition, "Zwiebeln")

  returnval[["potato"]] <- create_datasets(read.csv2("./data/51000-0014_Kartoffeln.csv", na.strings = "0"), columnDefinition, "Kartoffeln")
  returnval[["oranges"]] <- create_datasets(read.csv2("./data/51000-0014_Orangen.csv", na.strings = "0"), columnDefinition, "Orangen")
  returnval[["spargel"]] <- create_datasets(read.csv2("./data/51000-0014_Spargel.csv", na.strings = "0"), columnDefinition, "Spargel")
  returnval[["zitronen"]] <- create_datasets(read.csv2("./data/51000-0014_Zitronen.csv", na.strings = "0"), columnDefinition, "Zitronen")
  returnval[["erdbeeren"]] <- create_datasets(read.csv2("./data/51000-0014_Erdbeeren.csv", na.strings = "0"), columnDefinition, "Erdbeeren")

  return(returnval)
}
