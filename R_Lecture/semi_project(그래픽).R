install.packages("ggmap")
install.packages("gglplot2")
install.packages("raster")
install.packages("rgeos")
install.packages("maptools")
install.packages("rgdal")
install.packages("tidyverse")
install.packages("sf")
install.packages("viridis")
library(ggmap)
library(ggplot2)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)
library(stringr)
library(tidyverse)
library(sf)
library(viridis)
sessionInfo()




raw <- "C:/R_Lecture/data/SIG_201905/CCTV11.csv"


df <- read.csv(file = raw,
               header = T,
               fileEncoding = "UTF-8")
View(df)

map <- shapefile("C:/R_Lecture/data/SIG_201703/TL_SCCO_SIG.shp") #좌표계 설정 

map <- spTransform(map,CRSobj = CRS("+proj=longlat +ellps=WGS84 +datumWGS84 +no_defs"))
korea_map <- fortify(map,region ="SIG_CD")

class(korea_map)
View(korea_map)


#서울시만 뽑아내기 
korea_map$id <- as.numeric(korea_map$id)
seoul_map <- korea_map[korea_map$id <= 11740,]
View(seoul_map)
map_merge <- merge(seoul_map, df, by="id")
View(map_merge)

cameras <- ggplot() + geom_polygon(data = map_merge,
                        aes(x=long, y = lat, group = group, fill=X2018),
                        color = "gold") 
cameras



#########################################################################

install.packages("readxl")
library(readxl)

raw <- "C:/R_Lecture/data/Seoul_Police_Stations(2018).xls"


df <- read_excel(path = raw, 
                 col_names = T)
View(df)

map <- shapefile("C:/R_Lecture/data/SIG_201703/TL_SCCO_SIG.shp") #좌표계 설정 

map <- spTransform(map,CRSobj = CRS("+proj=longlat +ellps=WGS84 +datumWGS84 +no_defs"))
korea_map <- fortify(map,region ="SIG_CD")

class(korea_map)
View(korea_map)


#서울시만 뽑아내기 
#행정구별 치안시설 인구대비비율을 그림으로 도출((치안시설/구 인구)*100)
korea_map$id <- as.numeric(korea_map$id)
seoul_map <- korea_map[korea_map$id <= 11740,]
View(seoul_map)
map_merge <- merge(seoul_map, df, by="id")
View(map_merge)

cameras <- ggplot() + geom_polygon(data = map_merge,
                                   aes(x=long, y = lat, group = group, 
                                       fill=치안시설비율),
                                   color = "white") 
cameras + scale_fill_gradient(low='white', high='#004ea2') +
  scale_fill_viridis(direction=-1) + theme_void()



#########################################################################

#인구 10만명당 치안센터 비율로 구하기 
install.packages("readxl")
library(readxl)

raw <- "C:/R_Lecture/data/Seoul_Police_Stations(2018).xls"


df <- read_excel(path = raw, 
                 col_names = T)
#View(df)
#치안시설 비율 순서 
df2 <- arrange(df,
        desc(치안시설비율2))

View(df2)

map <- shapefile("C:/R_Lecture/data/SIG_201703/TL_SCCO_SIG.shp") #좌표계 설정 

map <- spTransform(map,CRSobj = CRS("+proj=longlat +ellps=WGS84 +datumWGS84 +no_defs"))

korea_map <- fortify(map,region ="SIG_CD")

class(korea_map)
View(korea_map)


#서울시만 뽑아내기 
#행정구별 치안시설 인구대비비율을 그림으로 도출((치안시설/구 인구)*100)
korea_map$id <- as.numeric(korea_map$id)
seoul_map <- korea_map[korea_map$id <= 11740,]
View(seoul_map)
map_merge <- merge(seoul_map, df, by="id")
View(map_merge)

cameras <- ggplot() + geom_polygon(data = map_merge,
                                   aes(x=long, y = lat, group = group, 
                                       fill=치안시설비율2),
                                   color = "white") 
cameras + scale_fill_gradient(low='white', high='#004ea2') +
  scale_fill_viridis(direction=-1) + theme_void()

############################################################################

## 읍에 대한 좌표 지도 구하기 
##읍면동 단위로 나눈 지도 데이터 가져와 


small_map <-shapefile("C:/R_Lecture/data/EMD_201703/TL_SCCO_EMD.shp")
small_map <- spTransform(small_map,CRSobj = CRS("+proj=longlat +ellps=WGS84 +datumWGs84 +no_defs"))

small_map <- fortify(small_map,region ="EMD_CD")
View(small_map)

# 서울시 치안시설 통계 데이터(읍단위로 나눠져 있진 않지만 그냥 해보자)
# 걍 때려치고 출력안되는 이유를 찾기위해 CCTV 분포로 가자 
#raw <- "C:/R_Lecture/data/SIG_201905/CCTV11.csv"
#df <- read_excel(path = raw, 
#                 col_names = T)

df <- read.csv(file = raw,
               header = T,
               fileEncoding = "UTF-8")

df <- as.data.frame(df)
View(df)

#25. 강동구
#shp 파일에서 용산구만 뽑아내기(근데왜 강동구가 나오냐 빡치네)
small_map$id <- as.numeric(small_map$id)
yongsan_map <- small_map[(11740100 < small_map$id) & (small_map$id <= 11740110),]
View(yongsan_map) 
View(small_map)
str(yongsan_map)
yongsan_merge <- merge(yongsan_map, df, by="id")
View(yongsan_merge)


#일단 merge안한 지도부터 
ggplot() + geom_polygon(data = yongsan_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")


#1. 종로구 
#shp 파일에서 용산구만 뽑아내기(뭐야 개넓어)
jongro_map <- small_map[(11110100 < small_map$id) & (small_map$id <= 11110290),]


#일단 merge안한 지도부터 
ggplot() + geom_polygon(data = jongro_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")


#2. 중구 
#shp 파일에서 중구만 뽑아내기
junggu_map <- small_map[(11140100 < small_map$id) & (small_map$id <= 11140174),]

#일단 merge안한 지도부터 
ggplot() + geom_polygon(data = junggu_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")


#3. 용산구
#shp 파일에서 용산구만 뽑아내기
yongsan_map <- small_map[(11170100 < small_map$id) & (small_map$id <= 11170136),]

#일단 merge안한 지도부터 
ggplot() + geom_polygon(data = yongsan_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")


#4. 성동구
sungdong_map <- small_map[(11200100 < small_map$id) & (small_map$id <= 11200122),]
ggplot() + geom_polygon(data = sungdong_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")



#5.광진구  
gwangjin_map <- small_map[(11215100 < small_map$id) & (small_map$id <= 11215109),]
ggplot() + geom_polygon(data = gwangjin_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")


#5.동대문구  
dongdaemoon_map <- small_map[(11230100 < small_map$id) & (small_map$id <= 11230110),]
ggplot() + geom_polygon(data = dongdaemoon_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")


#6.중랑구  
jungrang_map <- small_map[(11260100 < small_map$id) & (small_map$id <= 11260106),]
ggplot() + geom_polygon(data = jungrang_map,
                        aes(x=long,
                            y=lat,
                            group=group),
                        color="black")
#####일단 여기까지 


# merge한 지도 (여기서부터는 진행중) 
yongsan_merge <- ggplot() + geom_polygon(data = yongsan_merge,
                                         aes(x=long, 
                                             y=lat,
                                             group = group, 
                                             fill =X2018),
                                         color = "black")

yongsan_merge

