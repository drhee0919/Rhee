**지난과정복습**

> 유클리디안 거리 Method : L2 Distance
>
> - n차원인 공간에서 두 점 사이의 최단 거리를 피타고라스 정리를 이용하여 계산 
> - 거리의 최대값이라는 게 없어서 비교를 하기가 어려우므로 0~1사이의 값을 갖도록 하기 위해 1/1+ED 로 계산(역) → 거리가 가까울수록 1에 근접, 거리가 멀수록 0이 됨 
> - 인공지능 분야에서 두 개체의 속성값이 여러 개 일 경우 속성값의 거리 계산으로 유사도를 구할 때 많이 사용 
>
> 맨하탄 거리 측정 방식(Method) : L1 Distance 
>
> - 단순히 두 점 사이의 가로측과 세로측의 차이를 더한 것 
>
> - ```
>   d = |x1-x2|+|y1-y2|
>   d = |x1-x2|+|y1-y2| +|z1-z2|
>   ```



> 로지스틱 회귀(분류)
>
> - 로지스틱  : 종속변수의 결과가 범주형 분류 
>
>   종속변수에 로짓변환을 수행 
>
>   독립변수 값에 관계없이 종속변수의 값이 0~1사이의 값이 되도록 로짓변환 
>
> - 모수 u(x)는 x에 대한 함수의 결과가 0~1사이의 값을 반환 
>
>   u(x) 로지스틱 함수는 음의 무한대~양의 무한대의 실수값을 0과 1사이의 실수값으로 1:1대응시키는 시그모이드 함수.
>
>   하이퍼볼릭탄젠트는 로지스틱 함수를 위아래 2배로 늘리고 좌우는 1/2로 축소
>
>   오차함수
>
> - 데이터의 복잡성을 튜닝을 해야 오버피팅과 언더피팅의 균형점을 찾을 수 있음 
>
> - L2 정규화를 수행하기 위해 C는 하이퍼파라미터 값을 찾기 위해 LogisticRegressionCV(Cs=C의 범위)을 사용한다. 
>
> - predict_proba() = 예측 확률 확인 함수 
>
> - 다항 로지스틱 회귀분석 - 시그모이드 함수를 소프트맥스 함수로 수행(multi_class 매개변수로 설정)
>
>   다중 로지스틱 회귀분석 - 클래스마다 로짓변환 모델을 생성하는 OvR로지스틱 회귀 분석 수행 
>
> - 대용량 데이터로부터 로지스틱 회귀(분류)를 빠르게 수행하려면 solve=sag(경사하강법)
>
> - 클래스가 불균형한 경우 class_weight='balanced' 로 
>
>   불균형한 클래스의 가중치 계산 반환 함수 compute_class_weight()



> Decision Tree
>
> - 가장 상위 노드부터 분류규칙(부모노드와 자식노드간의 엔트로피값을 가장 낮게 만드는 기준값)을 차례대로 적용하여 마지막에 도달하는 노드의 조건부 확률 분포를 이용하여 클래스를 예측 
> - 엔트로피는 다른 종류의 값들이 섞여 있는 정도로 엔트로피가 낮아질 수 록 분류가 잘 된 것임 
>   - 정보획득량 = X라는 조건에 의해 확률변수 y의 엔트로피가 얼마나 감소하였는가?
> - draw_decision_tree() : 의사결정 과정의 세부적인 내역을 다이어그램으로 시각화 
> - DecisionTree의 분류 결과 정확도 평가를 위해서 confusion_matrix(y, y^)



#### RandomForest

```
여러개의 모델을 학습시켜 모델의 예측결과가 하나의 모델보다 더 나은 값을 예측하는 앙상블 학습방법을 사용
예] 여러 개의 decision tree를 생성하여 각 트리의 예측값들 중에서 가장 많은 선택을 받는 클래스로 예측하는 알고리즘
여러 개의 decision tree 모델별로 오차의 상관관계가 작아지게 하는 방법으로 학습시켜야 함

투표기반 분류 (voting classifier) : 여러 머신러닝 알고리즘 모델을 학습시킨 후에 생성된 모델을 이용하여 새로운 데이터에 대한 모델별 예측값에 대해서 다수결 투표를 통해 최종 클래스를 예측하는 방법


from sklearn.model_selection import train_test_split
from sklearn.datasets import make_moons  # 반달모양의 패턴을 가지는 데이터셋 생성

X , y = make_moons (n_samples=500, noise=0.30, random_state = 42)
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=42)

from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import  VotingClassifier

log_clf = LogisticRegression(random_state=42)
rnd_clf = RandomForestClassifier(random_state=42)
svm_clf = SVC(random_state=42)

voting_clf = VotingClassifier(estimators =[ ('lr', log_clf), ('svc', svm_clf ), ('rf', rnd_clf)], voting='hard')
voting_clf.fit(X_train, y_train)

from sklearn.metrics import accuracy_score
for clf in (log_clf, rnd_clf, svm_clf, voting_clf) :
    clf.fit(X_train, y_train)
    y_pred = clf.predict(X_test)
    print(clf.__class__.__name__,accuracy_score(y_test, y_pred))
※ 다수결 투표 분류기가 앙상블에 포함된 개별 머신러닝 분류 알고리즘들중 가장 성능이 좋은 분류기보다 정확도가 더 높은 경우가 많음


간접 투표(soft voting) 분류기 : 각 머신러닝 분류 알고리즘의 예측값의 확률에 대해 평균을 계산 후 평균이 가장 높은 클래스로 최종 앙상블 예측을 수행

svm_clf = SVC(probability=True, random_state=42)

voting_clf = VotingClassifier(estimators =[ ('lr', log_clf), ('svc', svm_clf ), ('rf', rnd_clf)], voting='soft')
voting_clf.fit(X_train, y_train)

from sklearn.metrics import accuracy_score
for clf in (log_clf, rnd_clf, svm_clf, voting_clf) :
    clf.fit(X_train, y_train)
    y_pred = clf.predict(X_test)
    print(clf.__class__.__name__, accuracy_score(y_test, y_pred))

#bagging :  하나의 알고리즘을 사용할때 학습 데이터셋을 랜덤하게 추출(샘플링)하여 학습을 통해 모델을 생성할때  중복을 허용해서  학습 데이터셋을 랜덤하게 추출하는 방식
# pasting : 학습 데이터셋의 중복을 허용하지 않는 샘플링

#샘플링한 학습 데이터셋으로 생성된 모델은 전체 학습 데이터셋으로 학습시킨 것보다 편향되어 있지만, 앙상블을 통해서 편향과 분산이 감소합니다.

from sklearn.tree import DecisionTreeClassifier

tree_clf =   DecisionTreeClassifier(random_state=42)
tree_clf.fit(X_train, y_train)
y_pred_tree = tree_clf.predict(X_test)
print('Accuracy=', accuracy_score(y_test, y_pred_tree))

from sklearn.ensemble import BaggingClassifier
#샘플링 데이터셋(데이터 개수 100개)마다 DecisionTree모델 학습을 500번 수행
bag_clf =  BaggingClassifier ( DecisionTreeClassifier(random_state=42), n_estimators=500,  max_samples=100, bootstrap=True,  n_jobs=-1, random_state=42)
bag_clf.fit(X_train, y_train)
y_pred =bag_clf.predict(X_test)
print('Accuracy=', accuracy_score(y_test, y_pred ))
#BaggingClassifier는 각 예측 클래스의 확률을 추정하여 soft voting방식을 사용합니다.

from matplotlib.colors import ListedColormap
import matplotlib.pyplot as plt
import numpy as np

def plot_decision_boundary(clf, X, y, axes=[-1.5, 2.5, -1, 1.5], alpha=0.5, contour=True):
    x1s = np.linspace(axes[0], axes[1], 100)
    x2s = np.linspace(axes[2], axes[3], 100)
    x1, x2 = np.meshgrid(x1s, x2s)
    X_new = np.c_[x1.ravel(), x2.ravel()]
    y_pred = clf.predict(X_new).reshape(x1.shape)
    custom_cmap = ListedColormap(['#fafab0','#9898ff','#a0faa0'])
    plt.contourf(x1, x2, y_pred, alpha=0.3, cmap=custom_cmap)
    if contour:
        custom_cmap2 = ListedColormap(['#7d7d58','#4c4c7f','#507d50'])
        plt.contour(x1, x2, y_pred, cmap=custom_cmap2, alpha=0.8)
    plt.plot(X[:, 0][y==0], X[:, 1][y==0], "yo", alpha=alpha)
    plt.plot(X[:, 0][y==1], X[:, 1][y==1], "bs", alpha=alpha)
    plt.axis(axes)
    plt.xlabel(r"$x_1$", fontsize=18)
    plt.ylabel(r"$x_2$", fontsize=18, rotation=0)

plt.figure(figsize=(11,4))
plt.subplot(121)
plot_decision_boundary(tree_clf, X, y)
plt.title("결정 트리", fontsize=14)
plt.subplot(122)
plot_decision_boundary(bag_clf, X, y)
plt.title("배깅을 사용한 결정 트리", fontsize=14)
plt.show()

# bagging = resampling : bootstrap 방식
예] 난수를 이용하여 학습 데이터 셋을 여러번 샘플링하면 어떤 데이터는 여러번 샘플링되어 학습데이터셋으로 사용될 수 있고 어떤 데이터는 전혀 샘플링되지 않을 수 있습니다.
전혀 샘플링되지 않은 데이터를 oob(out-of-bag) 샘플
앙상블 bagging 학습 단계에서 oob 샘플은 사용되지 않기 때문에 검증 셋이나 교차 검증에 사용할 수 있습니다. (oob_score=True)


bag_clf =  BaggingClassifier ( DecisionTreeClassifier(random_state=42), n_estimators=500,  max_samples=100, bootstrap=True,  n_jobs=-1, random_state=42, oob_score=True)
bag_clf.fit(X_train, y_train)
print('oob score ', bag_clf.oob_score_)
 
#RandomForestClassifier와  BaggingClassifier 성능 비교
rnd_clf = RandomForestClassifier(n_estimators=500, max_leaf_nodes=16,  n_jobs=-1, random_state=42)
rnd_clf.fit(X_train, y_train)
y_pred_rf = rnd_clf.predict(X_test)
print('Accuracy=', accuracy_score(y_test, y_pred_rf ))


bag_clf =  BaggingClassifier ( DecisionTreeClassifier(splitter="random", max_leaf_nodes=16, random_state=42), n_estimators=500,  max_samples=1.0, bootstrap=True,  n_jobs=-1, random_state=42)
bag_clf.fit(X_train, y_train)
y_pred  = bag_clf.predict(X_test)
print('Accuracy=', accuracy_score(y_test, y_pred ))

# 두 모델의 예측 비교
print(np.sum(y_pred==y_pred_rf) / len(y_pred))


plt.figure(figsize=(6, 4))
for i in range(15):
    tree_cf = DecisionTreeClassifier(max_leaf_nodes=16, random_state=42+i)
    indices_with_replacement = np.random.randint(0, len(X_train), len(X_train))
    tree_cf .fit(X_train, y_train)
    plot_decision_boundary(tree_clf, X, y, axes=[-1.5,2.5,-1,1.5], alpha=0.02, contour=False)

plt.show()


#RandomForest는 특성의 상대적 중요도를 측정하기 쉽다
scikit-learn에서는 어떤 특성을 사용하여 분류된  노드에서 불순도(impurity)를 얼마나 감소키는지를 계산하여 각 특성마다 상대적 중요도를 측정합니다. (계산된 특성별 중요도는 feature_importances_ 속성으로 확인)

from sklearn.datasets import load_iris

iris = load_iris()
rnd_clf = RandomForestClassifier(n_estimators=500, n_jobs=-1, random_state=42)
rnd_clf.fit(iris["data"], iris["target"])
for name, score in zip(iris["feature_names"], rnd_clf.feature_importances_ ) :
    print(name, score)


#boosting : 성능이 약한 학습기를 여러 개 연결하여 강한 학습기를 만드는 앙상블 학습 (앞에서 학습된 모델을 보완해나가면서 더 나은 모델로 학습하는 것)
AdaBoost와 Adaptive Boostring
과소적합(underfitted)된 학습 데이터 샘플의 가중치를 높여서 새로 학습된 모델이 학습하기 어려운 데이터에 잘 적합되도록 하는 방식
1. 전체 학습 데이터셋을 이용하여 학습 후 모델  생성
2. 잘못 예측된(분류된) 샘플의 가중치를 상대적으로 높여서 적용하여 두번째 학습 후 모델을 생성
 
from sklearn.ensemble import AdaBoostClassifier

ada_clf = AdaBoostClassifier(DecisionTreeClassifier(max_depth=1), n_estimators=200,  algorithm="SAMME.R", learning_rate=0.5, random_state=42)
ada_clf.fit(X_train, y_train)
plot_decision_boundary(ada_clf, X, y)


#그레디언트 boosting : 이전에 학습된 모델의 오차를 보완하는 방향으로 모델을 학습시키는 방법
학습 전단계에서 모델의 잔여 오차를 사용해서 새로운 학습 모델을 생성

np.random.seed(42)
X = np.random.rand(100, 1) -0.5
y = 3*X[:, 0]**2+0.05 *np.random.rand(100)

from sklearn.tree import DecisionTreeRegressor
tree_reg1 = DecisionTreeRegressor(max_depth=2, random_state=42)
tree_reg1.fit(X, y)

y2 = y-tree_reg1.predict(X)
tree_reg2 = DecisionTreeRegressor(max_depth=2, random_state=42)
tree_reg1.fit(X, y2)

y3 = y2-tree_reg2.predict(X)
tree_reg3 = DecisionTreeRegressor(max_depth=2, random_state=42)
tree_reg3.fit(X, y3)


#############################################################
from sklearn.ensemble import RandomForestClassifier
from sklearn import datasets

iris = datasets.load_iris()  # 데이터 로드
features = iris.data
target = iris.target

# 랜덤 포레스트 분류기 객체를 만듭니다.
randomforest = RandomForestClassifier(random_state=0, n_jobs=-1)
model = randomforest.fit(features, target)  # 모델 훈련

observation = [[ 5,  4,  3,  2]] # 새로운 샘플을 만듭니다.
model.predict(observation)  # 샘플 클래스를 예측합니다.

# 엔트로피를 사용하여 랜덤 포레스트 분류기 객체를 만듭니다.
randomforest_entropy = RandomForestClassifier(criterion="entropy", random_state=0)
model_entropy = randomforest_entropy.fit(features, target)  # 모델 훈련

observation = [[ 5,  4,  3,  2]] # 새로운 샘플을 만듭니다.
model_entropy .predict(observation)  # 샘플 클래스를 예측합니다.

 
#다음 의사결정 분류 분석 코드의 결과를 앙상블 학습인 RandomForest 분류 분석으로 수행하여 결과를 비교해보세요


import pandas as pd

uci_path = 'http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.data'

df = pd.read_csv(uci_path, header=None)

df.columns = ['id', 'clump', 'cell_size', 'cell_shape', 'adhesion', 'epithlial', 'bare_nuclei', 'chromatin', 'normal_nucleoli', 'matoses', 'class']
#chromatin 염색체의 단백질?
# adhesion 부착 , clump 덩어리, epithlial 상피

print(df.head())
print(df.info())
print(df.describe())

#bare_nuclei  문자열-> 숫자타입(int), 고유값 확인,  누락값 처리(행 삭제)
print(df ['bare_nuclei'].unique())
df ['bare_nuclei'].replace('?', np.nan, inplace=True)
df.dropna(subset = ['bare_nuclei'] ,  axis=0, inplace=True)
df['bare_nuclei'] = df['bare_nuclei'].astype('int')
print(df.describe())

X=df [['id', 'clump', 'cell_size', 'cell_shape', 'adhesion', 'epithlial', 'bare_nuclei', 'chromatin', 'normal_nucleoli', 'matoses'] ]

y = df['class']

#정규화
from sklearn.preprocessing  import StandardScaler
X = StandardScaler().fit(X).transform(X)

#train, test dataset 분리
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=10)
print('train data 개수 :', X_train.shape)
print('test data 개수 :' ,X_test.shape)

tree_model = DecisionTreeClassifier(criterion='entropy', max_depth=5)
tree_model.fit(X_train, y_train)

y_hat = tree_model.predict(X_test)
print(y_hat[0:10])
print(y_test.values[0:10])

#모델 성능 평가
tree_matrix = confusion_matrix(y_test, y_hat)
print(tree_matrix)

tree_report = metrics.classification_report(y_test, y_hat)
print(tree_report)

rf_model = RandomForestClassifier(criterion='entropy', n_estimators=20, max_depth=5)
rf_model.fit(X_train, y_train)

y_hat = rf_model.predict(X_test)
print(y_hat[0:10])
print(y_test.values[0:10])

#모델 성능 평가
rf_matrix = confusion_matrix(y_test, y_hat)
printrf_matrix)

rf_report = metrics.classification_report(y_test, y_hat)
print(rf_report)
```





#### KNN(K-Nearest Neighbors)

```
k-최근접 이웃 알고리즘은 특정 공간 내에서 입력과 제일 근접한(가까운) k개의 요소를 찾아 더 많이 일치하는 클래스로 분류하는 알고리즘
가장 단순한 지도 학습 알고리즘
가까운 멤버에는 가중치를 높게 주고, 멀리 떨어진 멤버에는 가중치를 낮게 주어 처리하는 것이 좋습니다.

#샘플 데이터로부터 가장 가까운 k개의 이웃 찾기

from sklearn.datasets import load_iris
from sklearn.neighbors import  NearestNeighbors
from sklearn.preprocessing import StandardScaler

iris = load_iris()
features = iris.data
#특성 정규화
features_standard = StandardScaler().fit_transform(features)

nearest_neighbors = NearestNeighbors(n_neighbors=2).fit(features_standard)
new_observation = [1,1,1,1]
#새로운 샘플 데이터의 최근접 이웃의 인덱스와 거리 반환
distances, indices = nearest_neighbors.kneighbors([new_observation]) 
features_standard [indices]   #최근접 이웃 확인 
distances

nearest_neighbors_euclidean= NearestNeighbors(n_neighbors=2,  metric='euclidean' ).fit(features_standard)
distances

nn_euclidean = NearestNeighbors(n_neighbors=3, metric='euclidean').fit(features_standard) 
distances
nn_with_self = nn_euclidean.kneighbors_graph(features_standard).toarray()
#최근접 이웃 중에서 1로 표시된 자기 자신을 제외시킵니다.
for i, x in enumerate(nn_with_self) :
    x[i] = 0

print(nn_with_self[0]) #첫번째 샘플에 대한 최근접 이웃 확인


#샘플과 가까운 최근접 이웃 5개 인덱스 찾기
indices = nn_euclidean.kneighbors([new_observation], n_neighbors=5, return_distance=False)
features_standard[indices]   #최근접 이웃 확인

# 반경 0.5 안에 있는 모든 샘플의 인덱스를 찾습니다.
indices = nn_euclidean.radius_neighbors([new_observation], radius = 0.5 , return_distance=False)
features_standard[indices[0]] 

nn_with_self = nn_euclidean.radius_neighbors_graph([new_observation], radius = 0.5).toarray()
nn_with_self  
```

