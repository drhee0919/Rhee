



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
>   https://datascienceschool.net/view-notebook/c19b48e3c7b048668f2bb0a113bd25f7/
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
>   >
>   > - GaussianNB 사용예제 
>
>   ``` python
>   ## 예제1
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
>   
>   
>   '''결과
>   [1]
>   [1]
>   '''
>   #GaussianNB의 속성 theta_은 정규분포의 기댓값
>   #GaussianNB의 속성 sigma_는 정규분포의 분산
>   
>   ```
>
>   
>
>   ```python
>   ## 예제2
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
>   
>   import matplotlib as mpl
>   xx1 = np.linspace(-5, 5, 100)
>   xx2 = np.linspace(-5, 5, 100)
>   XX1, XX2 = np.meshgrid(xx1, xx2)
>   plt.grid(False)
>   plt.contour(XX1, XX2, rv0.pdf(np.dstack([XX1, XX2])), cmap=mpl.cm.cool)
>   plt.contour(XX1, XX2, rv1.pdf(np.dstack([XX1, XX2])), cmap=mpl.cm.hot)
>   plt.scatter(X0[:, 0], X0[:, 1], marker="o", c='b', label="y=0")
>   plt.scatter(X1[:, 0], X1[:, 1], marker="s", c='r', label="y=1")
>   plt.legend()
>   plt.title("데이터의 확률분포")
>   plt.axis("equal")
>   plt.show() #시각화 출력 
>   
>   ```
>
>   ```python
>   from sklearn.naive_bayes import GaussianNB
>   model_norm = GaussianNB().fit(X, y)
>   #y 클래스의 종류와 각 클래스에 속하는 표본의 수, 그리고 그 값으로부터 구한 사전 확률
>   model_norm.classes_   #종속변수 Y의 클래스(라벨)
>   model_norm.class_count_  #종속변수 Y의 값이 특정한 클래스인 표본 데이터의 수
>   model_norm.class_prior_ #종속변수 Y의 무조건부 확률 분포 P(Y)
>   
>   ##설명변수 x의 기댓값 , 정규분포의 분산  (확률 분포의 모수)
>   
>   model_norm.theta_[0], model_norm.sigma_[0]
>   model_norm.theta_[1], model_norm.sigma_[1]
>   
>   x_new = [0, 0]  #새로운 관측 데이터 
>   model_norm.predict_proba([x_new])  # 예측확률
>   
>   
>   
>   '''결과
>   array([[0.48733438, 0.51266562]])
>   '''
>   ```
>
> > 
> >
> > - MultinomialNB
> >
> > 다항 나이브베이즈 분류
> >
> > (ex/ 스팸 메일 필터링 : BOW 인코딩을 할 때, 각 키워드가 출현한 빈도를 직접 입력 변수로 사용)
> >
> > ```python
> > X = np.array([
> >     [3, 4, 1, 2],
> >     [3, 5, 1, 1],
> >     [3, 3, 0, 4],
> >     [3, 4, 1, 2],
> >     [1, 2, 1, 4],
> >     [0, 0, 5, 3],
> >     [1, 2, 4, 1],
> >     [1, 1, 4, 2],
> >     [0, 1, 2, 5],
> >     [2, 1, 2, 3]])
> > y = np.array([0, 0, 0, 0, 1, 1, 1, 1, 1, 1])
> > 
> > from sklearn.naive_bayes import MultinomialNB
> > model_mult = MultinomialNB().fit(X, y)
> > model_mult.classes_            
> > model_mult.class_count_
> > np.exp(model_mult.class_log_prior_)  #종속변수 Y의 무조건부 확률분포의 로그 
> > 
> > '''
> > array([0.4, 0.6])
> > '''
> > ```
> >
> > ```python
> > # 각 클래스에 대한 가능도 확률분포를 구한다. 
> > 예 :  다항분포 모형을 사용하므로 각 클래스를 4개의 면을 가진 주사위로 생각할 수 있다. 그리고 각 면이 나올 확률은 각 면이 나온 횟수를 주사위를 던진 전체 횟수로 나누면 된다. 
> >  
> > fc = model_mult.feature_count_  #각 클래스의 면이 나오는 횟수
> > fc
> > fc / np.repeat(fc.sum(axis=1)[:, np.newaxis], 4, axis=1)
> > 
> > ''' 결과 
> > [[12. 16.  3.  9.]
> >  [ 5.  7. 18. 18.]]
> > array([[0.3       , 0.4       , 0.075     , 0.225     ],
> >        [0.10416667, 0.14583333, 0.375     , 0.375     ]])
> > '''
> > ```
>
> > - 스무딩(smoothing)
>
> > 표본 데이터의 수가 적은 경우에는 모수에 대해   스무딩(smoothing)을 합니다.
> >
> > 표본 데이터의 수가 적은 경우에는 베르누이 모수가 0 또는 1이라는 극단적인 모수 추정값이 나올 수도 있다.
> >
> > 현실적으로는 실제 모수값이 이런 극단적인 값이 나올 가능성이 적다. 
> >
> > 베르누이 모수가 0.5인 가장 일반적인 경우를 가정하여 0이 나오는 경우와 1이 나오는 경우, 
> >   두 개의 가상 표본 데이터를 추가한다. 그러면 0이나 1과 같은 극단적인 추정값이 0.5에 
> >   가까운 값으로 변한다.
> >
> > **라플라스 스무딩(Laplace smoothing)** 또는 **애드원(Add-One) 스무딩** 이 존재한다 
> >
> > 극단적인 추정을 피하기 위해 이 값을 가중치 1인 스무딩을 한 추정값을 사용한다.
>
> ``` python
> # 선행 예제 이어서 
> model_mult.alpha
> (fc + model_mult.alpha) / (np.repeat(fc.sum(axis=1)[:,np.newaxis],4,axis=1) + model_mult.alpha * X.shape[1])
> # 모수 추정치
> theta = np.exp(model_mult.feature_log_prob_)  #다항분포의 모수의 로그
> theta
> # 어떤 메일에 1번부터 4번까지의 키워드가 각각 10번씩 나왔다면 다음처럼 확률을 구할 수 있다. 
> # 구해진 확률로부터 이 메일이 스팸임을 알 수 있다.
> x_new = np.array([10, 10, 10, 10])  #새로운 관측 데이터
> model_mult.predict_proba([x_new])
> 
> '''결과
> array([[0.38848858, 0.61151142]])
> '''
> ```
>
> 
>
> > - 베르누이 나이브 베이즈 분류
>
> ```python
> 
> X = np.array([
>     [0, 1, 1, 0],
>     [1, 1, 1, 1],
>     [1, 1, 1, 0],
>     [0, 1, 0, 0],
>     [0, 0, 0, 1],
>     [0, 1, 1, 0],
>     [0, 1, 1, 1],
>     [1, 0, 1, 0],
>     [1, 0, 1, 1],
>     [0, 1, 1, 0]])
> y = np.array([0, 0, 0, 0, 1, 1, 1, 1, 1, 1])
> #데이터는 4개의 키워드를 사용하여 정상 메일 4개와 스팸 메일 6개를 BOW 인코딩한 행렬이다. 
> X = np.array([
>     [0, 1, 1, 0],
>     [1, 1, 1, 1],
>     [1, 1, 1, 0],
>     [0, 1, 0, 0],
>     [0, 0, 0, 1],
>     [0, 1, 1, 0],
>     [0, 1, 1, 1],
>     [1, 0, 1, 0],
>     [1, 0, 1, 1],
>     [0, 1, 1, 0]])
> y = np.array([0, 0, 0, 0, 1, 1, 1, 1, 1, 1])
> #데이터는 4개의 키워드를 사용하여 정상 메일 4개와 스팸 메일 6개를 BOW 인코딩한 행렬이다. 
>  
> from sklearn.naive_bayes import BernoulliNB
> model_bern = BernoulliNB().fit(X, y)
> #y 클래스의 종류와 각 클래스에 속하는 표본의 수, 그리고 그 값으로부터 구한 사전 확률의 값
> model_bern.classes_
> model_bern.class_count_
> np.exp(model_bern.class_log_prior_)
> 
> #각 클래스  k  별로, 그리고 각 독립변수  d  별로, 각각 다른 베르누이 확률변수라고 가정하여 모두 8개의 베르누이 확률변수의 모수를 구하면
> fc = model_bern.feature_count_
> fc
> fc / np.repeat(model_bern.class_count_[:, np.newaxis], 4, axis=1)
> 
> model_bern.alpha  #스무딩 가중치 값
> #스무딩이 적용된 베르누이 모수값
> theta = np.exp(model_bern.feature_log_prob_)
> theta
>  
> x_new = np.array([0, 1, 1, 1])  #새로운 관측 데이터 
> model_bern.predict_proba([x_new])  #정상 , 스팸메일 분류 확률 확인
> 
> '''
> 결과
> array([[0.34501348, 0.65498652]])
> '''
> ```
>
> 
>
> - 확률보정
>
> ``` python
> ## 확률 보정 
> from sklearn import datasets
> from sklearn.naive_bayes import GaussianNB
> from sklearn.calibration import CalibratedClassifierCV
> 
> iris = datasets.load_iris()  # 데이터 로드
> features = iris.data
> target = iris.target
> 
> classifer = GaussianNB()  # 가우시안 나이브 베이즈 객체 생성
> # 시그모이드 보정을 사용해 보정 교차 검증을 만듭니다.
> classifer_sigmoid = CalibratedClassifierCV(classifer, cv=2, method='sigmoid')
> classifer_sigmoid.fit(features, target) # 확률을 보정
> new_observation = [[ 2.6,  2.6,  2.6,  0.4]]  #New Sample Data
> print(classifer_sigmoid.predict_proba(new_observation))  # 보정된 확률을 확인 
> 
> # 가우시안 나이브 베이즈를 훈련하고 클래스 확률을 예측합니다.
> classifer.fit(features, target).predict_proba(new_observation)
> print(classifer_sigmoid.predict_proba(new_observation)) # 보정된 확률을 확인
> 
> '''결과 
> [[0.31859969 0.63663466 0.04476565]]
> [[0.31859969 0.63663466 0.04476565]]
> 
> '''
> ```
>
> 







#### Clustering(군집)

> - 군집이란?
>
> >데이터 집합을 유사한 데이터들의 그룹으로 나누는 것 
> >데이터의 속성(특성)들을 분석하여 비슷한 속성(특성)을 가지는 데이터들끼리 클러스터(군집, 집단)로 묶는 알고리즘
> >어느 클러스터에도 속하지 못하는 관측 데이터가 존재할 수도 있다
> >정답이 없는 데이터들의 유사성만을 기준으로 판단합니다.
>
> ​		→ 신용카드 부정 사용 탐지, 구매 패턴 분석 후 소비자 행동 특성을 그룹화하는데 사용
>
> - 군집의 종류
>
> > - k-평균 군집화
> >
> > ```
> > 데이터간의 유사성을 기준으로 클러스터 중심까지의 거리를 이용하는 분석방법
> > 데이터 집합에 임의의 k개의 클러스터를 주고 데이터와 클러스터의 중심까지의 거리를 계산하여 가장 가까운 클러스터로 데이터를 할당 (k값에 따라 모델의 성능이 달라집니다)
> > k값이 크면 모델의 정확도가 높아지지만 너무 크면 분석 효과가 작아진다
> > KMeans(n_clusters, n_init, max_iter,  random_state)
> > 가장 단순하면서 빠른 군집화 알고리즘
> > KMeans 군집화는 유클리드 거리 계산을 사용하므로 너무 차원이 높은 겨우 군집화 선능이 떨어지므로 차원 축소 후에 사용해야 합니다.
> > ```
> >
> > - DBSCAN 군집화
> > - 유사도 전파 군집화
> > - 계층적 군집화
> > - 스펙트럴 군집화
> >
> > → 군집화 알고리즘들의 사용법과 모수가 서로 다름
>
> - 군집 분석의 성능 지표
>
> > - 조정 랜드지수
> >
> > ```
> > # 랜드지수(Rand Index , RI)는 데이터가 원래 군집화되어 있는 정답이 필요함
> > 랜드지수는 모든 데이터의 쌍의 개수에 대해 정답인 데이터 쌍의 개수 비율로 정의되므로 0~1사이의 값을 가지며, 1이 가장 좋은 성능을 의미합니다.
> > 
> > 무작위 군집화에서 생성되는 랜드지수의 기대값은 크게 나오는 경향이 있기 때문에 랜드지수의 기댓값을 원래 값에서 빼서 기댓값과 분산을 재조정한것을 조정랜드지수(ARI)
> > ```
> >
> > - 조정 상호정보량 - 두 확률변수의 상호 의존성을 측정한 값 
> > - 실루엣 계수
> >
> > ```
> > 동일 군집내에 데이터의 거리는 가깝고, 다른 군집의 데이터와의 거리는 멀다는 특성
> > 동일 군집내에 데이터의 거리가 다른 군집의 데이터와의 거리보다 가까우면 양수, 
> > 다른 군집의 데이터와의 거리가 가까우면 음수
> > ```
>
> - k평균 군집화 실습 
>
> ```python
> # 초기 중심위치에 따라 결과가 달라질 수 있다 > 시각화를 통해 확인
> from sklearn.datasets import make_blobs
> from sklearn.cluster import KMeans
> X, _ = make_blobs(n_samples=20, random_state=4)
> def plot_KMeans(n) :
>     model = KMeans(n_clusters=2, init="random", n_init=1, max_iter=n, random_state=6).fit(X)
>     c0, c1 = model.cluster_centers_
>     plt.scatter(X[model.labels_ ==0, 0], X[model.labels_==0, 1], marker='v', facecolor='r', edgecolors='k')
>     plt.scatter(X[model.labels_ ==1, 0], X[model.labels_==1, 1], marker='^', facecolor='y', edgecolors='k')
>     plt.scatter(c0[0], c0[1], marker='v', c="r", s=200)
>     plt.scatter(c1[0], c1[1], marker='^', c="y", s=200)
>     plt.grid(False)
>     plt.title('iter count={}, score={:5.2f}'.format(n, -model.score(X)))
> 
> plt.figure(figsize=(8, 8))
> plt.subplot(321)
> plot_KMeans(1)
> plt.subplot(322)
> plot_KMeans(2)
> plt.subplot(323)
> plot_KMeans(3)
> plt.subplot(324)
> plot_KMeans(4)
> plt.tight_layout()
> plt.show()
> # 각 점수 및 군집화 결과 열람 가능 
> ```
>
> ```
> kmean 알고리즘 수행 
> 1. n차원 공간에서 k개의 중심점을 임의로 선택
> 2.  중심점에서 각 샘플 데이터까지의 거리 계산
> 3. 각 데이터 포인트를 가장 가까운 중심점에 할당하여 클러스터 갱신
> 4. 각 중심점에 선택된 데이터 포인트들의 평균 위치로 중심점을 다시 이동
> 5. 1~4 과정을 수렴할때(중심점의 변화가 거의 없는, 할당된 군집의 변화가 없을때)까지 반복
> 
> 중심점 centroid 선택 방법 - 랜덤하게 설정, 수동으로 설정, kmean++ 
> #k-mean++ 방식을 사용하여 초기 클러스터 중심점을 정하여 군집화 수행 실습
> kmeans 단점은 알고리즘이 수렴하지 않는 문제가 발생할 수 있으므로 초기 중심점의 seed를 최적화하는 알고리즘 kmean++을 사용합니다.
> ```
>
> - kmean++ 
>
> ```python
> from sklearn.datasets import load_digits
> 
> digits = load_digits()
> 
> model = KMeans(init="k-means++", n_clusters=10, random_state=0)
> model.fit(digits.data)
> y_pred = model.labels_
> 
> def show_digits(images, labels):
>     f = plt.figure(figsize=(8, 2))
>     i = 0
>     while (i < 10 and i < images.shape[0]):
>         ax = f.add_subplot(1, 10, i + 1)
>         ax.imshow(images[i], cmap=plt.cm.bone)
>         ax.grid(False)
>         ax.set_title(labels[i])
>         ax.xaxis.set_ticks([])
>         ax.yaxis.set_ticks([])
>         plt.tight_layout()
>         i += 1
> 
> def show_cluster(images, y_pred, cluster_number):
>     images = images[y_pred == cluster_number]
>     y_pred = y_pred[y_pred == cluster_number]
>     show_digits(images, y_pred)    
> 
> for i in range(10):
>     show_cluster(digits.images, y_pred, i)
>     
> #성능 지표
> from sklearn.metrics import confusion_matrix
> 
> confusion_matrix(digits.target, y_pred)
> #군집화 결과의 ARI, AMI, 실루엣계수값 확인
> from sklearn.metrics.cluster import adjusted_mutual_info_score, adjusted_rand_score, silhouette_score
> 
> print("ARI:", adjusted_rand_score(digits.target, y_pred))
> print("AMI:", adjusted_mutual_info_score(digits.target, y_pred))
> print("Silhouette Score:", silhouette_score(digits.data, y_pred))
> 
> '''
> 결과
> ARI: 0.6703800183468681
> AMI: 0.7417664506416767
> Silhouette Score: 0.18249069204151275
> '''
> 
> ```
>
> > - 미니 배치 K-means 군집화 
>
> ```python
> '''
> k-means는 중심위치와 모든 데이터 사이의 거리를 계산해야 하므로 데이터 개수가 많아지면 계산량이 늘어나므로 데이터 수가 많을 때는 미니배치 k-means 군집화 방법을 사용하면 계산량을 줄일 수 있습니다.
> '''
> from sklearn.cluster import MiniBatchKMeans
> from sklearn.datasets import make_blobs
> X, y = make_blobs(n_samples=150000, cluster_std=[1.0, 2.5, 0.5], random_state=170)
> 
> import time
> start = time.time()  # 시작 시간 저장 
> model1 = KMeans(n_clusters=3).fit(X)
> print("time :", time.time() - start)
> 
> start = time.time()  # 시작 시간 저장  
> model2 = MiniBatchKMeans(n_clusters=3, batch_size=1000, compute_labels=True).fit(X)
> print("time :", time.time() - start)
> #미니배치 크기 batch_size 매개변수로 설정
> 
> # → 미니배치시 시간이 훨씬 줄어드는 것을 확인 
> ```
>
> ``` python
> # KMeans와 MiniBatchKMeans의  군집화 결과를 시각화하여 비교(거의 동일하게 군집화함)
> idx = np.random.randint(150000, size=300)
> plt.subplot(121)
> plt.scatter(X[idx, 0], X[idx, 1], c=model1.labels_[idx])
> plt.title("K-Means cluster")
> plt.subplot(122)
> plt.scatter(X[idx, 0], X[idx, 1], c=model2.labels_[idx])
> plt.title("MiniBatch K-Means cluster")
> plt.tight_layout()
> plt.show()
> 
> #결과물의 형태도 거의 유사 (시간↓, 성능=)
> ```
>
> 
>
> - 연습문제 : uci 에서 제공되는 외부데이터를 가지고 K-Means 알고리즘을 처리해보자 
>
> ```python
> import pandas as pd 
> uci_path = 'https://archive.ics.uci.edu/ml/machine-learning-databases//00292/Wholesale%20customers%20data.csv'
> df = pd.read_csv(uci_path, header=0)
> print(df.head())
> print(df.info())
> print(df.describe())
> ```
>
> ``` python
> # 분석에 사용할 속성 선택(모든 속성 선택 -비지도학습)
> X = df.iloc[:, :]
> print(X[:5])
> 
> #설명 변수 데이터를 정규화 전처리 
> from sklearn.preprocessing import StandardScaler
> X = StandardScaler().fit(X).transform(X)
> print(X[:5])
> ```
>
> ``` python
> # KMeans 군집화(중심점 설정은 k-means++, 중심점개수 5, 초기점 설명수 = 10)
> # 군집화된 결과 labels_ 로 확인 
> 
> kmeans = KMeans(init='k-means++', n_clusters=5, n_init=10)
> kmeans.fit(X)   
> cluster_label = kmeans.labels_   
> print(cluster_label) #군집화 개수를 5로 지정 -> 0, 1, 2, 3, 4
> 
> ```
>
> ```python
> # 예측 결과를 데이터 프레임에 추가 
> df['Cluster'] = cluster_label
> print(df.head())
> ```
>
> ``` python
> # 그래프로 표현 - 시각화
> df.plot(kind='scatter', x='Grocery', y='Frozen', c='Cluster', cmap='Set1', 
>         colorbar=False, figsize=(10, 10))
> df.plot(kind='scatter', x='Milk', y='Delicassen', c='Cluster', cmap='Set1', 
>         colorbar=True, figsize=(10, 10))
> plt.show()
> plt.close()
> ```
>
> ``` python
> # 값이 몰려있는 구간을 mask를 통해 자세하게 분석 
> mask = (df['Cluster']==0) | (df['Cluster']==4)
> ndf = df[~mask]
> ndf.plot(kind='scatter', x='Grocery', y='Frozen', c='Cluster', cmap='Set1',
>          colorbar=False, figsize=(10,10))
> ndf.plot(kind='scatter', x='Milk', y='Delicassen', c='Cluster', cmap='Set1',
>          colorbar=True, figsize=(10,10))
> plt.show()
> plt.close()
> ```
>
> 
>
> 
>
> - DBSCAN(Density-Based Spatial Clustering of Applications with Noise)
>
> > - 데이터 위치의 공간 밀집도를 기준으로 군집화 
> > - K-means의 단점 : 단순하고 강력하지만, 군집모양이 원형인 경우에는 잘 동작하나 
> >                    그렇지 않은 경우에는 잘 동작하지 않음 + 군집 개수를 직접 지정해야 한다. 
> > - DBSCAN은 데이터 형태에 영향을 받지 않으며, 군집 개수를 직접 지정할 필요가 없습니다. 
> > - 초기 데이터로부터 근접한 데이터를 찾아 군집을 확장하는 방식 
> > - 필요 지정 변수
> > 최소 거리( ε,Eps ,앱실론, 코어를 중심으로 한 동심원의 반지름)
> > 최소 데이터 개수(밀집 지역을 정의하기 위한 최소 필요 이웃 개수)
> > 코어 포인트 (핵심데이터): 반지름 R공간에 최소 M개의 포인트가 존재하는 점 
> > 경계포인트 : 반지름 안에 다른 코어 포인터가 있다면 그것은 경계 포인트로 간주 
> > 코어 포인트도 아니고 경계 포인트도 아닌 데이터는 Noise(outlier)로 간주 
>
> ```
> - eps매개변수 : 이웃을 정의하기 위한 거리 
> - min_samples : 핵심 데이터를 정의하기 위한 최소(필요한) 이웃영역안의 데이터 개수 
> - labels_ : 클러스터링 군집 결과에 대한 클래스 번호, -1값 표시시 outlier. 
> - core_sample_indices_ : 핵심 데이터의 인덱스 
> ```
>
> ```python
> from sklearn.datasets import make_circles, make_moons
> from sklearn.cluster import DBSCAN
> 
> n_samples = 1000
> np.random.seed(2)
> X1, y1 = make_circles(n_samples=n_samples, factor=.5, noise=.09)
> X2, y2 = make_moons(n_samples=n_samples, noise=.1)
> 
> def plot_DBSCAN(title, X, eps, xlim, ylim):
>     model = DBSCAN(eps=eps)
>     y_pred = model.fit_predict(X)
>     idx_outlier = model.labels_ == -1
>     plt.scatter(X[idx_outlier, 0], X[idx_outlier, 1], marker='x', lw=1, s=20)
>     plt.scatter(X[model.labels_ == 0, 0], X[model.labels_ == 0, 1], marker='o', facecolor='g', s=5)
>     plt.scatter(X[model.labels_ == 1, 0], X[model.labels_ == 1, 1], marker='s', facecolor='y', s=5)
>     X_core = X[model.core_sample_indices_, :]
>     idx_core_0 = np.array(list(set(np.where(model.labels_ == 0)[0]).intersection(model.core_sample_indices_)))
>     idx_core_1 = np.array(list(set(np.where(model.labels_ == 1)[0]).intersection(model.core_sample_indices_)))
>     plt.scatter(X[idx_core_0, 0], X[idx_core_0, 1], marker='o', facecolor='g', s=80, alpha=0.3)
>     plt.scatter(X[idx_core_1, 0], X[idx_core_1, 1], marker='s', facecolor='y', s=80, alpha=0.3)
>     plt.grid(False)
>     plt.xlim(*xlim)
>     plt.ylim(*ylim)
>     plt.xticks(())
>     plt.yticks(())
>     plt.title(title)
>     return y_pred
> 
> plt.figure(figsize=(10, 5))
> plt.subplot(121)
> y_pred1 = plot_DBSCAN("circle cluster", X1, 0.1, (-1.2, 1.2), (-1.2, 1.2))
> plt.subplot(122)
> y_pred2 = plot_DBSCAN("moon cluster", X2, 0.1, (-1.5, 2.5), (-0.8, 1.2))
> plt.tight_layout()
> plt.show()
> ```
>
> ``` python
> #성능 지표 (ARI, AMI) 확인
> from sklearn.metrics.cluster import adjusted_mutual_info_score, adjusted_rand_score
> 
> print("동심원 군집 ARI:", adjusted_rand_score(y1, y_pred1))
> print("동심원 군집 AMI:", adjusted_mutual_info_score(y1, y_pred1))
> print("초승달 군집 ARI:", adjusted_rand_score(y2, y_pred2))
> print("초승달 군집 AMI:", adjusted_mutual_info_score(y2, y_pred2))
> 
> '''결과 
> 동심원 군집 ARI: 0.9414262371038592
> 동심원 군집 AMI: 0.8967648464619999
> 초승달 군집 ARI: 0.9544844153926417
> 초승달 군집 AMI: 0.9151495815452475
> '''
> ```
>
> - 계층적 군집화
>
>   여러 개의 군집 중에서 가장 유사도가 높거나 거리가 가까운 군집 두개를 선택하여 하나로 합쳐가면서 군집 개수를 줄이는 방법
>   최초 군집개수는 데이터 개수와 동일(모든 군집이 하나의 데이터만 가진다)
>   계층적 군집화는 모든 군집 간에 거리를 계산(측정)해야 한다.
>
> - 거리 측정 방법 - 비계층적 방법, 
>   비계층적 측정 방법 : 중심 거리(두 중심점간의 거리, 군집간의 거리), 단일거리(최소거리) , 
>
>   ​									 완전거리(최장 거리),  평균 거리(계산량이 많음)
>   계층적 측정 방법 :  이전 단계에서 계층적 방법으로 합쳐진 군집이 있다고 가정하고 이 정보를 사용하는 측정법
>   중앙값 거리 , 가중 거리, 와드 거리

