# R의 주석은 #을 이용한다. 
# 주석을 이용하면 한 줄이 몽땅 comment 처리가 된다. 
# 일반적으로 프로그래밍 언어에서 statement를 종료하기 위해서 사용하는 
# ";"을 R에서는 생략할 수 있다. 
3+5;
3+6; 2*7
# 코드를 수행하기 위해서는 ctrl + Enter 를 사용 
# R은 대소문자를 구분한다(case sensitive)
# 변수를 만들때 camelcase notation 로 만든다.
# (단어가 접합될때 뒤에오는거 대문자로)
#  ex/ myResult : camelcase notation  
#  ex/ MyResult : pascal notation 
#####################################################

myResult = 200 # assignment 
myResult <- 300 #assignment 
400 -> myResult #assignment 
myResult
print(myResult)  #변수출력 
print("결과값은 : " + myResult)
cat("결과값은:" , myResult)
######################################################

# 멤버를 이용한 변수 선언 

goods.price = 3000
goods.code = "001"
goods.name = "냉장고"


#######################################################
# 출력된는 형식을 살펴보아요 

myResult
mySeq = seq(100) # 1부터 100까지 1씩 증가하는 숫자의 집합 
mySeq = seq(5, 100) #5부터 100까지 1씩 증가하는 숫자의 집합 
mySeq
mySeq = seq(1,100,by = 2)
mySeq

# Operator(연산자)
var1 <- 100
var2 <-3
var1 /var2  # JAVA언어 => 33
            # R은 마치 실세계의 연산처럼 수행(33.333333.....)
var1 %/% var2 #몪 부분만 구하고 싶다면? 
var1 %% var2 # 나머지 부분을 구하고 싶다면?    


# 비교 연산자 

var1 == var2 #FALSE(F)
var1 != var2 #TRUE(T)

# 논리연산자  &, &&(and)

TRUE && FALSE 
TRUE & FALSE

# 논리연산자 |, || (or)

TRUE || FALSE
TRUE | FALSE

#일반 단일변수는 1개짜리 공간 (값 하나를 assign 할 수 있는 형태) 
#R에는 여러가지 자료구조가 있다. 
#가장 대표적인 자료주고(데이터를 저장하는 구조) 에는 vector 가 있다. 
#R에서 vector는 연속적인 저장공간(1차원, 선형) 
#저장공간안에 모두 같은 데이터 타입이 들어와요! 

# 함수를 이용해서 vector 를 생성 > C()
c(10,20,30) # 10 20 30 
c(TRUE,20,3.14) # 1.00 20.00  3.14
# 데이터 값이 다르지만 자체적인 '우선순위' 에 의해서 같은 데이터 타입으로 

c(TRUE,FALSE) & c(TRUE,TRUE) # 각각의 위치에 있는 것을 논리연산을 거쳐 출력 # vector 연산 결과값은 vector로 떨어진다. 

c(TRUE,FALSE) && c(TRUE,TRUE) #앞에 있는 것만 한다. (스칼라만 떨어진다.)

C(TRUE,F,TRUE) & C(FALSE,T)

!c(T,F,T,F) #  FALSE  TRUE FALSE  TRUE

# 다른언어와 마찬가지로 다양한 수학함수를 내장하고 있다. 
abs(-3) #절대값
round(3.1415)  #반올림
sqrt(100) #제곱근 

#########################################################################

#R의 데이터 타입 
#R에는 Data Type이 크게 2가지가 존재 
#1. 기본데이터 타입, 2. 특수데이터 타입 

#1-1. 숫자형(numeric): 숫자로 되어 있고 정수형과 실수형을 의미. 
#R은 기본적으로 숫자는 다 실수형 
# 100 : 실수형
# 100L : 정수형 ("L"기호를 이용하여 정수, 실수를 구분)

#1-2. 문자열(character): 하나 혹은 둘 이상의 문자의 집합을 지칭. 
#JAVA는 문자열(String) != 문자(character) 를 구분하지만, R은 그렇지 않다. 
#'', "" 로 만듬 (single, double quotation 구분안함)
#"홍길동"     #문자열
#'최길동'     #문자열
#'홍'     #문자열
# 어느쪽을 써도 되지만 혼용은 국룰아님 

#1-3. 논리형(logical) : TRUE(T), FALSE(F)
#1-4. 복소수형(complex) : 4-3i

#특수 데이터 타입 
#2-1. NULL : 객체가 존재하지 않음을 지칭하는 객체 
var1=NULL
#2-2. NA : Not Available(결측치를 표현할 때 사용)
#필드에서 나와있는 데이터 중에 측정하지 못한 데이터 
#2-3. NaN : Not Available Number, Not A Number(연산이 불가능한 숫자)
sqrt(-3)
#2-4. Inf : 양의 무한대 
#    -Inf : 음의 무한대      


args(as)


#########################################################################
var1=100
var2=100L
var3="Hello"
var4=TRUE
var5=4-3i
var6 =NULL
var7 = sqrt(-3)

#데이터 타입을 조사하기 위해 제공된 함수  mode()
mode(var1) #numeric 
mode(var2) #numeric
mode(var3) #character
mode(var4) #logical
mode(var5) #complex
mode(var6) #NULL
mode(var7) #numeric,숫자긴 숫자인데 계산할 수 없는 숫자이기 때문 

#is. 계열의 함수 
is.numeric(var1) #TRUE
is.numeric(var2) #TRUE

is.integer(var1) #FALSE
is.integer(var2) #TRUE


# data type의 우선순위가 있어요 
# 기본데이터타입 4개에 있어서 우선순위가 가장 높은 것은 'character'
# 그 다음은 복소수 "complex"
# 그 다음은 숫자형 "numeric"
# 가장 우선순위가 낮은 것은 "logical"

myVector <- c(TRUE,10,30) #numeric 으로 통일 
myVector <- c(TRUE, 10, 30, "Hello")
myVector

# 하나의 데이터타입은 다른 데이터 타입으로 바꿀 수 있다. (Typecasting)
var1<-3.14159265358979
var2<-0
var3<-"3.1415"
var4<-"Hello"

# 데이터 타입을 변경할 때는 as계열의 함수를 사용합니다. 
as.character(var1)
as.integer(var1) #3
as.logical(var2) #FALSE
as.double(var3) #3.1415

##########################################################################

