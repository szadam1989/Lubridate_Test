# install.packages("ROracle.zip", repos = NULL)
library("ROracle")
drv <- Oracle()
con <- dbConnect(drv, username = Sys.getenv("userid"), password = Sys.getenv("pwd"), dbname = "emerald.ksh.hu")

# res <- dbSendQuery(con, "select * from VB_REP.VB_APP_INIT where ALKALMAZAS like 'MNB napi változáslista küldése' and PROGRAM = 'mnb_EBEAD.sql' and PARAM_NEV = 'utolso_futas'")
# (data <- fetch(res))
# str(data)
# 
# res2 <- dbSendQuery(con, "select distinct AAJE, upper(VNEVEM) VNEVEM, upper(UNEVEM) UNEVEM, upper(SZVNEVE) SZVNEVE, upper(SZUNEVE) SZUNEVE, upper(AVENVE) AVNEVE, upper(AUNEVE) AUNEVE, to_char(lg.lg_naptar_uj.szulido_adoazbol(AAJE), 'YYYY-MM-DD') SZUL_DAT from LG23.VNAA0_2326_230112_V00 where (upper(VNEVEM) like 'A%' or upper(VNEVEM) like 'Á%') order by upper(VNEVEM), upper(UNEVEM)")
# (data2 <- fetch(res2))
# str(data2)

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

Sys.getenv("TZ") ""
Sys.getenv("ORA_SDTZ") ""

Sys.setenv(TZ = "GMT")
Sys.setenv(ORA_SDTZ = "GMT")

rs3 <- dbSendQuery(con, "insert into GA.DATUM(idopont) values (:1)", data = worksheet_firsthalf$idopont)
dbCommit(con)

dbDisconnect(con)