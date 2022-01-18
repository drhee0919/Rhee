### RNN 구현하기



#### 1. 케라스(Keras)로 RNN 층 추가하기

```python
# RNN 층을 추가하는 코드.
model.add(SimpleRNN(hidden_size)) # 가장 간단한 형태

```

```python
# 추가 인자를 사용할 때
model.add(SimpleRNN(hidden_size, input_shape=(timesteps, input_dim)))

# 다른 표기
model.add(SimpleRNN(hidden_size, input_length=M, input_dim=N))
# 단, M과 N은 정수
```

> * hidden_size = 은닉 상태의 크기를 정의. 메모리 셀이 다음 시점의 메모리 셀과 출력층으로 보내는 값의 크기(output_dim)와도 동일. RNN의 용량(capacity)을 늘린다고 보면 되며, 중소형 모델의 경우 보통 128, 256, 512, 1024 등의 값을 가진다.
> * timesteps = 입력 시퀀스의 길이(input_length)라고 표현하기도 함. 시점의 수.
> * input_dim = 입력의 크기.

- batch 사이즈를 미정한 경우(예시) 

```python
from keras.models import Sequential
from keras.layers import SimpleRNN

model = Sequential()
model.add(SimpleRNN(3, input_shape=(2,10)))
# model.add(SimpleRNN(3, input_length=2, input_dim=10))와 동일함.
model.summary()
'''출력
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
simple_rnn_1 (SimpleRNN)     (None, 3)                 42        
=================================================================
Total params: 42
Trainable params: 42
Non-trainable params: 0
_________________________________________________________________

'''
```

> 출력값이 (batch_size, output_dim) 크기의 2D 텐서일 때, output_dim은 hidden_size의 값인 3.
>
>  이 경우 batch_size를 현 단계에서는 알 수 없으므로 (None, 3)이 된다. 



- batch 사이즈를 미리 지정한 경우 예시

```python
model = Sequential()
model.add(SimpleRNN(3, batch_input_shape=(8,2,10)))
model.summary()

'''출력
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
simple_rnn_2 (SimpleRNN)     (8, 3)                    42        
=================================================================
Total params: 42
Trainable params: 42
Non-trainable params: 0
_________________________________________________________________

'''
```

> batch_size를 8로 기재하자, 출력의 크기가 (8, 3)이 된 것을 볼 수 있다. 



-  return_sequences 매개 변수에 True를 기재

  →출력값으로 (batch_size, timesteps, output_dim) 크기의 3D 텐서를 리턴하도록 모델링

```python
model = Sequential()
model.add(SimpleRNN(3, batch_input_shape=(8,2,10), return_sequences=True))
model.summary()


'''출력
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
simple_rnn_3 (SimpleRNN)    (8, 2, 3)                 42        
=================================================================
Total params: 42
Trainable params: 42
Non-trainable params: 0
_________________________________________________________________
'''
```

> 출력 크기가 (8,2,3)이 된 것을 확인 



#### 2. 파이썬으로 RNN 구현하기 

| 직접 Numpy로 RNN 층을 구현해보자

> 은닉 상태를 계산하는 식을 다음과 같이 정의
>
> ***" ht=tanh(WxXt+Whht−1+b) "***
>
> * 의사코드로 변환하기 

``` pseudocode
# 아래의 코드는 의사 코드(pseudocode)로 실제 동작하는 코드가 아님. 

hidden_state_t = 0 # 초기 은닉 상태를 0(벡터)로 초기화
for input_t in input_length:  # 각 시점마다 입력을 받는다.
    output_t = tanh(input_t, hidden_state_t) 
    					    # 각 시점에 대해서 입력과 은닉 상태를 가지고 연산
    hidden_state_t = output_t # 계산 결과는 현재 시점의 은닉 상태가 된다.
```

> * 은닉 상태를 hidden_state_t라는 변수로 선언 
> * 입력 데이터의 길이를 input_length로 선언 
> *  입력 데이터의 길이는 곧 총 시점의 수(timesteps)가 됨. 
> *  t 시점의 입력값을 input_t로 선언. 
> * 각 메모리 셀은 각 시점마다 <u>input_t와 hidden_sate_t(이전 상태의 은닉 상태)를 입력</u>으로 활성화 함수인 **하이퍼볼릭탄젠트 함수**를 통해 현 시점의 hidden_state_t를 계산합니다.

