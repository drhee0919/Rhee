> **지난 나용 복습 **

```
통계적 속성을 조사하여 뛰어난 특성을 선택해서 차원을 축소하는 방법 :
분산값이 높은 특성을 선택 (VT variance thresholding)
특성들의 상관관계를 계산 , 상관관계가 큰 특성 선택 (dataframe.corr())
분류 작업에 관련 없는 특성 삭제 ( 카이제곱 통계 이용, SelectKBest(chi2, k=선택될 특성 개수), f-통계값)
관련 없는 특성의 개수가 아니라 상위 n 퍼센트 특성 선택 - SelectPercentile
모델 성능이 나빠질때까지 교차검증(cv, cross_val_score)을 사용해서 모델을 평가해서 특성 제거 - RFECV

비지도, 지도 알고리즘 모델 평가 목적 : 예측력 높이기 위해, 좋은 클러스터링 등....품질을 높임
샘플 데이터를 train과 test 데이터로 분리하여 학습 후 예측 : train_test_split()

일부가 아닌 전체 샘플 데이터를 test와 train 에 사용하려면 :  K-폴드 교차검증
K-폴드 교차 검증을  방복 수행 : RepeatedKFold

회귀분석 (지도 학습, target label)의 예측값을 target label과 비교해서 모델 평가 : 평균 제곱 오차

분류분석 (지도 학습, target label) : TP, TN, FP, FN의 confusion_matrix(), 정확도, 정밀도, 재현율 값일 비교 평가

군집평가는 클러스터  내의 샘플 데이터간의 거리는 가깝고, 클러스터간의 거리는 먼 값(silouette_score ,실루엣 계수)을 사용하여 평가

logistic regression로 이진분류 수행시 임계값 평가을 평가할 수 있습니다.
TPR과 FPR을 비교해주는 ROC곡선을 사용, predict_proba()로 예측 확률 계산
곡선이 위로 올라가고 곡선 아래 면적이 커질수록 좋은 모델로 평가할 수 있음
roc_auc_score()함수의 곡선 아래 면적 값이 1에 가까울수록 좋은 모델

train data량이 학습 알고리즘 성능에 영향 주는지 검증 => 학습 곡선(정확도와 재현율을 교차 검증) learning_curv()
분류모델의 평가 결과를 보고서로 생성 : classification_report()

학습 알고리즘의 모델 성능에 영향을 주는 파라미터 (하이퍼파라미터)의 값 범위를 사용해서 모델 성능 영향을 평가하기 위해 시각화 : validation_curve()

최선의 모델을 선택하기 위해 사용하는 완전 탐색 방법을 수행 : GridSearchCV
최선의 모델을 선택하기 위해 비용을 줄여주는 랜덤 서치를 사용하는 탐색 방법 : RandomizedSearchCV
```

----

#### 회귀분석 

> 가격, 매출, 주가, 환율, 수량 등 연속적인 값을 갖는 연속 변수를 예측하는데 주로 사용 

```
종속변수=예측변수
독립변수 =설명변수
단순선형회귀분석은 두 변수가 일대일로 대응되는 확률적, 통계적 상관성을 갖는 알고리즘(모델)을 찾는 것  (1차 함수로 표현되는 관계 y=aX+b)
선형관계 존재 여부 확인을 위해서 Seaborn의 regplot()는 두변수에 대한 산점도를 이용
회귀선은 Seaborn의 joinplot(kind='reg') 를 사용해서 출력
LinearRegression().fit() 은 학습(훈련)을 통해 coef_, intercept_
결정계수는 score()
모델을 이용해서 새로운 데이터에 대한 예측값은 predict()를 이용
```

```python
# 외부 데이터 auto-mpg.csv참고
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("./auto-mpg.csv", header=None)
#컬럼 이름 지정
df.columns =['mpg', 'cylinders', 'displacement', 'horsepower', 'weight', 'acceleration', 'model year', 'origin', 'name']
```

``` python
df.info()  # 데이터 자료형 확인

df.describe()  # 데이터 통계 요약 정보 확인

#horsepower 열의 고유값 확인
print(df['horsepower'].unique())
# ?를 np.nan으로 변경
df['horsepower'].replace('?', np.nan, inplace=True)
# 누락된 행 삭제
df.dropna(subset=['horsepower'], axis=0, inplace=True)

# 문자열을 실수형으로 변환
df['horsepower'] = df['horsepower'].astype('float')
df.describe()  # 데이터 통계 요약 정보 확인

#분석에 활용할 열(속성, 특성) 선택 - 연비, 실린더, 마력, 무게
ndf =df[['mpg', 'cylinders', 'horsepower', 'weight']]

#종속변수 Y는 연비로 다른 변수는 독립변수로 선형관계 존재 확인을 위해 산점도로 출력
ndf.plot(kind='scatter', x='weight', y='mpg', c='coral', s=10, figsize=(10, 5))
plt.show()
plt.close()

#seaborn으로 산점도 출력
fig = plt.figure(figsize=(10,2))
ax1 = fig.add_subplot(1, 2, 1)
ax2 = fig.add_subplot(1, 2, 2)

#seaborn으로 회귀선 표시
sns.regplot(x='weight', y='mpg', data=ndf, ax=ax1)
sns.regplot(x='weight', y='mpg', data=ndf, ax=ax2, fit_reg=False)
plt.show()
plt.close()

#seaborn으로 산점도와 히스토그램 표시 (조인트 그래프)
sns.jointplot(x='weight', y='mpg', data=ndf )  
sns.jointplot(x='weight', y='mpg', kind='reg', data=ndf )  #회귀선 표시
plt.show()
plt.close()

#seaborn으로 두 변수 간의 모든 경우의 수 그리기
sns.pairplot(ndf )   
plt.show()
plt.close()


#데이터 셋을 train과 test로 분리 (종속변수는 mpg, 독립변수는 weight)
X=ndf[['weight']]
y=ndf['mpg']

from sklearn.model_selection import train_test_split
#test data set 비율 30%
X_train, X_test, y_train, y_test = train_test_split (X, y, test_size=0.3, random_state=1)

#개수 확인
print('train  data 개수 : ', len(X_train))
print('test data 개수 : ',  len(X_test))

#train 데이터 셋으로 선형 회귀 모델 생성 
from sklearn.linear_model import LinearRegression
lr = LinearRegression()
lr.fit(X_train, y_train)

# 결정계수 출력
r_square = lr.score(X_test, y_test)
print('r 결정계수 :', r_square)

# 계수(기울기)
print('기울기 :', lr.coef_  )

# 절편
print('절편 :',  lr.intercept_ )

#예측값 생성
y_hat = lr.predict(X)

plt.figrue(figsize=(10, 5))
ax1 = sns.distplot(y, hist=False, label = "y")
ax2 = sns.distplot(y_hat, hist=False, label="y_hat", ax=ax1)
plt.show()
plt.close()
```

``` python
#######비선형회귀분석 ############################
#다항식으로 변환 클래스 : PolynomialFeature 
from sklearn.preprocessing import PolynomialFeature 

poly = PolynomialFeature (degree=2)
X_train_poly = poly.fit_transform(X_train)   

print('original data : ', X_train.shape)
print('2차항 변환 data : ', X_train_poly.shape)


# train data를 가지고 모형 학습
pr = LinearRegression()   
pr.fit(X_train_poly, y_train)

# 학습을 마친 모형에 test data를 적용하여 결정계수(R-제곱) 계산
X_test_poly = poly.fit_transform(X_test)       #X_test 데이터를 2차항으로 변형
r_square = pr.score(X_test_poly,y_test)
print(r_square)
print('\n')

```

``` python
########다중 회귀 분석 ##############################
#종속변수를 설명하는 독립변수가 두개일 때 단순회귀모형을 설정한다면 모형설정(specification)이 부정확할 뿐 아니라 종속변수에 대한 중요한 설명변수(독립변수)를 누락함으로써 계수 추정량에 대해 편의(bias)를 야기 시킬 수 있으므로 단순회귀분석은 그 유용성을 상실하게 된다. 따라서 다중회귀분석을 통해 편의현상(bias)을 제거할 수 있다 

X=ndf[['cylinders', 'horsepower', 'weight']]  #독립 변수 X1, X2, X3
y=ndf['mpg']     #종속 변수 Y

# train data 와 test data로 구분(7:3 비율)
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=10) 

print('훈련 데이터: ', X_train.shape)
print('검증 데이터: ', X_test.shape)   

from sklearn.linear_model import LinearRegression

# 단순회귀분석 모형 객체 생성
lr = LinearRegression()   

# train data를 가지고 모형 학습
lr.fit(X_train, y_train)

# 학습을 마친 모형에 test data를 적용하여 결정계수(R-제곱) 계산
r_square = lr.score(X_test, y_test)
print(r_square)
 
# 회귀식의 기울기
print('X 변수의 계수 a: ', lr.coef_)
 
# 회귀식의 y절편
print('상수항 b', lr.intercept_)
 
# train data의 산점도와 test data로 예측한 회귀선을 그래프로 출력 
y_hat = lr.predict(X_test)

plt.figure(figsize=(10, 5))
ax1 = sns.distplot(y_test, hist=False, label="y_test")
ax2 = sns.distplot(y_hat, hist=False, label="y_hat", ax=ax1)
plt.show()
plt.close()

```

``` python
#참고 코드 :
sns.pairplot(df[[ 'cylinders', 'horsepower', 'weight', 'acceleration', 'displacement']]) 

# 다중 공선성 확인 : variance_inflation_factor()
from patsy import dmatrices
from statsmodels.stats.outliers_influence import variance_inflation_factor

y, X = dmatrices('mpg ~ cylinders + horsepower + weight + acceleration + displacement', df, return_type='dataframe')
vif = pd.DataFrame()
vif['VIF Factor'] = [variance_inflation_factor(X.values, i) for i in range(X.shape[1])]
vif["features"] = X.columns
vif
```

[https://bkshin.tistory.com/entry/DATA-20-%EB%8B%A4%EC%A4%91%EA%B3%B5%EC%84%A0%EC%84%B1%EA%B3%BC-VIF](https://bkshin.tistory.com/entry/DATA-20-다중공선성과-VIF)