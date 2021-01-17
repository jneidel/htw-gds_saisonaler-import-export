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

define_annotation = function(xmin, xmax, color, alpha){
  return(list(xmin=xmin, xmax=xmax, color=color, alpha=alpha))
}

create_all_datasets <- function(columnDefinition) {
  returnval <- list()
  
  returnval = define_dataset(returnval, columnDefinition, "\u00C4pfeln", list(define_annotation(9,12,main_season),define_annotation(1,4,main_season),define_annotation(5,8,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Birnen", list(define_annotation(8,11,main_season, 0.2),define_annotation(12,12,lame_season),define_annotation(1,3,lame_season, 0.2)))
  returnval = define_dataset(returnval, columnDefinition, "Cornichons", list(define_annotation(7,10,main_season)))
  returnval = define_dataset(returnval, columnDefinition, "Erbsen", list(define_annotation(7,8,main_season),define_annotation(6,6,lame_season),define_annotation(9,9,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Erdbeeren", list(define_annotation(6,8,main_season),define_annotation(5,5,lame_season),define_annotation(9,9,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Gurken", list(define_annotation(5,9,main_season),define_annotation(3,4,lame_season),define_annotation(10,11,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Himbeeren", list(define_annotation(6,9,main_season),define_annotation(10,10,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Karotten", list(define_annotation(7,12,main_season),define_annotation(1,6,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Kartoffeln", list(define_annotation(1,12,main_season)))
  returnval = define_dataset(returnval, columnDefinition, "K\u00FCrbissen", list(define_annotation(9,12,main_season),define_annotation(1,1,main_season)))
  returnval = define_dataset(returnval, columnDefinition, "Orangen", list())
  returnval = define_dataset(returnval, columnDefinition, "Spargel", list(define_annotation(4,6,main_season),define_annotation(3,3,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Spinat", list(define_annotation(3,5,main_season),define_annotation(9,11,main_season),define_annotation(12,12,lame_season),define_annotation(1,2,lame_season),define_annotation(6,8,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Steinpilzen", list(define_annotation(6,9,main_season),define_annotation(10,11,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Tomaten", list(define_annotation(5,9,main_season),define_annotation(3,4,lame_season),define_annotation(10,11,lame_season)))
  returnval = define_dataset(returnval, columnDefinition, "Zitronen", list())
  returnval = define_dataset(returnval, columnDefinition, "Zwiebeln", list(define_annotation(7,10,main_season),define_annotation(11,12,lame_season),define_annotation(1,4,lame_season)))

  return(returnval)
}
