source("src/create_all_calculated_datasets.R")
source("src/globals.R")
source("src/create_colchart.R")

dataframes = create_all_datasets(getColumns())
scales = get_scales()
ordinates = get_ordinates()

for (dataframe in dataframes) {
	print(dataframe$name)
	for (ordinate in ordinates) {
		for (isExport in 0:1) {
			create_colchart(dataframe$csv, dataframe$name, dataframe$annotations, scales$combined, ordinate, isExport == 0)
			create_colchart(dataframe$yearly_avg, dataframe$name, NULL, scales$yearly, ordinate, isExport == 0)
			create_colchart(dataframe$monthly_avg, dataframe$name, dataframe$annotations, scales$monthly, ordinate, isExport == 0)
			
			create_boxPlot(dataframe$csv, dataframe$name, NULL, dataframe$csv$Jahr, scales$yearly, ordinate, isExport == 0)
			create_boxPlot(dataframe$csv, dataframe$name, dataframe$annotations, dataframe$csv$Monat.Nr., scales$monthly, ordinate, isExport == 0)
		}
		create_im_and_export_colchart(dataframe$yearly_avg, dataframe$name, NULL, scales$yearly, ordinate)
		create_im_and_export_colchart(dataframe$monthly_avg, dataframe$name, dataframe$annotations, scales$monthly, ordinate)
		
		create_im_and_export_boxPlot(dataframe$csv, dataframe$name, NULL, dataframe$csv$Jahr, scales$yearly, ordinate)
		create_im_and_export_boxPlot(dataframe$csv, dataframe$name, dataframe$annotations, dataframe$csv$Monat.Nr., scales$monthly, ordinate)
	}
}
print("finished!")