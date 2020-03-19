```
import pandas as pd
import folium 
 
# 학교 알리미 공개용 데이터
#서울시 중학생 졸업생 진로현황 데이터셋
#고등학교 진학률 데이터를 활용하여 속성이 비슷한 중학교끼리 클러스터를 만들어 보는 실습
file_path = './2016_middle_shcool_graduates_report.xlsx'
df = pd.read_excel(file_path, header=0)

# 열 이름 배열을 출력
print(df.columns.values) 
print(df.info()) 
print(df.head()) 
print(df.describe())

# 지도에 위치 표시
mschool_map = folium.Map(location=[37.55,126.98], tiles='Stamen Terrain', zoom_start=12)

# 중학교 위치정보를 CircleMarker로 표시
for name, lat, lng in zip(df.학교명, df.위도, df.경도):
    folium.CircleMarker([lat, lng],
                        radius=5,              # 원의 반지름
                        color='brown',         # 원의 둘레 색상
                        fill=True,
                        fill_color='coral',    # 원을 채우는 색
                        fill_opacity=0.7,      # 투명도    
                        popup=name
    ).add_to(mschool_map)

# 지도를 html 파일로 저장하기
mschool_map.save('./seoul_mschool_location.html')

# sklearn 라이브러리에서 cluster 군집 모형 가져오기 
from sklearn import cluster
from sklearn.preprocessing import StandardScaler

# 분석에 사용할 속성을 선택 (과학고, 외고_국제고, 자사고 진학률)
columns_list = [10,11,14]
X = df.iloc[:, columns_list]
print(X[:5])

# 설명 변수 데이터를 정규화
X = StandardScaler().fit(X).transform(X)

dbm = cluster.DBSCAN(eps=0.2, min_samples=5)
dbm.fit(X)   
 
cluster_label = dbm.labels_   
print(cluster_label)

# 예측 결과를 데이터프레임에 추가
df['Cluster'] = cluster_label
print(df.head())  

grouped_cols = [0, 1, 3] + columns_list
grouped = df.groupby('Cluster')
for key, group in grouped:
    print('* key :', key)
    print('* number :', len(group))    
    print(group.iloc[:, grouped_cols].head())
    print('\n')

#클러스터 0은 외고(국제고)와 자사고 합격률은 높지만 과학고 합격자가 없다
#클러스터 1은 자사고 합격자만 존재하는 그룹이고,
#클러스터 2는 자사고 합격률이 매우 높으면서 과학고와 외고(국제고) 합격자도 일부 존재한다.
#클러스터 3은 과학고 합격자 없이 외고(국제고)와 자사고 합격자를 배출한 점

colors = {-1:'gray', 0:'orange', 1:'blue', 2:'green', 3:'red', 4:'purple', 
          5:'coral', 6:'brown', 7:'brick', 8:'yellow', 9:'magenta', 10:'cyan'}

cluster_map = folium.Map(location=[37.55,126.98], tiles='Stamen Terrain', 
                        zoom_start=12)

for name, lat, lng, clus in zip(df.학교명, df.위도, df.경도, df.Cluster):  
    folium.CircleMarker([lat, lng],
                        radius=5,                   # 원의 반지름
                        color=colors[clus],         # 원의 둘레 색상
                        fill=True,
                        fill_color=colors[clus],    # 원을 채우는 색
                        fill_opacity=0.7,           # 투명도    
                        popup=name
    ).add_to(cluster_map)

cluster_map.save('./seoul_mschool_cluster.html')


#type(국립, 공립, 사립)열을 추가해서 다시 클러스터링 해봄
# X2 데이터셋에 대하여 위의 과정을 반복(과학고, 외고국제고, 자사고 진학률 + 유형)
from sklearn.preprocessing import LabelEncoder
 
label_encoder =LabelEncoder() 
onehot_type = label_encoder.fit_transform(df['유형'])
df['type'] = onehot_type
print(df.info())

from sklearn.preprocessing import StandardScaler
columns_list2 = [10,11,14, 22]
X2 = df.iloc[:, columns_list2]

X2 =  StandardScaler().fit(X2).transform(X2)
dbm2 = cluster.DBSCAN(eps=0.2, min_samples=5)
dbm2.fit(X2)  
df['Cluster2'] = dbm2.labels_   

grouped2_cols = [0, 1, 3] + columns_list2
grouped2 = df.groupby('Cluster2')
for key, group in grouped2:
    print('* key :', key)
    print('* number :', len(group))    
    print(group.iloc[:, grouped2_cols].head())
    print('\n')

cluster2_map = folium.Map(location=[37.55,126.98], tiles='Stamen Terrain',  zoom_start=12)

for name, lat, lng, clus in zip(df.학교명, df.위도, df.경도, df.Cluster2):  
    folium.CircleMarker([lat, lng],
                        radius=5,                   # 원의 반지름
                        color=colors[clus],         # 원의 둘레 색상
                        fill=True,
                        fill_color=colors[clus],    # 원을 채우는 색
                        fill_opacity=0.7,           # 투명도    
                        popup=name
    ).add_to(cluster2_map)

# 지도를 html 파일로 저장하기
cluster2_map.save('./seoul_mschool_cluster2.html')

##################################################
```