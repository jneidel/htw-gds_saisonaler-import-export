source("src/create_all_calculated_datasets.R")
source("src/globals.R")
source("src/create_colchart.R")
source("src/unused/create_linechart.R")

datasets = create_all_datasets(getColumns())
scales = get_scales()
ordinates = get_ordinates()

for (dataset in datasets) {
	print(dataset$name)
	for (ordinate in ordinates) {
		for (isExport in 0:1) {
			create_colchart(dataset$csv, dataset$name, scales$combined, ordinate, isExport == 0)
			create_colchart(dataset$yearly_avg, dataset$name, scales$yearly, ordinate, isExport == 0)
			create_colchart(dataset$monthly_avg, dataset$name, scales$monthly, ordinate, isExport == 0)
			
			create_boxPlot(dataset$csv, dataset$name, dataset$csv$Jahr, scales$yearly, scales$monthly, ordinate, isExport == 0)
			create_boxPlot(dataset$csv, dataset$name, dataset$csv$Monat.Nr., scales$monthly, scales$yearly, ordinate, isExport == 0)
		}
		create_im_and_export_colchart(dataset$yearly_avg, dataset$name, scales$yearly, ordinate)
		create_im_and_export_colchart(dataset$monthly_avg, dataset$name, scales$monthly, ordinate)
		
		create_im_and_export_boxPlot(dataset$csv, dataset$name, dataset$csv$Jahr, scales$yearly, scales$monthly, ordinate)
		create_im_and_export_boxPlot(dataset$csv, dataset$name, dataset$csv$Monat.Nr., scales$monthly, scales$yearly, ordinate)
		
		# create_colchart(potato_normalized_m, "Kartoffeln", normalized_m_scale, ordinate, TRUE)
		# create_colchart(potato_normalized_y, "Kartoffeln", normalized_y_scale, ordinate, TRUE)
		# create_colchart(potato_normalized_ym, "Kartoffeln", normalized_ym_scale, ordinate, TRUE)
		
	}
}
print("finished!")