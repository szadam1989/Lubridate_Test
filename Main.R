# install.packages("ROracle.zip", repos = NULL)
library("readr")
library("lubridate")
library("ROracle")
worksheet_firsthalf <- read_csv2(paste0(getwd(), "/Excel_Files/969_KSH_attrakcio_minta_pinot_kozfurdok_20240415_0430.csv"), col_types = NULL, show_col_types = FALSE)

dim(worksheet_firsthalf) # 160534 sor és 45 oszlop
str(worksheet_firsthalf)

worksheet_firsthalf$idopont
ymd_hm(gsub(". ", "-", worksheet_firsthalf$idopont))
worksheet_firsthalf$idopont <- ymd_hm(gsub(". ", "-", worksheet_firsthalf$idopont))

worksheet_firsthalf$program_kezdete <- ymd_hm(gsub(". ", "-", worksheet_firsthalf$program_kezdete))
worksheet_firsthalf$program_vege <- ymd_hm(gsub(". ", "-", worksheet_firsthalf$program_vege))

Sys.Date()
Sys.time()

Sys.getenv("TZ") # ""
Sys.getenv("ORA_SDTZ") # ""

Sys.setenv(TZ = "CET")
Sys.setenv(ORA_SDTZ = "CET")

drv <- Oracle()
con <- dbConnect(drv, username = Sys.getenv("userid"), password = Sys.getenv("pwd"), dbname = "emerald.ksh.hu")
res <- dbSendQuery(con, "insert into GA.DATUM(idopont) values (:1)", data = worksheet_firsthalf$idopont)
dbClearResult(res)
dbCommit(con)

dbDisconnect(con)