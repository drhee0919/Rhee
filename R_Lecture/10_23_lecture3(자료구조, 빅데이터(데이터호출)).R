# 서로 다른 데이터 타입을 저장하는 자료구조(list, Data Frame)
# 4. list : 1차원, 다른 데이터 타입도(중첩 자료구조; 백터와의 차이점)
# 1차원 선형구조에 다른 데이터 타입이 들어올 수 있다. 
# 중첩 자료구조로 이용 
# (자바의 map, 파이썬의 hash 로 이해하면 됨 )

# 예제1 : 지금까지 했던 여러 자료구조들을 생성해서 List 안에 저장하기
var_scalar = 100  #공간하나짜리 백터 생성(scalar) 
var_vector = c(10,20,30)  #공간 세개짜리 vector생성 
var_matrix = matrix(c(1:12), ncol =3, nrow=4, byrow=T)
var_array = array(c(1:12), dim=c(2,2,3))
var_df = data.frame(id=1:4, name=c("홍길동","김길동","최길동","이길동"), age=c(30,40,20,10))
#matrix와 유사한 구조,단 다른 데이터 타입이 들어옴(TABLE 이라 생각)
myList = list(var_scalar, var_vector, var_matrix, var_array, var_df)
myList

# → list는 일차원 선형 자료구조이기 떄문에 index로 접근 가능하다 
myList[1]  # 첫번째 scalar 출력  
           #[[1]]
           #[1] 100 
# key와 value로 저장되는 자료구조이고 데이터를 출력할 때 Key값도 같이 출력 
# list의 각각이 방들은 key와 value로 저장되어 있다.(락카룸, map구조 )
# 여기선 key값을 따로 저장하지 않았으므로 index번호가 출력 
myList[[1]] #공간이 아닌 key에 access. → 특정 데이터에만 접근 
            #[1] 100

#key값 할당하기 
myList = list(name=c("홍길동","김길동"),
              age=c(20,30),address=c("서울","부산"))
myList   #key가 name이고 후술 vector가 value
         #$name
         #[1] "홍길동" "김길동"

         #$age
         #[1] 20 30

         #$address
         #[1] "서울" "부산"
myList[1]   # $name
            # [1] "홍길동" "김길동"
           
myList$name # list에서 key를 access하기 위해서는 $ 기호를 이용한다. 
            # [1] "홍길동" "김길동"
# → 이러한 형태도 가능하다 
myList[[1]]
myList[["name"]]
myList$name # 그래도 이 형태를 가장 access할때 일반적으로 사용 

###############################################################

# 5. Data Frame : 2차원, 다른 데이터 타입도
# matrix 와 같은 2차원 형태의 자료구조, 단, 다른 데이터 타입 사용 가능 
# column명을 이용할 수 있다. 
# Database의 Table 과 유사하다. 
# vector를 이용해서 data frame 만들기 
no=c(1,2,3)
name=c("홍길동","김길동","최길동")
age=c(10,20,30)

# 함수 내 등호앞에 있는 것이 col명, 뒤에 있는 것이 백터 
df = data.frame(s_no=no, s_name=name, s_age=age )
df   #  s_no s_name s_age
     #1    1 홍길동    10
     #2    2 김길동    20
     #3    3 최길동    30

   
# $표시를 통해서 특정 column 을 검색할 수 있다. (list에서는 key)
df$s_name

# matrix를 이용한 data frame으로 전환하기
myMatrix = matrix(c(1:12), ncol=3, nrow=4, byrow=T)
myMatrix #[1] 홍길동 김길동 최길동
         #Levels: 김길동 최길동 홍길동
         #기본적으로 범주형으로 잡혀서 출력된다.(character형태로 변경가능)

# Data Frame의 함수 
str(df)  #해당 data frame에 대한 대략적인 구조, 정보를 보여줌 
         #obs : 행을 지칭 , variables: 열을 지칭 
         #전반적인 데이터 타입과 해당 요소를 보여줌(열 기준)
summary(df) #최대최소, 4분위값, 평균 등 해당 df의 요약 통계치 출력 

apply()  #data frame에도 적용할 수 있다. (함수 적용용 함수)

#예제 : 주어진 data frame의 1,2번째 column에 대하여 각각 합계를 구하시오 
df = data.frame(x=c(1:5), y=seq(2,10,2), z=c("a","b","c","d","e"))
# ＊범주로 출력하기가 싫다면 
df = data.frame(x=c(1:5), y=seq(2,10,2), 
                          z=c("a","b","c","d","e"),
                          stringsAsFactors = F)
df
apply(X=df[,c(1:2)], MARGIN = 2, FUN=sum) # apply는 기본적으로 2차원적용 
apply(X=df[-3], MARGIN =2, FUN=sum) #또는 이렇게 

df$x + df$y # 백터합 산출

sum(df$x) + sum(df$y) #1,2열 numeric원소값 총합 

#subset함수 
#데이터 프레임내 해당 조건에 만족하는 내용 출력(자주사용!) 
subset(df,x>3)   #  x  y z
                 #4 4  8 d
                 #5 5 10 e
#→ x가 3보다 작고 y가 4이상인 데이터 추출(AND연산)
subset(df,x<3 & y>=4)
#출력하지 않고 결과를 저장(assign) 가능 
df_sub <- subset(df,x<3 & y>=4)

# *데이터 프레임 인덱스 출력 
df[1,2]  # 1행 2열 출력 (value) 
df[,2]   # 2열 출력 (value) → vector 로 리턴 
df[2,]   # 2행 출력 (value) → vector 로 리턴  
df[2]    # 2열 출력(structure) →df 로 리턴  
df[[2]]  # 2열 출력 (value) → vector 로 리턴 
df["y"]  # 2열 출력(structure) →df 로 리턴  
df[["y"]]# 2열 출력 (value) → vector 로 리턴

#class : 자료의 구조
class(df[1,2])   #numeric
class(df[,2])    #numeric
class(df[2,])    #data.frame
class(df[2])     #data.frame
class(df[[2]])   #numeric
class(df["y"])   #data.frame
class(df[["y"]]) #numeric


#mode : 자료의 성질
#성질을 표현하기 어려운 복합적 변수는 구조로 표현하기도 함 
mode(df[1,2])    #numeric
mode(df[,2])     #numeric
mode(df[2,])     #list
mode(df[2])      #list
mode(df[[2]])    #numeric
mode(df["y"])    #list
mode(df[["y"]])  #numeric
#################################################################
# 범주형 자료구조 
# 6. factor : 범주형 데이터를 저장하기 위한 자료구조.
# (가령 방의 크기가 "대", "중", "소" → level 이라 지칭)
# '빈도' 와 관련된 목적에 자주 사용된다. 

# 일반적으로 vector를 이용해서 factor를 만들게 된다. 
# 예제1 : 6명의 혈액형 데이터를 vector에 저장 후 factor로 변형시키기 
var1 = c("A","AB","o","A","B","B")
var1  # "A"  "AB" "o"  "A"  "B"  "B" 

factor_var1 = factor(var1) #factor함수로 해당 vector를 factor형으로 변환 
factor_var1   #Levels : A AB B O

nlevels(factor_var1)   #4, 범주의 개수를 찾는 함수 

levels(factor_var1)    # "A"  "AB" "B"  "o", 사용되는 level 출력 

is.factor(factor_var1) # TRUE (factor가 맞냐)  

# 예제2 : 남성과 여성의 성별데이터로 factor를 생성하고 빈도수 산출하기 
var1 = c("MAN","WOMAN","MAN","MAN","MAN","WOMAN")
var1

factor_gender = factor(var1)
factor_gender

table(factor_gender)  #   factor_gender
                      #     MAN WOMAN 
                      #       4     2
plot(factor_gender)   #   빈도를 그래프로 도시해준다  



#######################################################################
#배운내용을 복습하기 위한 연습문제 
#Q1. 4,5,6,7,10,9,4 데이터를 이용해서 숫자형 vector x를 생성하세요. 
x <- c(4,5,6,7,10,9,4); x

#Q2. 아래의 두 백터의 연산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,4)

x1+x2 #recycling rule (warning과 error메시지를 구분하자)

#Q3. 데이터프레임을 이용하여 다음의 결과를 도출하시오 
Age <- c(22,25,18,20)
Name <- c("James","Mathew","Olivia","Stella")
Gender <- c("M","M","F","F")

ID = data.frame(Age=c(22,25,18,20), 
    Name=c("James","Mathew","Olivia","Stella"), Gender=c("M","M","F","F"))

ID[c(1:2),]

# → 또는 특성행을 '조건에 맞추면'
subset(df, Gender == "M")
subset(df, Gender != "F")
subset(df, Age >= 22) 

#Q4.아래의 구문을 실행한 결과는 ? 
x <- c(1,2,3,4,5)
(x*x)[!is.na(x) & x > 2] #9 16 25 
                         #(1 4 9 16 25)[(TTTTT) & (FFTTT)] →fancy indexing
                         # logical타입과 선수하는 vector와 연산하는 것 
                         # T 부분만 남기고 날린다. 
#Q5. 다음의 계산 결과는? 
x <- c(2,4,6,8)
y <- c(T,T,F,T)
sum(x[y])   #Fancy indexing의 또다른 예제 

#Q6. 제공된 vector에서 결측치(NA)의 개수를 구하는 코드를 작성하세요.
var1 <- c(34,55,89,45,NA,22,12,NA,99,NA,100)
is.na(var1) # F F F F T F F T F T F 
sum(is.na(var1)) # 3

#Q7. Q6의 결측치를 제외한 평균을 구하세요 
mean(var1[!is.na(var1)]) #57  ,Fancy Indexing 사용 

#Q8. 두개의 백터를 결합하세요, 그리고 결합해서 matrix를만드세요. 
x1 <- c(1,2,3)
x2 <- c(4,5,6)
c(x1,x2)

rbind(x1,x2) #2행 3열 짜리 
cbind(x1,x2) #3행 2열 짜리

#Q9. 다음 코드의 실행 결과는? 
x = c("BLUE",10,TRUE,20)
is.character(x)  #TRUe, 데이터타입 우선순위 

######################################################################
# 빅데이터란? : 일반적으로 3가지 요건(3V)을 만족하면 빅테이터라고 지칭 
# 1) volumn : 많은 양의 데이터 
# 2) velocity : 데이터 생성 속도 
# 3) variety : 데이터의 다양성(기존 데이터는 정형적, 지금은 소리, 음성, 영상등 다양한 종류의 데이터가 실시간으로 수집됨)
# 일반적으로 빅데이터 처리는 문자열 처리를 동반하는 경우가 많다. 

# 문자열 처리 알아보기
# 문자열 처리는 stringr package를 이용하면 쉽고 편하게 처리가능 
install.packages("stringr")
library(stringr)

var1 = "Honggd1234Leess9032YOU25최길동2009"

# 1) 문자열의 길이를 구하라 
str_length(var1) #31 (한글 1글자도 1개)
length(var1)     #전체 한글자로 취급 

# 2) 문자열내 특정 문자열 위치를 찾아라
str_locate(var1, "9032")         #     start end
                                 #[1,]    16  19
                                 # 찾는 문자열의 시작과 끝을 알려줌 
class(str_locate(var1, "9032"))  # 특정 구문의 자료구조를 알려주는 class
                                 # (mode출력시에는 numeric)  

# 3) 부분문자열을 구해보아요! 
str_sub(var1,3,8)                     #var1 문자열의 3번째부터 8번째까지 
                         #(R에서는 시작과 끝 문자 모두 포함 (inclusive))
                         # Return type 은 character 
# 4) 대소문자 변경 
str_to_lower(var1)
str_to_upper(var1)

# 5) 문자열 교체 
str_replace(var1, "Hong", "KIM")         #처음 '찾은' 하나만 바꿈 
str_replace_all(var1, "Hong", "KIM")     #해당 하는거 다 찾아 바꿈 


# 6) 문자열 결합 
var2 = "홍"
var3 = "길동"

str_c(var2,var3)          # R에서는 연산자가 아닌 str_c() 함수 이용 결합 


# 7) 문자열 분할 
var1 = "Honggd1234,Leess9032,you25,최길동2009"
str_split(var1,",")       # , 를 기준으로 list형식으로 분할출력
               #[[1]]
               #[1] "Honggd1234" "Leess9032"  "you25"      "최길동2009"

# 8) 문자열 결합2 
var1 = c("홍길동","김길동","최길동")
paste(var1, collapse="-")     # - 를 이용해서 붙이겠다는 선언 
                              #[1] "홍길동-김길동-최길동"
                               
######################################################################

# 정규표현식(regular expression)
# 문자열 처리를 쉽고 편하기 하기 위해서는 양식 패턴을 지정하자 
# (매칭 되는 것 찾아내기)
var1 = "Honggd1234,Leess9032,YOU25,최길동2009"

str_extract_all(var1, "[a-z]{4}") #조건에 부합하는 문자열을 추출 
                                  #소문자a부터z까지 4연속되는 것을 추출
                                  #[[1]]
                                  #[1] "ongg" "eess"
str_extract(var1, "[a-z]{4}")     #[1] "ongg" (조건에 부합하는 첫번째만)

str_extract_all(var1, "[A-Z]{2}")  #[[1]]
                                   #[1] "YO"
str_extract_all(var1, "[a-z]{2,}") #소문자a부터z까지 2글자 이상 연속 추출
                                   #[[1]]
                                   #[1] "onggd" "eess" 
str_extract_all(var1, "[a-z]{2,3}")#[[1]]
                                   #[1] "ong" "gd"  "ees"

# 한글만 추출해보아요! 
#해당 문자열에서 한글 다 찾기
str_extract_all(var1,"[가-힣]")  
#해당 문자열에서 두글자 이상 한글 다 찾기
str_extract_all(var1,"[가-힣]{2,}")
#해당 문자열에서 한글을 제외한 나머지 문자 추출(^ : hat사용)
str_extract_all(var1,"[^가-힣]")  
#숫자문자를 추출해보기 
str_extract_all(var1, "[0-9]{2,}")


# 예제: 주민등록록증 검사를 해보자 
myID = "801112-1210419"

str_extract_all(myID, "[0-9]{6}-[1-4][0-9]{6}") #부합하면 그대로 출력                                

##################################################################


# 데이터 입출력 
# 키보드로부터 데이터를 받을 수 있다.(미리 선언no, 실시간으로 입력받기) 
# scan() 함수를 이용해서 숫자데이터를 받을 수 있다. 
myNum <- scan()
myNum

# scan()을 이용해서 문자열도 입력받을 수 있다. 
var1 = scan(what=character()) #문자열 형태로 받겠다고 데이터 형식선언


# edit() 함수 
# scan()이 받아들이는 느낌이라면, edit()은 편집, 수정과 비슷함
# 특정 데이터프레임을 선언하고 edit()을 사용하여 수정해보자 
var1 = data.frame()    #공백상태의 데이터프레임 생성 

df = edit(var1)        #데이터 편집기 팝업(닫으면 입력됨) 
df                     #출력(확인해보기) 



# 파일로부터 데이터를 읽어오기 (.txt, .csv 등을 df형태로 읽어오기)
# 1) text 파일에 ","로 구분된 데이터들을 읽어오기. 
#read.table()을 사용 
getwd()
setwd(str_c(getwd(),"/data"))
#잠시 해당 .txt파일이 있는 곳으로 워킹 디렉토리 변경 
student_midterm = read.table(file="student_midterm.txt" ,sep=",",fileEncoding = "UTF-8" ,header = F)
getwd()
#또는 
student_midterm = read.table(file.choose(), sep=",",fileEncoding = "UTF-8",header = T) #헤더는 재량껏 
student_midterm
/

