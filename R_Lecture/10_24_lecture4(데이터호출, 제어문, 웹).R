#강의 시작전 코딩 환경 관련 팁 

var1 = c("홍길동")  #scalar선언 
var2 - c(10,20,30) 

# 빗자루 외에 환경창의 변수들을 소거 하는 방법
rm(list=ls()) #ls(): 환경창에 있는 객체들 

#console clear
cat("\014")

##########################################################

#외부 데이터 읽어오기(read.table 이어서)
student_midterm = read.table(file.choose(),
                             header=FALSE,  
                             sep=",",fileEncoding = "UT-8")#헤더는 재량껏                    
student_midterm

# 파일로부터 데이터를 읽어들일때 일반txt 형식을 잘 쓰이지 않음 
# 컴퓨터간에 데이터를 주고 받으려고 하면 
# (process간에 데이터 통신을 하기 위해서라면) 특정 형식을 이용해 데이터를 주고 받는다. 

# CS에서 가장 많이 사용하는 데이터 포멧은 

# 1. CSV형식 (comma seperated value, 데이터쪽에서 가장 빈번)
# : 콤마로 구분된 데이터값이라는 뜻 
#   해당 문자열을 전달해서 데이터 통신 
# ex/ "홍길동,20,서울,김길동,30,부산,최길동,50,인천,... "
# 장점: 간단하다, 구분자가 콤마밖에 없기 때문에 부가적인 데이터가 적다 
#       실데이터로 꽉 차 있는 상대적으로 작은 사이즈 
#       → 많은 양의 데이터 처리 가능 
#       패킷양에 과금되는 모바일 시대에서는 매우 효율적인 형식 
#       (옛날보다 오늘날 데이터 사이즈에 더 신경쓴다)
# 단점: 구조적인 데이터를 표현하기에 적합하지 않다.  
#       구조가 달라지면 콤마 기호 하나만으로 표현하기엔 어렵다. 
#       →parsing 작업이 복잡하고 유지보수에 문제가 발생한다.
#       현대사회는 구조적 데이터를 찾지 않는 것이 더 어렵다(예: 전화번호)
#
# 2. XML 형식
# : tag를 이용해서 데이터를 표현하는 방식 
# ex/ <name>홍길동</name><age>20</age><address>서울</address>...
# <phone>
#     <mobile>010-111-2221</mobile>
#     <home>02-342-2233</home> 
# </phone> 
# 장점 : 데이터의 계층화등 구조화에 관한 기존 CSV의 단점을 보완 
#        구조적 데이터를 표현하기에 적합하고, 사용하기 편리, 데이터의    
#        의미를  표현할 수 있다. 
# 단점 : 부가적인 데이터가 너무크다
#        (방대한 양의 데이터를 다루는 빅데이터에 큰 손실 )
#
# 3. JSON 형식 (JavaScript Object Notation)
# ex/ {name : "홍길동", age : 20, address : 서울, ...}
#     →{key값: value값, ... }  
#구조적 표현이 가능하면서 XML 보다 크기가 작아졌음.  

# 2) csv 파일 데이터를 읽어오기. 
# ※ csv파일이 애초에 콤마로 구분하기 떄문에, sep="," 따로 선언 필요 X
# read.csv()
df = read.csv(file.choose(),fileEncoding = "UTF-8")
df

# excel파일을 불러올 수 있다. (확장 package이용)
# ※ R을 설치하면 base system이 설치된다고 표현한다 .
#    base package(로딩 불필요), recommended package(로딩필요)
#    →R이랑 같이 깔림   
#    other package(설치 및 로딩 필요 )

# xlsx package를 설치하고 로딩해요 
install.packages("xlsx")
library(xlsx)

#JAVA_HOME 환경변수 설정 
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_231") 
#JAVA runtime환경 구성 
#폴더 표현시 역슬레시 두방 
student_midterm <- read.xlsx(file.choose(),sheetIndex = 1, encoding="UTF-8")                       #sheetIndex =1: excel에 있는 첫번째 sheet에 access
student_midterm         #호출  
class(summary(student_midterm)) # table
######################################################################

# 5. 처리된 결과를 파일에 writing 하기 
# write.table() : data frame을 file에 저장 
# cat() : 분석결과(vector)를 file에 저장 
# capture.output() : 분석결과(List, table)을 file에 저장 
# ex/ 기존 student_midterm 파일을 이용하여 report.txt파일 생성하기 
cat("처리된 결과는 :","\n","\n",file="C:/R_Lecture/data/report.txt",
    append=T) #append옵션을 주면 뒤쪽에 추가할 수 있다. 
#해당 경로에 "처리된 결과는 :" ㅇ로 시작하는 report.txt 
#파일을 생성 
write.table(student_midterm, file="C:/R_Lecture/data/report.txt",append=T)
# append를 통해 선수 결과에 추가 
# Warning message:
# In write.table(student_midterm, file = "C:/R_Lecture/data/report.txt",  :
#   열의 이름들을 파일에 추가합니다.

capture.output(summary(student_midterm),file="C:/R_Lecture/data/report.txt",append = T)


# R에서 작성한 데이터 프레임 엑셀(.xlsx) 형태로 저장하기 

df = data.frame(x=c(1:5), y=seq(1,10,2), z=c("a","b","c","d","e"),
                stringsAsFactors = F)
df                                  #특정 데이터프레임 하나 선언 
write.xlsx(df,"C:/R_Lecture/data/report.xlsx")
#워크스테이션에 report.xlsx 파일 생성여부 확인 



#####################################################################

# 6. 조건문 생성하기 
# R은 프로그래밍 언어. 따라서 제어문도 가지고 있다. 
# if 구문(조건문) 생성하기 
var1 = 100
var2 = 20

if(var1 > var2) {
  # 조건문이 참일 때 실행 
  cat("참이예요!!")
} else{
  # 조건문이 거짓일때 실행 
  cat("거짓이예요!!")
}

# ifelse : 3항 연산자 
var1 = 10
var2 = 20

ifelse(var1>var2, "참일경우 선택","F일경우 선택")
# ifelse(test, yes, no)
# "참일경우 선택"



#반복문(for, while)
# for : 반복 횟수만큼 반복 실행 (얼만큼 반복될 줄 알때 )
# while : 조건이 TRUE일 동안 반복 실행 

#ex1/
for(var1 in seq(1:5)){print(var1)}
#[1] 1
#[1] 2
#[1] 3
#[1] 4
#[1] 5
#print라는 구분을 입력한 수열만큼 반복 실행. 

#ex2/
idx = 1 
mySum= 0

while(idx < 10) {   mySum = mySum + idx
idx = idx + 1     }
mySum
#sum(c(1:9))
#mySum은 idx(==1~9)의 합 


#연습문제1
#로직(제어문을 이용해서) 1부터 100사이에 있는 3의 배수 출력하기 
for(var1 in seq(1,100)){
  if(var1 %% 3 == 0){print(var1)}
}

#연습문제2 
#1부터 100사이에 있는 prime number를 출력하세요 

help("for")
for(var1 in seq(2,100)){
  c = 0 
  for(var2 in seq(2,100)){
    if(var1 %% var2==0)
      c = c+1 
  }  
  if(c==1){print(var1)}    
}

#사용자 정의 함수 (User Define Function)
#제공된 함수말고 우리가 함수를 만들 수 있을까 ?
#함수명 <- functon(x){...}

#ex1/ 입력받은 숫자를 제곱해서 돌려주는 함수 생성 
sqr <- function(x){x = x^2
return(x)         
}
sqr(2)
sqr(4)

#ex2/ sum 함수와 동일한 역할을 하는 mysum 작성 
#     (vector를 입력으로 받아서 합을 구해주는 합수 작성 )
mySum = function(x) { 
  result = 0
  for(t in x) {
    result = result + t
  }
  return(result)
}

var1 = c(1:10) # 1~10 수열 생성 
mySum(var1)    # 만든 sum 함수 검증   

###############################################################

#연습문제
#Q1. 주어진 데이터로 vector x를 생성하세요 
x <- c(2,3,5,6,7,10); x

#Q2. 주어진 데이터 각각을 제곱해서 vector x를 생성하세요 
x <- c(2,3,5,6,7,10)^2
x

#Q3. 주어진 데이터 각각을 제곱해서 합을 구하세요 
sum(c(2,3,5,7,10)^2)

#Q4.주어진 백터에 5이상인 원소들만 출력하시오 
x= c(2,3,5,6,7,10)
var1 = c(2,3,5,6,7,10) >5 #mask
x[var1]                   #fancy indexing 


#Q5. vector x의 길이를 구하세요 
length(x)

#Q6. 패키지를 활용하여 소수를 출력하세요  
#R의 package중에 UsingR이 있어요
install.packages("UsingR")
#설치된 package를 불러들여요 
library(UsingR)
#데이터를 불러들일 수 있어요
#1~2003까지 숫자 중 prime number를 갖고 있다. 
data("primes") # 다 출력 
head(primes) #해당 데이터의 앞에서 6개만 출력 
# 2  3  5  7 11 13
tail(primes) #끝에 6개 출력 
# 1979 1987 1993 1997 1999 2003






#Q7. 1부터 2003까지 숫자 중 prime number는 몇개인가? 
length(primes)  #304





#Q8. 1부터 200까지 숫자 중 prime number는 몇개인가 
var <- primes<201
length(primes[var]) #46
#또는 
sum(primes <= 200)  #46



#Q9. 소수들의 평균을 구해보자 
mean(primes)


#Q10. 500이상 1000이하의 prime number만으로 구성된 vector P를 구하세요.
P <- c(500<=prime & prime<=1000)
primes[P]
# 또는 
p = primes[primes >= 500 & primes<=1000]; p


# *다음과 같은 형여태의 데이터를 이용하여  아래의 문제를 풀자 
# 1 5 9
# 2 6 10
# 3 7 11 
# 4 8 12
# Q.11 위의 데이터를 이용해서 matrix x를 생성하기 
x = matrix(seq(1,12), nrow =4, byrow=F); x

# Q.12 위 matrix x의 전치행렬을 만들어 보아요 
t(x)  # transpose 함수

# Q.13 matrix x에 대해 첫번째 행만 추출하세요  
x[1,]

# Q.14 matrix x에 대해 6,7,10,11을 matrix형태로 추출하세요 
x[2:3,-1]  #2행과 3행, 2열과 3열 추출 

# Q.15 matrix x에 대해 x의 두번째 열의 원소가 홀수인 행들만 뽑아서 
#      matrix P를 생성하세요 
p<- rbind(x[1,], x[3,])
p
#또는 
p = x[x[,2] %% 2 ==1, ] #2열에서 홀수인 원소가 있는 행 추출 
p

#################################################################
# ★LG CNS프로그래밍 예제: 
# 홀수개의 숫자로 구성된 숫자문자열이 입력으로 제공됩니다. 
# 문자열이 개수는 7개 이상 11개 이하로 제한됩니다.  
# 입력 문자열의 길이는 7개, 9개, 11개 
# 중앙 숫자를 기준으로 앞과 뒤의 숫자를 
# 분리한 후 분리된 두 수를 거꾸로 뒤집어서 두수의 차를 구하라. 

##ex/ 입력으로 들어온 숫자가 7648623일떄 
##    가운데를 기준으로 나누고 764 623
##    각 숫자를 거꾸로 뒤집고  467 326  
##    두 수의 차를 구한다. 141(467-326)

## scan함수를 통해 문자열 형태로 받은뒤  
## str류 함수를 이용해서 문자를 분할하고 
## 문자열을 실수형ㅇ로 변환할 것 


library(stringr)
input = scan(what=character())
input

mid_input=(str_length(input) %/% 2) +1 
mid_input

var1 = str_sub(input, 1, mid_input-1); var1; 
var2 = str_sub(input, mid_input+1, str_length(input)); var2;

#절대값 함수 사용 
###############################################################
#기본적인 R의 사용 
# data type(자료형), data structure(자료구조), control statement(제어문)

# 1.Web 
# 다양한 방법을 통한 데이터를 구축 
#: Database로부터 데이터를 얻어올 수 있다
#  Open API(웹 공개 프로그램)를 이용해서 데이터를 얻어올 수 있다. 
#  파일로부터 데이터를 얻어올 수 있다. 
#  프로그램적으로 web scraping, crawmling을 통해 데이터를 구축 

#HTML, CSS, 그리고 Javascript 
#HTML은 웹페이지 문서의 내용과 구조표현 
#CSS는 화면구성 및 스타일을 잡는다. 
#Javascript 웹페이지 내에서 동적 프로그래밍 처리를 위해 사용 
# (client 액션에 따라서 어떻게 행동할 것인가? )

#기본적으로 웹은 cs(client-server)구조로 되어있다.
#server쪽 프로그램 : web server HTML, CSS< Javascript 를 제공
#(ex/ Apache Tomcat)
#client쪽 프로그램 : HTML, CSS, Javascript를 받아서 화면에 rendering. 
#(ex/ 익스플로러, 크롬 같은 웹 브라우저)

# HTML, CSS, Javascript를 이용해서 클라이언트에게 제공해주는 webpage작성
# 1) IDE 설치 (webstorm) 
# https://www.jetbrains.com/webstorm/, 다운 후 실행 
# 기본설정 후 (경로설정 등) 새로운 HTML FILE 실행(HTML5버전으로)

# 2) 웹페이지 서비스 
# 클라이언트에게 제공할 HTML을 작성했어요 
# 서버프로그램(web server)에게 우리 프로젝트를 알려줘야 한다.(Configure)
# web server프록램을 기동시켜서 우리 프로젝트를 웹에 deploy(띄우다) 시킴.
# web client(browser)를 이용해서 URL(주소, 좌표) 서버쪽 프로그램에 
# 접속해서 HTML 화면에 그리기 

# 3)HTML의 태그 
# h1~h4태그와 span태그 
# 주석표시 <!-- 여기가 주석이에요 -->
# HTML언어는 대소문자를 따로 구분하지 않음 
# span은 단순 영역만 잡아주는 태그, 따로 특별히 크기나 특별한 변화를 주지 않는다.
# DIV는 똑같이 특별 기능이 없고 영역만 잡지만, span은 block 레벨, DIV는 라인 전체를 잡는다. (브라우저 도시 후 F12키를 눌러 확인가능 )
