※ 파라미터와 하이퍼파라미터의 차이 

[https://bkshin.tistory.com/entry/%EB%A8%B8%EC%8B%A0%EB%9F%AC%EB%8B%9D-13-%ED%8C%8C%EB%9D%BC%EB%AF%B8%ED%84%B0Parameter%EC%99%80-%ED%95%98%EC%9D%B4%ED%8D%BC-%ED%8C%8C%EB%9D%BC%EB%AF%B8%ED%84%B0Hyper-parameter](https://bkshin.tistory.com/entry/머신러닝-13-파라미터Parameter와-하이퍼-파라미터Hyper-parameter)



```
차원 축소 해야 하는 이유(목적) :
1. 데이터 시각화 가능 -> 데이터의 패턴 이해 용이
2. 노이즈 제거
3. 메모리 절약 -> 모델 성능 개선

차원 축소 method : 
주성분분석(PCA) : 특성들 중에서 클래스를 분류하는데 두드러지게 중요한 특성 추출함으로써 차원을 축소
데이터 집합에 대해 공분산 행렬  구함 ->  공분산 행렬로부터 고유값과 고유벡터 계산 -> 고유값 목록에서 값이 높은 k개의 인덱스를 구함
PCA는 데이터 압축, 얼굴 인식 기능등에 활용됨
PCA는 정방행렬에서만 가능

LDA(선형 판별 분석) : 클래스를 최대한 분리하는 성분을 축으로 차원 축소

SVD(특이값 분해) 를 이용한 차원 축소
행렬을 대각화하는 방법으로  정방행렬이 아니어도 mXn 행렬에 대해 적용 가능
직교하는 벡터 집합에 대해서  선형 변환 후에 그 크기는 변하지만 여전히 직교할 수 있게 되는 직교집합을 찾음으로서 차원을 축소하는 방식
데이터 압축, 유사도 분석등에 많이 활용됨
TSVD는 희소 특성 행렬

NMF(비음수 행렬 인수분해)는 비지도 학습 알고리즘
음수가 아닌 특성과 계수 값을 찾음
주성분 계수가 양수(0보다 크거나 같아야 함)
음수가 아닌 특성들에 대해서 가중치의 합으로 데이터를 분해
여러 데이터 특성 중에서 주요 독립 특성을 추출하는 방법으로 차원을 축소
```