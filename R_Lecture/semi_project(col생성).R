library(foreign)
library(ggplot2)
library(dplyr)
library(xlsx)
df <- read.csv(file="C:/R_Lecture/data/child_abuse.csv",
               fileEncoding = "UTF-8")

View(df)

df <- subset(df, SURVEY1w7 == "조사성공")
View(df)    

df$FAM3B01w7 <- ifelse(df$FAM3B01w7 == "매우 그렇다",
                       4,
                       ifelse(df$FAM3B01w7 == "그런 편이다",
                              3,
                              ifelse(df$FAM3B01w7 == "그렇지 않은 편이다",
                                     2,
                                     1)))
df$FAM3B02w7 <- ifelse(df$FAM3B02w7 == "매우 그렇다",
                       4,
                       ifelse(df$FAM3B02w7 == "그런 편이다",
                              3,
                              ifelse(df$FAM3B02w7 == "그렇지 않은 편이다",
                                     2,
                                     1)))
df$FAM3B03w7 <- ifelse(df$FAM3B03w7 == "매우 그렇다",
                       4,
                       ifelse(df$FAM3B03w7 == "그런 편이다",
                              3,
                              ifelse(df$FAM3B03w7 == "그렇지 않은 편이다",
                                     2,
                                     1)))
df$FAM3B04w7 <- ifelse(df$FAM3B04w7 == "매우 그렇다",
                       4,
                       ifelse(df$FAM3B04w7 == "그런 편이다",
                              3,
                              ifelse(df$FAM3B04w7 == "그렇지 않은 편이다",
                                     2,
                                     1)))

df <- df%>%
  mutate(abuse_sum=df$FAM3B01w7+df$FAM3B02w7+df$FAM3B03w7+df$FAM3B04w7)
df$abuse_sum



table(df$INCOMEw7)
View(df$PSY2A01w7)




#write.csv(df,
#         "C:/R_Lecture/data/child_abuse2.csv",
#          fileEncoding="UTF-8")


#g<-ggplot(data=df,  #데이터는 df를 이용할거야
#       aes(x=abuse_sum)+ 
#  geom_bar()
#g

#table(df$PSY2A01w7)
#table(df$PSY1E04w7)




## 하나 더 만들자 (삶의 만족도)

df$PSY3B01w7 <- ifelse(df$PSY3B01w7 =="매우 그렇다",
                       4,
                       ifelse(df$PSY3B01w7 =="그런 편이다",
                              3,
                              ifelse(df$PSY3B01w7 == "그렇지 않은 편이다",
                                     2,
                                     1)))
df$PSY3B02w7 <- ifelse(df$PSY3B02w7 == "매우 그렇다",
                       4,
                       ifelse(df$PSY3B02w7 == "그런 편이다",
                              3,
                              ifelse(df$PSY3B02w7 == "그렇지 않은 편이다",
                                     2,
                                     1)))
df$PSY3B03w7 <- ifelse(df$PSY3B03w7 == "매우 그렇다",
                       4,
                       ifelse(df$PSY3B03w7 == "그런 편이다",
                              3,
                              ifelse(df$PSY3B03w7 == "그렇지 않은 편이다",
                                     2,
                                     1)))



df <- df%>%
  mutate(satisfaction=df$PSY3B01w7+df$PSY3B02w7+df$PSY3B03w7)
View(df$satisfaction)




write.csv(df,
         "C:/R_Lecture/data/child_abuse3.csv",
          fileEncoding="UTF-8")
