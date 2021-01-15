source("src/transform_dataset.R")

create_datasets <- function(dataset, columnDefinition, name, annotations) {
  returnval <- list()

  returnval[["csv"]] <- dataset
  returnval[["name"]] <- name
  returnval[["annotations"]] <- annotations
  returnval[["yearly_sum"]] <- transform_dataset_yearly(dataset, columnDefinition, colSums)
  returnval[["yearly_avg"]] <- transform_dataset_yearly(dataset, columnDefinition, colMeans)
  returnval[["monthly_sum"]] <- transform_dataset_monthly(dataset, columnDefinition, colSums)
  returnval[["monthly_avg"]] <- transform_dataset_monthly(dataset, columnDefinition, colMeans)
  
  #returnval[["normalized_m"]] <- create_normalized_by_month_dataset(dataset, datasets["monthly"])
  #returnval[["normalized_ym"]] <- create_normalized_by_year_and_month_dataset(dataset, datasets["yearly"], datasets["monthly"])

  return(returnval)
}

define_dataset = function(list, columnDefinition, name, annotations) {
  list[[name]] <- create_datasets(read.csv2(paste("./data/new/51000-0014_", name, ".csv", sep=""), na.strings = "0"), columnDefinition, name, annotations)
  return(list)
}

define_annotation = function(xmin, xmax, color){
  return(list(xmin=xmin, xmax=xmax, color=color))
}

create_all_datasets <- function(columnDefinition) {
  returnval <- list()
  
  returnval = define_dataset(returnval, columnDefinition, "\u00C4pfeln", list())
  returnval = define_dataset(returnval, columnDefinition, "Birnen", list(define_annotation(5,12), define_annotation(1,2)))
  returnval = define_dataset(returnval, columnDefinition, "Cornichons", list())
  returnval = define_dataset(returnval, columnDefinition, "Erbsen", list())
  returnval = define_dataset(returnval, columnDefinition, "Gurken", list())
  returnval = define_dataset(returnval, columnDefinition, "Himbeeren", list())
  returnval = define_dataset(returnval, columnDefinition, "Karotten", list())
  returnval = define_dataset(returnval, columnDefinition, "K\u00FCrbissen", list())
  returnval = define_dataset(returnval, columnDefinition, "Spinat", list())
  returnval = define_dataset(returnval, columnDefinition, "Steinpilzen", list())
  returnval = define_dataset(returnval, columnDefinition, "Tomaten", list())
  returnval = define_dataset(returnval, columnDefinition, "Zwiebeln", list())
  
  returnval = define_dataset(returnval, columnDefinition, "Kartoffeln", list())
  returnval = define_dataset(returnval, columnDefinition, "Orangen", list())
  returnval = define_dataset(returnval, columnDefinition, "Spargel", list())
  returnval = define_dataset(returnval, columnDefinition, "Zitronen", list())
  returnval = define_dataset(returnval, columnDefinition, "Erdbeeren", list())

  return(returnval)
}
