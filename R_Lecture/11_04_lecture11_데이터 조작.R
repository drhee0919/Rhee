## 3주차 예정사항 
#-데이터 조작, 데이터 정제, 데이터 전처리 
#-시각화에 대한 내용(ggplot2)
############################################

#'데이터 조작 및 정'제에 앞서..(+복습)
# : mpg data set을 이용해서 데이터 조작, 정제에 대한 내용 학습 
# 'mpg data set'이란? : 1999~2008까지 38개의 인기있는 차종에 대한 자동차 연비에 관하여 정리해놓은 데이터 셋 

# mpg data set을 이용하기 위해서 package를 설치해야 함.(외부패키지)
install.packages("ggplot2")
library(ggplot2)
View(mpg)
class(mpg) # [1] "tbl_df"     "tbl"        "data.frame", 테이블 DF 
str(mpg) # Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	234 obs. of  11 variables:

# mpg는 table data frame의 형태 (→즉 출력을 용이하게 하기 위한 형태)
# console 크기에 맞추어서 data frame을 출력 
# 용도에 따라 원래 우리가 알고 있는 data frame형태로 변형해서 사용 

df <- as.data.frame(mpg)  #data frame으로 변환 
View(df)
class(df) # [1] "data.frame"

# 사용할 data frame을 준비했어요 
# data frame의 column 명을 알아보자. 
ls(df)  #컬럼명 character형태로 출력(알파뱃 오름차순 정렬) 
        #컬럼을 순서대로 보려면 str사용 

# mpg에 대한 document를 확인해서 column 에 대한 의미를 먼저 파악 
# https://www.rdocumentation.org/ 여기에서도 확인 가능 
help(mpg)
head(df,3)    #보고싶은 개수를 지정할 수 있어요 
tail(df,3)    #(default는 6개)
dim(df)       #차원, 2차원일 경우 몇개의 행과 몇개의 열인지 알려줌 
nrow(df)      #행의 개수 
ncol(df)      #열의 개수 
length(df)    #원래 length()원소의 개수를 구하는 함수인데, 
              #df에 적용되면 column의 개수를 구한다. 
str(df)       #자료구조부터 하여 행의 개수, 열의 개수, 컬럼명,
              #데이터 타입, ... (df의 종합적인 정보)
summary(df)   #기본적 통계치출력(최소,1분위,중간값,평균,3분위,최대) 
              #문자열을 출력하지 못하고character라 명시 
rev(df)         #vector에 대해서 데이터를 역순으로 변환하는 기능 
##############################
# - 데이터 조작 (dplyr() : 디플라이알 사용)
# ※plyr과 동시선언 가급적 지양 (필요한 패키지만 불러오기:충돌방지)
# ※ dplyr package 
# 속도에 강점 : C++로 구현되어 있따. 
# chaining 이 가능하다 (%>%)
# dplyr이 제공하는 여러 함수를 이용해서 우리가 원하는 데이터로 추출 
library(dplyr)

# 1) tbl_df()
df <- tbl_df(df) # 다시 table df 형태로 바꾸는 용도 
                 # 출력을 위한 용도로 많이 사용하게 됨 
df <- as.data.frame(df) #처리 과정에선 일반적 df를 많이 사용 

# 2) rename() : column의 이름을 변경 가능 
# rename(df, 새로운 컬럼 = 원래 컬럼)
# raw data를 이용할 경우 column 명이 없을 때, column명을 새로 명시해서 사용해야 한다. 
# 모두 소문자, 또는 대문자로 변경해서 사용하면 편해요 
# ex/ df의 컬럼명을 모두 소문자 혹은 대문자로 변경 
name(df) = toupper(names(df)) #한방에 
# rename()은 data frame을 리턴 
new_df<-rename(df, MODEL = model)     #개별로 
new_df                      # model → MODEL여부 확인   

# 3) 조건을 만족하는 행을 추출하는 함수 
# filter(data frame, 
#        조건1, 조건2, 조건3, ...     )
#ex1/ mpg에서 2008년도에 생산된 차량이 몇개 있는지 추출
filter(mpg, 
       year == 2008)    #117개 case 출력 
#ex2/모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량의 model명을 출력하세요 
mean(mpg$cty)
e_car<-filter(mpg, 
              mpg$cty > 16.85897 )
View(e_car)
count_temp <- e_car$model
factor(count_temp)
#또는 
avg_cty <- mean(df$cty, na.rm=T); avg_cty #na.rm: 결측치 제거 
e_car <- filter(df, 
                cty > avg_cty)$model
unique(e_car) #중복치 제거 

#ex3/ 고속도로 연비가 상위 75% 이상인 차량을 제조 하는 제조사는 몇개인지 추출하세요 
summary(df)
help(quantile)
quantile(df$hwy, 0.75) # 3분위 값 확인 (27)
third_quar <- filter(df,
                     hwy >= 27 )$manufacturer
#또는
third_quar <- filter(df,
                    hwy >= summary(df$hwy)[5])$manufacturer
                      #summary 통계치에서 3분위 순서 찾기
unique(third_quar)

#ex4/ 오토 차량 중 배기량이 2500cc이상인 차량의 수는 몇개인가? 
# hint : 문자열 처리 선수 필요 
library(stringr)
View(df)
df_c<-filter(df,
             displ>=2.5,
             str_detect(trans,"auto"))

nrow(df_c)   # 125가지 


# 4) arrange() : 정렬하는 함수 (복습!) 
# arrange(data frame, 
#         column1, 
#         desc(column2)) : column1을 기준으로 column2 내림차순 정렬 
# ex 5/ 상기ex2에 대해서 모델명을 오름차순으로 정렬하세요 
avg_cty <- mean(df$cty, na.rm=T); avg_cty #na.rm: 결측치 제거 
e_car <- filter(df, 
                cty > avg_cty)$model 
e_car <-as.data.frame(e_car)
arranged_car <- arrange(e_car,
                        e_car,
                        e_car)
unique(arranged_car)

#또는(chaining 활용)
df %>% filter(cty > mean(cty)) %>% 
       select(model) %>% 
       unique() %>%
       arrange(model)

# 5) select() : data frame에서 원하는 column 만 추출하는 함수 
# select(data frame, column1, column2, ..) 여러개의 컬럼 추출가능 



# 6) mutate() : 새로운 column을 생성하는 함수  
# mutate(data frame, 
#        컬럼명1 = 수식1,
#        컬럼명2 = 수식2)
# ex6/ 도시연비와 고속도로 연비를 합쳐서 평균 연비 column 작성 
# mutate 함수 미사용(base기능으로만)
df$mean_rate  = (df$cty + df$hwy) /2 
head(df)
# mutate함수 사용 
new_df <- df %>% mutate(mean_rate = (cty+hwy)/2)
# 도심과 고속도로 연비를 백터로 받아서 평균을 구한다. 
head(new_df)



#7) summarise(): 통계량을 구해서 새로운 컬럼으로 생성하는 함수 
# ex7/ model명이 a4이고 배기량이 2000c 이상인 차들에 대해 평균 연비를 계산하시오(전체 평균 연비 계산). 
#summarize() 미사용 
  result <- df %>% 
            filter(model == "a4",
                   displ >= 2.0) %>%
            mutate(avg_rate = (cty+hwy)/2) %>% 
            select(avg_rate)

mean(result$avg_rate)

# summarise() 사용
df %>% filter(model == "a4",
              displ >= 2.0) %>%
              summarise(avg_rate = mean(c(cty,hwy)))

#8) group_by() : 범주형 변수에 대한 grouping 
# ex8/ 제조사별 그룹을 지어 평균 연비 나타내기 
df %>% filter(displ >= 2.0) %>%
       group_by(manufacturer) %>%
       summarise(avg_rate = mean(c(cty,hwy)))

#9) left_join(), right_join(), inner_join(), outer_join() 
# Lecture 10 참고 

############################
# 연습문제 
# mpg data set에 대해서 다음의 내용을 수행하세요
#Q1. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.
df_4 <- filter(df,
               displ <= 4)$hwy
df_5 <- filter(df,
               displ >= 5)$hwy
mean(df_4) < mean(df_5)  #false
mean(df_4) > mean(df_5)  #TRUE 


#Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 평균적으로 더 높은지 확인하세요.
df_cty<- group_by(df,manufacturer) %>%
         summarise(avg_rate = mean(cty))  
df_cty #audi==17.6, toyota==18.5


#Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.
df_hwy<- group_by(df,manufacturer) %>%
         summarise(avg_rate = mean(hwy))  
df_hwy
chevorlet <- df_hwy[2,]; chevorlet
ford <- df_hwy[4,]; ford
honda <- df_hwy[5,]; honda

#3개사 고속도로 연비의 평균 
mean_hwy <- mean(as.numeric(c(chevorlet[,2],ford[,2],honda[,2])))
mean_hwy
#3개사 '전차종'에 대한 연비의 평균 
mean_hwy2<- filter(df, manufacturer == "chevorlet"
                   | manufacturer =="ford" 
                   | manufacturer == "honda") %>%
            summarise(avg_rate = mean(hwy)) 
mean_hwy2


#Q4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.
df_audi<-filter(df,
                manufacturer == "audi")
audi_hwyr<-arrange(df_audi,
                   model,
                   desc(hwy))
head(audi_hwyr,5)


#Q5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.
suv_eff <- group_by(df, manufacturer) %>% 
           filter(class == "suv") %>%
           summarise(avg_rate = mean(c(cty,hwy)))
e_rank <- as.data.frame(e_rank)
e_rank <- arrange(suv_eff, 
                  desc(avg_rate))
head(e_rank,5)


#Q6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.
class_cty <- group_by(df, class) %>% 
             summarise(avg_cty = mean(cty))
arrange(class_cty,
        desc(avg_cty))



#Q7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.
hwy_rank <- group_by(df, manufacturer) %>% 
            summarise(avg_hwy = mean(hwy))
top_hwy <- arrange(hwy_rank,
                   desc(avg_hwy)
                  )
head(top_hwy,3)                    

#Q8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요
compacts <- filter(df, 
                   class == "compact" )
nrow(compacts)
c_Compacts <- group_by(compacts, manufacturer) %>%
              count(class=='compact')%>%
              select(manufacturer, n)       
arrange(c_Compacts,
        desc(n))
