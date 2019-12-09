#데이터 분석				<---오늘 진행 내용 							
#-데이터 분석 예제 실습 
#-통계적 데이터 분석  
###################################################################

# 사용하는 데이터는 한국 복지 패널데이터 
# 한국 보건사회연원 → 2006년부터 10년간 7000 여 가구에 대한 경제활동, 샐황실태, 복지욕구 등등에 대한 내용 

# 파일을 복사한 뒤 경로 확인(가급적 한글 안 섞이도록)
# 제공받은 데이터 파일은 SPSS파일(R에서 읽어들일 수 있음)
install.packages("foreign")
library(foreign) #이제 SAV파일을 불러들일 수 있음 

#다른 필요한 package들도 미리 로딩 
library(stringr) 
library(ggplot2)
library(dplyr)
library(xlsx)

#사용할 raw data를 불러오기 
raw_data_file = "C:/R_Lecture/data/Koweps_hpc10_2015_beta1.sav"
#spss파일을 읽어오고 속성을 사용해 df로 전환  
raw_welfare <- read.spss(file=raw_data_file,
                         to.data.frame = T)
#원본 보존을 위한 새로운 변수 선언 
welfare <- raw_welfare

str(welfare)  #16664개 데이터, 957개 column(ls나 head파악은 어려울것)
          #column의 개수가 많으므로 뽑아낼 수 있는 자료가 무궁무진함 
          #(같이 첨부된) code book  엑셀 파일을 참조(메뉴얼)
         
#데이터 분석에 필요한 컬럼은 컬럼명을 변경해줄것(분석상편이)
welfare <- rename(welfare, 
                  gender=h10_g3, #성별 
                  birth=h10_g4,  #출생연도 
                  marriage=h10_g10, #혼인상태
                  religion=h10_g11, #종교 유무여부
                  code_job=h10_eco9, #직종(해당 내용이 코드)
                  income=p1002_8aq1,  #월별 임금(자영업자 제외필요!)
                  code_region=h10_reg7) #지역(해당 내용이 코드)
#########################데이터 준비 완료 

##<예제1: 성별에 따른 월급 차이> 

# 성별빈도 확인 (이상치 유무여부 확인 )
table(welfare$gender)#   1    2 
                     #7578 9086 
                     #성별에 대한 이상치 없음 
                     #숫자를 인지할 수 있는 글로 바꿀것 
                     #(1→MALE, 2→FEMALE)
welfare$gender = ifelse(welfare$gender == 1, 
                        "male",
                        "female") #3항 연산자를 이용해서 바꾸자 
table(welfare$gender)# female   male 
                     #   9086   7578  정상출력여부 확인 

# 월급분포 확인
class(welfare$income)   # numeric
summary(welfare$income) #월급에 대한 범주 확인 
                        #중간값>평균값 → 저소득층에 분포가 많다 
qplot(welfare$income)   #임금별 분포를 가시적으로 확인할 수 있다. 
                      
qplot(welfare$income) + xlim(0,1000)  #x축 조정(확인용도) 
#0~250만원 사이에 가장 많은 사람들이 분포하고 있음을 확인 

#월급에 대한 이상치부터 처리 
welfare$income = ifelse(welfare$income %in% c(0,9999),
                        NA,
                        welfare$income)
#월급이 0 또는 9999(무응답) 이면 결측으로 반환 
                        
#NA 가 몇개 있는지 확인         #FALSE  TRUE 
table(is.na(welfare$income))    #4620  12044 
                                #임금생활자가 4620명
                                #기타 자영업, 학생, 무직, 결측                                      #등등이 12044명                      
####분석준비 완료 
# 수식을 통해 성별별 임금분석 실시 
gender_income <- welfare %>%  
  filter(!is.na(income)) %>%  #결측치 제외 
  group_by(gender) %>%        #정리된 값을 성별로 묶어라 
  summarise(mean_income = mean(income)) #mean income이란 column에                                            #평균월급 대입

gender_income = as.data.frame(gender_income) #결과 df화 
gender_income #확인 

  #####결과 데이터 프레임을 얻었으니 그래프 그려보기(막대그래프)
ggplot(data=gender_income,
       aes(x=gender,
           y=mean_income)) +
       geom_col(width=0.5) + #geom_bar은 원 데이터 빈도에 많이 쓰임 
       labs(x="성별", 
            y="평균 월급",
            title="성별에 따른 월급",
            subtitle="남성이 여성보다 150~이상 많이 번다",
            #부재 역시 삽입 가능 
            caption=("Example 1 Fig."))
            #우하단에 caption 삽입 

            #※통계치를 구할때는 geom_bar보다는 geom_col 사용 
            #(geom_bar의 경우 y축에 대한 내용을 지정해주지 않는다.)

############################
##<예제2: 나이와 임금의 상관관계>
# 데이터에서 몇살때 월급을 가장 많이 받을까? 
# 나이에 따른 월급을 선 그래프로 표현할 것 

#### 출생년도 데이터 확인
class(welfare$birth)   #출생연도(숫자) → 데이터 타입 파악
summary(welfare$birth) # 통계 데이터 확인 → 대략적 범위 파악
qplot(welfare$birth)   #빈도를 알 수 있다. 

#출생년도에 대한 결측치 확인 
table(is.na(welfare$birth)) #TRUE(0)가 없다 → 결측이 없네?

#출생년도에 대한 이상치 처리 
welfare$birth = ifelse(welfare$birth %in% c(0,9999),
                       NA,
                       welfare$birth)
table(is.na(welfare$birth)) #이상치 없음 

#'한국나이(age)' 컬럼 만들어주기 
welfare <- welfare %>% 
  mutate(age=2015-birth+1)

qplot(welfare$age)


##### 월급 데이터 확인
welfare$income = ifelse(welfare$income %in% c(0,9999),
                        NA,
                        welfare$income)


#### 나이별 평균월급 산출 
age_income <- welfare %>% 
              filter(!is.na(income)) %>% 
              group_by(age) %>%
              summarise(mean_income = mean(income))

#### 가장 월급 많이 받는 나이 산출 
age_income = as.data.frame(age_income)
age_income %>% arrange(desc(mean_income)) %>% select(age) %>% head(1)

#### 나이별 평균임금에 대한 선그래프 도시 
ggplot(data=age_income, 
       aes(x=age,
           y=mean_income)) +
  geom_line() 
 
############################
##<예제3: 연령대애 따른 월급 차이>
# 30대 미만 : 초년(young)
# 30~59세 : 중년(middle)
# 60세 이상 : 노년(old)
# 위의 범주로 연령대에 따른 평균 월급 차이 분석 

#나이범주라는 새로운 column 생성 
welfare <- welfare %>% 
           mutate(age_category= ifelse(age<30,"young",
                                ifelse(age<60,"middle",
                                               "old")))
#나이범주별 분포 확인 
table(welfare$age_category)  

#나이범주별 소득 확인 
age_category_income <- welfare %>% 
                       filter(!is.na(income)) %>%
                       group_by(age_category) %>%
                       summarise(mean_income = mean(income))

age_category_income = as.data.frame(age_category_income)

#그래프 도시하기(막대그래프)
ggplot(data=age_category_income, 
       aes(x=age_category,
           y=mean_income)) +
       geom_col() 

#만일 막대그래프의 순서를 정렬하고 싶다면?
#(ggplot은 막대 그래프를 그릴 때, 알파벳 오름차순 정렬해서 출력)
ggplot(data=age_category_income, 
       aes(x=reorder(age_category,-mean_income),
           y=mean_income)) +
  geom_col()  #소득작은 순위(내림차순)로 출력력

#초년생, 중년, 노년생(나이순) 으로 조정 
#막대그래프의 x축 순서를 내가 원하는 순서로 바꿀려면?
ggplot(data=age_category_income, 
       aes(x=age_category,
           y=mean_income)) +
  geom_col() +
  scale_x_discrete(limits=c("young","middle","old"))

############################
# <에제4. 연령대 및 성별의 월급 차이를 알아보아요>
# 총 6개 그룹이 나온다.(M,F * y,m,o)

age_gender_income <- welfare %>% 
                     filter(!is.na(income)) %>%
                     group_by(age_category,gender) %>%
                     summarise(mean_income = mean(income))
    
age_gender_income = as.data.frame(age_gender_income)

table(age_gender_income)
age_gender_income

# 누적 차트로 표현 해보자(이중구조) 
install.packages("digest")
library(digest)

ggplot(data=age_gender_income,
       aes(x=age_category,
           y=mean_income)) +
  geom_col(aes(fill=gender))

# 좀더 깔끔하게 그래프를 분류하자
ggplot(data=age_gender_income,
       aes(x=age_category,
           y=mean_income,fill=gender)) +
  geom_col(position="dodge")

############################
## <에제5. 나이 및 성별에 따른 월급 차이 분석>

#데이터 묶기
linear_age_gender_income <- welfare %>% 
                            filter(!is.na(income)) %>%
                            group_by(age,gender) %>%
                            summarise(mean_income = mean(income))

#그래프 그리기(선 그래프)
linear_age_gender_income <- as.data.frame(linear_age_gender_income)

ggplot(data=linear_age_gender_income, 
       aes(x=age,
           y=mean_income, fill=gender)) +
  geom_line(position="dodge") 

#그래프 좀더 깔끔하게 정리하기(주석도 넣고, 색도 넣고)
ggplot(data=linear_age_gender_income,
       aes(x=age,
           y=mean_income, 
           fill=gender, #또는 col=gender
           color=gender)) +
  geom_line(position="dodge",size=1 #두께 1로 설정 
            ) + 
  labs(x="나이", 
       y="평균 월급",
       title="나이대별 성별에 따른 월급",
       subtitle="부재 뭘로 하지",
       #부재 역시 삽입 가능 
       caption=("linear_age_gender_income."))

############################
## <에제5. 직업에 따른 월급 차이 분석>
# 가장 월급을 많이 받는 직업은?
# 가장 월급을 작게 받는 직업은? 
# 코드 북의 sheet2 직종 코드 참조 필요 
# 외부데이터 참조, 조인, 결측치 전처리 필요 

#코드북 불러오기 
code_sheet <-read.xlsx("C:/R_Lecture/data/Koweps_Codebook.xlsx",sheetIndex = 2 , encoding = "UTF-8") 

#코드북 구조파악 
class(code_sheet)
head(code_sheet)

#직업코드와 비교 
welfare$code_job

#직업코드와 코드북간 이너조인 
job_Sheet <-inner_join(welfare, 
                       code_sheet, 
                       by=c("code_job" = "code_job"))
#이너조인 결과 필요한 부분만 쪼개기(직업코드, 직업명, 수입)
wage_by_job <- select(job_Sheet,
                      code_job,
                      job,                                                                income)

#데이터 조작하기 
job_income <- wage_by_job %>% 
  filter(!is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

class(job_income)
job_income <- as.data.frame(job_income)

arrange(job_income,
        desc(mean_income))
arrange(job_income,
        mean_income)

# 전처리 및 조작된 데이터를 그래프로 도시 
ggplot(data=job_income,
       aes(x=job,
           y=mean_income)) +
  geom_col(width=0.5 ,position="dodge") + 
  coord_flip()  #x축, y축 뒤집기(그냥 바꿔쓰면 원하는거 안나온다)


############################
## <에제6. 종교유무에 따른 이혼률 분석>
#종교가 있는 사람은 없는 사람보다 이혼을 덜 할까? 아니면 그 반대?

table(welfare$religion)
class(welfare$religion)


welfare$religion = ifelse(welfare$religion == 1, 
                        "유종교",
                        "무교") #3항 연산자를 이용해서 바꾸자 

temp1   <-select(welfare,
                 religion,
                 marriage)


nrow(temp1)

b_group1 = filter(temp1,
                religion == "유종교",
                marriage == 1)
b_group2 = filter(temp1,
                religion == "유종교",
                marriage == 2)
b_group3 = filter(temp1,
                religion == "유종교",
                marriage == 3)
b_group4 = filter(temp1,
                religion == "유종교",
                marriage == 4)
n_group1 = filter(temp1,
                religion == "무교",
                marriage == 1)
n_group2 = filter(temp1,
                religion == "무교",
                marriage == 2)
n_group3 = filter(temp1,
                religion == "무교",
                marriage == 3)
n_group4 = filter(temp1,
                religion == "무교",
                marriage == 4)

b_divorce_rate= 
nrow(b_group3) / {nrow(b_group1)+nrow(b_group2)+nrow(b_group3)+nrow(b_group4)}

n_divorce_rate=
nrow(n_group3) / {nrow(n_group1)+nrow(n_group2)+nrow(n_group3)+nrow(n_group4)}
(n_divorce_rate)
join(n_divorce_rate, b_divorce_rate)


df <- data.frame()
mutate(df, rate = c(b_divorce_rate,n_divorce_rate))
            








