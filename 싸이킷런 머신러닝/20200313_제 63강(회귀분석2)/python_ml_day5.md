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



**Decision Tree**

```python
from sklearn.tree import DecisionTreeClassifier
from sklearn import datasets

iris = datasets.load_iris()  # 데이터 로드
features = iris.data
target = iris.target
# 결정 트리 분류기 객체 생성 (불순도를 감소를 지표의 기본값을  지니 계수를 사용)
decisiontree = DecisionTreeClassifier(random_state=0)
model = decisiontree.fit(features, target)  # 모델 훈련

observation = [[ 5,  4,  3,  2]]  # New 샘플 데이터
model.predict(observation)  # 샘플 데이터의 클래스 예측
model.predict_proba(observation)  # 세 개의 클래스에 대한 예측 확률을 확인

# 엔트로피를 사용해 결정 트리 분류기를 훈련합니다.
decisiontree_entropy = DecisionTreeClassifier( criterion='entropy', random_state=0)
model_entropy = decisiontree_entropy.fit(features, target)   # 모델 훈련

observation = [[ 5,  4,  3,  2]]  # New 샘플 데이터
model_entropy .predict(observation)            # 샘플 데이터의 클래스 예측
model_entropy .predict_proba(observation)   # 세 개의 클래스에 대한 예측 확률을 확인
```

```python
#DecisionTree는 분류와 회귀 분석에 모두 사용 가능
from sklearn.tree import DecisionTreeRegressor
from sklearn import datasets

boston = datasets.load_boston()   # 데이터 로드
features = boston.data[:,0:2]   #두 개의 특성만 선택
target = boston.target

decisiontree = DecisionTreeRegressor(random_state=0)  # 결정 트리 회귀 모델 객체 생성
model = decisiontree.fit(features, target)   # 모델 훈련

observation = [[0.02, 16]]   #New 샘플 데이터
model.predict(observation)   # 샘플 데이터의 타깃을 예측

# 평균 제곱 오차를 사용한 (평균 절댓값 오차MAE가 감소되는) 결정 트리 회귀 모델 객체 생성
decisiontree_mae = DecisionTreeRegressor(criterion="mae", random_state=0)
model_mae = decisiontree_mae.fit(features, target)   # 모델 훈련
model_mae.predict(observation)   # 샘플 데이터의 타깃을 예측
```

```python
'''
결정 트리 모델 시각화
 결정 트리 분류기의 장점은 훈련된 전체 모델을 시각화할 수 있다는 것이다.
 훈련된 모델을 DOT 포맷으로 변환한 다음 그래프를 그립니다.
'''
import pydotplus
from sklearn.tree import DecisionTreeClassifier
from sklearn import datasets
from IPython.display import Image
from sklearn import tree

iris = datasets.load_iris() # 데이터 로드
features = iris.data
target = iris.target

decisiontree = DecisionTreeClassifier(random_state=0) # 결정 트리 분류기를 만듭니다.
model = decisiontree.fit(features, target) # 모델 훈련

# DOT 데이터를 만듭니다
dot_data = tree.export_graphviz(decisiontree,
                                out_file=None,
                                feature_names=iris.feature_names,
                                class_names=iris.target_names) 

graph = pydotplus.graph_from_dot_data(dot_data) # 그래프를 그립니다.
Image(graph.create_png()) # 그래프 출력
# graph.write_pdf("iris.pdf") # PDF를 만듭니다.
# graph.write_png("iris.png") # PNG 파일을 만듭니다
```

※ pydotplus 클래스 graphviz 사용법 

```
pip install pyparsing
pip install graphviz
pip install pydot
conda install graphviz


1. graphviz.2.38.msi 파일 설치
https://graphviz.gitlab.io/_pages/Download/Download_windows.html

2. 시스템 환경변수에 추가하기
시스템환경변수 > path 추가
C:\Program Files (x86)\Graphviz2.38\bin 

시스템환경변수 > GRAPHVIZ_DOT 새로만들기
C:\Program Files (x86)\Graphviz2.38\bin\dot.exe 

3. jupyter notebook 재시작
```

```python
##############타이타닉 데이터 생존자 분류 분석 (decision tree) 
##############타이타닉 데이터 생존자 분류 분석 (decision tree) ###########
df = sns.load_dataset("titanic")
df.head()
feature_names = ["pclass", "age", "sex"]
dfX = df[feature_names ].copy()
dfy = df["survived"].copy()
dfX.tail()

from sklearn.preprocessing import LabelEncoder
dfX["sex"] = LabelEncoder().fit_transform(dfX["sex"])
dfX.tail()

dfX["age"].fillna(dfX["age"].mean(), inplace=True)
dfX.tail()

from sklearn.preprocessing import LabelBinarizer
dfX2 = pd.DataFrame(LabelBinarizer().fit_transform(dfX["pclass"]), columns=['c1', 'c2', 'c3'], index=dfX.index)
dfX = pd.concat([dfX, dfX2], axis=1)
del(dfX['pclass'])
dfX.tail()

#test, train data 분리 (0.25)
#decisiontree 분류 분석
#시각화
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
import io
import pydot 
from sklearn.tree import DecisionTreeClassifier
from sklearn import datasets
from IPython.display import Image
from sklearn import tree 

X_train, X_test, y_train, y_test = train_test_split(dfX, dfy, test_size=0.25, random_state=0)

#분류분석 
model = DecisionTreeClassifier(criterion='entropy', 
                               max_depth=3, 
                               min_samples_leaf=5).fit(X_train, y_train)

#시각화
command_buf = io.StringIO() #문자열 입출력 관하여 선언 (메모리 처리속도상)
tree.export_graphviz(model, out_file=command_buf, feature_names=[
                'Age', 'Sex', '1st_class', '2nd_class', '3rd_class'])
#graph = pydot.graph_from_dot_data(command_buf.getvalue())[0]
graph = pydotplus.graph_from_dot_data(command_buf.getvalue())
image = graph.create_png()
Image(image)
```

```python
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report

confusion_matrix(y_train, model.predict(X_train))

confusion_matrix(y_test, model.predict(X_test))

print(classification_report(y_train, model.predict(X_train)))

print(classification_report(y_test, model.predict(X_test)))

```

