

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
