#### 분류 분석

```
	################# 분류(classification)  #################
예측하려는 대상의 속성(설명 변수)을 입력 받고, 목표 변수가 갖고 있는 카테고리(범주형)값 중에서 어느 한 값으로 분류하여 예측한다.
고객 분류, 질병 진단, 스팸 메일 필터링, 음성 인식 등 목표 변수가 카테고리 값(범주형)을 갖는 경우에 사용한다.
KNN, SVM, Decision Tree, Logistic Regression등 

Logistic Regression는 종속변수(Y), 독립변수(X)간의 관계를 나타내는 예측모델이면서 목표 변수가 카테고리 값(범주형)을 갖는 경우에는 분류 분석에 해당된다
```

**로지스틱 회귀분석**

```python
#statsmodel 패키지의 로지스틱 회귀 분류 분석
from sklearn.datasets import make_classification 
import matplotlib.pyplot as plt
import seaborn as sns

X, y=make_classification(n_features=1,  n_redundant=0, n_informative=1, 
n_clusters_per_class=1, random_state=4)

plt.scatter(X, y, s=100, edgecolor="k", linewidth=2)
sns.distplot(X[y==0, :], label="y=0", hist=False)
sns.distplot(X[y==1, :], label="y=1", hist=False)
plt.ylim(-0.2, 1.2)
plt.show()
```

```python
#statsmodel 패키지에서 베르누이 분포를 따르는 로지스틱 회귀 모델 클래스 Logit 제공

import statsmodels.api as sm
x = sm.add_constant(X)
logit_model = sm.Logit(y, x)
logit_result = logit_model.fit(disp=0)
print(logit_result.summary())   # (4.2382x+0.2515)  

import numpy as np
xx = np.linspace(-3, 3, 100)
mu = logit_result.predict(sm.add_constant(xx))
plt.plot(xx, mu, lw=3)
plt.scatter(X, y, c=y, edgecolor="k", lw=2)
plt.scatter(X, logit_result.predict(x), label=r"$\hat{y}$", marker='s', c=y, s=100, edgecolor="k", lw=1)
plt.xlim(-3, 3)
plt.xlabel("x")
plt.ylabel(r"$\mu$")
plt.title(r"$\hat{y}$")
plt.legend()
plt.show()
```

``` python
#다중 클래스의 로지스틱 회귀 분석
from sklearn.linear_model import LogisticRegression
from sklearn import datasets
from sklearn.preprocessing import StandardScaler

iris = datasets.load_iris()   		# 데이터 로드
features = iris.data
target = iris.target

scaler = StandardScaler()   		# 특성을 표준화
features_standardized = scaler.fit_transform(features)
```

```python
# OVR 로지스틱 회귀 모델을 만듭니다.
logistic_regression = LogisticRegression(random_state=0, multi_class="ovr")
model = logistic_regression.fit(features_standardized, target) 	 # 모델 훈련
new_observation = [[.5, .5, .5, .5]] 		 # 새로운 샘플 데이터 생성
model.predict(new_observation)  			# 클래스 예측
model.predict_proba(new_observation)  


# MLR 로지스틱 회귀 모델을 만듭니다.
logistic_regression = LogisticRegression(random_state=0, multi_class="multinomial")
model = logistic_regression.fit(features_standardized, target) 	 # 모델 훈련
new_observation = [[.5, .5, .5, .5]] 		 # 새로운 샘플 데이터 생성
model.predict(new_observation)  		# 클래스 예측
model.predict_proba(new_observation)  
```

```python
##################로지스틱 회귀 분류 평가
# 타이타닉 데이터로부터 train-test 데이터 분리 (80:20) 생존률 예측
(# 분산을 줄이는 하이퍼파라미터 C을 구함)
# 로지스틱 회귀 모델을 사용하여 학습
#테스트 데이터에 대한 예측 결과 생성후 
# 정확도, 정밀도, 재현율 평가 결과 출력


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline

raw_data = pd.read_excel('titanic.xls')
raw_data.info()

# pclass : 객실 등급
#survived : 생존 유무
#sex : 성별
#age : 나이
#sibsp : 형제 혹은 부부의 수
#parch : 부모, 혹은 자녀의 수
#fare : 지불한 운임
#boat : 탈출한 보트가 있다면 boat 번호 

tmp = []
for each in raw_data['sex']:
    if each == 'female':
        tmp.append(1)
    elif each == 'male':
        tmp.append(0)
    else:
        tmp.append(np.nan)

raw_data['sex'] = tmp

raw_data['survived'] = raw_data['survived'].astype('int')
raw_data['pclass'] = raw_data['pclass'].astype('float')
raw_data['sex'] = raw_data['sex'].astype('float')
raw_data['sibsp'] = raw_data['sibsp'].astype('float')
raw_data['parch'] = raw_data['parch'].astype('float')
raw_data['fare'] = raw_data['fare'].astype('float')

raw_data = raw_data[raw_data['age'].notnull()]
raw_data = raw_data[raw_data['sibsp'].notnull()]
raw_data = raw_data[raw_data['parch'].notnull()]
raw_data = raw_data[raw_data['fare'].notnull()]

raw_data.info()
features  = raw_data[['pclass','sex','age','sibsp','parch','fare']]
features.info()
target = raw_data[['survived']].values
 
from sklearn.linear_model import LogisticRegressionCV

scaler = StandardScaler()  		# 특성을 표준화
features_standardized = scaler.fit_transform(features )

logistic_regression = LogisticRegressionCV( penalty='l2', Cs=1000, random_state=0, n_jobs=-1)
model = logistic_regression.fit(features_standardized, target )  # 모델 훈련
logistic_regression.C_


titanic = raw_data[['pclass','sex','age','sibsp','parch','fare', 'survived']]
from sklearn.model_selection import train_test_split
#test(valid)/train 을 2:8 로 randomly select
train, valid = train_test_split(titanic, test_size=0.2, random_state=0)

#train/valid set 완성! 
train_y=train['survived']
train_x=train.drop(['survived'], axis=1)

valid_y=valid['survived']
valid_x=valid.drop(['survived'],axis=1)

from sklearn.linear_model import LogisticRegression
lr = LogisticRegression(C=1000.0, random_state=0 )
lr.fit(train_x, train_y)
pred_y = lr.predict(valid_x)


print("Misclassification samples : %d" %(valid_y != pred_y).sum())

from sklearn.metrics import precision_score, recall_score, f1_score
from sklearn.metrics import accuracy_score
print("accuracy: %.2f" %accuracy_score(valid_y, pred_y))
print("Precision : %.3f" % precision_score(valid_y, pred_y))
print("Recall : %.3f" % recall_score(valid_y, pred_y))
print("F1 : %.3f" % f1_score(valid_y, pred_y))
```

