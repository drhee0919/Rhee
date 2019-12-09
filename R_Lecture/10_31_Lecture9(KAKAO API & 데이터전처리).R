#10/31(목) 강의계획
#- KAKAO API(이미지 검색) + 찾은 Image 파일로 저장 
#- Selenium 을 이용한 동적 데이터 Crawling 
#- 공공 데이터 포탈(www.data.or.kr)
#- 데이터 전처리 

#####################################################
## KAKAO API(이미지 검색)를 이용해서 
# 이미지를 찾고 파일로 저장해 보아요 

# 사용하는 package는 network 연결을 통해서 서버에 접속해서
# 결과를 받아올 때 일반적으로 많이 사용하는 패키지를 사용할 것 

install.packages("httr") #http프로토콜 관련 가장 일반적인 패키지 
library(httr)
library(stringr)
# Open API의 주소를 알아야 호출하죠(카카오)
# 검색창에 kakao developer(카카오 개발자) 검색 → '검색'쪽 api 이용 
# → '이미지 검색' 확인(키 설명 필수 타입) 
url <- "https://dapi.kakao.com/v2/search/image" #서버 api따오기 

keyword <- "query=아이유" #붙여스자(완전다른문자)

request_url <- str_c(url, 
                     "?", 
                     keyword) # 가독성! (코딩 습관을 잘 들이자(indent) )

request_url <- URLencode(request_url) #원활한 한글사용을 위한 인코딩 
request_url # API 호출

#Open API를 사용할 때 거의 대부분 인증절차를 거쳐야 사용할 수 있다. 
apiKey<- "3ff18a312805d71ae9e6be0089c9bfb5" 
#카카오 개발자에서 받은 REST API키 입력 

#web에서 클라이언트가 서버쪽 ㅍ로그램을 호출할 때 여러호출방식이 존재(4가지)
# 1) GET, 2) POST, 3)PUT, 4)DELETE 4가지 다이용하는건 rest pool 이라 함 
# 일반적으로는 GET, POST 방식을 이용 
#GET방식 : 서버 프로그램을 호출할 때, 전달 데이터를 URL뒤에 붙여서 전달 
#POST방식 : 서버 프로그램을 호출할 때 전달 데이터가  request header에 붙어서 전달 


  result <- GET(request_url, 
                add_headers(Authorization=paste("KakaoAK",
                                                apiKey))) 
#카카오에서 정한 권한 및 키코드

http_status(result)    
#접속상태 결과 
                      
#안될 때 
#$category
#[1] "Client error"

#$reason
#[1] "Unauthorized"

#$message
#[1] "Client error: (401) Unauthorized"

#됐을 때 
#$category
#[1] "Success"

#$reason
#[1] "OK"

#$message
#[1] "Success: (200) OK"

result_data <- content(result) #httr패키지네 content함수
                               #결과를 추출 
result_data;

View(result_data) 
# 결과창의 image url 주고 다 긁어오자 

res<- vector()

for(idx in 1:80) {
  res[idx] <- result_data$documents[[idx]]$thumbnail_url
  
}
# 링크추출이 아닌 raw데이터를 그대로 받고 싶다면?

for(idx in 1:length(result_data$documents)) {
  req <- result_data$documents[[idx]]$thumbnail_url
  res = GET(req) # 이미지에 대한 응답 
  imgData = content(res, "raw")
  # 결과로 받은 이미지를 raw형태로 추출 
  writeBin(imgData, 
           paste("C:/R_Lecture/image/img", 
           idx,
           ".png")
          )
            #저장할 폴더 만들고 경로설정
            #img1.png , img2.png ... 계속 저장 
           
    }

help(writeBin)
res
View(res) #출력하기 

help(GET)
##############################
## Selenium 을 이용한 동적 페이지 scraping & crawling해보기 
# 상기 API실습 방법처럼 데이터를 구축할 수 없는 상황이 있다. 
# 가령 우리가 작업한 상황은
# ex1/ 네이버 영화 댓글 사이트 : 클라이언트가 request 보내고 서버 프로그램이 요청을 받는다. → 서버 프로그램이 결과 HTML page를 생성해서 클라이언트에게 response 로 전달
# → 클라이언트는 Selector와 xpath를 이용하여 전달된 HTML 내에 있는 필요한 데이터를 추출 
# ex2/ KAKAO 이미지 검색 API(Open API 이용해서 데이터 구축하는 방식)
#, 영화진흥위원회 OPEN API 클라이언트(R)가 request를 보내고 서버 프로그램이 요청을 받는다. → 서버 프로그램이 결과 JSON 문자열을 생성해서 클라이언트에게 response로 전달 →이 결과 데이터를 dDframe으로 받아요! → Data Frame을 이용해서 결과를 추출하는 방식 

#데이터를 분석하기 쉬운 적절한 형태로 적절하느냐가 데이터 과학의 핵심역량(분석은 기계가) 
# 상기 두가지 방향으로 해석할 수 없는 상황이 발생한다.

#Selenium : 브라우저 자동 제어 프로그램 
#1) selenium 검색 (https://www.seleniumhq.org) -> download -> ver.3.141.59 다운받기 (JAVA프로그램(EXE아니다)이므로 JDK환경 조성 필요) 

#2) 크롬에서 설정 → Chrome 정보 → Chrome버전 확인(버전 78.0.3904.70) →	https://chromedriver.chromium.org/ 에서 최신 안정화 버전 다운 
#(버전정보와 맞는지 확인) →  다운받은거 경로를 환경변수 Path에 추가 (내 컴퓨터 우클릭-시스템속성-고급-환경변수)  
#(*크롬 브라우저를 자동으로 제어하려면 chrome driver 가 필요)

#3) Selenium Server 기동 → "java-jar파일명-port4445"
# : cmd창 → cd 셀레니움 저장 폴더 → 상기 명령어 입력
#(java -jar selenium-server-standalone-3.141.59.jar -port 4445)

#4) 예제풀이를 위한 web deploy(Eclipse사용), my sql 기동 (ex/ 도서검색 프로그램) 

#5) selenium 을 R에서 사용할 수 있도록 도와주는 package 설치 
install.packages("RSelenium")
library(RSelenium)

#6) R에서 selenium 서버에 접속, remote driver 객체를 return 받기 
#   : 직접이 아닌 원격으로 브라우저를 제어하겠다는 것 
remDr <- remoteDriver(remoteServerAddr="localhost",
                      port=4445,
                      browserName="chrome")
                      #4)에서 실행시킨 서버에 접속 
remDr                 # 접속에 성공하면chrome을 Rcode로 제어가능

remDr$open()          #크롬 브라우저가 뜨게 됨 

#7) scraping 한 페이지를 팝업한 브라우저 주소창에 기입 
# ex/ 도서검색 프로그램 (http://localhost:8080/ajax/index.html)
remDr$navigate("http://localhost:8080/ajax/index.html")
remDr$navigate("http://localhost:8080/bookSearch/index.html")
# ※수업때 연산프로그램에서 환경 옮겼으면 후자도 가능 

#8)태그를 통해서 검색창(입력상자) 찾기(CSS,또는 xpath로)
inputBox <- remDr$findElement(using="css", 
                              "[type=text")

#9)찾은 입력상자에 검색어를 넣어요(값을 여러개 넣을 수 있게 list선언)
inputBox$sendKeysToElement(list("여행")) #reference확인해서 연습 

#10)검색을 하기 위해(=AJAX호출하기 위해) 버튼을 먼저 찾기
btn <- remDr$findElement(using="css",
                         "[type=button]")
#11) 찾은 버튼에 click event를 발생
btn$clickElement()

#12) AJAX 호출이 발생해서 출력된 화면에서 필요한 내용을 추출 
#    : 해당화면 f12로 구성 확인
li_element = remDr$findElements(using="css",
                                "li")
#13)이렇게 얻어온 element 각각에 대해서 함수를 호출
myList <- sapply(li_element,function(x){
                   x$getElementText()
}) 

for(i in 1:length(myList)){
  print(myList[[i]])
} #검색결과 출력 



