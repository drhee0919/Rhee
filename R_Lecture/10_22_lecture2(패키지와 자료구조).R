#ggplot2 패키지 설치하기 
install.packages("ggplot2")
require(ggplot2)
library(ggplot2)

#간단한 빈도를 나타내는 막대그래프를 그리기 위해 vector하나 생성 
var1 = c("a","b","c","a","b","a")
qplot(var1)

#설치된 package를 삭제하려면 remove.packages()를 사용한다. 
remove.packages(ggplot2)
remove.packages("ggplot2")

library(ggplot2)
require(ggplot2)

#package가 설치된 폴더 경로
.libPaths()

#package 설치 경로를 변경하고 싶다면? 
.libPaths("C:/R_Lecture/lib")


# 많은 package에 대한 정보, 사용법 등을 알면 알수록 R을 잘 사용할 수 있다. 
# package를 설치하면 package에서 제공하는 함수를 이용할 수 있다. 
# help창에서 해당 함수에 대한 설명을 듣고 싶을 때
help(qplot)
# 해당 함수의 수식구조를 보고 싶을때 
args(qplot)

path.package("ggplot2")
library(ggplot2)
help(qplot)
example(qplot)

# 현대의 working directory 확인
getwd()
# 현재 워킹디렉토리를 바꾸고 싶다면?
set("c:/R_Lecture/") 
##########################################################################
#자료 구조 알아보기 
#Data Type : 저장된 데이터의 성격(숫자, 문자열, logical) 
#Data Structure: 변수에 저장된 데이터의 메모리 구조 

#R이 제공하는 자료구조 6가지 : 2개의 분류(같은 데이터 타입인가 아닌가)

# 1. vector : 1차원, 같은 데이터 타입만 (사실상 1차원 배열)
# vector는 scalar의 확장, 1차원 선형구조 
# vector는 같은 data type으로 구성된다. 
# vector는 첨자형태로 access가 가능( [] )
# 첨자(index)의 시작은 1 (일반적인 프로그래밍 언어는 0부터 시작)

# 백터를 생성하는 방법 

# 1) combine 함수를 사용해서 생성 ( c() ) 
# 일반적으로 규칙성이 없는 데이터를 이용해서 vector를 생성할 때 이용 
var1 = c(1,2,6,9,10)
var1
mode(var1)
var2 = c(TRUE,FALSE,TRUE)
var2
var3 = c("홍길동", "김길동", "최길동")
var3
var4 = c(200,TRUE,"아우성!!")
var4
# vector를 이용해서 다른 vector를 만들 수 있다. 
var5 = c(var1,var2)
var5

# 2) :(콜론) 을 이용해서 vector를 생성할 수 있다. 
# numeric 에서만 사용 가능하고 1씩 증가하거나 감소하는 숫자의 집합을 
# vector로 만들때사용 
# start;end 형태로 사용되고 둘 다 inclusive 
var1 = 1:5; 
var2 = 5:1; var2;
var3 = 3.4:10; var3;

# 3) seq()를 이용해서 vector를 생성할 수 있다. 
# : 의 일반형으로 등차수열을 생성해서 vector화 시킬 때 사용 
var1 = seq(from=1, to=10, by=3)
var1 = seq(1,10,3)
#일반적으로 readability 가 좋은 위의 형태를 선호 

# 4) rep()를 이용해서 vector를 생성할 수 있다. (replicate)
# 지정된 숫자만큼 반복해서 vector를 생성하게 된다. 
var1 = rep(1:3, times=3) #times는 생략이 가능, 1 2 3 1 2 3 1 2 3 
var2 = rep(1:3, each =3) # 1 1 1 2 2 2 3 3 3 

#vector의 데이터 타입을 확인하기 
mode(var1) #numeric 

# vector의 데이터의 개수를 알아내려면? 
var1 = c(1:10); var1
length(var1)  #10 

#length를 다른 의미로 사용할 수 있다. (구간나눔) 
var1 = seq(1,100, length=3); var1
# → 백터안에 길이별로 중간값을 찾아 구간을 나눔 

#vector에서 데이터 추출 
#vector의 사용은 []를 이용해서 데이터 추출 
var1 = c(67,90,87,50,100); var1;
var1[1] #67, 백터안 첫번째 원소 추출 
var1[length(var1)] #100, 맨 마지막 원소를 추출 
var1[2:4] #90, 87, 50 추출 
#vector를 만들기 위해 사용한 :, c(), seq(), rep()를 vector 요소를 access하기 위한 용도로 사용할 수 있다. 
var1[c(1,5)] #67, 100 추출 
var1[seq(1,4)] #2,3,4번째 추출 (맨 끝의 100을 제외한 원소를 추출)
var1[6] # 결측치에 해당하는 NA 출력 
var1[-1]# 여기서 -1는 '역' 을 지칭, 즉 1을 제외한 나머지 추출(제외의 의미)
var1[-c(1:3)] # 50 100 

#vector 데이터의 이름 (names())
var1 = c(67,90,50)
names(var1) # NULL

names(var1) = c("국어", "영어", "수학") #name 설정 
var1[2] #index를 이용해서 vector 데이터를 추출 
var1["영어"] #name을 통해서 vector 데이터를 추출 

# vector의 연산 
# 수치형 vector는 scalar를 이용해서 사칙연산을 할 수 있다. 
# vector와 vector간의 연산도 수행할 수 있다. 
var1 <- 1:3
var2 <- 4:6 

var1 * 2 # 2 4 6
var1 + 10 # 11 12 13 
var1 + var2 # 5 7 9 

var3 = 5:10 # 5 6 7 8 9 10
var1 + var3  # 6 8 10 9 11 13 , recycling rule(사이즈를 채워서 맞춘다)

var4 = 5:9  #5 6 7 8 9
var1 +var4  #6 8 10 9 11 , warning 메시지 출력(length가 배수가 아님) 

# vector간의 집합 연산 
# union() : 합집합 
# intersect() : 교집합 
# setdiff() : 차집합 
var1 = c(1:5) 
var2 = c(3:7)
union(var1,var2)      # 1 2 3 4 5 6 7
intersect(var1,var2)  # 3 4 5 
setdiff(var1,var2)    # 1 2 

#vector간의 비교(두 vector가 같은가 다른가 확인 )
#identical 함수 : 비교하는 두 vector의 요소가(순서, 갯수, 요소, 데이터 모두가 같아야) 완전히 일치하면 TRUE, 아니면 FALSE 를 출력 
var1 = 1:3
var2 = 1:3
var3 = c(1,3,2)
identical(var1, var2)
identical(var1, var3)

#setequal 함수: 비교하는 두 vector의 크기, 순서와 상관없이 내용만을 비교 
setequal(var1, var3) #TRUE 
var3 = c(1,3,2,1,1,1,3,3,3) #vector의 내용만은 같음 
setequal(var1, var3) #TRUE

#요소가 없는 vector (vector함수)
var1 = vector(mode="numeric", length=10)
var1 # 0 0 0 0 0 0 0 0 0 0





# 2. matrix : 2차원, 같은 데이터 타입만 (2차원 배열)
# 동일한 data type을 가지는 2차원 형태의 자료구조 
args(matrix)
# matrix의 생성 
var1 = matrix(c(1:5))          #matrix의 생성 기준은 열! 
                               #열은 고정되고 행이 늘어나게됨 
                               #5행 1열짜리 matrix가 생성
var1 = matrix(c(1:10), nrow=2) #속성을 이용, 행의 갯수를 지정 
                               #2행 5열짜리 matrix가 생성 
var1 = matrix(c(1:10), nrow=3) #recycling 발생, 행 부터 숫자가 체워짐 
                               #warning message 동반 
var1 = matrix(c(1:10), nrow=2, byrow = T) 
# 열부터 숫자가 체워지는 2행 열짜리 
var1 = matrix(c(1:10), nrow=5, ncol=2)

#vector를 연결해서 matrix를 만들 수 있다. 
#가령, vector를 가로방향, 세로방향으로 붙여서 2차원 형태로 만들 수 있다. 
var1 = c(1,2,3,4)
var2 = c(5,6,7,8)
mat1 = rbind(var1, var2); mat1
mat2 = cbind(var1, var2); mat2

#matrix 원소의 출력 
var1 = matrix(c(1:21), nrow=3, ncol=7) # 3행 7열짜리 matrix 
var1
var1[1,4]          #1행 4열에 있는 원소 출력 
var1[2,]           #2행 다 출력 
var1[,3]           #3열 다 출력 

# Q. 11 12 13 14 15의 값을 가져오려면? 
var1[c(2,3),c(4,5)]
var1[c(2:3),c(4:5)]

length(var1) # 원소의 갯수 출력 
nrow(var1)   # 행의 갯수(길이) 출력
ncol(var1)   # 열의 갯수(길이) 출력 


# matrix에 적용할 수 있는 함수 
# apply() 함수 : 함수를 적용할 수 있는 함수(3가지 속성)
# x → 적용할 속성(matrix) 
# MARGIN → 1이면 행기준, 2이면 행기준
# FUN → Function, 적용할 함수 
var = c(20,60,90.100,40,76,99)
mean(var1) #var1 matrix의 원소 평균치 
apply(X=var1, MARGIN = 1, FUN=max) # 19,20,21  행별 최대원소값 출력
apply(X=var1, MARGIN = 1, FUN=mean) # 10, 11, 12 열별 원소평균치 출력 
# 이미 적용된 함수 외에도 '직접만든' 함수 역시 적용이가능하다 

# matrix의 연산
# 1) matrix의 요소단위의 곱연산(elementwise product) 
var1 = matrix(c(1:6), ncol=3)   #2행 3열짜리 matrix 2개생성  
var2 = matrix(c(1,-1,2,-2,1,-1), ncol=3)
var1 * var2 
# 2) 행렬곱(matrix product)
var3 = matrix(c(1,-1,2,-2,1,-1), ncol=2)
var1 %*% var3 # 2행 2열짜리 내적 산출 
# 3) 전치행렬(matrix transpose)을 구해보자 
# var1을 전치행열한다면? → 열이 행에 가고 행이 열에 가서 3행 2열 형성 
t(var1)
#  4) 역행렬(matrix inversion) → 가우스 소거법 이용 
# 정의: matrix A가 n x n(n by n) 일때 다음의 조건을 만족하는 행렬 B가 존재하면 B를 A의 역행렬이라 지칭한다
# " AB=BA=I(단위행렬E) "   #존재하지 않을 수도 있다. 
solve(var)
var = matrix(c(1:16), ncol=4) # 4x4 정방형 행렬 생성 
solve(var)

# 3. array : 3+차원, 같은 데이터 타입만 ( 4차원이 넘어가는 array는 일반적으로 사용하지 않는다)
# 백터의 개수가 곧 차원의 개수이다.(사실상 vector, matrix, array는 차원차)
var1 = array(c(1:24), dim=c(3,2,4)) #3행, 2열 평면이 4개 있음. (총 64개)



# 서로 다른 데이터 타입을 저장하는 자료구조(list, Data Frame)
# 4. list : 1차원, 다른 데이터 타입도(중첩 자료구조; 백터와의 차이점)
# 5. Data Frame : 2차원, 다른 데이터 타입도


# 범주형 자료구조 
# 6. factor : 





