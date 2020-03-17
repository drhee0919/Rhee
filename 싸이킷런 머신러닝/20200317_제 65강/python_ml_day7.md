**지난과정복습**

> 앙상블(ensemble) 학습: 여러 머신러닝모델을 연결하여 더 강력한 모델을 만드는 기법 
>
> DecisionTree 단점 : 훈련 데이터에 과대적합되는 경향이 있다. 
>
> RandomForest는 조금씩 다른 여러 Decision Tree의 묶음으로 각각의 잘 동작하는 서로 다른 방향으로 과대적합되는 DecisionTree 학습 결과를 평균냄으로써 과대적합 양을 줄일 수 있다. 
>
> RandomForest 모델을 만들려면 생성할 트리 개수 지정해야 하며, 여러 DecisionTree를 독립적으로 만들어 훈련시켜 모델을 생성해야 하므로 각 트리의 데이터를 랜덤하게 선택(랜덤하게 특성 선택)
>
> n_samples만큼 랜덤하게 데이터를 추출하여 n_estimators만큼의 트리를 생성 