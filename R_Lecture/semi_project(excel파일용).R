install.packages("readxl")
library(readxl)
raw_data_file2 = "C:/R_Lecture/data/child_abuse3.xlsx"

raw_grade_2_2015 <- read_excel(path = raw_data_file2,
                               col_names = T)

df1 <- subset(raw_grade_2_2015, SURVEY1w7 == "1")
