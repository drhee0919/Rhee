# 데이터 조작(plyr, dplyr, reshape2, etc)
# package 함수를 이용한 data frame 조작
# 데이터 전처리 


# 데이터 분석업무에서 raw data를 얻은 다음 
# 신러닝 모델링을 위해서 또는 시각화를 위해서 raw data를 적절한 형태로 변형 
# 데이터 변환, 필터링, 전처리 작업이 필요해요 
# 이런 작업(data 조작) 에 특화된 package 들이 존재해요 
#  ex/ plyr → plier + R (R을 사용하는 도구 비스무리한 의미) → 패키지를 구현한 언어 R 
#  dplyer → data frame + pliers + R (디플라이알) 
# vector나 data frame 에 적용할 수 있는 기본함수들에 대해 배울 것  

#실습할 데이터가 필요하다. 
#대표적으로 iris(아이리스, 붓꽃 종류) → R에 내장되어 있다. 
View(iris) 
#iris : 3가지 붓꽃종에 대한 측정 정보 df 출력 
# 붓꽆이 종류와 크기에 대해 측정한 데이터 
# 통계학자 피셔라는 사람이 측정해서 제공 
# 컬럼
# Species : 종(3가지)
# Sepal.length : 꽃받침의 길이
# Sepal.width : 꽃받침의 너비 
# Petal.Length : 꽃잎의 길이
# Petal.width : 꽃잎의 너비

# 기본함수 
# 1. head() : 데이터셋의 앞에서부터 6개의 데이터를 추출해요 
#             데이터 프레임이 아닌 자료구조에서도 적용이 된다. 
#             help 참조 
head(iris,3); 
var1 = c(1,2,3,4,5,6,7,8)
head(var1)
help(head)
# 2. tail() : 데이터 셋의 뒤에서부터 6개의 데이터를 추출한다. 
#             데이터 프레임이 아닌 경우 적용이 되요
tail(iris,n=3)
# 3. View() : View 창에 데이터를 출력하는 함수 
#             필터를 사용해서 분포확인, 특정데이터만 확인 가능 
# 4. Dim() : 차원을 구하는 함수. 일반적으로 df에 적용이 되었을때 
#            행과 열의 개수를 알려준다. 
#            선형자료구조(vector,list)에서는 NULL을 출력
#            2차원 이상이 자료구조에만 쓰임.
dim(iris)
dim(var1)
# 5. nrow() : df의 행의 개수를 알려줌 
# 6. ncol() : df의 열이 개수를 알려줌 
# 7. str()  : df에 대한 일반적인 정보를 추출 
str(iris)
# 8. summary() : df의 요약 통계량을 보여준다. 
#                최대 최소값, 사분위, 평균(mean), 중간값(Median) 
summary(iris)
# 9. ls() :  df의 column명을 vector로 추출, 오름차순으로 정렬
ls(iris)
#10. rev() : reverse, 선형 자료구조의 데이터 순서를 거꾸로 만든다. 
rev(iris)
# 11. length() : 길이를 구하는 함수, df는 column의 개수를 출력 
#                ※matrix 의 경우에는 원소의 개수를 출력한다. 
length(iris)

###############################
# 1. plyr package 사용해보기 → dplyr (개량형 package)
install.packages("plyr")
library(plyr)
require(plyr) # library(plyr) 

# 1) key값을 이용해서 두개의 data frame을 합침 (세로방향, 열방향)
#     → java 에서 join 과 유사(join 유형 확인)
#       R에서는 기본 join 방식은 left 로 잡음
#       DBMA 에서는 inner join 이 기본 방식 
x = data.frame(id=c(1,2,3,4,5),
               height=c(150,190,170,188,167))
y = data.frame(id=c(1,2,3,6),
               weight=c(50,100,80,78))
join(x,y,by="id",type="inner")
join(x,y,by="id",type="left") #default 
join(x,y,by="id",type="right")
join(x,y,by="id",type="full")

# key를 1개 이용해서 결합하는건 상기사항에 해봄 
# key를 2개 이상 이용해서 결합하는건? 

x = data.frame(id=c(1,2,3,4,5),
               gender=c("M","F","M","F","M"),
               height=c(150,190,170,188,167))

y = data.frame(id=c(1,2,3,6),
               gender=c("F","F","M","F"),
               weight=c(50,100,80,78))

join(x,y,by=c("id","gender"),type="inner")

# ※ dplyr에서는 join() →  left_join() 으로 함수선에서 구분가능

# 2) 범주형 변수를 이용해서 그룹별 통계량 구하기 
# IRIS에서는 범주가 3개가 있다.(각 범주별 평균, 분산 통계량 산출가능)
str(iris)   
unique(iris) #중복치를 배제하고 출력 
unique(iris$Species) # $를 이용하여 특정 column 내 산출로 설정가능 

# 예제1 : iris의 종별 꽃잎 길이의 평균을 구하세요 
# tapply(대상 column, 범주형 column, 적용할 함수)
# tapply는 한번에 1개의 통계만 구할 수 있다 .
tapply(iris$Petal.Length,
       iris$Species,
       FUN=mean)
# 예제2 : iris의 종별 꽃잎 길이의 최대값을 구하세요 
tapply(iris$Petal.Length,
       iris$Species,
       FUN=max)
# 예제3 :  iris의 종별 꽃잎 길이의 평균과 표준편차를 구하세요 
# ddply() : 한번에 여러개의 통계치를 구할 수 있다. 
df<- ddply(iris,
           .(Species),
            summarise,
            avg=mean(Petal.Length),
            sd=sd(Petal.Length))
class(df)
View(df)
###################################
## 2. dplyr 사용하기 
install.packages("dplyr")
library(dplyr)
#plyr에서는 join()과 통계값을 구하는 함수 '2개' 만 알아두면 된다! 
#실제론 data frame을 핸들링 할때는 plyr을 개량한 dplyr을 이용 
#dplyr은 C++로 구현되었기 때문에 속도가 빠르다 
#dplyr은 코딩시 chaining을 사용할 수 있다. 

#ex/ 기존방법 
var1 <- c(1,2,3,4,5) # 백터생성
var2 <- var1 *2 
var3 <- var2 +5 
# chaining (연속적인 기법)
#var1 <- c(1,2,3,4,5) %>% *2 %>% +5 (이런식으로)

# -dplyr의 주요 함수들 
#1) tbl_df() : 현재 console크기에 맞추어 df을 추출하라는 함수 
iris # 그냥 iris출력, 글자크기가 크다면 table이 두줄로 나뉜다. 
     # (한번에 출력못함) 
tbl_df(iris) # 콘솔에서 확인할 수 있을 정도로만 보여줌(나머지 주석)

#2) rename():컬럼명을 쉽게 바꿀 수 있다. 
#   rename(data frame,
#           바꿀컬럼명1 = 이전컬럼명1, 
#           바꿀컬럼명2 = 이전컬럼명2, ...)
# column명을 수정한 새로운 data frame이 리턴 
# 기존 df이 바뀌는 것이 아닌 새롭게 df가 만들어지는 것 
# 여기서부터는 iris가 아닌 다른 데이터 샘플 사용 
# \\M1604INS 에서 '2016 2017 이용건수 및 이용금액.xlsx' 다운
install.packages("xlsx")
library(xlsx)

excel <- read.xlsx(file.choose(),
                   sheetIndex = 1,
                   encoding = "UTF-8")


str(excel)
ls(excel)
View(excel)
# 제공된excel을 읽어들여서 data frame을 생성한 후 column명 확인 
# AMT : 2017년도 이용금액
# Y17_CNT : 2017년도 이용횟수 
df <- rename(excel, 
             CNT17 = Y17_CNT,
             CNT16 = Y16_CNT)
df #변경확인 

# 3)filter() 함수
#하나의 데이터 프레임에서 하나 이상의 조건을 이용해서 데이터 추출
#(가장 많이 쓰는 기능 중 하나 )
#filter(data frame, 
#        조건1, 조건2, ...)
#예제1) '2016 2017 이용건수 및 이용금액.xlsx' 에서 성별이 남자만 뽑아내기 
excel
filter(excel,
       SEX == "M",
       AREA == "서울") #또는
filter(excel, SEX == "M" & AREA == "서울")

#예제2) 모든 사람들 중에 지역이 서울 혹은 경기인 남성들 중 40살 이상의 사람들의 정보를 출력하세요 
filter(excel, 
       AREA == "서울" | AREA == "경기",
       SEX == "M",AGE > 40)

#예제3) 지역이 서울 or 경기 or 제주인 남성들 중 40살 이상 출력 
filter(excel,
       AREA %in%c("서울","경기","제주"),
       SEX =="M",
       AGE >= 40)

# 4) arrange() 함수 
# 특정 데이터 프레임을 어떤 column을 기준으로 정렬할 것인지 지정 
# arrange(data frame, 
#         column1, column2, ...)
# 여러개의 column이 기준이 되는 것이 아닌 맨앞이 기준, 
# 다만 동률데이터가 계속 나올 것을 대비해 우선순위 부여 
# 정렬의 기준은 오름차순 정렬(작은게 위에, ex/ 금액이 작은거부터)
# 만약 내림차순으로 정렬하려면 desc(column1), ... 처럼 표기 

#예제4) '서울'에 살고 '남성'이면서 '2017년도 처리금액'이 40만원 이상인 사람을 '나이가 많은 순'으로 출력

df <- filter(excel, 
             AREA == "서울",
             SEX == "M",
             AMT17 >= 400000) #일단 필터로 걸러내고 
    
df2 <- arrange(df,
               desc(AGE))    #arrange 함수로 정렬 
df2

#또는 (chaining 사용)
df <- filter(excel, 
             AREA == "서울",
             SEX == "M",
             AMT17 >= 400000) %>%
  arrange(desc(AGE))        #chaining 기호는 사용해서 앞의 df를  
                            #받아옴 
df

# 5) select()함수 
# : 추출하길 원하는 column을 지정해서 해당 column만 추출할 수 있다. 
# select(data frame, column1, column2 ...)
#예제5) '서울'에 살고 '남성'이면서 '2017년도 처리금액'이 40만원 이상인 사람을 '나이가 많은 순'으로 'ID' 와 나이, 그리고 2017년도 처리 건수만 출력하세요.(Chaining 포함)
df <- filter(excel, 
             AREA == "서울",
             SEX == "M",
             AMT17 >= 400000) %>%
  arrange(desc(AGE)) %>% 
  select("ID","AGE","Y17_CNT")
df
# 범위를 잡아도 무방하다 
df <- filter(excel, 
             AREA == "서울",
             SEX == "M",
             AMT17 >= 400000) %>%
  arrange(desc(AGE)) %>% 
  select("ID:AGE","Y17_CNT") #아이디부터 나이까지 
df
# 필요한 것만 빼도 된다. 
df <- filter(excel, 
             AREA == "서울",
             SEX == "M",
             AMT17 >= 400000) %>%
  arrange(desc(AGE)) %>% 
  select(-SEX)                #성별 column 제외 

df


# 6) 새로운 column을 생성하기.((1)기본기능, (2)dplyr함수 mutate())
# 3항 연산자 ifelse()로 조건을 동반할 수 있다.
# 예제 6) 17년도 500000만원 이상 쓴사람 VIP 지정(아닌사람 NORMAL)
excel$GRADE = ifelse(excel$AMT17 >= 500000,
                     "VIP",
                     "NORMAL")    #GRADE라는 이름의 column 생성 
excel

# dplyr 사용: mutate()함수 
# mutate(data frame, 
#        컬럼명1 = 수식1,
#        컬럼명2 = 수식2)
# 예제 7) 경기도 사는 여자를 기준으로 17년도 처리금액을 이용하여 처리금액의 10%를 가산한 값으로 새로운 컬럼 AMT17_REAL을 만들고 AMT17_REAL이 45만원 이상인 경우 VIP 칼럼을 만들어서 TRUE,아니면 FALSE 생성 
df <-  filter(excel, 
              AREA == "경기" & SEX == "F") %>% #조건부터 받고 
       mutate(AMT17_REAL = AMT17 *1.1, 
              VIP =ifelse(AMT17_REAL>=450000, #칼럼 생성하기 
                          TRUE,FALSE))
df

# 7) group_by() & summaries()
# 그룹별로 그룹화 및 통계 처리 
# 예제8) 
df <- filter(excel, 
             AREA == "서울" & AGE > 30) %>%
      group_by(SEX) %>% 
      summarise(sum=sum(AMT17), cnt=n())

df
sum
help(n)
# +추가예제 
# 예제9) plyr package의  join 함수가 
# 각 기능별로 독립적인 함수로 제공된다. 
left_join()
right_join()
inner_join()
full_join()
# 예제 10) bind_rows(df1, df2) : 두개의 df 칼럼이 같아야 붙는다. 
df1 <- data.frame(x=c("a","b","c"))
df1
df2 <- data.frame(x=c("d","e","f"))
df2
bind_rows(df1,df2)
df3 <- data.frame(y=c("d","e","f"))
bind_rows(df1,df3) # 붙으나 매칭이 없는 부분은 결측이 생긴다 
########################################################
# 연습문제를 풀어보아요 
# 연습문제 1~6.
# MovieLens Data set을 이용해서 처리해 보자 
#: Minnesota 대학에서 영화에 대한 평점 정보를 기록해 놓은 데이터 
# 평점은 1점 ~5점(5점이 최대)
# 사람이 한 두 사람이 아니기 때문에 영화도 굉장히 많다. 
#( 한 사람이 여러 영화를 평가할 수 도 있다. )
# https://grouplens.org/datasets/movielens/

# 데이터를 받았으면 데이터의 구조 확인
# 컬럼의 의미를 파악 

#1. 사용자가 평가한 모든 영화의 전체 평균 평점 
r_List <- read.csv(file.choose(),
                    encoding = "UTF-8")
summary(r_List) #3.502 확인 또는 
rateMean <-mean(r_List$rating)
rateMean # [1] 3.501557

#2. 각 사용자별 평균 평점 
userMean <- tapply(r_List$rating,
                   r_List$userId,
                   FUN = mean)
View(userMean)

#3. 각 영화별 평균 평점 
movieMean <- tapply(r_List$rating,
                    userMean,
                    FUN = mean) 
u_movieMean<-unique(movieMean)                    
View(movieMean)
View(u_movieMean)

#4. 평균 평점이 가장 높은 영화의 제목은 내림차순으로 정렬해서 출력
#   (동률이 있는 경우 모두 출력)

avg_mean <- max(movieMean) 
View(avg_mean)
df2 <- arrange(df,
               desc())    #arrange 함수로 정렬

#5. comedy 영화 중 가장 평점이 낮은 영화의 제목을 출력 
#   (동률이 있는 경우 모두 출력)
unity_List <- inner_join(m_List,r_List) 
View(unity_List)

l_comedy <- filter(unity_List, 
             genres == "Comedy",
             rating == 1)
View(unique(l_comedy))
View(l_comedy)


View(select(r_List, movieId, rating))


#6. 2015년도에 평가된 모든 romance영화의 평균 평점출력 
#   (timestamp 사용 필수 : 2015/01/01/00/00 ~ 2015/12/31/23/59)