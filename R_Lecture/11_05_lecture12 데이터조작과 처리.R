#데이터 조작 이어서 (plyr, dplyr, reshape2, etc)
#: package 함수를 이용한 data frame조작 
#reshape2 package
#데이터 전처리(결측치 처리, 이상치, 극단치 )
#데이터 시각화(텍스트 분석 및 시각화, ggplot2, graphics)
#데이터 분석 
#프로젝트 => 3자(2주 프로젝트, 1주 GitHub)
##################################################

# 1. reshape2 package 
# 데이터의 형태를 바꿀 수 있다. 
# 가로로 되어 있는 데이터를 세로로 바꿀 수 있다. 
# →column으로 저장되어 있는 데이터를 row 형태로, 혹은 그 반대로 
# 엑셀 등에서의 피벗 테이블과 유사한 기능을 지원 
# 분석하기 편한 형태로 가공할 떄 사용하는 대표적인 package 
# 2가지 핵심적인 함수 존재 : melt, dcast

# 1) melt: column을 row형태로 바꾸어서 가로로 길 데이터를 세로로 길게 전환하는 함수 
# melt의 기본동작은 numeric을 포함하고 있는 모든 column을 row로 변환 
install.packages("reshape2")
library(reshape2)
#기본적으로  R에 내장하고 있는 data set 활용(airquality)
help(airquality)  #1973년 5~9월까지 뉴욕시 일별 오존량 측정내용 
ls(airquality)    #column명 확인 
head(airquality)  #상단 6개 내용 확인
str(airquality)   #데이터 셋 구조 확인  → 처음보는 자료확인 3대장  

df <- airquality  #원본데이터 훼손 방지를 위한 변수 선언 (153행, 6열)
melt(df)      #특별한 지정이 없으면 variable, value두 column으로변환 
nrow(melt(df))    # 153 * 6 = 918개 행으로 출력 
nrow(melt(df, na.rm=T)) #874, 결측치 제외 
melt(df, id.vars="Month") #Month 컬럼을 제외한 나머지 컬럼 융합 
                          #765행(153 * 5)
melt_df <- melt(df, id.vars=c("Month","Day"),
           measure.vars = "Ozone",
           variable.name ="Item",
           value.name = "Item_value") 
                #백터형태로도 지정가능 (153*4 = 612행)
                # Month, day제외하고 녹이고, ozone만 variable로 출력
                # variable은 Item으로, value는 Item-value로 이름 변경                 # →녹일 때 다양한 옵션 지정이 가능하다. 


# 2) dcast()(cast()) : 데이터 케스트, 다루는 자료형태가 df가 많으니 
# cast중 dcast형태를 자주 사용할 것(array일 경우 acast()) 
# row로 되어있는 데이터를 column 형태로 전환(melt 원상복귀 가능)
dcast(melt_df,
      formula = Month + Day ~...) 
                      #month와 day를 제외하고 column값으로 되돌림 
                      #오존 col이 뒤에 와 있는 것을 확인 
                      # → 식을 잘못 넣으면 잘못 복구할 수 있다.  
dcast(melt_df,
      formula=Month ~ Item,
      fun=mean,
      na.rm=T)    #집계함수에 대한 계산 결과를 df형태로 뽑을 수 있다. 




# 이해를 돕기위한 2개의 sample파일 활용 
# melt_mpg.csv,   sample_mpg.csv
sample_mpg <- read.csv(file = "C:/Users/student/Desktop/R강의 일람/191105 제 12강_/sample_mpg.csv", 
                       sep=",", header=T, fileEncoding="UTF-8")
class(sample_mpg)
sample_mpg   # 4행짜리 데이터 프레임 

melt_sample_mpg <- read.csv(file = "C:/Users/student/Desktop/R강의 일람/191105 제 12강_/melt_mpg.csv",
                     sep=",", header = T, fileEncoding="UTF-8")
melt_sample_mpg # 12행짜리 데이터 프레임(섞여 들어감)
#variable 이란 컬럼을 통해 기존의 cty, hwy, displ을 row 형태로 받음. 


#ex/ 상기 두개의 data frame 에서 평균 도시 연비 산출 
# 1) sample_mpg 
library(ggplot2)
library(stringr)
library(dplyr)
mean(sample_mpg$cty)

# 2) melt_sample_mpg 
melt_sample_mpg %>% 
               filter(variable == "cty") %>% ##cty만 걸러내기 
               summarise(avg_rate = mean(value))
                #   avg_rate
                #1    18.25


# ex2/ 두 개의 data frame에 대해서 평균 연비를 구해서 표시 
# (평균 연비 = 도시연비와 고속도로 연비의 평균으로 계산)
# 1) sample_mpg 
sample_mpg %>% 
          mutate(avg_rate = (cty+hwy)/2)
# 2) melt_sample_mpg
# reshape 2 package를 사용할 것 
# melt_sample_mpg를 원상복구시키자 
dcast(melt_sample_mpg, 
      formula= 
        manufacturer + model + class +trans +year ~ variable,
        value.var = "value")
       #이것들 기본으로 잡고 variable 조직해라 

# ※제공된 파일을 이용한 melt형식의 data frame은 원상복귀가 어려움 
# (duplicate 발생) 

# melt()된 데이터를 생성해 보자. 
df <- as.data.frame(mpg)    #table.df 를 df로 변환 
head(df)
audi_df <- df %>% 
           filter(manufacturer == "audi",
                  model == "a4")

audi_df

melt_audi_df <- melt(audi_df, id.vars = c("manufacturer",
                                          "model",
                                          "year",
                                          "cyl",
                                          "trans"),
                            measure.vars=c("displ",
                                           "cty",
                                           "hwy"))
melt_audi_df

# 다시 melt 분해하기 
dcast(melt_audi_df, 
      formula = 
        manufacturer + model + year + cyl + trans ~ variables, 
        value.var = "value")                     

########################################

# 2. 데이터 정제 
# 우리가 얻는 raw data는 항상 오류를 포함하고 있다.
# 분석하기 전에 데이터 오류를 수정해야한다. 

# - 결측치 처리 (NA)
# 결측치는 누락된 값을 지칭, 비어있는 값을 지칭 
# 결측치가 있으면 함수 적용이 잘못될 수 있다. 
# 분석 자체가 잘못될 수 있다. 
  
# 결측치를 찾아야 한다. 
  # 간단하게 결측치가 있는 data set하나 작성 

df<- data.frame(id=c(1,2,NA,4,5,NA,7),
                score = c(20,30,90,NA,60,NA, 99))
df

sum(is.na(df)) #계산을 통해서 NA개수를 확인

table(is.na(df$id))  #빈도를 이용해서 결측치 확인 

# 결측치를 제거하려 해요 
# → data frame이기 때문에 결측치자 들어가 있는 행을 삭제 
# dplyr을 이용하면 가능하다 

df %>% filter(!is.na(id),
              !is.na(score))
#또는 
na.omit(df)   # 결측치를 다 찾아서 해당 행(record)을 삭제 
# 단, 행을 지우는 행위는 그다지 옳지 않은 행위 
# 행을 지우게 되면 결측치 뿐만 아니라 멀쩡한 정상데이터 줄도 같이 삭제되기 때문에 분석시 문제가 될 수 있다. 

#ex/ score안에 있는 결측치(NA)값을 다른값으로 대치해서 score이 평균산출 
#score 열에 대해 NA를 제외한 평균을 구해서 그 값으로 score의 NA를 대체    
df$score = ifelse(is.na(df$score),
                  mean(df$score, na.rm=T),
                  df$score)
df
###########

# - 이상치, 극단치(outlier) 처리 
# 이상치 :존재 할 수 없는 값이 포함된 경우 이상치라 지칭 
# 극단치 : 이상치 중에서도 자료적으로는 문제가 없으나 정상적인 
#          범주에서 너무 벗어난 값이 들어온 경우 
#  (예 : 성인 남성의 몸무게가 5kg 으로 산출될 때)

# 1) 이상치 처리 (in 연산자 활용 )
# ex1/ 이상치가 존재하면 결측치로 바꿔주자 
df<- data.frame(id=c(1,2,NA,4,5,NA,7),
                score = c(20,30,90,NA,60,NA, 99),
                gender=c("M","F","M","F","M","F","^^"),
                stringsAsFactors = F)
                #gender col에 이상치 식별 
                #범주형 예외처리를 안해주면 gender의 경우 
                #default 로 범주로 잡혀버림 
df
df$gender = ifelse(df$gender %in% c("M","F"),
                   df$gender,
                   NA)
df

# 2) 극단치 처리 
# 극단치 : 이상치 중에 값이 극단적으로 크거나 작은 값을 의미 
# 극단치 처리에는 기준을 정해야 한다. 
# 극단치를 분류하는 기준은 IQR을 이용한다.(interqualtile range)
#  IQR : 데이터 중간 위쪽에 mid point
#         - 데이터 중간 아래쪽의 mid point
# 4분위부터 알아보도록 한다. 

# 극단치를 알아보기 위한 sample 작성 
data = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,22) 
        #등차수열에 갑자기 22등장

# 기존 통계값을 이용해서 사분위 값을 알아본다. 
summary(data) # 1사분위: 4.5, 중간값:8 ,3사분위: 11.5, 
lower_data = c(1,2,3,4,5,6,7,8)
upper_data = c(8,9,10,11,12,13,14,22) #중간값을 기준으로 나누다. 
iqr_value = median(upper_data) - median(lower_data) # IQR : 7

# 극단치를 결정하는 기준값 : IQR * 1.5
deter_value = iqr_value * 1.5  #10.5

# 3사분위 값 + 기준값 
#   11.500   +  10.5  = 22 (초과하지는 않음 → 제외되지는 않는다)


# 그래프를 이용하면 극단치를 눈으로 확인 
boxplot(data)  #plots 창에 캔들차트 출력 

# 만약 극단치가 22보다 크다면? (=22.1)
data = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,22.1) 
lower_data = c(1,2,3,4,5,6,7,8)
upper_data = c(8,9,10,11,12,13,14,22.1)
iqr_value = median(upper_data) - median(lower_data)
deter_value = iqr_value * 1.5
boxplot(data) #극단치가 동그라미로 표시 
boxplot(data)$stats   #     [,1]
                      #[1,]  1.0  최소값
                      #[2,]  4.5  1사분위 값
                      #[3,]  8.0  중간값
                      #[4,] 11.5  3사분위 값
                      #[5,] 14.0  최대값
##########################################################
######################################################################즐거운 연습문제 타임 (연습문제.txt) 
# data : excel 파일(exec1105.xlsx)

# 만약 결측값이 존재하면 결측값은 결측값을 제외한 
# 해당 과목의 평균을 이용합니다.

# 만약 극단치가 존재하면 하위 극단치는 극단치값을 제외한
# 해당 과목의 1사분위 값을 이용하고 상위 극단치는
# 해당 과목의 3사분위 값을 이용합니다.

# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?
# 답: 김연아 81.111
# 2. 남자와 여자의 전체 평균은 각각 얼마인가요?
# 답: 남자:40.7
#     여자:54.6
# 3. 수학성적이 전체 수학 성적 평균보다 높은 남성은 누구이며
#    수학성적은 얼마인가요?
# 답: 이순신:68
#     강감찬:78.66667
library(xlsx)
sheet1 <-read.xlsx(file.choose(), sheetIndex = 1, header= F,  encoding="UTF-8")

sheet2 <-read.xlsx(file.choose(), sheetIndex = 2, header= F,
encoding="UTF-8")

sheet1

View(sheet1)
t_exer<-dcast(sheet1, 
              formula = X1 ~...,
              )         

t_exer$math = ifelse(is.na(t_exer$math),
                  mean(t_exer$math, na.rm=T),
                  t_exer$math)
summary(t_exer) 
# 풀이
# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?
