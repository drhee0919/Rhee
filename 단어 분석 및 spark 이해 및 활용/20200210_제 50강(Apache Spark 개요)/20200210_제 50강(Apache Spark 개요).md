#### 아파치 스파크란? 

> 통합 컴퓨팅 엔진이며 클러스터 환경에서 데이터를 병렬로 처리하는 라이브러리 집합 
>
> 간단한 데이터 읽기에서부터 SQL처리, 머신러닝, 스트리밍 처리에 이르기까지 다양한 데이터 분석 작업을 동일한 연산 엔진과 일관성 있는 API로 행할 수 있도록 설계되어 있다. 
>
> 인메모리 기반의 대용량 데이터 고속 처리 엔진으로 범용 분산 클러스터 컴퓨팅 프레임워크 
>
> " 빅데이터 애플리케이션 개발에 필요한 통합 플랫폼을 제공하자 "
>
> ![spark_framework](../../../../TIL/TIL/image/spark_framework.png)
>
> 시스템적 설정 지원(일관된 model 개발) + library(ADF) + 성능검증전 유용 Component 
>
> - 스파크는 통합이라는 관점을 중시하면서 기능의 범위를 컴퓨팅 엔진을 제한
>
>   → 해당 영역은 클라우드 기반 및 분산 파일 시스템 저장소를 지원(특정 선호 X)
>
>   → 저장소 시스템의 데이터를 연산하는 역할만 수행 
>
> - 기본적으로 스칼라로 이루어진 JAVA 가상머신 위에서 작동한다. 
>
>   → 단, 스칼라 및 자바 이외에도, 파이썬, SQL 언어 역시 지원한다. 
>
> - 로컬 환경에서도 스파크를 내려받아 실행할 수 있다. (단, 자바개발 환경이 사전에 구성되어야 한다.)

```python
'''
Spark : 
- 통합 컴퓨팅 엔진이며 클러스터 환경에서 데이터를 병렬로 처리하는 라이브러리 집합
- 간단한 데이터 읽기에서부터 SQL처리, 머신러닝, 스트리밍 처리에 이르기 까지 다양한 데이터 분석 작업을  동일한 연산 엔진과 일관성 있는 API로 수행할 수 있도록 설계되어 있다
- 저장소 시스템의 데이터를 연산하는 역할만 수행


Spark Application 구성 = driver 프로세스 + executor 프로세스
driver 프로세스 : 클러스터 노드 중 하나에서 실행되며 main()함수를 실행
                       스파크 애플리케이션 정보의 유지관리, 
                       사용자 프로그램이나 입력에 대한 응답, 
                       전반적인 익스큐터 프로세스의 작업과 관련된 분석, 배포, 스케줄링 역할 	
                       수행
executor 프로세스 : 드라이버 프로세스가 할당한 작업을 수행함

SparkSession - 스파크 코드를 실행시키는 객체
                    드라이버 프로세스를 제어
                    하나의 스파크 애플리케이션에 대응(1:1)
                    콘솔 실행 방식에서는 자동 생성되므로 spark변수로 사용
'''
myRange = spark.range(1000).toDF("number")  #데이터로부터 DataFrame생성
divisBy2 = myRange.where("number %2 = 0" )  #트랜스포메이션 연산, 새로운 DataFrame으로 결과 생성
divisBy2.count()  #액션연산


#csv파일로부터 데이터프레임 생성
flightData2015 = spark.read.option("inferSchema", "true").option("header", "true").csv("/home/tutor/data/2015-summary.csv")

flightData2015.take(3)   #액션 연산으로 3개의 행 확인 
flightData2015.sort("count").explain()  #정렬, 실행계획 확인


DataFrame :  Spark의 구조적 데이터를 표현하는 타입 
                  2차원구조의 컬럼, row로 데이터를 표현
                  생성되면 객체 변경 불가(불변객체)
                  toDF() 또는 SparkSession.read(spark.read)
                  다양한 데이터 타입의 테이블형 데이터를 보관할 수 있는 Row타입의 객체로 구성된 분산 컬렉션

파티션 : 클러스터에서 병렬로 실행하려면 데이터 chunk가 클러스터 노드에 분산 저장되어 있어야 합니다.


SparkSQL은 sql로 처리하거나 DataFrame을 이용해서 구조적 API의 메서드를 이용해서 SQL방식으로 처리할 수 있습니다.
DataFrame을 이용해서 SQL방식으로 처리하려면 테이블 또는 임시테이블(View)에 등록해야 합니다.


flightData2015 = spark.read.option("inferSchema", "true").option("header", "true").csv("/home/tutor/data/2015-summary.csv")
flightData2015.createOrReplaceTempView("flight_data_2015")
sqlWay = spark.sql("""
   select dest_country_name, count(1)
   from flight_data_2015
   group by dest_country_name
   """)
dataFrameWay = flightData2015.groupBy("DEST_COUNTRY_NAME").count()

sqlWay.explain()
dataFrameWay.explain()

from pyspark.sql.functions import max
flightData2015.select(max("count")).take(1)


flightData2015.printSchema()
flightData2015.print()

sqlWay
sqlWay.printSchema()


#트랜스포메이션 연산 - 변환, 필터, 매핑 처리 결과가 DataFrame타입으로 반환
#액션 연산 - 데이터 출력, 집게, 출력 데이터 소스에 저장, 처리 결과가 DataFrame 타입이 아닌 값이나 형태


#스파크 구조적 스트리밍 API
배치모드 연산 + 지연시간을 줄이는 증분처리 
```