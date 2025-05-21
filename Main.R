library("lubridate")
worksheet_firsthalf <- read.csv(paste0(getwd(), "/Excel_Files/969_KSH_attrakcio_minta_pinot_kozfurdok_20240415_0430.csv"), header = TRUE, sep = ";", colClasses = "character")

dim(worksheet_firsthalf) # 160534 sor és 45 oszlop
View(worksheet_firsthalf)
str(worksheet_firsthalf)

worksheet_firsthalf$idopont
ymd_hm(gsub(". ", "-", worksheet_firsthalf$idopont))
worksheet_firsthalf$idopont <- ymd_hm(gsub(". ", "-", worksheet_firsthalf$idopont))

worksheet_firsthalf$program_kezdete <- ymd_hm(gsub(". ", "-", worksheet_firsthalf$program_kezdete))
worksheet_firsthalf$program_vege <- ymd_hm(gsub(". ", "-", worksheet_firsthalf$program_vege))

Sys.Date()
Sys.time()