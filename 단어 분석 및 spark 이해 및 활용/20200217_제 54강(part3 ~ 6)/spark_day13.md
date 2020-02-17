```
#json이나 csv파일로부터 DataFrame구조로 로드해서 데이터 처리하는 방법
#json이나 csv파일로부터 스키마 구조를 정의(create table구문~)를 메타스토어 hive.warehouse를 기본 저장소에 등록후 sql을 사용해서 데이터 처리 가능

spark-sql> create table flights (
             dest_country_name string,
             origin_country_name string,
             count long)
             using json options (path '/home/tutor/data/2015-summary.json');
spark-sql> describe table  flights;

spark-sql> cache table flights;
spark-sql> show databases;  --데이터베이스 목록 확인(default)
spark-sql> create database some_db;  --새로운 데이터베이스 생성
spark-sql> show databases;   --데이터베이스 목록 확인
spark-sql> select current_database(); --현재 사용중인 데이터베이스 이름 확인
spark-sql> use some_db;  --다른 데이터베이스를 사용하기 위해 전환
spark-sql> select current_database(); 

spark-sql> show tables;   --테이블 목록 확인
spark-sql> select * from default.flights; --default 데이터베이스에 등록된 테이블 데이터 조회
spark-sql> select current_database()
spark-sql> use default;
spark-sql> drop database if exists some_db;  --데이터베이스 삭제
spark-sql> show databases;

RDD는 spark 1.X의 핵심 API
spark 2.X의 사용 권장 API는 구조적 API(DataFrame, SQL, Dataset)이지만, 연산이 수행될때 RDD로 변환(최적화된 물리적 실행 계획을 만드는데 사용됨)되어 실행됩니다.

RDD :
불변성
Collection (객체를 저장하는 집합)
클러스터 (분산 환경)에서 파티션닝된 레코드들의 병렬 처리 지원
RDD레코드는 (수동으로 정의, 사용자 정의 포맷 형식)객체
 내부 구조를 스파크에서 파악할 수 없기 때문에 최적화를 수동으로 선언해 수행해야 하므로 최적화에 시간이 많이 걸리며
모든 값을 다루거나 값 사이의 상호작용도 모두 수동으로 정의해야 합니다.
제네릭 RDD
키-값 RDD

DataFrame : 스키마 (Field로 구성된 ROW 객체)
               내부 구조를 스파크에서 파악할 수 있기 때문에 최적화를 빠르게  자동으로 수행 (수작업이 줄어둠)

spark.range(10).rdd   #Row 타입을 가지는 RDD로 생성

spark.range(10).toDF("id").rdd.map(lambda row: row[0])

myCollection="Spark The Definitive Gude : Big Data Processing Made Simple".split(" ")
myCollection
words = spark.sparkContext.parallelize(myCollection, 2)
words   ##words는 RDD
words.take(5)

words.setName("myWords")
words.name()
words.distinct().count()       #트랜스포메이션 연산 -> 액션 연산

def startWithS(individual) :
    return individual.startswith("S")

words.filter(lambda word : startWithS(word)).collect()



myCollection="Spark The Definitive Gude : Big Data Processing Made Simple".split(" ")
myCollection
words = spark.sparkContext.parallelize(myCollection, 2)
words   ##words는 RDD

#map함수를 이용해서 key, value구조의 PairRDD로 생성
prdd = words.map(lambda word : (word.lower(), 1))  
prdd
prdd.take(5)

#키를 만들때는 keyBy() 함수 이용
keyword = words.keyBy(lambda word : (word.lower()[0])
#만들어진 키에 값 매핑
keyword.mapValues(lambda word : word.upper()).collect()
 
keyword.keys().collect()
keyword.values().collect()

keyword.lookup("s")  #키가 s인 값들 반환

PairRDD를 샘플링 - sampleByKey()
PairRDD 집계 함수 - countByKey()
groupByKey()
reduceByKey()

chars = words.flatMap(lambda word: word.lower())
KVcharacters = chars.map(lambda letter : (letter, 1))

###########################################
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Test1").config("spark.executor.instances", "1").config("spark.executor.cores", "1").config("spark.executor.memory", "2g").config("spark.driver.memory", "2g").getOrCreate()

myCollection="Spark The Definitive Gude : Big Data Processing Made Simple".split(" ")
myCollection
words = spark.sparkContext.parallelize(myCollection, 2)
chars = words.flatMap(lambda word: word.lower())
chars.collect()

KVcharacters = chars.map(lambda letter : (letter, 1))
KVcharacters.collect()

KVcharacters.countByKey()

#내부 조인
import random
distinctChars = words.flatMap(lambda word: word.lower()).distinct()
distinctChars.collect()

keyedChars =  distinctChars.map(lambda c: (c, random.random()))
keyedChars.collect()
distinctChars.count()
KVcharacters.count()
KVcharacters.join(keyedChars).collect()


############Spark MLlib의 Vector 생성 실습################# 
#가상환경 활성화 상태에서 pip install scipy numpy


import numpy as np
import scipy.sparse as sps
from pyspark.mllib.linalg import Vectors

# dense vector
v1 = np.array([0.1, 0.0, 0.2, 0.3])
v2 = Vectors.dense([0.1, 0.0, 0.2, 0.3])
v3 = [0.1, 0.0, 0.2, 0.3]

# sparse vector
v3 = Vectors.sparse(4, [(0, 0.1), (2, 0.2), (3, 0.3)])
v4 = Vectors.sparse(4, [0, 2, 3], [0.1, 0.2, 0.3])
v5 = sps.csc_matrix((np.array([0.1, 0.2, 0.3]), np.array([0, 2, 3]), np.array([0, 3])), shape = (4, 1))
print(v1)
print(v3.toArray())
print(v5)


import numpy as np
from scipy.sparse import csc_matrix
csc_matrix((3, 4), dtype=np.int8).toarray()
출력 내용 :
array([[0, 0, 0, 0],
       [0, 0, 0, 0],
       [0, 0, 0, 0]], dtype=int8)

 row = np.array([0, 2, 2, 0, 1, 2])
col = np.array([0, 0, 1, 2, 2, 2])
data = np.array([1, 2, 3, 4, 5, 6])
 csc_matrix((data, (row, col)), shape=(3, 3)).toarray()
출력 내용 :
array([[1, 0, 4],
       [0, 0, 5],
       [2, 3, 6]])

indptr = np.array([0, 2, 3, 6])  # CSC format index pointer array  
indices = np.array([0, 2, 2, 0, 1, 2])  #CSC format index array 행인덱스
data = np.array([1, 2, 3, 4, 5, 6])
csc_matrix((data, indices, indptr), shape=(3, 3)).toarray()
출력 내용 :
array([[1, 0, 4],
       [0, 0, 5],
       [2, 3, 6]])
# data[indptr[i]:indptr[i+1]]
for column i are stored in indices[indptr[i]:indptr[i+1]] 0:1 
```