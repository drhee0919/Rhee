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