```
[make_regression() 함수의 매개변수]
n_samples : 정수 (옵션, 디폴트 100) 표본 데이터의 갯수  N 
n_features : 정수 (옵션, 디폴트 100) 독립 변수(feature)의 수(차원)  M 
n_targets : 정수 (옵션, 디폴트 1) 종속 변수(target)의 수(차원)
bias : 실수 (옵션, 디폴트 0.0) y 절편
noise : 실수 (옵션, 디폴트 0.0) 출력 즉, 종속 변수에 더해지는 잡음  ? 의 표준 편차
coef : 불리언 (옵션, 디폴트 False) True 이면 선형 모형의 계수도 출력
random_state : 정수 (옵션, 디폴트 None) 난수 발생용 시드값

n_informative : 정수 (옵션, 디폴트 10)
독립 변수(feature) 중 실제로 종속 변수와 상관 관계가 있는 독립 변수의 수(차원)

effective_rank: 정수 또는 None (옵션, 디폴트 None)
독립 변수(feature) 중 서로 독립인 독립 변수의 수. 만약 None이면 모두 독립

tail_strength : 0부터 1사이의 실수 (옵션, 디폴트 0.5)
effective_rank가 None이 아닌 경우 독립 변수간의 상관관계를 결정하는 변수. 0.5면 독립 변수간의 상관관계가 없다.

[make_regression() 함수의 출력]  
X : [n_samples, n_features] 형상의 2차원 배열
독립 변수의 표본 데이터 행렬  X 
y : [n_samples] 형상의 1차원 배열 또는 [n_samples, n_targets] 형상의 2차원 배열
종속 변수의 표본 데이터 벡터  y 
coef : [n_features] 형상의 1차원 배열 또는 [n_features, n_targets] 형상의 2차원 배열 (옵션)
선형 모형의 계수 벡터  w , 입력 인수 coef가 True 인 경우에만 출력됨


from sklearn.datasets import make_regression

X, y, w = make_regression(n_samples=10, n_features=1, bias=0, noise=0,
                          coef=True, random_state=0)

X
y
w

plt.scatter(X, y, s=100)
plt.xlabel("x")
plt.ylabel("y")
plt.title("make_regression 예제 (noise = 0인 경우)")
plt.show()


X, y, w = make_regression(n_samples=50, n_features=1, bias=100, noise=10,             coef=True, random_state=0)
plt.scatter(X, y, s=100)
plt.xlabel("x")
plt.ylabel("y")
plt.title("make_regression 예제 (noise = 10인 경우)")
plt.show()


[make_classification() 함수의 매개변수]
n_samples : 표본 데이터의 수, 디폴트 100
n_features : 독립 변수의 수, 디폴트 20
n_informative : 독립 변수 중 종속 변수와 상관 관계가 있는 성분의 수, 디폴트 2
n_redundant : 독립 변수 중 다른 독립 변수의 선형 조합으로 나타나는 성분의 수, 디폴트 2
n_repeated : 독립 변수 중 단순 중복된 성분의 수, 디폴트 0
n_classes : 종속 변수의 클래스 수, 디폴트 2
n_clusters_per_class : 클래스 당 클러스터의 수, 디폴트 2
weights : 각 클래스에 할당된 표본 수 
클래스 별 데이터의 갯수에 차이를 주고 싶을 땐, weights인수를 설정하면 된다
random_state : 난수 발생 시드



[make_classification() 함수의 출력]  
X : [n_samples, n_features] 크기의 배열
독립 변수
y : [n_samples] 크기의 배열
종속 변수

from sklearn.datasets import make_classification

plt.title("1개의 독립변수를 가진 가상 데이터")
X, y = make_classification(n_features=1, n_informative=1,
                           n_redundant=0, n_clusters_per_class=1, random_state=4)
plt.scatter(X, y, marker='o', c=y,
            s=100, edgecolor="k", linewidth=2)

plt.xlabel("$X$")
plt.ylabel("$y$")
plt.show()

sns.distplot(X[y == 0], label="y=0")
sns.distplot(X[y == 1], label="y=1")
plt.legend()
plt.show()

n_informative 변수를 1로 설정했다. 즉 2개의 독립변수 중 실제로 타겟 클래스와 상관관계가 있는 것은 1개의 독립변수이다.
X, y = make_classification(n_features=2, n_informative=1, n_redundant=0,
                           n_clusters_per_class=1, random_state=4)
plt.scatter(X[:, 0], X[:, 1], marker='o', c=y,
            s=100, edgecolor="k", linewidth=2)

plt.xlabel("$X_1$")
plt.ylabel("$X_2$")
plt.show()


# 비대칭데이터를 시뮬레이션  weight인수를 각 각 0.9, 0.1로 설정
plt.title("비대칭 데이터")
X, y = make_classification(n_features=2, n_informative=2, n_redundant=0,
                           n_clusters_per_class=1, weights=[0.9, 0.1], random_state=6)
val, cnt = np.unique(y, return_counts=True)
print("각 클래스별 데이터의 갯수 - {} 클래스 : {}, {} 클래스 : {}".format(val[0], cnt[0], val[1], cnt[1]))

plt.scatter(X[:, 0], X[:, 1], marker='o', c=y,
            s=100, edgecolor="k", linewidth=2)
plt.xlabel("$X_1$")
plt.ylabel("$X_2$")
plt.show()

# n_clusters_per_class 인수를 2로 설정하여, 클래스 당 클러스터 갯수를 늘리면 클래스 끼리 잘 분리되어 있지 않은 가상데이터를 얻을 수 있다. 
클래스 당 클러스터 갯수를 설정할 때 주의 할 점은  n_classes×n_clusters_per_class  는  2^n_informative 보다 작거나 같도록 설정해야 한다는 것이다.

plt.title("클래스 내에 2개의 클러스터가 있는 가상 데이터")
X2, Y2 = make_classification(n_samples=400, n_features=2, n_informative=2, n_redundant=0,
                             n_clusters_per_class=2, random_state=0)
plt.scatter(X2[:, 0], X2[:, 1], marker='o', c=Y2,
            s=100, edgecolor="k", linewidth=2)

plt.xlabel("$X_1$")
plt.ylabel("$X_2$")
plt.show()

[make_blobs() 함수의 매개변수]
make_blobs 함수는 등방성 가우시안 정규분포를 이용해 가상 데이터를 생성한다. 이 때 등방성이라는 말은 모든 방향으로 같은 성질을 가진다는 뜻이다. 
make_blobs는 보통 클러스링 용 가상데이터를 생성하는데 사용한다. 

n_samples : 표본 데이터의 수, 디폴트 100
n_features : 독립 변수의 수, 디폴트 20
centers : 생성할 클러스터의 수 혹은 중심, [n_centers, n_features] 크기의 배열. 디폴트 3
cluster_std: 클러스터의 표준 편차, 디폴트 1.0
center_box: 생성할 클러스터의 바운딩 박스(bounding box), 디폴트 (-10.0, 10.0))

[make_blobs() 함수의 출력]
X : [n_samples, n_features] 크기의 배열, 독립 변수
y : [n_samples] 크기의 배열, 종속 변수

# 세개의 클러스터를 가지는 가상 데이터 생성
from sklearn.datasets import make_blobs

plt.title("세개의 클러스터를 가진 가상 데이터")
X, y = make_blobs(n_samples=300, n_features=2, centers=3, random_state=1)
plt.scatter(X[:, 0], X[:, 1], marker='o', c=y, s=100,
            edgecolor="k", linewidth=2)
plt.xlabel("$X_1$")
plt.ylabel("$X_2$")
plt.show()


참고]
make_moons 함수는 초승달 모양 클러스터 두 개 형상의 데이터를 생성한다. make_moons 명령으로 만든 데이터는 직선을 사용하여 분류할 수 없다.

make_gaussian_quantiles 함수는 다차원 가우시안 분포의 표본을 생성하고 분포의 기대값을 중심으로 한 등고선으로 클래스를 분리한다.
이 데이터는 타원형 형태의 닫힌 경계선으로만 분류할 수 있다.


import pandas as pd
import numpy as np

# 날짜 범위를 만듭니다.
time_index = pd.date_range('06/06/2017', periods=100000, freq='30S')

# 데이터프레임을 만듭니다.
dataframe = pd.DataFrame(index=time_index)

# 난수 값으로 열을 만듭니다.
dataframe['Sale_Amount'] = np.random.randint(1, 10, 100000)

# 주 단위로 행을 그룹핑한 다음 합을 계산합니다.
dataframe.resample('W').sum()


##############수치 데이터 전처리 ###############################
[ 특성 표준화 실습]

import numpy as np
from sklearn import preprocessing

# 특성을 만듭니다.
x = np.array([[-1000.1],
              [-200.2],
              [500.5],
              [600.6],
              [9000.9]])
# 변환기 객체를 만듭니다.
robust_scaler = preprocessing.RobustScaler()
robust_scaler.fit_transform(x)

# 특성을 변환합니다.
robust_scaler.fit_transform(x)
interquatile_range = x[3] - x[1]
(x - np.median(x)) / interquatile_range

preprocessing.QuantileTransformer().fit_transform(x)

#nltk 태그 리스트 참조 url
https://www.learntek.org/blog/categorizing-pos-tagging-nltk-python/



말뭉치(corpus)는 자연어 분석 작업을 위해 만든 샘플 문서 집합을 말한다. 단순히 소설, 신문 등의 문서를 모아놓은 것도 있지만 품사. 형태소, 등의 보조적 의미를 추가하고 쉬운 분석을 위해 구조적인 형태로 정리해 놓은 것을 포함한다.
```