df1 <- read.csv(file = "C:/lecture2/data/lonlat.csv",
                fileEncoding = "UTF-8")
df1
str(df1)

install.packages() # CRAN에서 받아서 설치
install.packages("devtools")
library(devtools)
install_github("dkahle/ggmap") #이놈을 이용하기 위해서 dextools 패키지 먼저 설치
library(ggmap)
#https://cloud.google.com/maps-platform/terms/ -> 로그인하고 get start->maps

# 생성한 구글 API Key
key_t = "AIzaSyDb8Oqv9AqTVBFWUKyOZh1SkSv_9SeEtKI" #선생님 key
googleAPIKey = "AIzaSyBlxzwHJxYYtneVllnd2rsGzxIVEHVm5uE"

# 구글 API Key를 이용해서 인증을 받아요!
register_google(key=googleAPIKey)

gg_seoul <- get_googlemap("seoul", 
                          maptype = "roadmap") 
ggmap(gg_seoul)

library(dplyr)
library(ggplot2)

geo_code = geocode(enc2utf8("마포구")) #인코딩 to utf-8 #위도 경도 알아보기
geo_code # table형태

# google map을 그리려면 위도,경도가 숫자형태의 vector로 되어 있어야 해요!

geo_data = as.numeric(geo_code) # 값이 두개라서 vector로 됨
str(geo_data)

get_googlemap(center=geo_data, #이 위도 경도를 지도의 중앙으로 잡아  
              maptype = "roadmap",
              zoom=14)%>%   #지도 확대 표현, %>%를 사용해서 넘길 수있음
    ggmap() + #+로 그래프 지도 위에 그릴 수 있음
    geom_point(data=df1, #table형태의 data를 줘야 함
               aes(x=lon,
                   y=lat),
               size=1,
               color="red")
