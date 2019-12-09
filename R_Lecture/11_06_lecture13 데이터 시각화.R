#데이터 시각화(텍스트 분석 및 시각화, ggplot2, graphics)		<---오늘 진행 내용 
#-ggplot2의 graph(4종류)
#-한글 형태소 분석 및 wordCloud
#-영화댓글사이트 crawling → 형태소 분석 → wordCloud 실습 
####################################################################
# 1. R Graph 
# 숫자나 문자로 표현하는 것보다는 그림(그래프)으로 표현하면 변수의 관계 데이터 경향을 좀더 쉽게 파악할 수 있다. 

#(12강 복습) reshape2 package 
#: melt 와 dcast를 이용한 데이터의 융해와 복구 
# dplyr package : 데이터를 조작하는 대표적인 패키지 
# → 상기 패키지는 모두 같은 사람이 만듬(Hadley Wicham)
# Hadley Wichamd이 만든 패키지가 하나 더 있는데, 그것이 ggplot2 
# (R에서 가장 많이 사용하는 외부 패키지) 

# 대표적인 그래프의 유형들  
# 산점도(scatter)  : 변수간의 관계를 파악하는데 자주 사용 
# 막대그래프 : 집단간의 비교를 할때 자주 사용 
# 선 그래프 : 시계열 데이터를 표현할 때 자주 사용 
# 박스 그래프(boxplot) : 데이터의 분포를 쉽게 볼 수 있다. 

# 기존의 mpg 데이터셋을 이용하여 그래프 비교 
# ggplot2 패키지는 3단계로 나누어 그래프를 그린다. 
# 1) 축을 정한다(배경을 설정한다)   -배경깔고 
# 2) 설정한 배경에 그래프를 추가한다. -그래프 올리고
# 3) 축 범위, 배경설정 (후속작업)  -설정하고 

install.package("ggplot2")
library(ggplot2)
mpg             #데이터 셋 불러오기 

df <- as.data.frame(mpg)
df

# 1) 배경설정 
# data 설정 : 그래프를 그리는데 필요한 데이터 
# aes : 축(axis), (X=, y=) 형태
# mpg 데이터를 이용하여 배기량(x)에 따른 고속도로 연비(y) 산출 
ggplot(data=df, 
       aes(x=displ,
           y=hwy))      #축이 그려진 도화지 확인(plots 화면)
# 2) 그래프 추가 
# 배경을 이어받아서 원하는 그래프를 그릴 수 있다. 
# geom_point() : geometric point, 산점도 그리는 함수  
ggplot(data=df, 
       aes(x=displ,
           y=hwy)) + #이어 쓴다는 식으로 이전 코드와 '+" 기호 필요 
  geom_point()       #산점도를 그린다. 

# 3) 설정을 주가할 수 있다. 
ggplot(data=df, 
       aes(x=displ,
           y=hwy)) + 
  geom_point(size=3, color="red") +
  xlim(3,5) +
  ylim(20,30)  # 설정추가, x축과 y축 범위 조절 

plot.new() # 그린 그래프를 초기화(plot창을 비워준다.) 

##########################
# - 막대그래프 그리기 
# : 집단간의 비교를 할때 자주 사용하는 그래프 
# ex/ mpg에서 구동방식(drv)간 고속도로 연비차이(평균) 비교: f,r,4

# 1)구동방식에 따른 집단 구성 
library(dplyr)
result <-df %>% group_by(drv) %>% summarise(avg_hwy=mean(hwy))
result = as.data.frame(result)
result

# 2) 축 설정하기 (어떤 column을 맵핑할지) + 그래프 도시 
ggplot(data=result, 
       aes(x=drv, y=avg_hwy)) + 
  geom_col(width=0.5)  #컬럼 두께를 조절 가능 

# 3) 막대그래프 순서를 다시 잡아줄 경우(default는 이름 오름차순)
ggplot(data=result,
       aes(x=reorder(drv,-avg_hwy),  #그래프 긴 순서대로 
           y=avg_hwy)) +
  geom_col()

# 빈도 막대 그래프 
# 사용하는 함수는 geom_bar()

# raw data frame을 직접 이용해서 처리 (구동 별 빈도)
ggplot(data=df,
       aes(x=drv)) + #그래프 긴 순서대로 
            geom_bar() #geom_col은 y축도 선언되어야 함. 

# 구동 방식별 실린더 개수를 빈도로 잡아서 표현해주기(이중구조)
ggplot(data=df,
       aes(x=drv)) + 
  geom_bar(aes(fill=factor(cyl)))

# 구동 방식별 변속기 종류를 빈도로 잡아서 표현해주기(이중구조)
ggplot(data=df,
       aes(x=drv)) + 
  geom_bar(aes(fill=factor(trans)))

# 구동 방식별 차종을 빈도로 잡아서 표현해주기(이중구조)
ggplot(data=df,
       aes(x=drv)) + 
  geom_bar(aes(fill=factor(class)))

# - 히스토그램 (histogram)
#: 연속형 자료에 대한 도수분포표를 시각화한 그래프다.
# 연속형 자료를 계급으로 나누어 계급별 도수를 막대로 나타낸다.
ggplot(data = df,
       aes(x=drv)) +
  geom_histogram() #출력이 안된다.
                  #(변수가 factor형, 연속형 변수가 와야한다.)
ggplot(data = df,
       aes(x=hwy)) + #연속형 변수인 hwy 
  geom_histogram()   #히스토그램 도출 확인
                     #(최소부터 최대까지 30개 영역으로 분할 )

###############################
# - 선 그래프(시계열 데이터)
# 일반적으로 환율, 주식, 경제동향과 같은 시계열 데이터 표현 
# (mpg는 시계열 데이터가 없으므로, 다른데이터 셋(economics data set)
# 이용 )
# economics : Fred economic data에서 제공하는 미국 경제에 대한 날짜별 시계열 데이터 집합
help(economics)
economics_long
tail(economics)

#날짜별 실업률에 대한 선 그래프 출력 
ggplot(data=economics, 
       aes(x=date,
           y=unemploy)) +
  geom_line() +
  geom_point(color="red") #동시출력 가능능


#날짜별 개인 저축률 동향 그래프 
ggplot(data=economics, 
       aes(x=date,
           y=psavert)) +
  geom_line()

##########################
# -박스 그래프(boxplot) 그리기  
# 데이터의 분포를 쉽게 볼 수 있다.
# ex/ 구동방식별 연비에 대하여 상자 그림 그리기 (다시 mpg)
ggplot(data=df,
       aes(x=drv,
           y=hwy)) +
  geom_boxplot()

##########################################################
# 이렇게  ggplot2를 이용해서 4가지 종류의 그래프를 그려봄 
# 여기에 추가적인 객체를 표함시켜서 그래프를 좀 더 이해하기 쉬운 형태로 만들어 볼 것이다. 

# mpg : 자동차 연비에 대한 data set 
# economics: 월별 경제 지표에 대한 data set 
# 날짜별 개인저축률에 대한 선 그래프를 그려본다. 
# (선 그래프와 직선그래프 포함 )
ggplot(data=economics,
       aes(x=date, y=psavert))+ 
  geom_line() +
  geom_abline(intercept=12.1,
              slope= -0.00034)  
#직접 명시적 기울기나 절편을 지정해야 그려짐 

#만약 x축과 수평 형태의 수평선을 도시하고 싶다? (평균에 대한 대조)
#→geom_hline 확인 
ggplot(data=economics,
       aes(x=date, y=psavert))+ 
  geom_line() +
  geom_hline(yintercept= mean(economics$psavert))


# 수직선도 그릴 수 있다.(geom_vline)
# 가장 개인 저축률이 낮은 날짜에 대한 수직선을 도시 
tmp <- economics %>% filter(psavert == min(psavert)) %>%
              select(date)

tmp <- as.data.frame(tmp)
result <- tmp$date #최종적인 날짜 도출 , "2005-07-01"

ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_vline(xintercept=result)
#또는
ggplot(data=economics,
       aes(x=date, y=psavert)) +
  geom_line() +
  geom_vline(xintercept=as.Date("2005-07-01")) #직접 특정 날짜 입력 

help(as.Date)

#################################
# 그래프 안에서 text 표현하기 

ggplot(data=economics,
       aes(x=date, y=psavert)) + 
  geom_point() + 
  xlim(as.Date("1990-01-01"),
       as.Date("1992-12-01")) + #x쪽 영역잡기
  ylim(7,10) +                  #y쪽 영역잡기 
  geom_text(aes(label=psavert,  
                vjust=0,      
                hjust=-0.2))     #택스트 표시 
                                 #양수 음수로 표시위치 조정가능



# 그래프 안에서 그림 그리기 (네모, 화살표 등)
# 특정 영역을 highlighting 하기 위해서 사용해요 

#ex1)네모 영역 그리기
ggplot(data=economics, 
       aes(x=date, y=psavert)) + 
  geom_point() + 
  annotate( "rect",  #annotate: 특정 표시를 덧씌울때(여기선 네모)
    xmin = as.Date("1990-01-01"),
    xmax = as.Date("1992-01-01"),
    ymin=5,
    ymax=10,   #표시할 네모 사이즈 표시 
    alpha = 0.3, #투명도
    fill = "red")#채우기 색 
                  
            
#ex2)화살표 그리기 + 기타 
ggplot(data=economics, 
       aes(x=date, y=psavert)) + 
  geom_point() + 
  annotate( "rect",  #annotate: 특정 표시를 덧씌울때(여기선 네모)
            xmin = as.Date("1990-01-01"),
            xmax = as.Date("1992-01-01"),
            ymin=5,
            ymax=10,   #표시할 네모 사이즈 표시 
            alpha = 0.3, #투명도
            fill = "red") + #채우기 색 
  annotate("segment",  #(특정 영역을 가리키는) 화살표 표시 
           x=as.Date("1985-01-01"),
           xend=as.Date("1992-01-01"),
           y =7.5,
           yend =8.5,
           arrow=arrow(),
           color="blue") +
  annotate("text",     # 특정 위치에 문구 표시 
           x=as.Date("1985-01-01"),
           y=15,
           label ="소리없는 아우성!!") +
  labs(x="연도", y="개인별 저축률",
       title= "연도별 개인저축률 추이") +#축과 그래프에 타이틀 지정
  theme_light()   #그래프 배경 테마 표시 


########################################################
#2. 한글 형태소 분석 및 wordCloud
#- 자연어 처리 기능 이용하기 
#형태소 : 의미를 가진 가장 작은 단위 
#언어학적으로 추출하기, 특히 한글의 형태소는 애매해서 힘든작업 

#koNLP package : Korean Natural language Process 한글 텍스트 분석을 지원하는 패키지(해당 패키지 안에 사전이 포함되어 있다.) 
# 총 3가지의 사전 포함: 시스템 사전(28만개), 세종 사전(32만개), NIADic 사전(98만개)→ 가장 정확한 결과 추출 가능 

# Java 기능을 이용한다. : 시스템에 jre(자바 실행환경)가 깔려 있어야 한다. 
# JRE를 설치를 하긴 했는데, R package가 JRE를 찾아써 써야한다. 
# JAVA_HOME 환경변수를 설정해야 한다. 
# read.xlsx 때(4강참조) 처럼 말고 시스템 속성 - 환경변수에 새로 만들면 할 때마다 안 만들어줘도 된다. 
# →시스템 변수 편집
#변수이름 : JAVA_HOME   변수 값: C:\Program Files\Java\jre1.8.0_231
# 컴퓨터 다시 시작하기 

# ※ 영문 NLP 분석은 → openNLP, Snowball 두개의 패키지를 잘 사용 
install.packages("KoNLP")
library(KoNLP)

useNIADic() #NIADic 사전 사용 

#명사 추출하기 
tmp = "이것은 소리없는 아우성!!"
extractNoun(tmp)      #[1] "이것" "소리" "아우" "성"  

#외부 파일 hiphop.txt 파일을 통해 분석하기 
txt <-readLines("C:/Users/student/Desktop/R강의 일람/191106 제 13강_데이터 시각화/hiphop.txt", encoding = "UTF-8")  
#한줄씩 읽으라는 기본함수(무슨파일인지 상관없이)

head(txt) #한글 외 특수문자 확인 가능 → 이따 한글만 남기고 제거 

#정규표현식을 이용해서 특수문자를 모두 찾아서 " "으로 변환         
library(stringr)    #문자열처리 
txt <- str_replace_all(txt, 
                       "\\W", " ")  #모든 특수기호를 찾아서 공백전환
                                    #\\W(대문자) 
head(txt) #형태소를 분석할 데이터 준비 완료 

# 함수를 이용해서 명사만 뽑아내기 
nouns <- extractNoun(txt)
head(nouns)

# 명사를 추출해서 list 형태로 저장 
length(nouns)  #[1] 4261, 각각 list안에 vector로 들어있기 때문에 
               # 실제로는 더 많음(만개 이상)

#(wordCloud 형태로 만들 수 있는) DF형태로 가공 
# 1) list 형태를 vector로 변환 
words <- unlist(nouns)     #base package의 unlist사용 
head(words)                #vector형태인것을 확인 

# 2) 많이 등장하는 명사만 추출 
head(table(words))          #어휘가 출력되지 않음. 

wordcloud <- table(words) #먼저 table형식으로 바꿔줌 
class(wordcloud)         #table
df = as.data.frame(wordcloud,
                   stringsAsFactors = F)
View(df)                
ls(df)        #컬럼 확인 
# 한 글자짜리는 사실 의미가 없다. → 두 글자 이상 
# 두 글자 이상의 빈도수가 높은 상위 20개 단어들만 추출 
library(dplyr)

word_df <- df %>% filter(nchar(words) >=2) %>%
                  arrange(desc(Freq)) %>%
                  head(20)#빈도수로 정렬
word_df #데이터 준비완료 
 
# 3)워드클라우드 실행시키기                             
install.packages("wordcloud")
library(wordcloud) #필요한 패키지를 로딩중입니다: RColorBrewer 
                   #워드 클라우드에서 사용할 색상에 대한 팔래트 설정

#Dark2라는 색상목록에서 8개의 색상을 추출 
pal <- brewer.pal(8, "Dark2")

#워드 클라우드는 만들때마다 랜덤하게 만들어진다(재현성x)
# → 랜덤함수의 시드값을 고정시켜서 항상 같은 워드 클라우드가 만들어지게끔 설정하기 
set.seed(1111) #아무의미없음(시드값을 정한다는 것이 중요한거지 
               # 무엇인지는 크게 관계 없음 )
wordcloud(words=word_df$words, #단어 데이터참조
          freq=word_df$Freq,   #빈도 데이터참조 
          min.freq = 2,   #단어별 표시 최소 빈도수 
          max.words = 200,#최대단어수 설정(어차피 전부20개밖에 없음)
          random.order = F,#위치를 랜덤하게 잡지않고 가운데로 잡을거
          rot.per = .2,   # 단어 회전 비율(가뜸 누워있는 단어 빈도)
          scale=c(4,0.3), # 단어 크기 범위 
          colors=pal) #색상은 미리 잡아놓은 팔레트 사용 


#######################즐거운 연습문제 타임 ########################
### 네이버 영화 댓글 사이트 
### 특정 영화에 대한 review를 crawling해서 
### wordcloud를 작성 
library(rvest)
library(stringr)
##(1) 해당url 데이터 crawling
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="
request_url <-str_c(url,"?",page,1) #문자열 합하기
request_url

html_page = read_html(request_url)
html_page
class(html_page)

nodes = html_nodes(html_page, "td.title > a.movie")

title <- html_text(nodes)
title <- html_text(nodes, trim = TRUE) #맨앞과 맨뒤이 공백 잘라내기 

nodes = html_nodes(html_page, "td.title")
review <- html_text(nodes)

review = str_remove_all(review,"\t")
review = str_remove_all(review,"\n")
review = str_remove_all(review,"신고")

##(2) 데이터 추출하기 
nouns <- extractNoun(review)

words <- unlist(nouns)     #base package의 unlist사용 
head(words)

wordcloud <- table(words) #먼저 table형식으로 바꿔줌 
class(wordcloud)         #table
df = as.data.frame(wordcloud,
                   stringsAsFactors = F)


#dplyr기능 실행 
word_df <- df %>% filter(nchar(words) >=2) %>%
  arrange(desc(Freq)) %>%
  head(20)#빈도수로 정렬

##(3) wordCloud 만들기 
pal <- brewer.pal(8, "Dark1")
help("brewer.pal")

set.seed(1111) 
wordcloud(words=word_df$words, #단어 데이터참조
          freq=word_df$Freq,   #빈도 데이터참조 
          min.freq = 1,   #단어별 표시 최소 빈도수 
          max.words = 200,#최대단어수 설정
          random.order = F,#위치를 랜덤하게 잡지않고 가운데로 잡을거
          rot.per = .2,   # 단어 회전 비율(가뜸 누워있는 단어 빈도)
          scale=c(4,0.3), # 단어 크기 범위 
          colors=pal)





# ※ 영화  '리얼' 평점 뽑아보기 
library(rvest)
library(stringr)


result <- data.frame()
url <- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=137008&target=after&page="
page <- "page="

for(i in 1:9){ 
  request_url <- str_c(url,"&",page,i)
  
  html_moviePage <- read_html(request_url, encoding="CP949")
  
  nodes_movie = html_nodes(html_moviePage, "td.title > a.movie")

  title <- html_text(nodes_movie)
  title <- html_text(nodes_movie, trim = TRUE) #맨앞과 맨뒤이 공백 잘라내기 
  
  nodes_movie = html_nodes(html_moviePage, "td.title")
  review <- html_text(nodes_movie)
  
  review = str_remove_all(review,"\t")
  review = str_remove_all(review,"\n")
  review = str_remove_all(review,"신고")
} 
 
View(review)
 ##(2) 데이터 추출하기 
  nouns <- extractNoun(review)
  
  words <- unlist(nouns)     #base package의 unlist사용 
  head(words)
  
  wordcloud <- table(words) #먼저 table형식으로 바꿔줌 
  class(wordcloud)         #table
  df = as.data.frame(wordcloud,
                     stringsAsFactors = F)
  
  
  #dplyr기능 실행 
  word_df <- df %>% filter(nchar(words) >=2) %>%
    arrange(desc(Freq)) %>%
    head(20)#빈도수로 정렬
  
  ##(3) wordCloud 만들기 
  pal <- brewer.pal(8, "Dark1")
  help("brewer.pal")
  
  set.seed(1111) 
  wordcloud(words=word_df$words, #단어 데이터참조
            freq=word_df$Freq,   #빈도 데이터참조 
            min.freq = 1,   #단어별 표시 최소 빈도수 
            max.words = 200,#최대단어수 설정
            random.order = F,#위치를 랜덤하게 잡지않고 가운데로 잡을거
            rot.per = .2,   # 단어 회전 비율(가뜸 누워있는 단어 빈도)
            scale=c(4,0.3), # 단어 크기 범위 
            colors=pal)
  
