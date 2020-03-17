**지난과정복습**

> 앙상블(ensemble) 학습: 여러 머신러닝모델을 연결하여 더 강력한 모델을 만드는 기법 
>
> - RandomForest
>
> > DecisionTree 단점 : 훈련 데이터에 과대적합되는 경향이 있다. 
> >
> > RandomForest는 조금씩 다른 여러 Decision Tree의 묶음으로 각각의 잘 동작하는 서로 다른 방향으로 과대적합되는 DecisionTree 학습 결과를 평균냄으로써 과대적합 양을 줄일 수 있다. 
> >
> > RandomForest 모델을 만들려면 생성할 트리 개수 지정해야 하며, 여러 DecisionTree를 독립적으로 만들어 훈련시켜 모델을 생성해야 하므로 각 트리의 데이터를 랜덤하게 선택(랜덤하게 특성 선택)
> >
> > n_samples만큼 랜덤하게 데이터를 추출하여 n_estimators만큼의 트리를 생성 
> >
> > max_features값을 크게 하면 랜덤 포레스트 트리들은 매우 비슷해지고 가장 두드러진 특성을 
> > 이용하여 데이터를 맞춰나갑니다. 
>
> ```python
> from sklearn.model_selection import train_test_split
> from sklearn.ensemble import RandomForestClassifier 
> from sklearn.datasets import make_moons
> import matplotlib.pyplot as plt
> import mglearn
> 
> X,y = make_moons(n_samples=100, noise=0.25, random_state=3)
> X_train, X_test, y_train, y_test = train_test_split(X, y, stratify=y, random_state=42)
> 
> forest = RandomForestClassifier(n_estimators=5, random_state=2)
> forest.fit(X_train, y_train)
> 
> fig, axes = plt.subplots(2, 3, figsize=(20, 10))
> for i, (ax, tree) in enumerate(zip(axes.ravel(), forest.estimators_)):
> 	ax.set_title("Tree{}".format(i))
> 	mglearn.plots.plot_tree_partition(X, y, tree, ax=ax)
> 
> #2차원 데이터셋 분할평면그리기
> #(모델객체, train데이터, 평면채우기, 투명도)
> mglearn.plots.plot_2d_separator(forest, X, fill=True, ax=axes[-1, -1], alpha=.4)
> axes[-1, -1].set_title("RandomForest")
> mglearn.discrete_scatter(X[:, 0], X[:, 1], y)
> 
> # 정확도 출력
> print("train set accuracy :{:.3f}".format(forest.score(X_train, y_train)))
> print("test set accuracy :{:.3f}".format(forest.score(X_test, y_test)))
> ```
>
> > RandomForest는 특성의 중요도 제공 
> >
> > RandomForest는 성능이 매우 뛰어나고 매개변수를 튜닝하지 않아도 잘 동작하며 데이터의 스케일을 맞출 필요도 없다. 
> >
> > n_estimator값을 크게 할 수록 random_state값에 따른 변화가 적습니다.(더 많은 트리의 결과를 평균하기 때문에 과대적합을 줄여 더 안정적인 모델을 만들어줍니다.)
> >
> > 여러 개의 decision tree를 묶어 강력한 모델을 만드는 앙상블 학습 방법으로 이전의 decision tree 의 오차를 보완하는 방식으로 순차적으로 트리를 만듭니다. → 그레디언트 부스팅 회귀 트리 
> >
> > 그래디언트 부스팅 회귀 트리는 이전 트리의 오차를 얼마나 강하게 보정할 것인가를 제어하는 매개변수 학습률(learning_rate)이 크면 트리를 좀더 강하게 보정하므로 복잡한 모델을 만들 수 있다. 
>
> - KNN 
>
> > 새로운 관측값이 주어지면 기존 데이터 중에서 가장 속성이 비슷한 k개 이웃을 찾고 이웃들이 가지고 있는 목표 값과 같은 값으로 분류하여 예측하는 알고리즘 
> >
> > k값에 따라 예측의 정확도가 달라지므로 적절한 k값을 찾는 것이 중요함 
> >
> > KNN은 지도 학습(레이블이 있는 데이터를 사용하여 분류 작업을 수행하는 알고리즘)
> >
> > KNN**장점**은 알고리즘이 간단하고 구현하기 쉽다 
> >
> > KNN**단점**은 현상의 원인을 파악하는데는 도움이 되지 않는다. 
> >
> > 수행순서:
> >
> > 어떤 데이터로부터 다른 데이터들간의 거리 측정 → 가까운 K개의 데이터 선택 → 선택된 데이터의 레이블을 보고 다수결 선택 방법으로 사용하여 새로운 데이터 포인트의 레이블을 결정 
> >
> > KNN을 수행 전 반드시 변수를 정규화해주어야 합니다. 
> >
> > KNN은 노이즈 영향을 받지 않습니다. 
> >
> > ``` python
> > from sklearn.neighbors import KNeighborsClassifier
> > X, y = mglearn.datasets.make_forge()
> > 
> > X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=0)
> > 
> > clf = KNeighborsClassifier(n_neighbors=3)
> > clf.fit(X_train, y_train)
> > 
> > print("test data predict :{}" .format(clf.predict(X_test)))
> > print("test data accuracy:{:.2f}".format(clf.score(X_test, y_test)))
> > 
> > '''결과
> > test data predict :[1 0 1 0 1 0 0]
> > test data accuracy:0.86
> > '''
> > ```
> >
> > ```python
> > # 모의 데이터가 2차원이므로 평면 상에 데이터 포인트를 시각화 
> > fig, axes = plt.subplots(1, 3, figsize=(10,3))
> > for n_neighbors, ax in zip([1,3,9], axes):
> >     clf = KNeighborsClassifier(n_neighbors=n_neighbors).fit(X,y)
> >     mglearn.plots.plot_2d_seperator(clf, X, fill=True, eps=0.5, ax=ax, alpha=.4)
> >     mglearn.discrete_scatter(X[:,0], X[:1], y, ax=ax)
> >     ax.set_title("{}neighbors".format(n_neighbors))
> >     ax.set_label("feature 0")
> >     ax.set_label("feature 1")
> > axes[0].legend(loc=3)
> > ```
> >
> > K-최근접 이웃 분류기(KNeighborsClassifier)
> >  metric 매개변수는 사용할 거리 측정 방법을 지정합니다.
> >  n_jobs 매개변수는 컴퓨터 코어를 사용할지 결정합니다.
> >  algorithm 매개변수는 가장 가까운 이웃을 계산하기 위한 방법을 지정
> >  weights 매개변수를 distance로 지정하면 멀리 떨어진 샘플보다 가까운 이웃의 투표에 가중치가 더 부여됩니다
> >
> > ```python
> > from sklearn.datasets import load_breast_cancer
> > cancer = load_breast_cancer()
> > 
> > X_train, X_test, y_train, y_test = train_test_split(cancer.data, cancer.target, stratify=cancer.target,  random_state=66)
> > training_accuracy=[]
> > test_accuracy=[]
> > neighbors_settings=range(1, 11)  # 이웃수 범위 1~10
> > 
> > for n_neighbors in neighbors_settings :
> >     clf = KNeighborsClassifier(n_neighbors=n_neighbors)
> >     clf.fit(X_train, y_train)
> >     training_accuracy.append(clf.score(X_train, y_train))
> >     test_accuracy.append(clf.score(X_test, y_test))
> > 
> > plt.plot(neighbors_settings, training_accuracy, label="train accuracy")
> > plt.plot(neighbors_settings, test_accuracy, label="test accuracy")
> > plt.xlabel("n_neighbors")
> > plt.ylabel("accuracy")
> > plt.legend()
> > ```
> >
> > KNN 알고리즘은 이해하기 쉽지만, 훈련 데이터셋이 크면 예측이 느리고 특성이 많은 경우 처리 능력이 부족해서 현업에서 잘 쓰이지 않습니다.
> >
> > KNN의 거리 계산 방법 - 유클리디안 거리, 맨하튼 거리, 마할라노비스 거리( 변수 내 분산과 변수 간의 공분산을 모두 반영하여 거리를 계산)

(이어서 )**KNN 성능 평가 , 보고서**

> - seaborn의 타이타닉 데이터셋을 바탕으로 KNN성능평가 및 보고서 작성까지 완료해보자 
>
> ```python
> import pandas as pd
> import seaborn as sns
> 
> df  = sns.load_dataset('titanic')
> print(df.head())
> print(df.info())
> 
> #deck열(NaN이 많은)삭제, embarked와 embark_town열의 의미가 동일하므로 embark_town 삭제
> rdf = df.drop(['deck', 'embark_town'], axis=1)
> print(rdf.columns.values)
> 
> #age열에 NaN 데이터를 가지는 행 삭제 (고유값으로 확인 가능)
> rdf = rdf.dropna(subset=['age'], how='any', axis=0)
> print(len(rdf))
> 
> #embarked 열에 NaN 값을 가장 많은 승선도시 값으로 치환
> most_freq = rdf['embarked'].value_counts(dropna=True).idxmax()
> print(most_freq)
> #print(rdf.describe(include='all'))
> rdf['embarked'].fillna(most_freq, inplace=True)
> 
> #분석에 활용할 특성 선택
> ndf = rdf[['survived', 'pclass', 'sex' ,'age' ,'sibsp' ,'parch',  'embarked' ]]
> print(ndf.head())
> 
> # 범주형 데이터를 정수형으로 변환(one hot encoding) - 'sex', 'embarked' 
> onehot_sex = pd.get_dummies(ndf['sex'])
> ndf = pd.concat([ndf, onehot_sex], axis=1)
> 
> onehot_embarked = pd.get_dummies(ndf['embarked'], prefix='town')
> ndf = pd.concat([ndf, onehot_embarked], axis=1)
> 
> ndf.drop(['sex', 'embarked'], axis=1, inplace=True)
> print(ndf.head())
> 
> #특성(독립변수)과 타겟(종속변수) 분리
> X=ndf[['pclass', 'age', 'sibsp', 'parch', 'female', 'male', 'town_C', 'town_Q', 'town_S']]   
> y=ndf['survived']   
> 
> #특성(독립변수) 정규화
> from sklearn import preprocessing
> X = preprocessing.StandardScaler().fit(X).transform(X)
> 
> # train,  test dataset 분리 (7: 3)
> from sklearn.model_selection import train_test_split
> X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=10) 
> 
> print('train data 개수: ', X_train.shape)
> print('test data 개수: ', X_test.shape)
> 
> 
> # KNN 분류(k=5로 설정)
> from sklearn.neighbors import KNeighborsClassifier
> 
> knn = KNeighborsClassifier(n_neighbors=5)
> knn.fit(X_train, y_train)   
> y_hat = knn.predict(X_test)
> 
> print(y_hat[0:10])
> print(y_test.values[0:10])
> 
> # 모형 성능 평가 - Confusion Matrix 계산
> from sklearn import metrics 
> knn_matrix = metrics.confusion_matrix(y_test, y_hat)  
> print(knn_matrix)
> 
> # 모형 성능 평가 - 평가지표 계산
> knn_report = metrics.classification_report(y_test, y_hat)            
> print(knn_report)
> ```



#### SVM(커널 서포트 벡터 머신)

> - 정의
>
> 선형 모델을 유연하게 만드는 방법 중 하나인  특성끼리 곱하거나 특성을 거듭제곱하는 식으로 새로운 특성을 추가하여 단순한 초평면으로 정의되지 않는 더 복잡한 모델을 만들수 있도록 확장한 것
>
> (하단 코드는 실습으로 옮긴 뒤 그림으로 확인할 것)
>
> ```python
> #선형적으로 분류되지 않는 클래스를 가진 이진 데이터셋
> from sklearn.datasets import make_blobs
> X, y = make_blobs(centers=4, random_state=8)
> y=y%2
> mglearn.discrete_scatter(X[:,0], X[:,1], y)
> plt.xlabel('feature 0')
> plt.ylabel('feature 1')
> 
> 
> from sklearn.svm import LinearSVC
> linear_svm = LinearSVC().fit(X, y)
> 
> mglearn.plots.plot_2d_separator(linear_svm, X)
> mglearn.discrete_scatter(X[:,0], X[:,1], y)
> plt.xlabel('feature 0')
> plt.ylabel('feature 1')
> #분류를 위한 선형 모델은 직선으로만 데이터 포인트를 나누므로 올바르게 분류하지 못함
> ```
>
> ```python
> #두번째 특성을 제곱한 특성으로 새로운 특성을 추가해서 입력 특성을 확장
> import numpy as np
> from mpl_toolkits.mplot3d import Axes3D     
> 
> #conda install basemap ,  pip install -U matplotlib
> X_new = np.hstack([X, X[:, 1:] ** 2])
> from mpl_toolkits.mplot3d import Axes3D, axes3d
> figure = plt.figure()
> # 3차원 그래프
> ax = Axes3D(figure, elev=-152, azim=-26)
> # y == 0인 포인트를 먼저 그리고 그다음 y == 1인 포인트를 그립니다.
> mask = y == 0
> ax.scatter(X_new[mask, 0], X_new[mask, 1], X_new[mask, 2], c='b',
>            cmap=mglearn.cm2, s=60, edgecolor='k')
> ax.scatter(X_new[~mask, 0], X_new[~mask, 1], X_new[~mask, 2], c='r', marker='^',
>            cmap=mglearn.cm2, s=60, edgecolor='k')
> ax.set_xlabel("feature 0")
> ax.set_ylabel("feature1")
> ax.set_zlabel("feature1 ** 2")
> ```
>
> ```python
> #선형 모델과 3차원 공간의 평면을 사용해 두 클래스를 분류
> linear_svm_3d = LinearSVC().fit(X_new, y)
> coef, intercept = linear_svm_3d.coef_.ravel(), linear_svm_3d.intercept_
> 
> figure = plt.figure()
> ax = Axes3D(figure, elev=-152, azim=-26)
> xx = np.linspace(X_new[:, 0].min() - 2, X_new[:, 0].max() + 2, 50)
> yy = np.linspace(X_new[:, 1].min() - 2, X_new[:, 1].max() + 2, 50)
> 
> XX, YY = np.meshgrid(xx, yy)
> ZZ = (coef[0] * XX + coef[1] * YY + intercept) / -coef[2]
> ax.plot_surface(XX, YY, ZZ, rstride=8, cstride=8, alpha=0.3)
> ax.scatter(X_new[mask, 0], X_new[mask, 1], X_new[mask, 2], c='b',
>            cmap=mglearn.cm2, s=60, edgecolor='k')
> ax.scatter(X_new[~mask, 0], X_new[~mask, 1], X_new[~mask, 2], c='r', marker='^',
>            cmap=mglearn.cm2, s=60, edgecolor='k')
> 
> ax.set_xlabel("feature 0")
> ax.set_ylabel("feature 1")
> ax.set_zlabel("feature 1 ** 2")
> ```
>
> ```python
> #선형SVM 모델은 직선이 아닌 타원에 가까운 분류 경계를 찾아줌
> ZZ = YY ** 2
> dec = linear_svm_3d.decision_function(np.c_[XX.ravel(), YY.ravel(), ZZ.ravel()])
> plt.contourf(XX, YY, dec.reshape(XX.shape), levels=[dec.min(), 0, dec.max()],
>              cmap=mglearn.cm2, alpha=0.5)
> mglearn.discrete_scatter(X[:, 0], X[:, 1], y)
> plt.xlabel("feature 0")
> plt.ylabel("feature 1")
> ```
>
> - 데이터셋에 비선형 특성을 추가하여 더 강력한 선형 모델을 만들 수 있습니다.
> - 커널 기법(실제로 데이터를 확장하지 않고 확장된 특성에 대한 데이터 포인터들의 거리를 계산)을 이용해서 새로운 특성을 많이 만들지 않고도 분류기를 학습시킬 수 있습니다.
> - 데이터를 고차원 공간에 매핑하는 데 사용하는 방법 
>   1. 다항식 커널 : 원래 특성의 가능한 조합을 지정된 차수까지 모두 계산 (예: 특성1**2+ 특성**5) 
>   2. 가우시안 커널  : 차원이 무한한 특성 공간에 매핑되도록 계산, 모든 차수의 모든 다항식을 고려한다
> - 새로운 데이터에 대한 예측은  각 서포트 벡터와의 거리를 측정합니다
>
> ```python
> # 두 개의 클래스를 가진 2차원 데이터셋에 SVM으로 학습
> from sklearn.svm import SVC
> X, y = mglearn.tools.make_handcrafted_dataset()
> svm = SVC(kernel='rbf', C=10, gamma=0.1).fit(X, y)   
> #gamma는 가우시안 커널의 폭을 제어하는 매개변수
> mglearn.plots.plot_2d_separator(svm, X, eps=.5)
> mglearn.discrete_scatter(X[:,0], X[:, 1], y)
> 
> sv = svm.support_vectors_  #서포트 벡트들
> sv_labels = svm.dual_coef_.ravel() > 0   
> # dual_coef_의 부호에 의해 서포트 벡터의 클래스 레이블이 결정됩니다.
> mglearn.discrete_scatter(sv[:,0], sv[:, 1], sv_labels, s=15, markeredgewidth=3)
> plt.xlabel("feature 0")
> plt.xlabel("feature 1")
> 
> ```
>
> - KNN으로 titanic 데이터 분류 분석 수행을 SVM으로 분류 분석 수행하고
>   평가 지표 비교
>
> ```python
> # 전처리 절차 생략
> # 학습시작
> svm_model = SVC(kernel='rbf') #모형 객체 생성 
> svm_model.fit(X_train, y_train)
> y_hat = svm_model.predict(X_test)
> 
> print(y_hat[0:10])
> print(y_test.values[0:10])
> print("\n")
> 
> from sklearn import metrics 
> svm_matrix = metrics.confusion_matrix(y_test, y_hat)
> 
> #모형 성능 평가 - Confusion Matirx 계산 
> print(svm_matrix)
> print('\n')
> 
> #모형 성능 평가 - 평가 지표 계산 
> svm_report = metrics.classification_report(y_test, y_hat)
> print(svm_report)
> ```
>
> https://datascienceschool.net/view-notebook/731e0d2ef52c41c686ba53dcaf346f32/

