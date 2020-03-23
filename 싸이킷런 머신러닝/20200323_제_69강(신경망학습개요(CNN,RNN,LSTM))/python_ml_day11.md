**MNIST by Keras**

> MNIST 손글씨 인식하기: 데이터 전처리
>
>  28 × 28 = 784개의 속성을 이용해 0~9까지 10개 클래스 중 하나를 맞히는 분류 문제가 됩니다.
>
>  Reshape() 함수를 사용하여 가로 28, 세로 28의 2차원 배열을 784개의 1차원 배열로 바꿔 주어야 합니다.
>
>  케라스는 데이터를 0에서 1 사이의 값으로 변환해야 구동할 때 최적의 성능을 보이므로 0~255 사이의
>
> 값으로 이루어진 값을 0~1 사이의 값으로 값을 255로 나누어 데이터 정규화(normalization) 합니다.
>
>  Y_class를 np_utils.to_categorical(클래스, 클래스의 개수)를 사용하여 원-핫 인코딩 합니다.

```python
from keras.datasets import mnist
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense
from keras.callbacks import ModelCheckpoint,EarlyStopping

import matplotlib.pyplot as plt
import numpy
import os
import tensorflow as tf

# seed 값 설정
seed = 0
numpy.random.seed(seed)
#tf.set_random_seed(seed)

# MNIST 데이터 불러오기
(X_train, Y_train), (X_test, Y_test) = mnist.load_data()

X_train = X_train.reshape(X_train.shape[0], 784).astype('float32') / 255
X_test = X_test.reshape(X_test.shape[0], 784).astype('float32') / 255

Y_train = np_utils.to_categorical(Y_train, 10)
Y_test = np_utils.to_categorical(Y_test, 10)
# 모델 프레임 설정
model = Sequential()
model.add(Dense(512, input_dim=784, activation='relu'))
model.add(Dense(10, activation='softmax'))

# 모델 실행 환경 설정
model.compile(loss='categorical_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])

# 모델 최적화 설정
MODEL_DIR = './model/'
if not os.path.exists(MODEL_DIR):
    os.mkdir(MODEL_DIR)

modelpath="./model/{epoch:02d}-{val_loss:.4f}.hdf5"
checkpointer = ModelCheckpoint(filepath=modelpath, monitor='val_loss', verbose=1, save_best_only=True)
early_stopping_callback = EarlyStopping(monitor='val_loss', patience=10)

# 모델의 실행
history = model.fit(X_train, Y_train, validation_data=(X_test, Y_test), epochs=30, batch_size=200, verbose=0, callbacks=[early_stopping_callback,checkpointer])

# 테스트 정확도 출력
print("\n Test Accuracy: %.4f" % (model.evaluate(X_test, Y_test)[1]))

# 테스트 셋의 오차
y_vloss = history.history['val_loss']

# 학습셋의 오차
y_loss = history.history['loss']

# 그래프로 표현
x_len = numpy.arange(len(y_loss))
plt.plot(x_len, y_vloss, marker='.', c="red", label='Testset_loss')
plt.plot(x_len, y_loss, marker='.', c="blue", label='Trainset_loss')

# 그래프에 그리드를 주고 레이블을 표시
plt.legend(loc='upper right')
# plt.axis([0, 20, 0, 0.35])
plt.grid()
plt.xlabel('epoch')
plt.ylabel('loss')
plt.show() 
```

> - 컨볼루션 신경망
> - fiter, pooling, Dropout 적용
>
> ```python
> from keras.datasets import mnist
> from keras.utils import np_utils
> from keras.models import Sequential
> from keras.layers import Dense, Dropout, Flatten, Conv2D, MaxPooling2D
> from keras.callbacks import ModelCheckpoint,EarlyStopping
> 
> import matplotlib.pyplot as plt
> import numpy
> import os
> import tensorflow as tf
> 
> # seed 값 설정
> seed = 0
> numpy.random.seed(seed)
> #tf.set_random_seed(seed)
> 
> # 데이터 불러오기
> 
> (X_train, Y_train), (X_test, Y_test) = mnist.load_data()
> X_train = X_train.reshape(X_train.shape[0], 28, 28, 1).astype('float32') / 255
> X_test = X_test.reshape(X_test.shape[0], 28, 28, 1).astype('float32') / 255
> Y_train = np_utils.to_categorical(Y_train)
> Y_test = np_utils.to_categorical(Y_test)
> 
> # 컨볼루션 신경망의 설정
> model = Sequential()
> model.add(Conv2D(32, kernel_size=(3, 3), input_shape=(28, 28, 1), activation='relu'))
> model.add(Conv2D(64, (3, 3), activation='relu'))
> model.add(MaxPooling2D(pool_size=2))
> model.add(Dropout(0.25))
> model.add(Flatten())
> model.add(Dense(128,  activation='relu'))
> model.add(Dropout(0.5))
> model.add(Dense(10, activation='softmax'))
> 
> model.compile(loss='categorical_crossentropy',
>               optimizer='adam',
>               metrics=['accuracy'])
> 
> # 모델 최적화 설정
> MODEL_DIR = './model/'
> if not os.path.exists(MODEL_DIR):
>     os.mkdir(MODEL_DIR)
> 
> modelpath="./model/{epoch:02d}-{val_loss:.4f}.hdf5"
> checkpointer = ModelCheckpoint(filepath=modelpath, monitor='val_loss', verbose=1, save_best_only=True)
> early_stopping_callback = EarlyStopping(monitor='val_loss', patience=10)
> 
> # 모델의 실행
> history = model.fit(X_train, Y_train, validation_data=(X_test, Y_test), epochs=30, batch_size=200, verbose=0, callbacks=[early_stopping_callback,checkpointer])
> 
> # 테스트 정확도 출력
> print("\n Test Accuracy: %.4f" % (model.evaluate(X_test, Y_test)[1]))
> 
> # 테스트 셋의 오차
> y_vloss = history.history['val_loss']
> 
> # 학습셋의 오차
> y_loss = history.history['loss']
> 
> # 그래프로 표현
> x_len = numpy.arange(len(y_loss))
> plt.plot(x_len, y_vloss, marker='.', c="red", label='Testset_loss')
> plt.plot(x_len, y_loss, marker='.', c="blue", label='Trainset_loss')
> 
> # 그래프에 그리드를 주고 레이블을 표시
> plt.legend(loc='upper right')
> plt.grid()
> plt.xlabel('epoch')
> plt.ylabel('loss')
> plt.show()
> ```



#### 텍스트 마이닝

```
텍스트 마이닝이란?  
비정형 데이터에서 의미 있는 정보를 추출하는 기술
텍스트 분류 - 문장 또는 문서를 특정 카테고리로 분류, 예측
예) 신문기사와 같은 문서를 기사 내용에 따라 정치/경제/사회/문화등의 카테고리로 분류,  
메일의 내용을 분석해서 스팸 메일 분류
감정분석 -텍스트에서 나타나는 감정/판단/의견 등의 주관적인 요소를 분석하는 기법
예) 소셜 미디어 분석, 영화나 제품에 대해서 긍정 또는 리뷰, 조사, 의견 분석등에 활용
텍스트 요약 - 텍스트내엣 중요한 주제, 결론, 중심사상등을 추출하는 기법
텍스트 군집화, 텍스트 유사도 측정

NLP 자연어 처리   - 텍스트 분석을 향상시키는 기반 기술

텍스트 분석 단계 "
1. Feature Vectorization : 비정형 텍스트를 Feature 형태로 변환 (특성 추출)
    BOW(Bag of Words), Word2Vect
    cleansing > 대소문자 변환 > 특수문자 제거 > 토큰화 >  의미없는 불용어 제거 > 어근 추출(Stemming/Lemmatization) > 텍스트 정규화

NLTK  (자연어 처리 라이브러리 )
Gensim : 토픽 모델링 분야의 패키지
SpaCy :  토픽 모델링 분야의 패키지, 성능이 뛰어남

cleansing - nltk.download('punkt')
sent_tokenize()  문장 토큰화
word_tokenize() 단어 토큰화
2개의 단어, 3개의 단어 등으로 토큰화 : n-gram
필터링 : stop word 제거, 철자 수정 (Stemming/Lemmatization)
CountVectorizer
TfidfVectorizer

텍스트 정규화  :  
1. 클린징, 특수문자 제거, 소문자로 변환등 (전처리)
2. 토큰화 (n-gram적용)
3. 정규화 (stop word, 필터링 적용, Stemming/Lemmatization)
4. Feature Vectorizing  - Coordinate형식(0이 아닌 값의 행, 열 위치값 저장) ,  CSR(Compressed Spare Row)형식은 Coordinate형식의 행과 열 위치의 반복적인 값을 압축(차원 축소) 
```