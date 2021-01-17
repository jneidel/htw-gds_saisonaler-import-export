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

define_annotation = function(xmin, xmax, alpha){
  return(list(xmin=xmin, xmax=xmax, color=main_season, alpha=.125*alpha))
}

create_all_datasets <- function(columnDefinition) {
  returnval <- list()
  
  returnval = define_dataset(returnval, columnDefinition, "\u00C4pfeln", list(define_annotation(12,12,4),define_annotation(1,4,4),define_annotation(5,6,3),define_annotation(10,11,3),define_annotation(9,9,2),define_annotation(7,8,1)))
  returnval = define_dataset(returnval, columnDefinition, "Birnen", list(define_annotation(9,12, 2),define_annotation(8,8,1),define_annotation(1,3, 1)))
# Aussortiert returnval = define_dataset(returnval, columnDefinition, "Cornichons", list(define_annotation(7,10)))
  returnval = define_dataset(returnval, columnDefinition, "Erbsen", list(define_annotation(6,7,4),define_annotation(8,8,2),define_annotation(9,10,1)))
  returnval = define_dataset(returnval, columnDefinition, "Erdbeeren", list(define_annotation(6,6,4),define_annotation(7,7,3),define_annotation(5,5,2),define_annotation(8,12,1),define_annotation(4,4,1)))
  returnval = define_dataset(returnval, columnDefinition, "Gurken", list(define_annotation(6,8,4),define_annotation(5,5,3),define_annotation(4,4,2),define_annotation(9,9,2),define_annotation(3,3,1),define_annotation(10,10,1)))
  returnval = define_dataset(returnval, columnDefinition, "Himbeeren", list(define_annotation(7,7,4),define_annotation(6,6,2),define_annotation(8,9,2),define_annotation(5.5,5,1),define_annotation(10,10.5,1)))
  returnval = define_dataset(returnval, columnDefinition, "Karotten", list(define_annotation(12,12,4),define_annotation(7,11,2),define_annotation(1,6,1)))
# Aussortiert returnval = define_dataset(returnval, columnDefinition, "Kartoffeln", list(define_annotation(1,12)))
  returnval = define_dataset(returnval, columnDefinition, "K\u00FCrbissen", list(define_annotation(9,9,4),define_annotation(10,10,3),define_annotation(8,8,2),define_annotation(7,7,1),define_annotation(11,11.5,1)))
  returnval = define_dataset(returnval, columnDefinition, "Orangen", list())
  returnval = define_dataset(returnval, columnDefinition, "Spargel", list(define_annotation(5,5,4),define_annotation(6,6,3),define_annotation(4,4,2),define_annotation(3.5,3,1),define_annotation(7,6.5,1)))
  returnval = define_dataset(returnval, columnDefinition, "Spinat", list(define_annotation(5,8,4),define_annotation(4,4,3),define_annotation(9,10,3),define_annotation(11,11,2),define_annotation(3,3,1),define_annotation(12,12,1)))
# Aussortiert returnval = define_dataset(returnval, columnDefinition, "Steinpilzen", list(define_annotation(6,9),define_annotation(10,11)))
  returnval = define_dataset(returnval, columnDefinition, "Tomaten", list(define_annotation(6,8,4),define_annotation(5,5,3),define_annotation(9,9,3),define_annotation(4,4,2),define_annotation(10,11,2),define_annotation(12,12,1),define_annotation(3,3,1)))
  returnval = define_dataset(returnval, columnDefinition, "Zitronen", list())
  returnval = define_dataset(returnval, columnDefinition, "Zwiebeln", list(define_annotation(8,12,4),define_annotation(1,1,4),define_annotation(2,4,3),define_annotation(5,5,2),define_annotation(6,7,1)))

  return(returnval)
}
