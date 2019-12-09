#10/25(금요일)
#HTML, CSS를 이용한 화면 표현 
#JavaScript core 
#jQuery selector, method
#Server Program 설정 
# - 도서검색 프로그램(제공)
#AJAX 호출 후 browser동적 처리 
#-keyword로 도서 검색 후 출력(실습
# web crawling & web scraping 
# data frame 제어 관련 package 

#####################################

#(1. 웹(web)이어서) 

# 토막상식 
#w3c 
#HTML이 발전발전 해서1999년 4.01 버전 
#w3c 가 1999년 12월에 HTML 4.01을 마지막으로 더 이상 버전업이 없음을 선언 
#이는 기존언어에 근본적 문제점이 있기 때문에 아예 방향성을 바꾸겠다는 뜻 
#HTML언어의 기본적인 2가지 문제점 
#1. 정형성이 없다 → 유지보수에 문제점이 발생하게 된다. 
#2. 확장성이 없다 → 언어자체가 기능이 한정되어 있다. 
#                   정해진 태그만 이용해서 사용하다 보니 배우고 쓰기는 쉬우나 #                   응용 및 확장은 어려움 
# #################################

##### 10/25 연습문제 
# 입력으로 최대 100자의 문자열을 이용 
# 입력으로 사용된 문자열에서 숫자만을 추출해서 출력하세요!
# 예/ "Hi2567Hello23kaka890L34TT23
#  → "2567238903423"
# 이렇게 추출한 숫자문자열에서 
# 개수가 가장 많은 숫자를 찾아서 숫자와 출현빈도를 출력하세요! 

library(stringr)

install.packages("readr")
library(readr)

ans <- readline("문자를 입력하세요 : ")
num<-str_extract_all(ans, "[0-9]")
num
var1 <- num[[1]]
inVec <- as.numeric(var1)
inSummary<-sort(summary(as.factor(inVec)), decreasing=T)[1:length(inVec)]
inSummary
inTable <-sort(table(inVec),decreasing=TRUE)
inTable
for

########################################################

#as factor()
