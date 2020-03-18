



#### Naive Bayes

> 나이브 베이즈 : 연속적인 특성으로 분류기 훈련 
>
> - 베이즈 이론은 <u>새로운 정보P(A|B)</u>와 <u>사건의 사전 확률 P(A)</u>가 주어졌을 때 <u>어떤 사건이 일어날 확률</u>을 이해하는 방법을 지칭합니다. 
>
> - 조건부 독립: 확률변수 A, B가 독립이면, A와 B의 결합확률은 주변확률의 곱과 같다. 
>
>   조건이 되는 별개의 확률 변수 C 가 존재하며, 조건이 되는 확률변수 C에 대한 A,B의 결합조건부 확률은 C에 대한 A,B의 조건부 확률과 같다. (조건부 독립)
>
>   일반적인 독립은 '무조건 독립 확률'
>
>   조건부 독립 확률과 무조건 독립 확률간의 관계가 없다.(가령, 두 확률변수가 독립이라고 해서 항상 조건부 독립 확률이 되는 것은 아니며, 조건부 독립 확률이라고 해서 확률 변수가 항상 독립이 되는 것도 아니다.) 
>
>   ```python
>   import numpy as np 
>   C = np.random.normal(100, 15, 2000)
>   A = C + np.random.normal(0, 5, 2000) #평균이 0이고 표준편차가 5인 정규분포 데이터 
>   B = C + np.random.normal(0, 5, 2000) #평균이 0이고 표준편차가 5인 정규분포 데이터 
>   
>   #C가 고정이 되어있을시, A와 B가 독립인가?(시각화)
>   #시각화를 통해서 A,C B,C는 상관관계가 있지만, A와 B확률변수에 대해서는 서로 독립적입을 확인 
>   import matplotlib.pyplot as plt
>   plt.subplot(121)
>   plt.scatter(A, B)
>   plt.xlabel("A")
>   plt.ylabel("B")
>   plt.xlim(30, 180)
>   plt.xlim(30, 180)
>   plt.title("B,C의 unconditional corr")
>   plt.subplot(122)
>   idx1 = (118<C) & (C<122)
>   idx2 = (78<C) & (C<82)
>   plt.scatter(A[idx1], B[idx1], label="C=120")
>   plt.scatter(A[idx2], B[idx2], label="C=80")
>   plt.xlim(30, 180)
>   plt.xlim(30, 180)
>   plt.legend()
>   plt.title("A,B conditional corr")
>   plt.tight.layout()
>   plt.show()
>   
>   # 조건부 확률변수 C와 두 확률변수 A, B는 상관관계가 있지만,
>   # 조건부 확률변수 C를 고정시켰을 때 두 확률변수 A, B는 독립임을 확인할 수 있음
>   
>   ```
>
>   - Naive Bayes 분류 모델 은 모든 차원의 개별 독립 변수가 서로 조건부 독립이라는 가정을 사용합니다. 
>
>   > GaussianNB:  연속적인 데이터에 적용, 정규분포 NB
>   > BernouliNB :  이진 데이터에 적용, 
>   > MultinomialNB : 다항분포 NB, 카운트 데이터(특성의 출현 횟수, 문장의 단어 출현횟수 )
>   >
>   > BernouliNB, MultinomialNB 는 텍스트 데이터 분류 에 사용
>
>   ``` python
>   from sklearn import datasets
>   from sklearn.naive_bayes import GaussianNB
>   
>   iris = datasets.load_iris()  # 데이터 로드
>   features = iris.data
>   target = iris.target
>   
>   classifer = GaussianNB()  # 가우시안 나이브 베이지 객체 생성
>   model = classifer.fit(features, target)  # 모델 훈련
>   new_observation = [[ 4,  4,  4,  0.4]]    #New Sample Data
>   model.predict(new_observation)   # 클래스 예측
>   
>   ```
>
>   ``` python
>   # 각 클래스별 사전 확률을 지정한 가우시안 나이브 베이즈 객체 생성
>   clf = GaussianNB(priors=[0.25, 0.25, 0.5])
>   model = classifer.fit(features, target)  # 모델  훈련 
>   new_observation = [[ 4,  4,  4,  0.4]]    #New Sample Data
>   model.predict(new_observation)   # 클래스 예측
>   
>   #GaussianNB의 속성 theta_은 정규분포의 기댓값
>   #GaussianNB의 속성 sigma_는 정규분포의 분산
>   
>   #모의 데이터 생성
>   import scipy as sp
>   np.random.seed(0)
>   #다변량 정규값을 랜덤하게 생성 multivariate_normal( mean = None , cov = 1 , allow_singular = False , seed = None ) 
>   rv0 =sp.stats.multivariate_normal([-2, 2], [[1, 0.9], [0.9, 2]])   
>   rv1 =sp.stats.multivariate_normal([2, 2], [[1.2, -0.8], [-0.8, 2]])
>   X0 = rv0.rvs(40)
>   X1 = rv1.rvs(60)
>   X = np.vstack([X0, X1])
>   y = np.hstack([np.zeros(40), np.ones(60)])
>   ```
>
>   