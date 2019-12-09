library(foreign)
library(ggplot2)
library(dplyr)
library(xlsx)
#e1w1 <- read.spss("C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w1.sav", 
#                  to.data.frame=TRUE,
#                  fileEncoding="UTF-8")
#View(e1w1)


#raw_e1w1 <- "C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w1.sav"
#e1w1 <- read.spss(file=raw_e1w1,
#                  to.data.frame=T,
#                  fileEncoding="UTF-8")
#View(e1w1)



raw_e1w2 <- "C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w2.sav"
e1w2 <- read.spss(file=raw_e1w2,
                  to.data.frame = T,
                  fileEncoding ="UTF-8")
View(e1w2)




raw_e1w3 <- "C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w3.sav"
e1w3 <- read.spss(file=raw_e1w3,
                  to.data.frame = T,
                  fileEncoding ="UTF-8")
View(e1w3)




raw_e1w4 <- "C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w4.sav"
e1w4 <- read.spss(file=raw_e1w4,
                  to.data.frame = T,
                  fileEncoding ="UTF-8")
View(e1w4)





raw_e1w5 <- "C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w5.sav"
e1w5 <- read.spss(file=raw_e1w5,
                  to.data.frame = T,
                  fileEncoding ="UTF-8")
View(e1w5)




raw_e1w6 <- "C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w6.sav"
e1w6 <- read.spss(file=raw_e1w6,
                  to.data.frame = T,
                  fileEncoding ="UTF-8")
View(e1w6)




raw_e1w7 <- "C:/R_Lecture/data/KCYPS2010_e1[SPSS]/KCYPS2010_e1w7.sav"
e1w7 <- read.spss(file=raw_e1w7,
                  to.data.frame = T,
                  fileEncoding ="UTF-8")
View(e1w7)

job = table(e1w7$JOB1Aw7)
print(job)

health = table(e1w7$PHY3Aw7)
print(health)

###<가족 관련 데이터>###
##가족 구성
fam1a = as.data.frame(e1w7$FAM1Aw7)
View(fam1a)


##부모 구성
fam1b = as.data.frame(e1w7$FAM1Bw7)
View(fam1b)

##다문화 가정여부
fam1c = as.data.frame(e1w7$FAM1Cw7)
View(fam1c)

##형제자매 유무여부
fam1d = as.data.frame(e1w7$FAM1Dw7)
View(fam1d)


#묶기 
family_data = cbind(fam1a,fam1b,fam1c,fam1d)
View(family_data)

#파일로 내보내기 
#.xlsx
write.xlsx(family_data,"C:/R_Lecture/data/family_data.xlsx")
#.txt
write.table(family_data,"C:/R_Lecture/data/family_data.txt")





###※ 학대 관련 지표 #####
#내가많이 아프면 적절한 치료를 받게 하신다 
fam3a04 = as.data.frame(e1w7$FAM3A04w7)
View(fam3a04)

#내가 무언가 잘못했을 때 정도 이상으로 심하게 혼내신다
fam3b01 = as.data.frame(e1w7$FAM3B01w7)
View(fam3b01)

#내가 잘못하면 무조건 때리려고 하신다 
fam3b02 = as.data.frame(e1w7$FAM3B02w7)
View(fam3b02)

#내 몸에 멍이 들거나 상처가 남을 정도로 부모님(보호자) 께서 나를 심하게 대한 적이 많다 
fam3b03 = as.data.frame(e1w7$FAM3B03w7)
View(fam3b03)

#나에게 심한 말이나 욕을 하신 적이 많다
fam3b04 = as.data.frame(e1w7$FAM3B04w7)
View(fam3b04)

#묶기 
children_abuse = cbind(fam3a04,fam3b01,fam3b02,fam3b03,fam3b04)
View(children_abuse)

#파일로 내보내기 
#.xlsx
write.xlsx(childre_abuse,"C:/R_Lecture/data/children.xlsx")
#.txt
write.table(childre_abuse,"C:/R_Lecture/data/children.txt")

#모은 코드를 다 뽑아보자 
preDF <- select(e1w7, ID,SURVEY1w7,PARENTw7,BRT1Aw7,BRT2Aw7,BRT2Bw7,ARA2Aw7,ARA2Bw7,HOUSEw7,HAK2Aw7,HAK2Bw7,JOB1Aw7,JOB1Bw7,JOB4Aw7,
       JOB4Bw7,
       INCOMEw7,
       INCOME1w7,
       PAR2w7,
       PHY1Aw7,
       PHY1Bw7,
       PHY3Aw7,
       PSY1A06w7,
       PSY1A07w7,
       PSY1B01w7,
       PSY1B02w7,
       PSY1B03w7,
       PSY1B04w7,
       PSY1B05w7,
       PSY1B06w7,
       PSY1D01w7,
       PSY1D02w7,
       PSY1D03w7,
       PSY1D04w7,
       PSY1D05w7,
       PSY1E01w7,
       PSY1E02w7,PSY1E03w7,PSY1E04w7,PSY1E05w7,PSY1E06w7,PSY1E07w7,PSY1E08w7,
       PSY1E09w7,PSY1E10w7,PSY1E03w7,PSY2A01w7,PSY2A02w7,PSY2A03w7,PSY2A04w7,
       PSY2A05w7,PSY2A06w7,PSY2A07w7,PSY2A08w7,PSY2A09w7,PSY2A10w7,
       PSY3B01w7,PSY3B02w7,PSY3B03w7,
       FAM1Aw7,FAM1Bw7,FAM1Cw7,FAM1Dw7,FAM3A04w7,FAM3B01w7,FAM3B02w7,FAM3B03w7,FAM3B04w7)

s_preDF <- subset(preDF, SURVEY1w7 == "조사성공")

abused_rate1 <- table(e1w7$FAM3A04w7)
abused_rate1

abused_rate2 <- table(e1w7$FAM3B01w7)
abused_rate3 <- table(e1w7$FAM3B02w7)
abused_rate4 <- table(e1w7$FAM3B03w7)
abused_rate5 <- table(e1w7$FAM3B04w7)
View(abused_rate2)
abused_rate3
abused_rate4
abused_rate5

abused_group1  <- subset(s_preDF, FAM3A04w7 == "전혀 그렇지 않다")
View(abused_group1)
abused_group2  <- subset(s_preDF, FAM3B01w7 == "매우 그렇다")
View(abused_group2)
abused_group3  <- subset(s_preDF, FAM3B02w7 == "매우 그렇다")
View(abused_group3)
abused_group4  <- subset(s_preDF, FAM3B03w7 == "매우 그렇다")
View(abused_group4)
abused_group5  <- subset(s_preDF, FAM3B04w7 == "매우 그렇다")
View(abused_group5)

View(s_preDF)

s_preDF$FAM3B01w7 <- ifelse(s_preDF$FAM3B01w7=="매우 그렇다",
                            4,
                            s_preDF$FAM3B01w7)
s_preDF$FAM3B01w7 <- ifelse(s_preDF$FAM3B01w7=="그런 편이다",
                            3,
                            s_preDF$FAM3B01w7)
s_preDF$FAM3B01w7 <- ifelse(s_preDF$FAM3B01w7=="그렇지 않은 편이다",
                            2,
                            s_preDF$FAM3B01w7)
s_preDF$FAM3B01w7 <- ifelse(s_preDF$FAM3B01w7=="전혀 그렇지 않다",
                            1,
                            s_preDF$FAM3B01w7)


s_preDF$FAM3B02w7 <- ifelse(s_preDF$FAM3B02w7=="매우 그렇다",
                            4,
                            s_preDF$FAM3B02w7)
s_preDF$FAM3B02w7 <- ifelse(s_preDF$FAM3B02w7=="그런 편이다",
                            3,
                            s_preDF$FAM3B02w7)
s_preDF$FAM3B02w7 <- ifelse(s_preDF$FAM3B02w7=="그렇지 않은 편이다",
                            2,
                            s_preDF$FAM3B02w7)
s_preDF$FAM3B02w7 <- ifelse(s_preDF$FAM3B02w7=="전혀 그렇지 않다",
                            1,
                            s_preDF$FAM3B02w7)




s_preDF$FAM3B03w7 <- ifelse(s_preDF$FAM3B03w7=="매우 그렇다",
                            4,
                            s_preDF$FAM3B03w7)
s_preDF$FAM3B03w7 <- ifelse(s_preDF$FAM3B03w7=="그런 편이다",
                            3,
                            s_preDF$FAM3B03w7)
s_preDF$FAM3B03w7 <- ifelse(s_preDF$FAM3B03w7=="그렇지 않은 편이다",
                            2,
                            s_preDF$FAM3B03w7)
s_preDF$FAM3B03w7 <- ifelse(s_preDF$FAM3B03w7=="전혀 그렇지 않다",
                            1,
                            s_preDF$FAM3B03w7)




s_preDF$FAM3B04w7 <- ifelse(s_preDF$FAM3B04w7=="매우 그렇다",
                            4,
                            s_preDF$FAM3B04w7)
s_preDF$FAM3B04w7 <- ifelse(s_preDF$FAM3B04w7=="그런 편이다",
                            3,
                            s_preDF$FAM3B04w7)
s_preDF$FAM3B04w7 <- ifelse(s_preDF$FAM3B04w7=="그렇지 않은 편이다",
                            2,
                            s_preDF$FAM3B04w7)
s_preDF$FAM3B04w7 <- ifelse(s_preDF$FAM3B04w7=="전혀 그렇지 않다",
                            1,
                            s_preDF$FAM3B04w7)





View(s_preDF)
table(select(s_preDF,FAM3B01w7,FAM3B02w7,FAM3B03w7 ,FAM3B04w7 ))
table(s_preDF$FAM3B01w7)
table(s_preDF$FAM3B02w7)
table(s_preDF$FAM3B03w7)
table(s_preDF$FAM3B04w7)
View(s_preDF$FAM3B01w7)


raw_e4w1 <- "C:/R_Lecture/data/KCYPS2010_e4[SPSS]/KCYPS2010_e4w1.sav"
e4w1 <- read.spss(file=raw_e4w1,
                  to.data.frame = T,
                  fileEncoding="UTF-8")
View(e4w1)





raw_e4w2 <- "C:/R_Lecture/data/KCYPS2010_e4[SPSS]/KCYPS2010_e4w2.sav"
e4w2 <- read.spss(file=raw_e4w2,
                  to.data.frame = T,
                  fileEncoding="UTF-8")
View(e4w2)






raw_e4w3 <- "C:/R_Lecture/data/KCYPS2010_e4[SPSS]/KCYPS2010_e4w3.sav"
e4w3 <- read.spss(file=raw_e4w3,
                  to.data.frame = T,
                  fileEncoding="UTF-8")
View(e4w3)






#raw_e4w4 <- "C:/R_Lecture/data/KCYPS2010_e4[SPSS]/KCYPS2010_e4w4.sav"
#e4w4 <- read.spss(file=raw_e4w4,
#                  to.data.frame = T,
#                  fileEncoding="UTF-8")
#View(e4w4)






raw_e4w5 <- "C:/R_Lecture/data/KCYPS2010_e4[SPSS]/KCYPS2010_e4w5.sav"
e4w5 <- read.spss(file=raw_e4w5,
                  to.data.frame = T,
                  fileEncoding="UTF-8")
View(e4w5)






raw_e4w6 <- "C:/R_Lecture/data/KCYPS2010_e4[SPSS]/KCYPS2010_e4w6.sav"
e4w6 <- read.spss(file=raw_e4w6,
                  to.data.frame = T,
                  fileEncoding="UTF-8")
View(e4w6)





