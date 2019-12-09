getwd()
setwd("C:/R_Lecture")
## 1. R에서 \JSON처리 
# Network를 통해서 JSON 데이터를 받아서 Data Frame으로 만들기 위해 새로운 
# package 를 이용해보자 

#1. package 설치 
install.packages("jsonlite")
install.packages("stringr")
install.packages("httr") # 네트워크 연결에 필요한 패키지
#2. package를 사용하기 위해 loading 작업 필요.
library(jsonlite)
library(httr)
#3. 문자열을 처리하기 위한 package (여기서는 stringr)
library(stringr)

#샘플 character하나 선언하기 
url <- "http://localhost:8080/bookSearch/search?keyword="

#키워드를 scan으로 읽어들일 수 있게 설정하기(한글키워드 사용시 에러)
request_url <- str_c(url, 
                     scan(what=character())) 

#한글이 가능하게 하려면? → url encoding필요
request_url <-URLencode(request_url)
request_url

#주소 완성시키기
df <- fromJSON(request_url) 

df       # df로 보기 
View(df) #데이터 프레임 차트로 보기 
str(df)  #해당 df에 대한 대략적인 정보 (value 포함)
summary(df) #해당 df에 대한 대략적인 정보 (class 및 mode유형 포함)
name(df) #df의 column 명, 즉 key값들을 확인하는 방법 

# 찾은 도서 제목만 console에 출력하기(==행이 개수만큼 출력) 
for (idx in 1:nrow(df)) {
  print(df$title[idx])
}


# JSON을 이용해서 Data Frame을 생성할 수 있어요 
# data frame을 csv형식으로 file에 저장 

write.csv(df, 
          file = "C:/R_Lecture/data/book.csv",
          row.names = FALSE,
          quote = FALSE) #쌍 따옴표 빼고 싶을 때 
                         #단, 자료제목 등에 따옴표가 있을 수 도 있기 때문에                          #처리상 문제를 막기 위해 비추천 

# (df로 바꾸지 않고 기존처럼) JSON을 그대로 싶을떄,
# Data Frame을 JSON으로 변경하려면 어떻게?
df_json <- toJSON(df)
df_json   #데이터 형식 변화여부 확인 
prettify(df_json)#(크롬에서 json 리스트 본 것처럼)깔끔하게 출력 

#json 형태로 다시 쓰기 
write(df_json, file="C:/R_Lecture/data/book_json.txt")
#구조화된 형태도 가능 
write(prettify(df_json), file="C:/R_Lecture/data/book_json.txt")


#################################
#연습문제 1 
# 2018년 10월 30일 박스오피스 순위를 알아내서 
#제목과 누적관람객 수를 CSV 파일로 저장할 것 

# (1) 단순무식하게
 m_url <- "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=180bd775952d53adb92d8dcf2c6fd2d4&targetDt="

request_m_url<-str_c(m_url, scan(what=character())) 


df1<-fromJSON(request_m_url)
df1
str(df1)

write.csv(df1, 
          file = "C:/R_Lecture/data/movie_list.csv",
          row.names = FALSE)

df2 <- df1$boxOfficeResult$dailyBoxOfficeList$movieNm
df3 <- df1$boxOfficeResult$dailyBoxOfficeList$audiAcc
write.csv(df2, 
          file = "C:/R_Lecture/data/movie_Nm.csv")
write.csv(df3,
          file = "C:/R_Lecture/data/audi_Acc.csv") 

df4 <- cbind(df2,df3)

df4
write.csv(df4,
          file = "C:/R_Lecture/data/movie_aud.csv")
#(1.5)깔끔하게 이름설정
UBD <- data.frame(영화명=df2, 누적관람객수=df3)
write.csv(UBD,
          file = "C:/R_Lecture/data/UBD_list.csv")
View(UBD)
#(2)다른풀이방법 
df_nnew <-df1$boxOfficeResult$dailyBoxOfficeList ##1
df_nnew
str(df_nnew)
newdf <- data.frame(2,1:nrow(df_nnew))
for(idx in 1:nrow(df_nnew)) {
  newdf[[1]][[idx]] <- df_nnew$movieNm[idx]
  newdf[[2]][[idx]] <- df_nnew$audiCnt[idx]
}

str(newdf)
View(newdf)

####################################
# 2. web scraping & crawling(web spidering)
# -web scraping : 하나의 web page 에서 내가 원하는 부분을 추출하는 행위
# -web crawling(web spidering) : 
#  자동화 봇인 crawler가 정해진 규칙에 따라 복수개의 web page를 browsing 
# 하는 행위. 

# 1) web scraping
# scraping을 할 때 CSS(jQuery) selector를 이용해서 필요한 정보를 추출 
# selector를 이용해서 추출하기 힘든놈들도 있다.  
# → 추가적으로 xpath도 이용할 것 (XML식 표현법)

# 예제: 특정 사이트에 접속해서 내가 원하는 정보를 긁어옵시다. 
# ex/ Naver 영화댓글 
# :  https://movie.naver.com/movie/point/af/list.nhn&page=1

#(1) 서버로 부터 받은 HTML태그를 구성된 문자열을 자료구조화 시키는 패키지를 이용해야 한다. 
install.packages("rvest")
library(rvest)
library(stringr)

#(2) url 준비 
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="
request_url <-str_c(url,"?",page,1) #문자열 합하기
request_url

#(3) 준비된 URL로 서버에 접속해서 HTML을 읽어온 후 자료구조화(객체화)한다 
html_page = read_html(request_url)
html_page
class(html_page)  #[1] "xml_document" "xml_node" (기본적인 자료형은 아님)

#(4)selector를 이용해서 추출하기 원하는 요소를 선택해요 
nodes = html_nodes(html_page, "td.title > a.movie") # a는 html의 anchor
            # F12 element 및 ctrl + Shift +c (커서) 확인 
           #내가 이용하고자 하는 요소를 찾아내기 
nodes
#(5) tag 사이에 들어있는 텍스트를 추출 (태그들 잘라내기)
title <- html_text(nodes)
title <- html_text(nodes, trim = TRUE) #맨앞과 맨뒤이 공백 잘라내기 
title

#(6) selector를 이용해서 리뷰 요소(element)를 선택해요! 
nodes = html_nodes(html_page, "td.title")
review <- html_text(nodes)
review 

#(7)필요없는 문자들을 제거 
review = str_remove_all(txt,"\t")
review = str_remove_all(txt,"\n")
review = str_remove_all(txt,"신고")
review

#(8) 영화제목과 리뷰에 대한 내용을 추출 
df = cbind(title,review)
View(df)

#(9) 구축한 데이터를 파일에 저장하기 

######################################
# - Xpath 사용하기
# 이번에는 같은 작업을 xpath를 이용해서
# 이하 전과 동 
url <- "https://movie.naver.com/movie/point/af/list.nhn"
page <- "page="
request_url <-str_c(url,"?",page,1) #문자열 합하기
html_page =read_html(request_url)
nodes =html_nodes(html_page, "td.title>a.movie")
title <- html_text(nodes, trim = TRUE)

#review부분은 xpath로 가져와보기 

review = vector(mode="character", length = 10)
for(idx in 1:10) { 
  myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                  idx,
                 ']/td[2]/text()' )

nodes = html_nodes(html_page, xpath=myPath)

txt <- html_text(nodes, trim = TRUE)
review[idx] = txt[3]
}

df <- cbind(title, review)
View(df)
######################################
# 2) web crawling
# 아까 영화리뷰페이지의 1page 부분을 열람 및 scraping 해봄 
# 이번에는 반복해서 page를 browsing하는 crawling까지 포함해보아요


#* 함수를 만들어서 작업해야 한다! (myFunc()사용)
extract_comment <- function(idx) {
  url <- "https://movie.naver.com/movie/point/af/list.nhn"
  page <- "page="
  request_url <- str_c(url,"?",page,idx)
  html_page = read_html(request_url,
                        encoding = "CP949")
  nodes = html_nodes(html_page,"td.title > a.movie")
  title <- html_text(nodes, trim = TRUE)
  # Review부분은 xpath로 가져와 보아요!
  
  review = vector(mode="character", length=10)
  
  for(idx in 1:10) {
    myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',
                   idx,
                   ']/td[2]/text()')
    nodes = html_nodes(html_page,
                       xpath=myPath)
    txt <- html_text(nodes, trim = TRUE)
    review[idx] = txt[3]  
  }
  df = cbind(title,review)
  return(df)
}

### 함수를 호출해서 crawling을 해보아요!!
result_df = data.frame();

for(i in 1:10) {
  tmp <- extract_comment(i)
  result_df = rbind(result_df,tmp)
}

View(result_df)

##############################################################
# 연습문제2 (★수행평가)
# https://www.rottentomatoes.com/top/bestofrt/?year=2019

# 로튼토마토 사이트에서 
# 2019년 가장 인기있는 영화 100개에 대해서 
# 영화제목, User rating, Genre 부분을 추출하여 Data Frame으로 만들고 
# 파일로 출력하세요 

# (1) 제목 출력시키기
library(rvest)
library(stringr)
url <- "https://www.rottentomatoes.com/top/bestofrt/?year=2019"

html_page = read_html(url)
#xpath 이용 
nodes = html_nodes(html_page, xpath = '//*[@id="top_movies_main"]/div/table/tr[1]/td[3]/a')
#selector 이용
nodes = html_nodes(html_page,"td>a.unstyled.articleLink")

link <- html_attr(nodes,name='href')

title <-html_text(nodes, trim = TRUE)

View(title)
#(2) user rating, genre 출력시키기 
df2 <- data.frame()
for(i in 1:length(title)) {
  url_det <- "https://www.rottentomatoes.com" #기본 url
  request_url<-str_c(url_det,link[i]) #요청 url 대입 
  html_moviepage <- read_html(request_url)
  nodes_movie <- html_nodes(html_moviepage, "strong.mop-ratings-wrap__text--small")
  user_Rating <- html_text(nodes_movie, trim = T)[2]
  nodes_genre <- html_nodes(html_moviepage,"ul>li:nth-child(2)>div:nth-child(2)")
  genre <- html_text(nodes_genre, trim = T)[2]
  genre <- str_remove_all(genre, "\n")
  genre <- str_replace_all(genre," ","")  #데이터 정리(장르)
     
  genre<- str_replace_all(genre,",","&")  #데이터 정리(장르)
  genre
  df1 <- data.frame(user_Rating,genre)
  df2 <- rbind(df2,df1)
}
title<- as.data.frame(title)
df2 <- cbind(title,df2)
View(df2)








